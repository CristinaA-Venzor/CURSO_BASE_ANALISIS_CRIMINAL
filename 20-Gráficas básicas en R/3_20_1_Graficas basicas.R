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
library('data.table')
library(janitor)

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

# Sin ggplot --------------------------------------------------------------

hist(b) # Histograma a partir de las edades

boxplot(valores) # Diagrama de caja basada en los valores de los cuartiles

plot(density(valores), col="red") # Muestra la grafica de densidad en cuanto a donde se concentran los datos pudiendo modificar el color de la linea

# GUARDAR EN EXTENSION DE IMAGEN
# En la parte de los plots una vez visualizada la grafica a modificar me voy a export y selecciono el tipo de archivo a utilizar

# Con ggplot --------------------------------------------------------------

# Grafica de densidad
densidad <- ggplot() +
  aes(valores) + # Indico los valores a trabajar
  geom_density() + # Indico el tipo de grafico
  labs(title = "Grafica de densidad", x = "Edades", y = "Porcentaje") # Coloco titulos a las partes de mi grafica (titulo, eje y/vertical, eje x/horizontal)

ggsave(filename = "grafico_densidad.png", plot = densidad, width = 8, height = 6, dpi = 300) # Generar png

# Histograma junto la grafica de densidad usando frecuencias relativas
histograma_densidad <- ggplot() +
  aes(valores) +
  geom_histogram(aes(y=..density..), position = "identity", alpha=0.5) + # Añado un histograma donde "y=..density.." para el uso de frecuencias acumuladas
  geom_density(alpha=0.6) # Añado un grafico de densidad

ggsave(filename = "histograma_densidad_frecuencias_relativas.png", plot = histograma_densidad, width = 8, height = 6, dpi = 300)

# Funcion de distribucion acumulada
distribucion_acumulada <- ggplot() +
  aes(valores) +
  stat_ecdf(geom = "step") # Indico el uso de una distribucion acumulada

ggsave(filename = "distribucion_acumulada.png", plot = distribucion_acumulada, width = 8, height = 6, dpi = 300)

##############
## INFORMACION DE LAS GRAFICAS DE FRECUENCIAS CON ELEMENTOS DEL TIPO CARACTER

# Generar un data frame con las fecuencias de los valor que toma mi variable
f1 <- table(delitos$sexo_de_la_victima) # Selecciono como variable sexo de la victima

f2 <- as.data.frame(f1) %>%
  rename(valor = Var1, frecuencia = Freq) # Genero el frame con los valores que toma sexo y sus frecuencias

grafica_f2 <- f2[f2$valor %like% "^H|^M", ] # Hago una depuracion en cuanto a terminos especificos en este caso coloco 2 condiciones con ayuda de "|" (inicien con letra H o M)

final <- grafica_f2 %>%
  mutate(valor = ifelse(valor %in% c("Hombre", "HOMBRE"), "Hombre", valor)) %>%
  group_by(valor) %>%
  summarise(Frecuencia_Total = sum(frecuencia)) # Unifico los terminos Hombre y HOMBRE y sumo sus frecuencias

final$valor[final$valor == "11"] <- "Mujer" # Modifico el valor 11 que no encaja por el valor correcto

# Generacion del grafico
grafico <- ggplot(final, aes(x = valor, y = Frecuencia_Total)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Gráfico de Frecuencias", x = "Valor", y = "Frecuencia") # Genero la grafica y en los valores de x coloca las opciones que puede tener sexo

print(grafico)
ggsave(filename = "grafico_sexo.png", plot = grafico, width = 8, height = 6, dpi = 300)

##########
# Exportar las bases de datos modificadas
write_csv(abc, "Edades.csv")  # Escribe en raíz

###################
# 1. Observar las variables de la base de datos
# 2. Filtre la base de datos para un delito y un estado
# 3. Realice por lo menos 3 visualizaciones de los datos con las que se puedan responder interrogantes
# 4. Escribir código para generarlas
###################

## Guarda este script con tus modificaciones donde exploraste la base de datos, como recultado de tu ejercicio.
## También es resultado de tu ejercicio la base de datos modificiada que exportaste.
## Sube un archivo de word con tus conclusiones del ejercicio.
## Compartélo a la siguiente liga: 
#        https://forms.gle/MdjKNikE5JzetfMQA 
