
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

base <- base[, c(1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,9,29,30,31,32,33,34)]


###################################################################
####filtrado de base original

data <- read_xlsx("/Users/cristinaalvarez/Downloads/2020.xlsx")

# Tiro todos los registros duplicados
data_1 <- distinct(data, NUC, .keep_all = TRUE)

#Separo Colonia

data_1 <- data_1 %>% separate(col=COLONIA, into=c("colonia", "calle"), sep=", Calle:")
data_1$colonia<-gsub("Colonia:","",as.character(data_1$colonia))

#Separo Calle
data_1 <- data_1 %>% separate(col=calle, into=c("calle", "numero"), sep=" Número:")
data_1$calle<-gsub(",","",as.character(data_1$calle))

#Separo Número
data_1 <- data_1 %>% separate(col=numero, into=c("num", "otro"), sep="Entre Calle1 :")
data_1$num<-gsub(",","",data_1$num)

##cuento los que no tienen dirección completa
## coloco un 1 a los que les falta número, colonia o calle

data_1$n <- 0
data_1$n[is.na(data_1$colonia)] <- 1
data_1$n[is.na(data_1$num)] <- 1
data_1$n[is.na(data_1$calle)] <- 1
data_1$n[data_1$calle == "" |data_1$calle == " "|data_1$calle == "   "|data_1$calle == " ....."] <-1
data_1$n[data_1$num == "  " |data_1$num == "  "|data_1$num == "."] <-1
data_1$n[data_1$colonia == "  " |data_1$colonia == "  "|data_1$colonia == ""] <-1
sum(data_1$n)


View(data_1[, c(9,10,11,33)])


#Genero columna con dirección limpia
data_1$EDO <- "Sonora"
data_1 <- data_1 %>% unite("direccion", c("calle","num", "MUNICIPIO", "EDO"), na.rm = FALSE, remove = FALSE, sep = ", ")


#filtro: data_1 = dirección válida
data_1 <- subset(data_1, n != 1)

#filtro: data_2 = dirección no válida
data_2 <- subset(data_1, n == 1)

#tablas de frecuencias por municipio
tabla <- as.data.frame(table(data_1$MUNICIPIO))
tabla2 <- as.data.frame(table(data_2$MUNICIPIO))

tabla <- subset(tabla, Freq >= 200)
tabla2 <- subset(tabla2, Freq >= 200)
tabla$incompleta <-tabla2$Freq

#frecuencias por delito dentro de hermosillo
data_11 <- subset(data_1, MUNICIPIO == "Hermosillo")
delito <- as.data.frame(table(data_11$DELITO))
sum(delito$Freq)
delito$porcetaje <- (delito$Freq/11752)*100

data_22 <- subset(data_2, MUNICIPIO == "Hermosillo")
delito2 <- as.data.frame(table(data_22$DELITO))

### Filtro el delito con mayor frecuencia = violencia familiar

delito1 <- subset(data_11, DELITO == "Art.234-A Violencia Familiar")

# pongo la columna de direcciones como vector
# Create a vector of the addresses you want to geocode
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

#Borro varibles basura

delito1 <- delito1[,!names(delito1) %in% c("otro", "colonia", "calle", "num", "MUNICIPIO", "EDO", "lon_max","lat_max","lon_min", "lat_min","n", "CIUDAD", "LOCALIDAD" )]

# Acomodo bases
delito1 <- delito1[, c(1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,9,27,28)]

#Exporto base de datos
write.csv(delito1,file='/Users/cristinaalvarez/Downloads/georef_violenciafam_hermosillo.csv',fileEncoding = "UTF-8")
