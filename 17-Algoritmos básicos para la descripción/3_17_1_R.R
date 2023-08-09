############################################
# Descripción de datos en R
############################################

library(tidyverse)   # Contiene ggplot2
library(readr)
library(dplyr)
library(ggplot)
library(readr)
library(tmaptools)
library(tidyverse)
library(knitr)
library(SmartEDA)
library(janitor)
library(dplyr)
library("data.table")
library(tidyr)
library(tidyverse)
library(lubridate)
library("RColorBrewer")

#############
rm(list=ls()) # Limpiar
setwd("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/CURSO/zacatecas")  # Directorio
# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("fresnillo.csv", check.names = F)

# Exploración de base de datos

#primeras entradas
head(delitos)

#
dim(delitos)

# dejo mi base con las primeras columnas
delitos <- delitos[, 1:25]

#tablas de frecuencias por horas y fechas

#pongo en formato fecha
delitos$`Fecha del delito` <- as.Date(delitos$`Fecha del delito`, "%d/%m/%y")
#pongo en formato hora
delitos$`Hora del delito` <- hms(delitos$`Hora del delito`)

#extraigo hora
delitos$hora <- hour(delitos$`Hora del delito`)
#extraigo día
delitos$dia <- format(delitos$`Fecha del delito`,"%A")
#extraigo año
delitos$año <- format(delitos$`Fecha del delito`,"%Y")
#extraigo mes
delitos$mes <- format(delitos$`Fecha del delito`,"%b")

#extraigo datos máximos, mínimos y totales
año <- names(which.max(table(delitos$año)))
max <- max(delitos$`Fecha del delito`)
min <-  min(delitos$`Fecha del delito`)
total <- dim(delitos)


#grafico para visualizar las frecuencias

#tabulo por mes
fremes <- t(as.matrix(table(delitos$mes)))
#Me quedo con los que sí idenitifica un mes
fremes <- fremes[, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov" , "Dec")]
#convierto la tabla a base de datos (data frame)
fremes <- as.data.frame(fremes)
#cambio nombre de meses a español
fremes$mes <- c("ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic")

#realizo gráfica con argumentos de R
my_bar <- barplot(height=fremes$fremes, names.arg =fremes$mes, 
                  col=rgb(0.8,0.1,0.1,0.6), axes = FALSE,
                  xlab="mes", 
                  main="Delitos en Fresnillo por mes", las=2, 
                  cex.axis=1, cex.names=.9) 
text(my_bar, fremes$fremes - 6, labels = fremes$fremes)



