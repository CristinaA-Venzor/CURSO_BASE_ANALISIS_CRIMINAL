############################################
# Generación de código para tablas                                
############################################

################################
# Estructura básica de un Script

# 2.1 Preámbulo
#   2.1.1 Limpiar espacio de trabajo
#   2.1.2 Establcer directorios de trabajo
#   2.1.3 Instalar y llamar librerías

# 2.2 Exportar datos
# https://www.uv.es/vcoll/importar-exportar.html # material extra
# https://bookdown.org/jboscomendoza/r-principiantes4/tablas-datos-rectangulares.html #Informacion sobre exportar tablas

##################################
# 2.1.1 LIMPIAR ESPACIO DE TRABAJO

rm(list=ls()) # Limpio los datos que hay en mi memoria
ls() # visualizar lista los objetos que hay en RAM

###########################
# 2.1.2 ESTABLECER DIRECTORIOS DE TRABAJO
getwd() # Pregunto directorio de trabajo
# Ejemplo
# setwd("/Users/cristinTOR/CURSO/Sesiones presenciales R") # Cambio directorio de trabajo en una carpeta dentro de mi unidad
setwd() # Dentro de los parentesis indico mi directorio/carpeta a trabaja si quiero cambiar
getwd() # Vuelvo a preguntar cuál es el directorio de trabajo
list.files(getwd()) # Qué archivos contiene mi directorio de trabajo
# Establecer rutas alternativas para proyectos más ordenados

# EJEMPLOS
# mi_dir <- setwd("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/CURSO")
# resultados <-  setwd("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/CURSO/Sesiones presenciales /RESULTADOS")

#################################
# 2.1.3 INSTALAR Y CARGAR LIBRERIAS

# En cuestión de estilo, hay quien prefiere instalar-cargar las librerías justo antes de usarlas a medio código.

# install.packages("readr")
library(readr) # Para importar de distintos formatos con delimitadores
# install.packages("foreign")
library(foreign) # Para importa de distintos formatos
# install.packages("haven")
# install.packages("Hmisc")
# install.packages("stargazer")
# install.packages("readxl")
# install.packages('epiDisplay')
library(epiDisplay)
library(haven) # Paquete para importar archivos DTA (Stata)
library(xlsx) # Paquete para exportar archivos en Excel
library(Hmisc) #Paquete par mostrar estad?sticas descriptivas
library(stargazer) #Paquete par mostrar estad?sticas descriptivas
library(readxl) # Otro paquete para leer libros de excel
library(sjlabelled) # Paquete para etiquetar variables
#install.packages("tidyverse")
library(tidyverse) # Metapaquete para Manipular datos (magrittr, dplyr, ggplot2, tidyr, purrr)
#devtools::install_github("hadley/tidyverse")
library(datasets) # Contiene Dataset "iris"
library(ggplot2)
library('data.table')
# install.packages("dplyr")
library(tidyr)
# install.packages("tibble")
library(tibble) # Volver el numero de renglones a una columna mas
# install.packages("writexl")
library(writexl)

##############
#  MI DATA FRAME

##############
# Generar vectores

a <- sample(1:5, 10, replace = TRUE) # Generar una numeracion aleatoria "sample(valores_posibles, longitud, replace = TRUE)"
b <- vector(mode = "logical", length = 10) # Los valores contenidos son de valor 0 "vector(mode = "tipo de dato", length = extension)"
c <- 1:10 # Secuencia numerica
d <- c("A", "B", "C", "A", "B", "C", "D", "E", "F", "G") # Concatenar datos

length(a) # Checo cuantos valores contienen mis vectores, para que todos los de mi tabla tengan la misma longitud
length(b)
length(c)
length(d)

mi_frame <- data.frame(c, d, b, a) # Genero mi tabla con los vectores formulados

mi_frame <- data.frame(secuencia = c, letras = d, vacio = b, suerte = a) # Modifico los titulos de mi tabla
colnames(mi_frame) # Visualizo los titulos de las columnas de mi data frame

# Busqueda de informacion

mi_frame[1:3, ] # Indico que filas usar
mi_frame[, c(1,3)] # Indico que columnas usar (coordenada)
mi_frame[, c("letras", "vacio")] # Indico que columnas usar (titulo)
mi_frame[mi_frame$suerte == 3, ] # Que valor aceptar (Numerico)
mi_frame[mi_frame$letras == "B" | mi_frame$letras == "A", ] # Que valor aceptar (Caracter)
mi_frame[5, 3] # Coordenada especifica

mi_frame[mi_frame$suerte < 3, ] # Rango
nrow(mi_frame[mi_frame$suerte < 3, ]) # Me muestra cuantas filas existen con esta condicion

head(mi_frame) # Muestra las primeras 6 filas
tail(mi_frame) # Muestra las ultimas 6 filas

ncol(mi_frame) # Muestra el numero de columnas
dim(mi_frame) # Muestra las dimensiones de mi data frame

nuevo_frame <- tibble::rownames_to_column(mi_frame, "Guia") # Los valores de inicio de la columna "Guia" los añado al data frame

##########################################
# 2.2 EXPORTAR DATOS

##########

# Guardar como csv
write_csv (mi_frame, "frame1.csv") # write_csv (nombre_de_la_base_de_datos_a_guardar, "extension y nombre con el que voy a guardar mi base") 

# Gruardar como excel
write_xlsx (nuevo_frame, "frame2.xlsx") # write_xlsx (nombre_de_la_base_de_datos_a_guardar, "extension y nombre con el que voy a guardar mi base") 

###################
# 1. Generar la base de datos
# 2. Filtre la base de datos para su uso
# 3. Realice por lo menos 3 preguntas que pueda resolver con el filtrado
# 4. Escribir código para generarlas
##########

## Guarda este script con tus modificaciones donde exploraste la base de datos, como recultado de tu ejercicio.
## También es resultado de tu ejercicio la base de datos modificiada que exportaste.
## Sube un archivo de word con tus conclusiones del ejercicio.
## Compartélo a la siguiente liga: 
#        https://forms.gle/KPpzRhN8MRB6gENc7 
