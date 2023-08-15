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

# Directorio debe ser sustituido por la ubicación del archivo con base en la computadora de cada usuario

# Nombre.csv es la base de datos que se va a documentar (en este caso un vinculo)
df_base<-read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# Ejcutamos la creación de meta datos (informacion basica por variable)
tabla_final<-SmartEDA::ExpData(df_base,type=1)

# Cambio nombres de columnas de la tabla
colnames(tabla_final) <- c("Descripción", "Valores")

# Cambio nombres de filas de la tabla
desc <- c("Tamaño de muestra (num. filas)", "No. de variables (num. col.)", "No, variables numéricas", "No. Variables de factor", "No. de variables de texto", "No, de variables lógicas", "No. de variables identificadoras", "No. de variables de fecha", "No. de variables de varianza cero (uniforme)", "% de variables con casos completos", "% de variables con >0% y <50% de casos perdidos", "% de variables con >=50% y <90% de casos perdidos", "%. de variables con >=90% de casos perdidos")

tabla_final$Descripción <- desc

# Exporto en documento de word
flextable(tabla_final) %>% save_as_docx( path = "metadatos_nivel_2.docx")

# Doy formato a la tabla y la genero en mi viewer
tabla_final<-flextable::flextable(tabla_final)
tabla_final<-width(tabla_final, 2, width = 1)
tabla_final
