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

## Instalar librerías
# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora
# install.packages("janitor")
# install.packages("dplyr")
# install.packages("readr")

## Activar librerías
library(readr) # Para importar de distintos formatos con delimitadores
library(dplyr)
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

# Limpieza de datos
delitos <- clean_names(delitos) # Limpio los titulos de mis columnas para que su escritura sea mas amigable con el texto

data("mtcars")
Carritos <- as.data.frame(mtcars)

?mtcars

Carritos <- Carritos %>% rename(millas_por_galon = mpg, cilindros = cyl, desplazamiento = disp, potencia = hp, relacion_eje = drat, peso = wt, velocidad = qsec, motor = vs, transmicion = am, n_velocidades = gear, n_carburadores = carb)

a <- Carritos$potencia # Guardamos la columna de la potencia de un auto
is.numeric(a) # Verificamos que los datos sean del tipo numerico para poder trabajarlo en las medidas de tendencia central
a <- as.numeric(a) # Pasamos nuestros datos al tipo numerico
a <- na.omit(a) # Omitimos todos los valores nulos que estan guardados dentro de mi variable

abc <- data.frame (y=a[a>0]) # Genero un nuevo frame con las edades donde por mera logica elimino los valores que no tendrian sentido en este caso edades mayorea a 100
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
write_csv(abc, "Potencia.csv")  # Escribe en raíz

###################
# 1. Observar las variables de la base de datos
# 2. Plantear dos preguntas
# Deben ser sobre un subconjunto del universo de datos
# Pueden usar cualquier vía para responder
# 3. Obtener las medidas de tendnecia central de su estado o en su defecto de la tabla muestra
# 3. Escribir código para responderlas
##########

## guarda este script con tus modificaciones donde exploraste la base de datos, como recultado de tu ejercicio.
## También es resultado de tu ejercicio la base de datos modificiada que exportaste
## Sube un archivo de word con tus conclusiones del ejercicio
## compartélo a la siguiente liga: 
#        https://forms.gle/QAzaEccj6CLNqYfn6 
