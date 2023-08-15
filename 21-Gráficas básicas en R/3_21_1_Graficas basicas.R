############################################
# Gráficas básicas en R                                 
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
library(ggplot2)

##########################################
# 2.2 IMPORTAR Y EXPORTAR DATOS

##########
# Importar
# Desde paquetes instalados
data(iris)
head(iris, n = 4)

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv") # Recurro a una fuente de internet

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

# Generar un data frame con las fecuencias de los valor que toma mi variable
f1 <- table(delitos$fecha_hechos) # Selecciono como variable la fecha de los hechos

f2 <- as.data.frame(f1) %>%
  rename(Dia = Var1, Frecuencia = Freq) # Genero el frame con los valores que toma la fecha y sus frecuencias

grafico <- ggplot(f2, aes(x = Dia, y = Frecuencia)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Gráfico de Frecuencias", x = "Valor", y = "Frecuencia") + # Genero la grafica y en los valores de x coloca las opciones que puede tener el dia
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 4))
print(grafico)
ggsave(filename = "grafico_densidad.png", plot = grafico, width = 8, height = 6, dpi = 300) # Generar png de modo que se vean todas las fechas

data("mtcars") # Recurro a fuente R para visualizar otros ejemplos
Carritos <- as.data.frame(mtcars)

Carritos <- Carritos %>% rename(millas_por_galon = mpg, cilindros = cyl, desplazamiento = disp, potencia = hp, relacion_eje = drat, peso = wt, velocidad = qsec, motor = vs, transmicion = am, n_velocidades = gear, n_carburadores = carb) # Remplazo los titulos

a <- Carritos$potencia # Guardamos la columna de la potencia de un auto
is.numeric(a) # Verificamos que los datos sean del tipo numerico para poder trabajarlo en las medidas de tendencia central
a <- as.numeric(a) # Pasamos nuestros datos al tipo numerico
a <- na.omit(a) # Omitimos todos los valores nulos que estan guardados dentro de mi variable

abc <- data.frame (y=a) # Genero un nuevo frame
valores <- abc$y # Genero mi variable donde estaran contenidos los valores ya limpios
is.numeric(valores)

valores <- sort (valores) # Ordeno mis valor de menor a mayor
unique (valores) # Muestro que valores pueden tomar los datos de mi variable

# Sin ggplot --------------------------------------------------------------

hist(valores) # Histograma a partir de la potencia

boxplot(valores) # Diagrama de caja basada en los valores de los cuartiles

plot(density(valores), col="red") # Muestra la grafica de densidad en cuanto a donde se concentran los datos pudiendo modificar el color de la linea

# GUARDAR EN EXTENSION DE IMAGEN
# En la parte de los plots una vez visualizada la grafica a modificar me voy a export y selecciono el tipo de archivo a utilizar

# Con ggplot --------------------------------------------------------------

# Grafica de densidad
densidad <- ggplot() +
  aes(valores) + # Indico los valores a trabajar
  geom_density() + # Indico el tipo de grafico
  labs(title = "Grafica de densidad", x = "Potencia", y = "Porcentaje") # Coloco titulos a las partes de mi grafica (titulo, eje y/vertical, eje x/horizontal)
print(densidad)
ggsave(filename = "grafico_densidad.png", plot = densidad, width = 8, height = 6, dpi = 300) # Generar png

# Histograma junto la grafica de densidad usando frecuencias relativas
histograma_densidad <- ggplot() +
  aes(valores) +
  geom_histogram(aes(y=..density..), position = "identity", alpha=0.5) + # Añado un histograma donde "y=..density.." para el uso de frecuencias acumuladas
  geom_density(alpha=0.6) # Añado un grafico de densidad
print(histograma_densidad)
ggsave(filename = "histograma_densidad_frecuencias_relativas.png", plot = histograma_densidad, width = 8, height = 6, dpi = 300)

# Funcion de distribucion acumulada
distribucion_acumulada <- ggplot() +
  aes(valores) +
  stat_ecdf(geom = "step") # Indico el uso de una distribucion acumulada
print(distribucion_acumulada)
ggsave(filename = "distribucion_acumulada.png", plot = distribucion_acumulada, width = 8, height = 6, dpi = 300)

##########
# Exportar las bases de datos modificadas
write_csv(abc, "Potencia_1.csv")  # Escribe en raíz

###################
# 1. Observar las variables de la base de datos
# 2. Plantear dos preguntas
# Deben ser sobre un subconjunto del universo de datos
# Pueden usar cualquier vía para responder
# 3. Obtener las medidas de tendnecia central
# 3. Escribir código para responderlas
##########

## guarda este script con tus modificaciones donde exploraste la base de datos, como recultado de tu ejercicio.
## También es resultado de tu ejercicio la base de datos modificiada que exportaste
## Sube un archivo de word con tus conclusiones del ejercicio
## compartélo a la siguiente liga: 
#        https://forms.gle/eK4s3dRou7vXZ7zb9
