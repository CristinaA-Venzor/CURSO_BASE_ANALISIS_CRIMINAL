############################################
# Medidas de variabilidad                                
############################################

################################
library(readr)
library(lubridate)

#Cargo base de datos
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")


#### RANGO

#convierto la columna fecha en formato fecha
delitos$fecha_hechos <- dmy(delitos$fecha_hechos)
# veo rango de la fecha
range(delitos$fecha_hechos, na.rm = FALSE)

#rango de años
range(delitos$ao_hechos)



## CONTEO POR CATEGORÍA

tabla_delitos<- as.data.frame(table(delitos$delito))
View(tabla_delitos)

tabla_fiscalias <- as.data.frame(table(delitos$fiscalia))
View(tablas_fiscalias)


# CUANTILES
#Genero los cuantiles para la tabla de frecuencias de delitos
quantile(tabla_delitos$Freq)

quantile(tabla_delitos$Freq, probs=c(0.05, 0.5, 0.8))


### Extreae el rango y los quantiles de la base de datos indicada
#responda:
  #1. ¿Qué información nos da el rango de la variable?
  #2. ¿Cómo nos ayuda conocer los quintiles de una distribución?
  #3. ¿En qué otras variables nos ayuda tener el Conteo por categoría?

