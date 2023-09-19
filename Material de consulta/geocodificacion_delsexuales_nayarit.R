###################################
### Limpieza de dierecciones ######
## Geocidifcación delitos sexuales#
###################################


# Librerías y paquetes ----------------------------------------------------

#install.packages("stringdist")

library(readr)
library(dplyr)
library(readxl)
library(stringdist)
library(tidyverse)
library(ggmap)


# Bases de datos ----------------------------------------------------------

setwd("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/NAYARIT")

delitos <- read.csv("sexuales con id.csv")


# Limpieza de direcciones -------------------------------------------------

# Cambiar N/E a Na

delitos <- delitos %>%
  mutate(across(colonia, na_if, "N/E"))

# Quito prefijos Col, Fracc, Fracc. 
delitos$colonia<- sub("FRACC.", "",delitos$colonia)
delitos$colonia<- sub("FRACCIONAMIENTO", "",delitos$colonia)

#quito el espacio en blanco
delitos <- delitos %>%
  mutate(colonia = gsub("^\\s+", "", colonia))

#Si es número menor a 10 quito el cero lo dejo en un character


# Códigos postales --------------------------------------------------------

cp <- read_excel("cp.xlsx")

# Lipio colonias en CP
cp$Asentamiento <-  toupper(cp$Asentamiento)
#quito acentos
cp$Asentamiento <- chartr("ÁÉÍÓÚ", "AEIOU", cp$Asentamiento)


#
delitos <- delitos[, -3]

delitos <- delitos %>% unite("direccion", c("calle","numero", "colonia","Código.Postal" ,"estado","pais"), na.rm = TRUE, remove = FALSE, sep = ", ")


# Emparajamiento de colonia por parecido ----------------------------------------------

correct_words <- cp$Asentamiento[amatch(delitos$colonia, cp$Asentamiento, maxDist = Inf, method = "jw", p = 0.25)]

sum(is.na(delitos$colonia))

sum(is.na(correct_words))

comparación <- data.frame(delitos$colonia, correct_words)


# Geocodificación ---------------------------------------------------------


# pongo la columna de direcciones como vector
# Create a vector of the addresses you want to geocode
addresses <- delitos$direccion
addresses <- stripWhitespace(addresses)

register_google(key = "AIzaSyB3kSKy6zlUi-G4uYYYDkKqE")


##########comenzar un proceso de google
### esto es un sistema de try and catch, que es una buena práctica pero no forzoso
geocode_with_error_handling <- function(address) {
  result <- tryCatch(
    expr = {
      geocode(addresses)  # Replace with the actual function call
    },
    error = function(e) {
      # Handle the error here
      cat("An error occurred:", conditionMessage(e), "\n")
      return(NULL)  # Return something appropriate when an error occurs
    }
  )
  
  return(result)
}

#colocamos una dirección cualquiera para la primera iteración
address_to_geocode <- "123 Main St, City, Country"
#decimos donde guardar futuras iteraciones
geocoded_result <- geocode_with_error_handling(address_to_geocode)

if (!is.null(geocoded_result)) {
  # Process the geocoded result
  print(geocoded_result)
} else {
  # Handle the case when geocoding failed
  cat("Geocoding failed for:", address_to_geocode, "\n")
}

############

#guardo latitud y longitud para no perderlas
write.csv(geocoded_result, "sexual_georreferencias_100.csv")

#le pego las direcciones para juntar con base principal
geocoded_result$direccion <- addresses

#elimino repeteciones para juntar bases muchos a 1
geocoded_result <- geocoded_result %>%
  filter(duplicated(direccion) == FALSE)

# hago el marge con la base de datos de las coordenadas y la original
base <- left_join(delitos, geocoded_result, by= "direccion")

write.csv(base, "sexual_georreferencias_100.csv")


# Después se depuran los puntos de manera espacial en Qgis.
#Note que hay dos coordenadas, lon.x lat.x y lon.y lat.y, 
#estos para tener una comparación con las geocodificación anterior o previa que se habían realizado
#estas fueron quitadas de la versión final y sólo se dejaron las más recientes