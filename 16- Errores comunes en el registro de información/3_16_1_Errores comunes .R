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


gitcreds::gitcreds_set()
credentials::set_github_pat("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")

# Desde archivos separados por delimitador (como CSV)

delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/fresnillo.csv?token=GHSAT0AAAAAACCJCBZJCPSDOZ5FNJZNQGWEZGJFLJA")

# Veo las diemnsiones de la base de datos

dim(delitos)

# Borro valores duplicados en el el identificador CUI
delitos <- delitos[!duplicated(delitos[ ,3]), ]  # Delete rows
 
#reviso las nuevas dimensiones
dim(delitos)

#vemos que había una línea repetida en el identificador único, lo cuál ahora tenemos
#342 eventos.

#Contar Número de NAs- número de registros que no tiene información en comunidad
sum(is.na(delitos$Comunidad))

#contar valores faltantes en Sexo de la victima
sum(is.na(delitos$Edad.de.la.víctima))

# Como faltan valores, calcilo el promedio de la edad y los imputo en los faltantes
delitos$Edad.de.la.víctima[is.na(delitos$Edad.de.la.víctima)] <- mean(delitos$Edad.de.la.víctima,na.rm=TRUE)

#contar valores faltantes en Sexo de la victima
sum(is.na(delitos$Edad.de.la.víctima))

##########################################
#EJERCICIO

#1) Cuántos valores faltantes hay en la columna "Colonia"?
#2) Elimina los valores faltentes en Colonia
#3) Eliina la columna si tiene más de la mitad de valores flatantes.

#sube tu este Script contestando las preguntas a esta liga:
# https://forms.gle/G8aJyP6vKVbYVTkb9

