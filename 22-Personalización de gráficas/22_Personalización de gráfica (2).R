############################################
# Gráficas con ggplot
############################################

######Temas

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

# cargo bases de datos
rm(list=ls()) # Limpiar
#EJEMPLO
##setwd("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/CURSO/zacatecas")  # Directorio
# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("2_zacatecas.csv", check.names = F)

# 1.- limpieza y filtración de datos

# Nos quedamos con sólo un delito: 

delitos <- subset(delitos, Delito = "ROBO A VEHICULO") 

# Nos quedamos con las variables que son de nuestro interés para el análisis
conservar <- c("Número de CUI", "Fecha del delito","Hora del delito","Estado", "Municipio" , "Latitud" , "Longitud", "Sexo de la Víctima", "Edad de la víctima" )
  
delitos <-  delitos[, conservar]

# elimino los  CUIs repetidos
dim(delitos)
delitos <- unique(delitos, by = "Número de CUI")
dim(delitos)


## Gráficas con paquetería ggplot
## material de consulta
# https://r-graph-gallery.com/index.html


#frecuencia por sexo de la victima

sexo <- as.data.frame(table(delitos$`Sexo de la Víctima`))
View(sexo)
sexo <- subset(sexo, sexo$Var1 == "Hombre" | sexo$Var1 == "Mujer")


# 2.- grafica de barras simples
# Nota: seleccione todos los comandos juntos para correrlos, aunque estén en distintas líneas
# para su visualización, se tienen que correr en conjunto.

sexo %>%
  ggplot( aes(x=Var1, y=Freq)) +
  geom_bar(stat="identity",)+
  theme_bw()

## 3.- modificació de características de gráficos
#     3.1.- color

sexo %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E392E6"))+
  theme_bw()

#     3.2.- título general

sexo %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E392E6"))+
  ggtitle("Robo a vehículo por sexo de la víctima") +
  theme_bw()

#     3.3.- título de ejes

sexo %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E392E6"))+
  ggtitle("Robo a vehículo por sexo de la víctima") +
  xlab(" ") + ylab("Frecuencia")+ labs(fill = "Sexo")+
  theme_bw()

#     3.4.- estilos

sexo %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E392E6"))+
  ggtitle("Robo a vehículo por sexo de la víctima") +
  xlab(" ") + ylab("Frecuencia")+ labs(fill = "Sexo")+
  theme_classic()


#     3.4.- estilos, voltear sentido del gráfico

sexo %>%
  ggplot( aes(x=Var1, y=Freq, fill= Var1)) +
  geom_bar(stat="identity", alpha=.6, width=.4) +
  scale_fill_manual(values=c("#3383FF", "#E392E6"))+
  coord_flip() +
  ggtitle("Robo a vehículo por sexo de la víctima") +
  xlab(" ") + ylab("Frecuencia")+ labs(fill = "Sexo")+
  theme_classic()


## 4.- gráficas de pie

#Traemos el pedacito de código en donde limpiamos la fecha y hora

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

#cuento incidncia por día
prop <- as.data.frame(table(delitos$dia))

#básico
pie(prop$Freq)

#con etiquetas
pie(prop$Freq , labels = c("Viernes","Lunes","Sábado","Domingo","Jueves", "Martes", "Miercoles"))

#cambio de color con paleta de paquetería
myPalette <- brewer.pal(7, "Set2") 

pie(prop$Freq , labels = c("Viernes","Lunes","Sábado","Domingo","Jueves", "Martes", "Miercoles"), border="white", col=myPalette )


