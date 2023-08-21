############################################
# Creación de funciones con condicionales
############################################

#############
rm(list=ls())                                   # Limpiar
setwd()  # Directorio/Carpeta a utilizar especificado dentro de los parentesis
#############

library(ggplot2)
library(dplyr)
library(magrittr)
library(tidyverse)
library(readr)
library(janitor)

# Desde archivos separados por delimitador mediante un link (CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# IF ----------------------------------------------------------------------

# Tipo numerico
x <- 10 # Puedo probar con diversos valores para hacer la prueba

if (x == 10) { # Coloco la sentencia que de ser verdadera se reproducira lo que esta entre comillas
  print("Es verdadero")
} else { # Aqui se reproduce cuando la sentencia no se cumple
  print("Es falso")
}

# Tipo caracter
nombre <- "pedro" # NOTA: se checa el hecho de usar mayusculas y minusculas

if (nombre == "Pedro") {
  print("Es verdadero")
} else {
  print("Es falso")
}

# Verificar el tipo de dato
y <- "Chucho"

if (is.character(y)) { # No usamos operadores logicos, estudiamos el tipo de dato y esto nos devuelve un verdadero o falso
  print("Es verdadero")
} else {
  print("Es falso")
}

!TRUE # El signo de interrogacion funciona como una negacion. Pasa a ser falso. Tambien puedo colocarlo en las condiciones de if
!FALSE # Pasa a ser verdadero

z <- 7
ifelse(z == 7, "Verdadero", "Falso") # La sentencia if else engloba lo que los codigos anteriores realiza en mas lineas de codigo
 # ifelse(condicion, "Que_se_imprime_en_caso_de_ser_verdadero", "Que_se_imprime_en_caso_de_ser_falso")

# A partir de sentencias when que son al estilo if modifico valores o agrego columnas dentro de un frame

VIF <- subset.data.frame(delitos, delito == "VIOLENCIA FAMILIAR") # Separo el delito
conservar <- c("fecha_hechos", "mes_hechos", "alcaldia_hechos", "municipio_hechos", "latitud", "longitud") # Nombro las columnas a guardar
VIF <- VIF[, conservar] # Genero la nueva tabla que contendra las columnas de interes

# Cambiar valores dentro de una columna
col_cambio <- VIF %>% transform(mes_hechos = case_when(
  mes_hechos == "Enero" ~ "1", # Pongo las condiciones y despues de "~" sera el nuevo valor
  mes_hechos == "Febrero" ~ "2",
  mes_hechos == "Marzo" ~ "3",
  mes_hechos == "Abril" ~ "4",
  TRUE ~ "No hay mes" # Lo coloca a todo lo que no esta dentro de los limites anteriores
))

# Añadir columna con la condicion anterior
col_añadir <- VIF %>% mutate(mes_hechos = case_when(
  mes_hechos == "Enero" ~ "1", 
  mes_hechos == "Febrero" ~ "2",
  mes_hechos == "Marzo" ~ "3",
  mes_hechos == "Abril" ~ "4", 
  TRUE ~ "No hay mes" 
))
  
# WHILE -------------------------------------------------------------------

x <- 0 # Coloco el valor inicial

while (x < 100) { # Entre parentesis se encuentra la condicion
  x <- x + 1 # La secuencia se repite y en cada repeticion el valor inicial suma 1
  print(x) # Se van a imprimir los valores que se van generando
}

y <- 0

while (TRUE) { # En este caso evaluo que el if devuelva un verdadero
  y <- y + 1 
  print(y)
  if (y >= 100){ # Evalua una condicion y esperamos a que devuelva un verdadero o falso
    break # Me permite el cierre del ciclo
  }
}

# Generar un caso para ejemplificar el while
frecuencia <- 0
registros <- c()

while (frecuencia <= 100) {
  
  print (paste("La frecuencia es de ", frecuencia)) # El valor de frecuencia de lado de la coma muestra el valor frecuencia
  frecuencia <- rnorm(1, mean = 95, sd = 2) # Se colocaran datos aleatorios los cuales tenderan a una curva gausiana
   # rnorm(numero_de_valores_que_devuelve, mean = media, sd = desviacion_estandar)
  
  if (frecuencia > 100){
    print("Revisalo") # Nos muestra un mensaje y en este caso no termina en break
  }
  
  registros <- c(registros, frecuencia) # Me permite ir sumando un registro en cuanto la frecuencia cambia
  
}

frecuencia # Puedo observar la frecuencia con la cual el codigo se detiene

length(registros) # Puedo observar cuantos registros se requirieron para cortar el ciclo

##########################################
#EJERCICIO

#1) Elabora una sentencia if a tu gusto, comentala y justifica su funcionamineto
#2) Elabora una sentencia ifelse a tu gusto, comentala y justifica su funcionamineto
#3) Elabora una sentencia while a tu gusto, comentala y justifica su funcionamineto

#sube tu Script a esta liga:
# https://forms.gle/W23E76TLiRe7Kedm7