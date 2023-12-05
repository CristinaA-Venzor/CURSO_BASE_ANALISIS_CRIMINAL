############################################
# Errores comunes en el registro de información 
############################################

#############
rm(list=ls())                                   # Limpiar
setwd()  # Directorio/Carpeta a utilizar especificado dentro de los parentesis
#############

#Instalar librerías
#Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora

#install.packages("tidyverse")
# install.packages("janitor")

## Activar librerías
library(tidyverse)
library(janitor)

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/FGJ.csv")

# Veo las diemnsiones de la base de datos
dim(delitos)

# Borro valores duplicados cuando concuerdan en las columnas dentro de c
delitos <- delitos[!duplicated(delitos[ ,c(2)]), ]  # Delete rows
 
#reviso las nuevas dimensiones
dim(delitos)

#vemos que había líneas repetidas, por lo cuál ahora tenemos 72434 eventos.

#Contar Número de NAs: número de registros que no tiene información en datos de la colonia
sum(is.na(delitos$Edad))

# Básico
#Estandarizar nombre de variables

# re-escribios 3 nombres de variables 

#criterios: minúsculas, sin acentos, sin espacios, corta
colnames(delitos)[1] <- "NUMERO"
colnames(delitos)[5] <- "FECHA_INICIO"

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
delitos$categoria_del_delito <- sapply(delitos$categoria, quitar_acentos)

#extraigo datos 
total <- dim(delitos[1]) #Tomo la primera columna
categorria <-  table(delitos$delito) #Tomo la columna delitos

##########################################
#EJERCICIO

#0) Replica el ejercicio con la base de datos propia
#1) Cuántos valores faltantes hay en la columna "municipio_hechos"?
#2) Elimina los valores faltentes en municipio_hechos
#3) Elimina la columna si tiene más de la mitad de valores flatantes.
#4) elimina los acentos de otra columna que consideres necesario
#5) cambia la "ñ" por n en la columna de "fórmula dirección"
#6) sustituye espacios por NA en don de consideres necesario
#7) cuántos registros no tienen información de punto de referencia (NA)?

#sube tu este Script contestando las preguntas a esta liga:
# https://forms.gle/G8aJyP6vKVbYVTkb9
