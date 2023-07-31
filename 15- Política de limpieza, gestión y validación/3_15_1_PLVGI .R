############################################
# Limpieza de datos en R
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

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/fresnillo.csv?token=GHSAT0AAAAAACCJCBZJMLVQOMPBSFBBHPMAZGIISHQ")

# Básico
#Estandarizar nombre de variables
# revisamos nombres de variables
colnames(delitos)
# re-escribios las primeras 5 nombres de variables 

#criterios: minúsculas, sin acentos, sin espacios, corta
colnames(delitos)[1] <- "marca_temporal"
colnames(delitos)[2] <- "num_cosecutivo"
colnames(delitos)[3] <- "CUI"
colnames(delitos)[4] <- "num_interno"
colnames(delitos)[5] <- "fecha_rep_OP"

#Otra manera de limpiar todos los nombres de las variables 
delitos <- clean_names(delitos)

# revisamos nombres de variables
colnames(delitos)

#Eliminar acentos en calle y número 

delitos$`Calle y Numero` <- chartr("ÁÉÍÓÚ", "AEIOU", toupper(delitos$`Calle y Numero`))


#Sustituir espacios en blanco por NA en columna comunidad
delitos$Comunidad[delitos$Comunidad == ""] <- NA 

##########################################
#EJERCICIO

#1) cambia el nombre de otras 5 columnas con los criterios mencionados
#2) elimina los acentos de otra columna que consideres necesario
#3) cambia la "ñ" por n en la columna de "fórmula dirección"
#4) sustituye espacios por NA en "colina", "cruce", "tipo de lugar" y "punto de referencia"
#5) cuántos registros no tienen información de punto de referencia (NA)?

#sube tu este Script contestando las preguntas a esta liga:
# https://forms.gle/dPZVGAmpuG7mVQ3ZA

