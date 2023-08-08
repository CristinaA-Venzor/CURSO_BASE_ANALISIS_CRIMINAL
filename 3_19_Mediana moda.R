############################################
# Mediana, moda y distribución de datos                                 
############################################

################################
# Estructura básica de un Script

# 2.1 Preámbulo
#   2.1.1 Limpiar espacio de trabajo
#   2.1.2 Establcer directorios de trabajo
#   2.1.3 Instalar y llamar librerías

# 2.2 Importar y exportar datos
# https://www.uv.es/vcoll/importar-exportar.html # material extra
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html #Informacion sobre grafica y distribucion

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

##########################################
# 2.2 IMPORTAR Y EXPORTAR DATOS

##########
# Importar
# Desde paquetes instalados
data(iris)
head(iris, n = 4)

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("zacatecas.csv", check.names = F) # Al nombrar el archivo es necesario colocar toda la ruta o de lo contrario su nombre siempre y cuando este almacenado en la misma carpeta/directorio donde estoy trabajando

View(delitos) # Me muestra mi base de datos

# Exportar
# Guardar como csv
 # write_csv (nombre_de_la_base_de_datos_a_guardar, "extension y nombre con el que voy a guardar mi base") 
# EJEMPLO (delitos, "Home/Union/haz/Documents/delitos_1.csv")

# Gruardar como excel
 # write_xlsx (nombre_de_la_base_de_datos_a_guardar, "extension y nombre con el que voy a guardar mi base") 
# EJEMPLO (delitos, "Home/Union/haz/Documents/delitos_1.xlsx")

str(delitos) # Estructura de los delitos

# Limpieza de datos
delitos <- clean_names(delitos) # Limpio los titulos de mis columnas para que su escritura sea mas amigable con el texto

a <- delitos$edad_de_la_victima # Guardamos la columna de la edad de la victima
is.numeric(a) # Verificamos que los datos sean del tipo numerico para poder trabajarlo en las medidas de tendencia central
a <- as.numeric(a) # Pasamos nuestros datos al tipo numerico
a <- na.omit(a) # Omitimos todos los valores nulos que estan guardados dentro de mi variable

abc <- data.frame (y=a[a<100]) # Genero un nuevo frame con las edades donde por mera logica elimino los valores que no tendrian sentido en este caso edades mayorea a 100
valores <- abc$y # Genero mi variable donde estaran contenidos los valores ya limpios
is.numeric(valores)

valores <- sort (valores) # Ordeno mis valor de menor a mayor
unique (valores) # Muestro que valores pueden tomar los datos de mi variable

# Medidas de tendencia central (media, moda, mediana) ---------------------

mean(valores) # Media

median(valores) # Mediana

frecuencias <- table(valores)
moda <- as.numeric(names(frecuencias[which.max(frecuencias)]))
print(moda) # Moda

# Distribución de datos ---------------------------------------------------

max (valores) # Hallar el valor maximo
min (valores) # Hallar el valor minimo

quantile (valores) # Me muestra los cuatro cuartiles

stem (valores) # Me da el grafico/tabla tallo-hoja

summary (valores) # Me muestra valores estadosticos (minimo, primer cuartil, mediana, media, tercer cuartil, maximo)

##########
# Exportar las bases de datos modificadas
write_csv(abc, "Edades.csv")  # Escribe en raíz

###################
# 1. Observar las variables de la base de datos
# 2. Plantear dos preguntas
# Deben ser sobre un subconjunto del universo de datos
# Pueden usar cualquier vía para responder
# 3. Obtener las medidas d etendnecia central de su estado para el año 2022 en hocmidios dolosos
# 3. Escribir código para responderlas
##########


## guarda este script con tus modificaciones donde exploraste la base de datos, como recultado de tu ejercicio.
## También es resultado de tu ejercicio la base de datos modificiada que exportaste
## Sube un archivo de word con tus conclusiones del ejercicio
## compartélo a la siguiente liga: 
#        https://forms.gle/MdjKNikE5JzetfMQA 

