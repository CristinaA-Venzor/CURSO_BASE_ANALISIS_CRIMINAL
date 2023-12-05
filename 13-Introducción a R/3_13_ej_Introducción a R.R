################################################
# Algortimos básicos para la descripción de datos en R
################################################

#install.packages("tidyverse")
#install.packages("magrittr")
library(magrittr) # Poder usar %<%
library(tidyverse)

#ejemplo de commit

# 1.1 Obtener ayuda
# 1.2 R como calculadora
# 1.3 Conociendo los tipos de información(datos)
  #   Clase de objetos 
        # Numeric (Integer, double, etc..)
        # Character
        # Factor
        # Lógico
        # NULL
  #   Evaluando el tipo de datos 
# 1.4 Arreglo de datos: 
    # vectores[.]
    # matrices[.,.]
    # arrays[.,.,.]
# 1.5 acercamiento exploratorio a base de datos
################################################

###################
# 1.1 Obtener ayuda

help(sd) # Funciones
?iris  # bases de datos
# Leer los mensajes de Error!
# SIEMPRE SIEMPRE -> !buscar en INTERNET!
# FOROS: Stack Overflow

########################
# 1.2 R como calculadora
# Operadores en R
5 + 10  # Suma
20 - 8  # Resta... 
# Multiplicación (*), División(/), potencia(^)

#########
a <- 8  # Esta es una ASIGNACIÓN " <- ".
# Evitaremos utilizar el signo "=".
b <- 10 
a*b     # Una vez guardados los objetos, R los puede utilizar cuando se les llama

#########
# Área círculo
r <- 5 # Parámetro variable
pi
A <- pi*(r^2)
print(A)
A

#########
# 1.3 Conociendo los tipos de datos

#  Clase de objetos 
class(1)    # integer, double, etc..
class("1")  # Cadenas de texto
class(TRUE) # Lógicos:TRUE, FALSE y NA
      1==1
class(iris) # Trible, es un data.frame tuneado
class(NULL) # Bolean data/ dato lógico
sex <- c(0,1)
sex<-as.factor(sex) # transormo a factor los datos dentro sex
class(sex) # Para variables categóricas, niveles (no tienen orden)
# listas
typeof(1)
typeof(1L)

#########
# Brief description
str(sex) # Dentro dos parentesis coloco aquel elemento del cual quiera conocer su estructura#skim{skimr}

#########
# Evaluando el tipo de datos 
is.integer(1)
is.numeric(1)
is.character("1")
is.na(NA)

# 1.4 Arreglo de datos: 
# vectores[.]
# matrices[.,.]
# arrays[.,.,.]. Funciones ?tiles para arrays =>apply()/sapply()

##########
# VECTORES
vector_num<-c(1, 2, 3, 5, 8, 13)          # Vector numérico
vector_cha<-c("arbol", "casa", "persona") # Vector de cadena de texto
vector_log<-c(TRUE, TRUE, FALSE, FALSE, TRUE)         # Vector lógico

# Podemos agregar un elemento a un vector ya existente, 
mi_vector <- c(TRUE, FALSE, TRUE)
c(mi_vector, FALSE)  # Nótese que no lo reemplacé (ni creé un nuevo objeto)

saludo <- c("buenos días", "cómo estas")
# imprimir saludo
print(saludo)
paste(saludo[1],saludo[2])

# Distintos tipos?
vector_mezcla <- c(FALSE, 2, "tercero", 4.00)
class(vector_mezcla) # notese que todos mis datos se vuelven del tipo caracter dado que R buscaa un tipo que englobe a todos

# Combinación de vectores.
vector_1 <- c(1, 3, 5)
vector_2 <- c(2, 4, 6)
nuevo_vector <- c(vector_1, vector_2)
vector_1+1 # sumo 1 a todos los elementos de mi vector

#######################
# Matrices

# Uniendo vectores en una matriz
rbind(vector_1,vector_2) # por filas
cbind(vector_1,vector_2) #por columnas
# Con función
1:12
matrix(1:12)                     # Matriz de 12x1
matrix(1:12, nrow = 3, ncol = 4) # Matriz de 3x4

#######################
# Arrays
mi_array <- array(c(vector_1,vector_2),dim = c(3,3,2)) 
mi_array  # Arreglo de dos matrices de 3x3. Colocando en secuencia y por columnas primero vector_1, vector_2 y asi consecutivamente

# Revisar función apply()
result <- apply(mi_array, c(3), sum) 
result # Suma de los valores dentro mi matriz

#####################################
# Operaciones con vectores y matrices
# área círculo
r <- c(2, 4, 6) # El radio de tres círculos
pi
pi*(r^2) # el Area de tres círculos

##################
# Data frames
#es de nxk dimensiones pero puede tener NA/NULL en algunas entradas
mi_df <- data.frame(
  "entero" = 1:4, 
  "factor" = c("a", "b", "c", "d"), 
  "numero" = c(1.2, 3.4, 4.5, 5.6),
  "cadena" = as.character(c("a", "b", "c", "d"))
)
mi_df
class(mi_df$numero)
names(mi_df) # Nombres de las columnas(variables)

##############
#Brief summary
summary(mi_df)  # Informacion y datos estadisticos de mi {base}

#############
## EJERCICIO

#deberás contestar las siguientes preguntas con la base mtcars:
#1) qué información recolecta la base de datos?
#2) qué variables son las más relevantes para comparar entre autos?
#3) qué clase de objetos tiene la base de datos?
#4) cuántas observaciones hay en la base?
#4) cuántas observacionesde la columna mpg tienen valores faltantes?

#Comandos para la exploración de bases de datos
data("mtcars") # cargamos base de datos instalda en R como ejemplo
View(mtcars) # visualizar la base de datos
help(mtcars) # documentación "Meta datos" de la base

str(mtcars) # primer acercamiento a los datos 

table(mtcars$mpg) #cantidad del mismo valor

min(mtcars$mpg) # valor mínimo
max(mtcars$mpg) # valor máximo

range(mtcars$mpg) # valor del rango

dim(mtcars) # dimensiones de bases de datos

sum(is.na(mtcars$mpg)) #suma el número de valores faltantes en una columna

x <- mtcars %>%
  drop_na() %>%
  select_if(~any(!is.na(.))) # elimina las columnas que están completamente vacías y las filas enteras que están completamente vacías.

summary(mtcars) # aporta datos estadisticos

## ahora explora la base de datos
data(iris)

## guarda este script con tus modificaciones donde exploraste la base de datos, como resultado de tu ejercicio.
## compartélo a la siguiente liga: 
#        https://forms.gle/MbMQJZdgDTuUHZXn7 

#########################################
