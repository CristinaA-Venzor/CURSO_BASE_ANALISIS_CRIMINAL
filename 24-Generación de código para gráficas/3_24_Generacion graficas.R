############################################
# Generación de código para gráficas 
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
library(datasets)
#install.packages("pivottabler")
library(pivottabler)
library(ggplot2)
library(magrittr)
library('data.table')
library(RCurl)
# install.packages("lubridate")
library(lubridate)
# install.packages("zoo")
library(zoo)

# Desde archivos separados por delimitador mediante un link (CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

VIF <- subset.data.frame(delitos, delito == "VIOLENCIA FAMILIAR") # Hago un filtrado del delito violencia familiar

# Grafico mensual ---------------------------------------------------------

f1 <- table(VIF$mes_hechos) # Selecciono como variable el mes de los hechos

f2 <- as.data.frame(f1) %>%
  rename(valor = Var1, frecuencia = Freq) # Genero el frame con los valores en el mes que sucede y sus frecuencias

# Define el orden específico de las categorías dado que se ordena por el valor de la frecuencia
orden_especifico <- c("Enero", "Febrero", "Marzo", "Abril")

f2$valor <- factor(f2$valor, levels = orden_especifico) # Convierte la columna 'valor' en un factor con el orden especificado

# Ordena el data frame basado en la columna 'valor' y conserva las demás columnas
datos_ordenados <- f2 %>%
  arrange(valor)

dia1 <- c("01/01/2023", "01/02/2023", "01/03/2023", "01/04/2023") # Genero una serie con el primer dia de los meses a trabajar
datos_ordenados <- datos_ordenados %>% mutate(mes = dia1) # Añado una columna a mi grafica con la serie antes realizada

datos_ordenados$mes <- as.Date(datos_ordenados$mes, "%d/%m/%y") # Paso los primeros dias al formato de fecha

grafico1 <- zoo(datos_ordenados$frecuencia, order.by = datos_ordenados$mes) # Realizo la variable para la grafica de serie zoo(valores_de_la_serie, order.by = respecto_a_que)
str(grafico1) # Visualizo la estructura

plot(grafico1, main="Grafica de series del delito Violencia Familiar\npara lo que va del año 2023", ylab="Numero de delitos",xlab="Mes") # Genero mi grafico

# Grafico diario ----------------------------------------------------------

f3 <- table(VIF$fecha_hechos) # Selecciono como variable la fecha de los hechos

f4 <- as.data.frame(f3) %>%
  rename(valor = Var1, frecuencia = Freq) # Genero el frame con las fechas y sus frecuencias

f4$valor <- as.Date(f4$valor, "%d/%m/%y") # Paso las fechas a formato fecha

### GENERO UN CALENDARIO

año <- 2023 # Define el año para el calendario

# Crea un vector con las fechas de los meses de informacion
fechas_cuatro_meses <- seq(ymd(paste(año, "01", "01", sep = "-")),
                         ymd(paste(año, "04", days_in_month(ymd(paste(año, "04", "01", sep = "-"))), sep = "-")),
                         by = "days")

# Crea un data frame con las fechas y coloco 0 en caso de que en el frame de trabajo exista un valor nulo
calendario_cuatro_meses <- data.frame(
  valor = fechas_cuatro_meses,
  frecuencia = 0
)

# Combina los dos data frames y elimina filas duplicadas con Valor = 0 conservando el orden en cuanto a las fechas
calendario_final <- bind_rows(f4, calendario_cuatro_meses) %>%
  filter(!(frecuencia == 0 & duplicated(valor))) %>%
  arrange(valor)

grafico2 <- zoo(calendario_final$frecuencia, order.by = calendario_final$valor) # Genero la informacion para la serie
str(grafico2) # Veo la estructura

plot(grafico2, main="Grafica de series del delito Violencia Familiar\npara lo que va del año 2023", ylab="Numero de delitos",xlab="Diario") # Genero grafico

##########################################
#EJERCICIO

#1) Elabora un nuevo grafico de series de tiempo a partir de otro delito
#2) Genera 2 graficos con diferente continuidad (diario, mensual, anual)

#sube tu Script a esta liga:
# https://forms.gle/CsoerGPVS9Uhb2817