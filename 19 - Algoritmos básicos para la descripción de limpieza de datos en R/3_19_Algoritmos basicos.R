############################################
# Algoritmos básicos para la descripción de limpieza de datos en R                              
############################################

################################
# Estructura básica de un Script

# 2.1 Preámbulo
#   2.1.1 Limpiar espacio de trabajo
#   2.1.2 Establcer directorios de trabajo
#   2.1.3 Instalar y llamar librerías

# 2.2 Importar y exportar datos
# https://www.uv.es/vcoll/importar-exportar.html # material extra
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html # Informacion sobre grafica y distribucion

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
library(janitor)

##########################################
# 2.2 IMPORTAR Y EXPORTAR DATOS

##########
# Importar
# Desde paquetes instalados
data(iris)
head(iris, n = 4)

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv") # Al nombrar el archivo es necesario colocar toda la ruta o de lo contrario su nombre siempre y cuando este almacenado en la misma carpeta/directorio donde estoy trabajando

View(delitos) # Me muestra mi base de datos

# Exportar
# Guardar como csv
# write_csv (nombre_de_la_base_de_datos_a_guardar, "extension y nombre con el que voy a guardar mi base") 
# EJEMPLO (delitos, "Home/Union/haz/Documents/delitos_1.csv")

# Gruardar como excel
# write_xlsx (nombre_de_la_base_de_datos_a_guardar, "extension y nombre con el que voy a guardar mi base") 
# EJEMPLO (delitos, "Home/Union/haz/Documents/delitos_1.xlsx")

str(delitos) # Estructura de los delitos

# LIMPIEZA DE DATOS -------------------------------------------------------

colnames(delitos) # Veo los titulos de las columnas

delitos <- clean_names(delitos) # Limpio los titulos de mis columnas para que su escritura sea mas amigable con el texto

colnames(delitos) # Compruebo cambios

colnames(delitos)[1] <- "ano_hechos" # Cambiar nombre de las columnas de forma manual colocando en los corchetes el numero de columna y en las comillas el nuevo titulo
colnames(delitos)[5] <- "ano_inicio"

colnames(delitos) # Compruebo cambios

delitos1 = remove_empty(delitos, which = c("rows","cols")) # Elimina las columnas que están completamente vacías y las filas enteras que están completamente vacías.

# FILTRAR COLUMNAS

delito <- delitos1$delito # Genero una identificacion para las columnas que voy a apartar
categoria_delito <- delitos1$categoria_delito

columnas_nuevas <- data.frame(delito, categoria_delito) # Con las columnas identificadas genero mi nuevo frame y el orden en que aparecen las columnas es conforme las coloque dentro de los parentesis

# ORDENAR DATOS
 # NOTA: sort ordena los valores de mayor a menor, sin embargo si tengo mas columnas no conservara su complemento de fila
 # delitos1$edad_de_la_victima <- sort (delitos1$edad_de_la_victima, na.last = TRUE)

# Acendente en cuanto a la hora que suceden los hechos, asi sucede con numeros
delito_mas <- delitos1[order(delitos1$hora_hechos, na.last = TRUE), ] 
 # NOTA: "na.last = TRUE" coloca los valores NA al final

# Descendente (solo funciona con datos del tipo numerico)
delito_menos <- delitos1[order(-delitos1$latitud, na.last = TRUE), ]

# Alfabetico
delito_alfa <- delitos1[order(delitos1$alcaldia_hechos), ]

# FILTRAR TABLA POR CIERTO DATO DENTRO DE LA COLUMNA ASI MISMO VISUALIZAR RANGOS
# Un valor
col_febrero <- subset(delitos1, mes_inicio == "Febrero") # subset(nombre_del_frame, nombre_de_la_columna == "valor")
col_hora <- subset(delitos1, hora_inicio < 20) # Solo valores antes de las 8 pm

# Mas de uno (por medio de operadores logicos OR uno_u_otro "|" y AND ambos "&")
col_febrero_mas <- subset(delitos1, mes_inicio == "Febrero" | mes_hechos == "Febrero")
col_hora_mas <- subset(delitos1, hora_hechos < 22 & hora_hechos > 18)

col_union <- subset(delitos1, mes_hechos == "Febrero" & (hora_hechos < 22 & hora_hechos > 18)) # Hacer el filtrado con diferentes columnas y tipos de datos

table(delitos1$alcaldia_hechos)

# Generar un data frame con las fecuencias de los valor que toma mi variable
f1 <- table(delitos$alcaldia_hechos) # Selecciono como variable alcaldia del suceso

f2 <- as.data.frame(f1) %>%
  rename(Alcaldia = Var1, Frecuencia = Freq) # Genero el frame con los valores que toma la alcaldia y sus frecuencias

delitos1$alcaldia_hechos[delitos1$alcaldia_hechos == "GUSTAVO A. MADERO"] <- "GAM" # Modifico Gustavo A. Madero por GAM

###################
# 1. Observar las variables de la base de datos
# 2. Filtre la base de datos para un delito y un estado
# 3. Realice por lo menos 2 nuevos frames con el filtrado
# 4. Escribir código para generarlas
###################

## Guarda este script con tus modificaciones donde exploraste la base de datos, como recultado de tu ejercicio.
## También es resultado de tu ejercicio la base de datos modificiada que exportaste.
## Sube un archivo de word con tus conclusiones del ejercicio.
## Compartélo a la siguiente liga: 
#        https://forms.gle/txiejSN1pDhzvqij6 
