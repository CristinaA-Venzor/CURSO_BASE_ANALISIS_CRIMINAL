
############## LIMPIEZA DE HORA ###################
###################################################

# LIBRERÍAS ---------------------------------------------------------------

#install.packages("tidyverse")

## Activar librerías
library(tidyverse)

# CARGO BASE DE DATOS -----------------------------------------------------

delitos<-read_csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/base_horas.csv")
View(delitos)

# LIMPIEZA DE HORA --------------------------------------------------------

#2.- Limpio la hora

# Me quedo con las variables que en hora tienen un contenido con formato segundos.
# Esto es por que hay observaciones que contienen texto, así que como todas las horas válidas
# acaban con :00 segundos, es el indicador para qudarme con toda observación que contenga :00
delitos <- delitos[grepl(":00", delitos$`Hora del delito`), ] 

# Parto la variable para separar números de letras
# hay un espacio entre la hora y el p.m. o a.m. esto me sirve para
# asilar el núemero y el sufijo (pm.m o am) si es que lo tiene
delitos$tiempo_num <- strsplit(delitos$`Hora del delito`, " ", fixed = TRUE)
# ahora tengo un vesctor con tres elementos !
# 1) el número de la hora
# 2) a.
# 3) m.

#para extraer el valor numérico,
# genero un vector vacío
tiempo_numero <- c()
# función para extraer hora
# le indico que me quedo con el elemento 1
for (i in 1:length(delitos$tiempo_num)) {tiempo_numero <- append(tiempo_numero, unlist(delitos$tiempo_num[i])[1])}
#agrego vector con hora a la base de datos
delitos$tiempo_num <- tiempo_numero

# Pongo todas las horas del mismo formato HH:MM:SS

# Defino el número de espacios que contiene mi formato de hora
target_length <- 8
character_to_add <- "0"

# Iterate over each observation
for (i in 1:length(delitos$tiempo_num)) {
  # Check if the length of the current observation matches the target length
  if (nchar(delitos$tiempo_num[i]) <target_length) {
    # Add the character to the observation
    delitos$tiempo_num[i] <- paste0(character_to_add, delitos$tiempo_num[i])
  }
}

# 2.1- Convierto a formato Hora-fecha

delitos$tiempo_num <- hms(delitos$tiempo_num)

### si tiene "p.m" se le suman 12 horas para convertir en formato 24hrs

suma <- hms("12:00:00")

tiempo_formato <- c()

for (i in 1:length(delitos$`Hora del delito`)) {if (grepl("p. m.", delitos$`Hora del delito`[i]) == TRUE) {
  tiempo_formato <- append(tiempo_formato, delitos$tiempo_num[i] + suma)} else {tiempo_formato <- append(tiempo_formato, delitos$tiempo_num[i])}}

#vuelvo a colocar las horas convertidas a formato hora
delitos$hora_delito <- tiempo_formato
# extraigo sólo el valor de las horas
delitos$hora <- hour(delitos$hora_delito)

# guardo archivo resultante -----------------------------------------------

write.csv(delitos, "base_hora_limpia.csv")
