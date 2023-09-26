

# Librerías y paquetes ----------------------------------------------------

library(readr)
library(tidyverse)
library(dplyr)
library(stringr)

# Cargo información -------------------------------------------------------
setwd("/Users/cristinaalvarez/Downloads")

data <- read.csv("violencia familiar 2022_georreferenciado.csv", fileEncoding = "latin1") 
View(data)

# Limpieza de columna "Hora de hechos" ------------------------------------

#cuento observaciones faltantes antes
sum(is.na(data$fecha_del_estado))
# Cambio N/E por NAs para que R las lea formato missing (faltantes)
data <- data %>% mutate(across(fecha_del_estado, na_if, "N/E"))
#cuento obsevraciones faltantes después
sum(is.na(data$fecha_del_estado))

#cuento el número de caracteres por observación de fecha
data$conteo <- nchar(data$fecha_del_estado)

# convierto a Na (valor faltante) todos los que tengan diferente número de caracteres a 10
data$fecha_del_estado[data$conteo != 10] <- NA

# Pongo formato fecha a la columna, pongo coerse por que si hay algún character que no forme fecha
data$fecha_del_estado <- as.Date(data$fecha_del_estado, format = "%d/%m/%Y", errors = "coerce")
