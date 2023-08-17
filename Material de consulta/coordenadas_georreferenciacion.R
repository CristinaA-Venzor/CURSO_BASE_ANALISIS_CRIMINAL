
########## Obtener coordenadas de multiplse direcciones #####
#############################################################
############# Archivo 2020 ##################################

## paquetes
library(readxl)
library(readr)
#install.packages("tmaptools")
library(tmaptools)
library(tidyverse)


## cargo base de direciones

data <- read_csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/BASE_DIRECCIONES_EJEMPLO.csv")

#corto base para prueba rápida
data <- data[1:100, ]


#Agrego estado a la base de datos
data$EDO <- "Sonora"

#Separo Colonia

data <- data %>% separate(col=COLONIA, into=c("colonia", "calle"), sep=", Calle:")
data$colonia<-gsub("Colonia:","",as.character(data$colonia))

#Separo Calle
data <- data %>% separate(col=calle, into=c("calle", "numero"), sep=" Número:")
data$calle<-gsub(",","",as.character(data$calle))

#Separo Número
data <- data %>% separate(col=numero, into=c("num", "otro"), sep="Entre Calle1 :")
data$num<-gsub(",","",data$num)


#Genero columna con dirección limpia

data <- data %>% unite("direccion", c("calle","num", "MUNICIPIO", "EDO"), na.rm = TRUE, remove = FALSE, sep = ", ")

# borro variables basura
data <- data[,!names(data) %in% c("otro", "colonia", "calle", "num", "MUNICIPIO", "EDO")]

# pongo la columna de direcciones como vector
# Create a vector of the addresses you want to geocode
addresses <- data$direccion


# Use the geocode_OSM() function to retrieve the coordinates
coordinates <- geocode_OSM(addresses)

# The function returns a data frame with the latitude and longitude coordinates
as.data.frame(coordinates)
# renombro para juntar las bases
coordinates <- coordinates %>% rename("direccion" = "query")

#elimino repeteciones para juntar bases muchos a 1
coordinates <- coordinates %>%
  filter(duplicated(direccion) == FALSE)

# hago el marge con la base de datos de las coordenadas y la original
base <- left_join(data, coordinates, by= "direccion")



###################################################################
####Para toda la base de datos, una vez que probé con los primeros 100

data <- read_xlsx("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/BASE_DIRECCIONES_EJEMPLO.csv")

#Separo Colonia

data_1 <- data_1 %>% separate(col=COLONIA, into=c("colonia", "calle"), sep=", Calle:")
data_1$colonia<-gsub("Colonia:","",as.character(data_1$colonia))

#Separo Calle
data_1 <- data_1 %>% separate(col=calle, into=c("calle", "numero"), sep=" Número:")
data_1$calle<-gsub(",","",as.character(data_1$calle))

#Separo Número
data_1 <- data_1 %>% separate(col=numero, into=c("num", "otro"), sep="Entre Calle1 :")
data_1$num<-gsub(",","",data_1$num)

#Genero columna con dirección limpia
data_1$EDO <- "Sonora"
data_1 <- data_1 %>% unite("direccion", c("calle","num", "MUNICIPIO", "EDO"), na.rm = FALSE, remove = FALSE, sep = ", ")

# pongo la columna de direcciones como vector
# Create a vector of the addresses you want to geocode
delito1 <- data_1
addresses <- delito1$direccion

# Use the geocode_OSM() function to retrieve the coordinates
#####coordinates <- geocode_OSM(addresses)

# The function returns a data frame with the latitude and longitude coordinates
as.data.frame(coordinates)
# renombro para juntar las bases
coordinates <- coordinates %>% rename("direccion" = "query")

#elimino repeteciones para juntar bases muchos a 1
coordinates <- coordinates %>%
  filter(duplicated(direccion) == FALSE)

# hago el marge con la base de datos de las coordenadas y la original
delito1 <- left_join(delito1, coordinates, by= "direccion")

#Exporto base de datos
write.csv(delito1,file= " ")
