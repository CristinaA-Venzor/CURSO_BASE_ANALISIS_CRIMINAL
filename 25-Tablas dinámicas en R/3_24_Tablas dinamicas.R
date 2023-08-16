############################################
# Tablas dinámicas en R 
############################################

#############
rm(list=ls())                                   # Limpiar
setwd()  # Directorio/Carpeta a utilizar especificado dentro de los parentesis
# Mas informacion: https://cran.r-project.org/web/packages/pivottabler/vignettes/v00-vignettes.html
#############

#devtools::install_github("hadley/tidyverse")
library(tidyverse)   # Contiene ggplot2
library(readr)
library(dplyr)
#install.packages("janitor")
library(janitor)
#install.packages("usethis")
library("usethis")
library(datasets)
#install.packages("pivottabler")
library(pivottabler)
library(ggplot2)
library(magrittr)
library('data.table')

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

delitos <- clean_names(delitos) # Limpio los titulos de mis columnas para que su escritura sea mas amigable con el texto

delitos <- delitos[delitos$delito %like% "^A|^B|^C|^E|^V", ] # Hago una depuracion en cuanto a los delitos que inician con cinco lentras (A,B,C,E,V)

colnames(delitos)

# Generar mi primer tabla dinamica con la funcion qhpvt
qhpvt(delitos, "delito", "alcaldia_hechos", "n()") # argumentos: qhpvt(dataFrame, rows-filas, columns, calculos-totales, ...)

# Generar la misma tabla con mas desgloce
pt <- PivotTable$new()
pt$addData(delitos) # Menciono la bade de datos que voy atrabajar
pt$addColumnDataGroups("alcaldia_hechos") # Que titulos van tomar las columnas
pt$addRowDataGroups("delito") # Que titulos van a tomar las filas
pt$defineCalculation(calculationName="TotalDelitos", summariseExpression="n()") # Indico la suma y generacion de los totales a partir de sus frecuencias
pt$renderPivot() # Muestro en el viewer mi tabla

# Añado mas informacion (subtemas) a los titulos de las columnas
pt1 <- PivotTable$new()
pt1$addData(delitos)
pt1$addColumnDataGroups("alcaldia_hechos")
pt1$addColumnDataGroups("mes_hechos") # Indico el subtema que va ha trabajar en las columnas
pt1$addRowDataGroups("delito")
pt1$defineCalculation(calculationName="TotalDelitos1", summariseExpression="n()")
pt1$renderPivot()

# Muestro el total de los subtemas en la columna total
pt2 <- PivotTable$new()
pt2$addData(delitos)
pt2$addColumnDataGroups("alcaldia_hechos")
pt2$addColumnDataGroups("mes_hechos", expandExistingTotals=TRUE) # Al añadir ese atributo permito que los subtemas se desglocen con sus totales
pt2$addRowDataGroups("delito")
pt2$defineCalculation(calculationName="TotalDelitos2", summariseExpression="n()")
pt2$renderPivot()

# Hago la adicion de los subtemas pero ahora en las filas y añadido a esto elimino algunos totales que se muestran
pt3 <- PivotTable$new()
pt3$addData(delitos)
pt3$addColumnDataGroups("alcaldia_hechos")
pt3$addRowDataGroups("delito", totalCaption="Suma Total") # Coloco un titulo para el total de la suma de los valores de las filas
pt3$addRowDataGroups("mes_hechos", addTotal=FALSE) # Elimino la adicion de los subtotales que se generan con las nuevas subfilas
pt3$defineCalculation(calculationName="TotalDelitos3", summariseExpression="n()")
pt3$renderPivot()

##########################################
#EJERCICIO

#1) Realizar 2 nuevas tablas dinamicas
 #a) Realizar un nuevo filtro de la informacion base 
 #b) Generar las nuevas tablas con diferentes valores para las columnas

#sube tu este Script a esta liga:
# https://forms.gle/WSFCKHK31T8Sq6cR9