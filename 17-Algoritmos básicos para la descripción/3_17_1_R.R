############################################
# Descripción de datos en R
############################################

## Instalar librerías
# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora
# install.packages("magrittr")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("lubridate")

## Activar librerías
library(lubridate)
library(ggplot2)
library(dplyr)
library(magrittr)

#############
rm(list=ls()) # Limpiar
# setwd("")  # Directorio a trabajar
# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# Exploración de base de datos

# primeras entradas
head(delitos)

# dimension columnas-filas
dim(delitos)

# dejo mi base con las primeras 10 columnas
delitos <- delitos[, 1:10]

#tablas de frecuencias por horas y fechas

#pongo en formato fecha
delitos$fecha_hechos <- as.Date(delitos$fecha_hechos, "%d/%m/%y")
#pongo en formato hora
delitos$hora_hechos <- hms(delitos$hora_hechos)

#extraigo hora
delitos$hora <- hour(delitos$hora_hechos)
#extraigo día de la semana
delitos$dia <- format(delitos$fecha_hechos,"%A")
#extraigo año
delitos$año <- format(delitos$fecha_hechos,"%Y")
#extraigo mes
delitos$mes <- format(delitos$fecha_hechos,"%b")

#extraigo datos máximos, mínimos y totales
año <- names(which.max(table(delitos$año))) # Año maximo
max <- max(delitos$fecha_hechos) # Fecha maxima
min <-  min(delitos$fecha_hechos) # Fecha minima
total <- dim(delitos)

#grafico para visualizar las frecuencias

#tabulo por mes
fremes <- t(as.matrix(table(delitos$mes)))
#Me quedo con los que sí idenitifica un mes en caso de estar en ingles
# fremes <- fremes[, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov" , "Dec")]
#convierto la tabla a base de datos (data frame)
fremes <- as.data.frame(fremes)
#cambio nombre de meses a español en caso de ser necesario
# fremes$mes <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic")

# Ordeno los meses de acuerdo al calendario
fremes <- fremes %>% select(ene., feb., mar., abr.)

fremes_uso <- t(fremes) # Giro la grafica para pasar las columnas a filas y viceversa
fremes_uso <- as.data.frame(fremes_uso) # Convierto a data frame

barra_frame <- tibble::rownames_to_column(fremes_uso, "Mes") # La columna de orden tiene los meses y convierto estos a un posible valor

#realizo gráfica basica de los meses y sus frecuencias
grafico <- ggplot(barra_frame, aes(x = Mes, y = V1)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Gráfico de Frecuencias", x = "Valor", y = "Frecuencia")

grafico
