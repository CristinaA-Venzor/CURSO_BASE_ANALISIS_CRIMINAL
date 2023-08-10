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

# Nombre.xlsx es la base de datos que se va a documentar
df_base<-read_excel("/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/CURSO/zacatecas/zacatecas.xlsx")

#Hejcutamos la creación de meta datos
tabla_final<-SmartEDA::ExpData(df_base,type=2)

#cambio lo valores de las gráficas
colnames(tabla_final)<-c("No.","Nombre de variable", "Tipo de datos", "Número de registros", "Valores faltantes", "Porcentaje de valores faltantes", "Número de valores distintos")


#exporto en documento de word
flextable(tabla_final) %>% save_as_docx( path = "/Users/cristinaalvarez/SynologyDrive/CONSULTORÍA/NESTOR/CURSO/zacatecas/metadatos_nivel_1.docx")


#Doy formate a la tabla
tabla_final<-flextable::flextable(tabla_final)
tabla_final<-width(tabla_final, 2, width = 1)
tabla_final