###### Limpiar variable fecha dese formato excel(.xlsx)


# librerías ---------------------------------------------------------------

#install.packages("readWorksheetFromFile")
#install.packages("readxl")
#install.packages("janitor")
#install.packages("tidyr")

library(readxl)
library(janitor)
library(tidyr)

# Cargar base -------------------------------------------------------------

#Ruta de archivo
setwd("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/NAYARIT")
#Nombre de archivo
delitos <- read_excel("sexuales.xlsx")
#limpiamos nombres de columnas
delitos <- clean_names(delitos)

# Limpiar fecha y hora ----------------------------------------------------

#convertimos el dato de fecha de denuncia primero a numércio, después a fecha,
#Sin embargi, como el excel tiene formato fecha de origen, le decimos a R que lo
#convierta desde la fecha origen de excel que es "1899-12-30"
delitos$fecha_de_denuncia <- as.Date(as.numeric(delitos$fecha_de_denuncia), origin = "1899-12-30")

#Separamos primeros datos y hora
delitos <- delitos %>% separate(col=hora, into=c("fecha", "hora"), sep=" ")

#convertimos ne formato hora 24 horas
delitos$hora <- as.POSIXct(delitos$hora, format = "%H:%M:%S")
#Volvemos a sperar primeros datos y hora
delitos <- delitos %>% separate(col=hora, into=c("fecha", "tiempo"), sep=" ")


