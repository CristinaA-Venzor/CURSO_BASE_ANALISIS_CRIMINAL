############################################
# Gráficas con ggplot
############################################

###### Temas

# 1.- limpieza y filtración de datos
# 2.- grafica de barras simples
# 3.- modificació de características de gráficos
#     3.1.- color
#     3.2.- título general
#     3.3.- título de ejes
#     3.4.- estilos
# 4.- gráficas de pie

#install.packages("ColorBrewer")
## cargo librerías
library(readr)
library(ggplot)
library(tidyverse)
library(lubridate)
library("RColorBrewer")
library(dplyr)
library(janitor)
library("usethis")
library(datasets)

# cargo bases de datos
rm(list=ls()) # Limpiar
#EJEMPLO
##setwd("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/CURSO/zacatecas")  # Directorio
# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# 1.- limpieza y filtración de datos

# Nos quedamos con sólo un delito: 

delitos <- subset(delitos, delito == "VIOLENCIA FAMILIAR") 

table(delitos$delito)

 # Nos quedamos con las variables que son de nuestro interés para el análisis
conservar <- c("fecha_hechos", "mes_hechos", "hora_hechos", "agencia", "alcaldia_hechos", "municipio_hechos", "latitud", "longitud")
  
delitos <-  delitos[, conservar] # Genero la nueva tabla que contendra las columnas de interes solo con el delito de violencia familiar

# elimino las filas repetidos
dim(delitos)

# Borro valores duplicados cuando concuerdan en las columnas dentro de c
delitos <- delitos[!duplicated(delitos[ ,c(1:8)]), ]  # Delete rows
dim(delitos)

## Gráficas con paquetería ggplot
## material de consulta
# https://r-graph-gallery.com/index.html

#frecuencia por mes del suceso

mes_1 <- as.data.frame(table(delitos$mes_hechos))
View(mes_1)
mes_1 <- subset(mes_1, mes_1$Var1 == "Enero" | mes_1$Var1 == "Febrero" | mes_1$Var1 == "Marzo" | mes_1$Var1 == "Abril")

# 2.- grafica de barras simples
# Nota: seleccione todos los comandos juntos para correrlos, aunque estén en distintas líneas
# para su visualización, se tienen que correr en conjunto.

mes_1 %>%
  ggplot( aes(x=Var1, y=Freq)) +
  geom_bar(stat="identity",)+
  theme_bw()

## 3.- modificació de características de gráficos
#     3.1.- color

mes_1 %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E992E6","#CC3300", "#AA9696"))+
  theme_bw()

#     3.2.- título general

mes_1 %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E992E6","#CC3300", "#AA9696"))+
  ggtitle("Violencia Familiar por mes de los hechos") +
  theme_bw()

#     3.3.- título de ejes

mes_1 %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E992E6","#CC3300", "#AA9696"))+
  ggtitle("Violencia Familiar por mes de los hechos") +
  xlab(" ") + ylab("Frecuencia")+ labs(fill = "Mes")+
  theme_bw()

#     3.4.- estilos

mes_1 %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E992E6","#CC3300", "#AA9696"))+
  ggtitle("Violencia Familiar por mes de los hechos") +
  xlab(" ") + ylab("Frecuencia")+ labs(fill = "Mes")+
  theme_classic()

#     3.4.- estilos, voltear sentido del gráfico

mes_1 %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E992E6","#CC3300", "#AA9696"))+
  coord_flip() +
  ggtitle("Violencia Familiar por mes de los hechos") +
  xlab(" ") + ylab("Frecuencia")+ labs(fill = "Sexo")+
  theme_classic()

## 4.- gráficas de pie

#Traemos el pedacito de código en donde limpiamos la fecha y hora

#pongo en formato fecha
delitos$fecha_hechos <- as.Date(delitos$fecha_hechos, "%d/%m/%y")
#pongo en formato hora
delitos$hora_hechos <- hms(delitos$hora_hechos)

#extraigo hora
delitos$hora <- hour(delitos$hora_hechos)
#extraigo día
delitos$dia <- format(delitos$fecha_hechos,"%A")
#extraigo año
delitos$año <- format(delitos$fecha_hechos,"%Y")
#extraigo mes
delitos$mes <- format(delitos$fecha_hechos,"%b")

#cuento incidncia por día
prop <- as.data.frame(table(delitos$dia))

#básico
pie(prop$Freq)

#con etiquetas
pie(prop$Freq , labels = c("Viernes","Lunes","Sábado","Domingo","Jueves", "Martes", "Miercoles"))

#cambio de color con paleta de paquetería
myPalette <- brewer.pal(7, "Set2") 

pie(prop$Freq , labels = c("Viernes","Lunes","Sábado","Domingo","Jueves", "Martes", "Miercoles"), border="white", col=myPalette )

###### EJERCICIO

#El ejercicio es lograr replicar la gráfica resultante del Script y contestar las siguientes preguntas:

#1) ¿Cual mes hay más frecuentemente víctimas de Violencia Familiar?
#2) Haga una gráfica de barras para contabilizar el mes de los casos. ¿En qué mes es más frecuente la incidencia en Violencia Familiar?
#3) ¿Qué sugiere la gráfica de pie en la distribución de ocurrencia del delito a través de los días de la semana?
#4) Realice una gráfica de pie por hora ¿Se sostiene esa inferencia cuando analizamos los porcentajes por hora?
#5) ¿Qué podemos decir acerca de la incidencia criminal de Violencia Familiar con base en estas gráficas realizadas?
