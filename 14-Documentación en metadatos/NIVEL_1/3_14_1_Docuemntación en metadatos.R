# La primera vez que se ejecuta el código, es relevante instalar los paquetes
#install.packages("kableExtra")
#install.packages("summarytools")
#install.packages("flextable")
#install.packages("gt")
#install.packages("pander")
#library(summarytools)

#library(dplyr)
library(SmartEDA)
library(knitr)
library(kableExtra)
library(readxl)
library(flextable)
library(janitor)
library(descr)
#library(gt)
library(pander)
library("usethis")

# Nombre.xlsx es la base de datos que se va a documentar (en este caso un vinculo terminacion.csv)
df_base<-read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# Ejcutamos la creación de meta datos (informacion basica por variable)
tabla_final<-SmartEDA::ExpData(df_base,type=2)

# Cambio lo valores de las gráficas
colnames(tabla_final)<-c("No.","Nombre de variable", "Tipo de datos", "Número de registros", "Valores faltantes", "Porcentaje de valores faltantes", "Número de valores distintos")

# Exporto en documento de word
flextable(tabla_final) %>% save_as_docx( path = "metadatos_nivel_1.docx") # Se guarda en la carpeta de trabajo "getwd()"

# Doy formato a la tabla y la genero en mi viewer
tabla_final<-flextable::flextable(tabla_final)
tabla_final<-width(tabla_final, 2, width = 1)
tabla_final
