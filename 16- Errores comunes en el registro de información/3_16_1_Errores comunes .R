############################################
# Errores comunes en el registro de información 
############################################

#############
rm(list=ls())                                   # Limpiar
setwd()  # Directorio/Carpeta a utilizar especificado dentro de los parentesis
#############

#devtools::install_github("hadley/tidyverse")
library(tidyverse)   # Contiene ggplot2
library(readr)
library(dplyr)
#install.packages("janitor")
library(janitor)
#install.packages("usethis")
library("usethis")
library(datasets)

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# Veo las diemnsiones de la base de datos
dim(delitos)

# Borro valores duplicados cuando concuerdan en las columnas dentro de c
delitos <- delitos[!duplicated(delitos[ ,c(4, 8, 11, 17)]), ]  # Delete rows
 
#reviso las nuevas dimensiones
dim(delitos)

#vemos que había líneas repetidas, por lo cuál ahora tenemos 65333 eventos.

#Contar Número de NAs: número de registros que no tiene información en datos de la colonia
sum(is.na(delitos$colonia_datos))

data(iris) # Recurro a una base de datos dentro de R

# Supongo que faltan valores, calculo el promedio Petal.Width sin considerar valores nulos
iris$Petal.Width[is.na(iris$Petal.Width)]
mean(iris$Petal.Width,na.rm=TRUE)

##########################################
#EJERCICIO

#1) Cuántos valores faltantes hay en la columna "municipio_hechos"?
#2) Elimina los valores faltentes en municipio_hechos
#3) Eliina la columna si tiene más de la mitad de valores flatantes.

#sube tu este Script contestando las preguntas a esta liga:
# https://forms.gle/G8aJyP6vKVbYVTkb9
