############################################
# Limpieza de datos en R
############################################

#############
rm(list=ls())                                   # Limpiar
setwd()  # Directorio/Carpeta a utilizar especificado dentro de los parentesis
#############

## Instalar librerías
# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora

#install.packages("tidyverse")
#install.packages("janitor")

## Activar librerías
library(tidyverse)
library(janitor)

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# Básico
#Estandarizar nombre de variables
# revisamos nombres de variables
colnames(delitos)
# re-escribios 3 nombres de variables 

#criterios: minúsculas, sin acentos, sin espacios, corta
colnames(delitos)[1] <- "año_hechos"
colnames(delitos)[5] <- "año_inicio"
colnames(delitos)[13] <- "categoria_del_delito"

colnames(delitos)

#Otra manera de limpiar todos los nombres de las variables 
delitos <- clean_names(delitos)

# revisamos nombres de variables
colnames(delitos)

# Eliminar acentos en categoria del delito --------------------------------

# Definir una función para reemplazar acentos por caracteres sin acento
quitar_acentos <- function(texto) {
  texto <- iconv(texto, to = "ASCII//TRANSLIT")
  return(texto)
}

# Aplicar la función a la columna 'texto' del data frame
delitos$categoria_del_delito <- sapply(delitos$categoria_del_delito, quitar_acentos)

#Sustituir espacios en blanco por NA en columna comunidad
delitos$colonia_datos[delitos$colonia_datos == ""] <- NA 

##########################################
#EJERCICIO

#1) cambia el nombre de otras 5 columnas con los criterios mencionados
#2) elimina los acentos de otra columna que consideres necesario
#3) cambia la "ñ" por n en la columna de "fórmula dirección"
#4) sustituye espacios por NA en don de consideres necesario
#5) cuántos registros no tienen información de punto de referencia (NA)?

#sube tu este Script contestando las preguntas a esta liga:
# https://forms.gle/dPZVGAmpuG7mVQ3ZA
