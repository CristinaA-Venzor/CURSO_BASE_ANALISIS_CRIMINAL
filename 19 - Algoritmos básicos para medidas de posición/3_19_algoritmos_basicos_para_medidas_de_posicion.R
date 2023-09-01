############################################
# Medidas de posición                                
############################################

################################

## Instalar librerías
# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora
# install.packages("lubridate")

## Activar librerías
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

#Genero los cuantil para la tabla de frecuencias de delitos
quantile(tabla_delitos$Freq)

#Genero los deciles para la tabla de frecuencias de deslitos
quantile(tabla_delitos$Freq, prob=seq(0, 1, length = 11))

# Genero percentiles
quantile(tabla_delitos$Freq, prob=seq(0, 1, length = 101))

# Interpretación de cuantiles

#Estas son algunas de las preguntas que se pueden responder con base en los cuantiles

#Ya sabemos que el último 25% de la distribución por cuartiles es el más grande, entonces podemos decir
cuartiles <- as.data.frame(quantile(tabla_delitos$Freq))
ultimo_cuartil <- subset(tabla_delitos, tabla_delitos$Freq >= cuartiles[4,])
ultimo_cuartil <- ultimo_cuartil[order(ultimo_cuartil$Freq, decreasing = F),]

print("los delitos en el último cuartil de la distribución de delitos son:", ultimo_cuartil$Var1)

#porcentaje que representa la incidencia del último cuantil, en proporción al resto

proporcion <- round((sum(ultimo_cuartil$Freq)/sum(tabla_delitos$Freq))*100, 2)

print(paste("el último cuartil de la distribución de incidencia delictiva representa:", proporcion, "%"))


### Extreae el rango y los quantiles de la base de datos indicada
#responda:
  #1. ¿Qué información nos da el rango de la variable?
  #2. ¿Cómo nos ayuda conocer los quintiles de una distribución?
  #3. ¿En qué otras variables nos ayuda tener el Conteo por categoría?
 #4. Obten cuáles son los delitos del último decil
 #5. Obten cuáles son los delitos del último percentil
 #6. Calcula la proporción de incidencia del útlimo  decil
 #7. Calcula la proporción de incidencia del útlimo  percentil

#El script con tus cálculos y respuestas será el resultado que subirás al enlace de evaluación
