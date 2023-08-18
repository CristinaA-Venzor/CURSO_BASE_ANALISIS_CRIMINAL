#### Limpieza de direcciones y Georeferenciación gratuita
## Resultados: 62% de direcciones totales georreferenciadas
##             64% de direcciones válidas georreferenciadas


library(readr)
library(dplyr)
library(tmaptools)
library(tm)

#setwd("/Users/cristinaalvarez/Downloads")
data <- read_csv("robos.csv")
data <- data[, 1:27]
data$estado <- "CHIHUAHUA"
data$municipio <- "CHIHUAHUA"

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

data <- data %>% unite("direccion", c("calle","numero", "municipio","estado"), na.rm = TRUE, remove = FALSE, sep = ", ")

# borro variables basura
#data <- data[, c(1,3)]


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



# Use the geocode_OSM() function to retrieve the coordinates
#coordinates_5 <- geocode_OSM(addresses)
#Quitar el comentario del comando para ejecutar: Nota tarda 45 min aprox en ejecutar

coordinates <- coordinates_5
# The function returns a data frame with the latitude and longitude coordinates
as.data.frame(coordinates)
# renombro para juntar las bases
coordinates <- coordinates %>% rename("direccion" = "query")

#elimino repeteciones para juntar bases muchos a 1
coordinates <- coordinates %>%
  filter(duplicated(direccion) == FALSE)

# hago el marge con la base de datos de las coordenadas y la original
base <- left_join(data, coordinates, by= "direccion")

base <- base[, 1:35]
write.csv(base, "robos_georreferenciados_62.csv")
