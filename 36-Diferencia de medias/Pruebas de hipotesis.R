# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##
## Script:            Prueba de hipótesis
##
##
##
## This version:      Jun 17th, 2024
##





## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##
## 1. Prueba de diferencia de medias para dos grupos independientes                                                                                         ----
##
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Datos de ejemplo
grupo1 <- c(5.1, 4.9, 4.7, 5.0, 5.3)
grupo2 <- c(6.2, 6.4, 6.1, 6.3, 6.5)

# Prueba t de diferencia de medias
resultado <- t.test(grupo1, grupo2, alternative = "two.sided")

# Mostrar los resultados
print(resultado)

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
##
## 2. Prueba de diferencia de medias para muestras pareadas                                                                                      ----
##
## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Datos de ejemplo pareados
antes <- c(120, 115, 130, 125, 110)
despues <- c(118, 113, 129, 123, 108)

# Prueba t de muestras pareadas
resultado_pareado <- t.test(antes, despues, paired = TRUE, alternative = "two.sided")

# Mostrar los resultados
print(resultado_pareado)

