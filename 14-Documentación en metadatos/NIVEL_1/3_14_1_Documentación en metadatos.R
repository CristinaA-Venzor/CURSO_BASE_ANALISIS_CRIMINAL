## Instalar librerías
# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora

# install.packages("magrittr")
# install.packages("flextable")

## Activar librerías
library(flextable)
library(magrittr)

# Nombre.csv es la base de datos que se va a documentar (en este caso un vinculo)
df_base<-read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

# Ejecutamos la creación de meta datos (informacion basica por variable)
tabla_final<-SmartEDA::ExpData(df_base,type=2)

# Cambio lo valores de las gráficas
colnames(tabla_final)<-c("No.","Nombre de variable", "Tipo de datos", "Número de registros", "Valores faltantes", "Porcentaje de valores faltantes", "Número de valores distintos")

# Exporto en documento de word
flextable(tabla_final) %>% save_as_docx( path = "metadatos_nivel_1.docx") # Se guarda en la carpeta de trabajo 

#para conocer la ruta que lo lleva a la carpeta en donde se exportaron los metadatos en word quite el signo de gato "#" en la siguiente
#"getwd()"

# Doy formato a la tabla y la genero en mi viewer
tabla_final<-flextable::flextable(tabla_final)

#Estilisamos los márgenes de la tabla
tabla_final<-width(tabla_final, 2, width = 1)

#Mandamos llamar la tabla
tabla_final
