###################################
### Limpieza de formato hora ######
###################################

# Librerías y paquetes ----------------------------------------------------

library(readr)
library(tidyverse)
library(dplyr)
library(stringr)

# Cargo información -------------------------------------------------------
setwd("/Users/cristinaalvarez/Downloads")

data <- read.csv("ROBOS A CASA HABITACION.csv", fileEncoding = "latin1") 
View(data)


# Limpieza de columna "Hora de hechos" ------------------------------------

#cuento observaciones faltantes antes
sum(is.na(data$FECHA.DEL.SUCESO))
# Cambio N/E por NAs para que R las lea formato missing (faltantes)
data <- data %>% mutate(across(FECHA.DEL.SUCESO, na_if, "N/E"))
#cuento obsevraciones faltantes después
sum(is.na(data$FECHA.DEL.SUCESO))

#cuento el número de caracteres por observación de fecha
data$conteo <- nchar(data$FECHA.DEL.SUCESO)

# convierto a Na (valor faltante) todos los que tengan diferente número de caracteres a 10
data$FECHA.DEL.SUCESO[data$conteo != 10] <- NA

# Pongo formato fecha a la columna, pongo coerse por que si hay algún character que no forme fecha
data$FECHA.DEL.SUCESO <- as.Date(data$FECHA.DEL.SUCESO, format = "%d/%m/%Y", errors = "coerce")

# Si quiero eleminar las observaciones en las que hay valor faltante en las fechas
data <- data[!is.na(data$FECHA.DEL.SUCESO), ]

# Guerdo archivo
write.csv(data, "ROBOS A CASA HABITACION_horalimpia.csv")
