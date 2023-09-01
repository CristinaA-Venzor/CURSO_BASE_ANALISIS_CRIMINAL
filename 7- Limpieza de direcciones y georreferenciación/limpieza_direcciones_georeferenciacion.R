#### Limpieza de direcciones y Georeferenciación gratuita
## Resultados: 62% de direcciones totales georreferenciadas
##             64% de direcciones válidas georreferenciadas


#### Limpieza de direcciones y Georeferenciación de paga - google maps
## Resultados: 62% de direcciones totales georreferenciadas
##             64% de direcciones válidas georreferenciadas


#install.packages("readr")
#install.packages(dplyr)
#install.packages(tidyverse)
#install.packages(tmaptools)
#install.packages(tm)
#install.packages(ggmap)

library(readr)
library(dplyr)
library(tidyverse)
library(tmaptools)
library(tm)
library(ggmap)

data <- read_csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/direcciones_chi.csv")
data$estado <- "CHIHUAHUA"
data$municipio <- "CHIHUAHUA"
data$pais <-  "MEXICO"

#inserto códigos postales
# PARA INSERTAR CÓDIGOS POSTALES IR AL SITITO OFICIAL DE SEPOMEX https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/Descarga.aspx 

cp <- read_csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/Copia%20de%20CP_CHIHUAHUA_CHI.csv")
cp$Asentamiento <-  toupper(cp$Asentamiento)
#quito acentos
cp$Asentamiento <- chartr("ÁÉÍÓÚ", "AEIOU", cp$Asentamiento)

# hago el marge con la base de datos de las coordenadas y la original
data <- merge(x=data, y=cp, by.x= "COLONIA", by.y="Asentamiento", all.x = TRUE)


#Separo calle
data <- data %>% separate(col=DIRECCION, into=c("calle", "colonia"), sep=", NÚMERO ")
data$calle<-gsub("CALLE","",as.character(data$calle))
data$calle<- sub(",.*", "",data$calle)
data$calle<- sub("#", "",data$calle)
data$calle<- sub("-", "",data$calle)
data$calle<- sub("/", "",data$calle)
data$calle<- sub(".", "",data$calle)

##Separo número
data <- data %>% separate(col=colonia, into=c("numero", "colonia"), sep=",")
data$calle<-gsub("NÚMERO","",as.character(data$calle))

##Limpio número para quitar interior
data <- data %>% separate(col=numero, into=c("numero", "interior"), sep=" INTERIOR")


#limpio nombre de  colonia
data$colonia<-gsub("COLONIA ","",data$colonia)
data$colonia<-gsub("COLONIA","",data$colonia)
#quito el espacio en blanco
data <- data %>%
  mutate(colonia = gsub("^\\s+", "", colonia))

#quito direcciones que tengas "sin datos"
data<- subset(data, calle != "SIN  DATOS")
data<- subset(data, calle != "SIN DATOS")
data<- subset(data, calle != "/")
#data<- subset(data, direccion != "SIN NUMERO")


#Genero columna con dirección limpia

data <- data %>% unite("direccion", c("calle","numero", "colonia","Código Postal" ,"municipio","estado"), na.rm = TRUE, remove = FALSE, sep = ", ")


#quito ñ
data$direccion <- gsub("Ñ", "", data$direccion)
#quito acentos
data$direccion <- chartr("ÁÉÍÓÚ", "AEIOU", data$direccion)
#quito
data$direccion <- removePunctuation(data$direccion)

#quito espacios iniciales en blanco
data <- data %>% mutate(direccion = gsub("^\\s+", "", direccion))

# pongo la columna de direcciones como vector
# Create a vector of the addresses you want to geocode
addresses <- data$direccion
addresses <- stripWhitespace(addresses)


######OPEN STREET MAP
##########try an catch



 ############NOTA

geocode_with_error_handling <- function(address) {
  result <- tryCatch(
    expr = {
      geocode_OSM(addresses)  # Replace with the actual function call
    },
    error = function(e) {
      # Handle the error here
      cat("An error occurred:", conditionMessage(e), "\n")
      return(NULL)  # Return something appropriate when an error occurs
    }
  )
  
  return(result)
}


address_to_geocode <- "123 Main St, City, Country"
geocoded_result <- geocode_with_error_handling(address_to_geocode)

if (!is.null(geocoded_result)) {
  # Process the geocoded result
  print(geocoded_result)
} else {
  # Handle the case when geocoding failed
  cat("Geocoding failed for:", address_to_geocode, "\n")
}

############3


# renombro para juntar las bases
geocoded_result <- geocoded_result %>% rename("direccion" = "query")

#elimino repeteciones para juntar bases muchos a 1
geocoded_result <- geocoded_result %>%
  filter(duplicated(direccion) == FALSE)

# hago el marge con la base de datos de las coordenadas y la original
base <- left_join(data, geocoded_result, by= "direccion")

# guardo la nueva base de datos
write.csv(base, "georreferenciados.csv")


########### GOOGLE API
#### alterntaiva de georeferencia

#SET api key
### ESTA LLAVE SE TIENE QUE CONFIGURAR PERSONALMENTE ESTE EJEMPLO YA NO ESTARÁ ACTIVO
#register_google(key = "AIzaSyB3kSKy6zlUi-G4uYYYDkKqCZ43F8H-s")


##########comenzar un proceso de google
geocode_with_error_handling <- function(address) {
  result <- tryCatch(
    expr = {
      #geocode(addresses)  # Replace with the actual function call
    },
    error = function(e) {
      # Handle the error here
      cat("An error occurred:", conditionMessage(e), "\n")
      return(NULL)  # Return something appropriate when an error occurs
    }
  )
  
  return(result)
}


address_to_geocode <- "123 Main St, City, Country"
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
write.csv(geocoded_result, "robos_georreferenciados_100.csv")

#le pego las direcciones para juntar con base principal
geocoded_result$direccion <- addresses


#elimino repeteciones para juntar bases muchos a 1
geocoded_result <- geocoded_result %>%
  filter(duplicated(direccion) == FALSE)

# hago el marge con la base de datos de las coordenadas y la original
base <- left_join(data, geocoded_result, by= "direccion")


write.csv(base, "robos_georreferenciados_100_final.csv")
