# La primera vez que se ejecuta el código, es relevante instalar los paquetes
#install.packages("kableExtra")
#install.packages("summarytools")
#install.packages("flextable")
#install.packages("gt")
#install.packages("pander")

library(SmartEDA)
library(knitr)
library(kableExtra)
library(readxl)
library(flextable)
library(janitor)
library(descr)
library(pander)



# Directorio debe ser sustituido por la ubicación del archivo con base en la computadora de cada usuario

# Nombre.xlsx es la base de datos que se va a documentar
df_base<-read_excel("3_zacatecas.xlsx")

# Ejecuto smart EDA para obtención de metadatos tipo 2
tabla_final<-SmartEDA::ExpData(df_base,type=2)

# Cambio nombres de columnas de la tabla
colnames(tabla_final)<-c("No.","Nombre de variable", "Tipo de datos", "Número de registros", "Valores faltantes", "Porcentaje de valores faltantes", "Número de valores distintos")

# Ejecuto smart EDA para obtención de metadatos tipo 1
tabla_final2 <-SmartEDA::ExpData(df_base,type=1)

# Cambio nombres de columnas de la tabla
colnames(tabla_final2) <- c("Descripción", "Valores")
# Cambio nombres de filas de la tabla
desc <- c("Tamaño de muestra (num. filas)", "No. de variables (num. col.)", "No, variables numéricas", "No. Variables de factor", "No. de variables de texto", "No, de variables lógicas", "No. de variables identificadoras", "No. de variables de fecha", "No. de variables de varianza cero (uniforme)", "% de variables con casos completos", "% de variables con >0% y <50% de casos perdidos", "% de variables con >=50% y <90% de casos perdidos", "%. de variables con >=90% de casos perdidos")
tabla_final2$Descripción <- desc

#Descargo en Word
flextable( tabla_final2) %>% save_as_docx( path = "metadatos_nivel3_tipo1.docx")

#Descrago en Word
flextable( tabla_final) %>% save_as_docx( path = "metadatos_nivel3_tipo2.docx")


# Doy estilo a las dos tablas y las genero en mi viewer
tabla_final<-flextable::flextable(tabla_final)
tabla_final<-width(tabla_final, 2, width = 1)
tabla_final

tabla_final2<-flextable::flextable(tabla_final2)
tabla_final2<-width(tabla_final2, 2, width = 1)
tabla_final2

