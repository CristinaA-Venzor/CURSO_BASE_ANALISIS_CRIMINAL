#################################
# ANALISIS DE TEXTO
################################


#install.packages("tm")
#install.packages("read.table")
#install.packages("wordcloud")

library(tm)
library(read.table)
library(wordcloud)
library(ggplot2)
library(dplyr)
library(readr)

#Pegamos texto como un objeto de R

docs <- "Que a la hora que ha quedado asentada, se presenta ante la Representación Social él C. LIC. 
CASTULO  DE  ROMERO  Y  ROMERO,  quien  se  ostentó  y  acredito  ser  Representante  Legal  de 
Petróleos  Mexicanos  (PEMEX),  quien  acreditó  su  personería  mediante  Instrumento  Notarial 
número 54666 de fecha 17 de noviembre del año 2017, pasado ante la fe del Notario Público 
número 03 de la Ciudad de México, Licenciado SILVERIO DE LA FONTANELA Y VIZCAYA, y quien 
manifestó  lo  siguiente:  Elementos  de  la  Policía  Municipal  de  Tlalnepantla  de  Baz,  ponen  a 
disposición de esta autoridad a quien dice llamarse PRÓCORO DE LA TORRE Y TORRE de 53 años. 
Con el antecedente de que los oficiales al encontrarse realizando sus rondines de  vigilancia, 
aproximadamente a las siete horas del día de hoy, siendo esto a la altura de la avenida Aceros 
Mexicanos en la colonia de Centro en el municipio de Tlalnepantla de Baz, Estado de México, 
momento en el cual se percatan de un tumulto de personas que se encontraban en la entrada 
de un predio que se encuentra cercado y forrado con malla de color verde y con una entrada de 
reja  igualmente  forrada  con  maya  de  plástico  de  color  verde`,  inmueble  que  no  tiene 
nomenclatura  exterior  visible,  por  lo  que  se  aproximan  al  lugar  donde  se  encontraban  las 
personas y al momento de estar en el lugar le preguntan a una de ellas qué era lo que pasaba y 
esta le responde que “huele mucho a Gasolina” por lo que proceden a tocar en la puerta y acude 
a su llamado quien en ese momento refirió ser “el señor Prócoro” y les pregunta ¿qué es lo que 
quieren? Por lo que les indican que huele mucho a gasolina y desean pasar a ver qué es lo que 
pasa, en ese momento uno de los policías alcanza a escuchar a una persona de identificación 
desconocida “aquí  venden  gasolina  muy  barata”  por  lo  que  los  policías  proceden a  solicitar 
nuevamente el acceso al inmueble por lo que el Señor Prócoro los deja pasar; en el interior del 
inmueble encuentra 30  tambos de  60  litros llenos  de  combustible del  denominado Gasolina 
Magna de 82 octanos y 45 tambos de 60 litros cada uno con gasolina Premium de 92 octanos. 
Acto seguido se le pregunta al señor Prócoro que hace esa gasolina en ese lugar a lo que el 
responde que solo es el velador del terreno. Debido a lo anterior y siendo todo lo que deseo 
manifestar, solicito en el momento procesal oportuno se formule imputación al C. PRÓCORO DE 
LA TORRE Y TORRE, por la probable comisión del delito de Robo y venta de combustible. EXPLICACIÓN Y APERCIBIMIENTO DE CONDUCIRSE CON VERDAD EN LA DILIGENCIA EN LA QUE 
VA  A  INTERVENIR  hago  de  su  conocimiento  que  para  el  caso  de  variar  el  contenido  de  la 
presente entrevista con lo que llegara a declarar ante el Juez competente comete el delito de falso testimonio, haciéndose acreedor a las penas previstas en el artículo 156 del Código Penal 
vigente en el Estado de México, que va de dos a seis años de prisión y de treinta a sesenta días 
multa, para que se conduzca con verdad en esta diligencia en que va a intervenir. 
NARRACIÓN DE HECHO O ENTREVISTA CON RELACIÓN A LA INVESTIGACIÓN 
ENTREVISTA DEL OFICIAL PRIMER RESPONDIENTE: ARCADIO JIMENEZ LÓPEZ.- En Tlalnepantla 
de Baz, estado de México, en fecha 18 de agosto de 2022, presente ante el suscrito quien dijo 
llamarse  ARCADIO  JIMENEZ  LÓPEZ  mismo  que  en  este  acto  se  identifica  con  credencial  de 
trabajo expedida por el H. Ayuntamiento de Tlanepantla de Baz, Estado de México con número 
de  empleado  767676 misma  que  lo  acredita  como  Policía,  mediante  la cual  se  observa una 
fotografía a color la cual concuerda con los rasgos fisonómicos de su presentante y de la cual 
solicita la devolución y en su lugar deja copias simples previo cotejo con su original, y para el 
desempeño de sus  funciones le es  asignada la unidad marcada  con el número  2022-80 y en 
relación a los hechos refiere: que es el caso que el día 17 de agosto de 2022, al encontrarse 
realizando sus rondines de vigilancia, aproximadamente a las siete horas del día de hoy, siendo 
esto  a  la  altura  de la  avenida Aceros  Mexicanos  en la colonia de  Centro en  el  municipio de 
Tlalnepantla de Baz, Estado de México, mi pareja asignada y yo nos percatamos de un tumulto 
de personas que se encontraban en la entrada de un predio que se encuentra cercado y forrado 
con malla de color verde y con una entrada de reja igualmente forrada con maya de plástico de 
color  verde,  inmueble  que  no  tiene  nomenclatura  exterior  visible,  por  lo  que  junto  con  mi 
compañera ANASTACIA RIVERA RODRIGUEZ nos aproximamos al lugar donde se encontraban las 
personas y al momento de estar en el lugar le preguntamos a una  de ellas: ¿qué era  lo que 
pasaba? y esta le responde que “huele mucho a Gasolina” por lo que procedimos a tocar en la 
puerta y acude a nuestro llamado quien en ese momento nos manifestó ser “el señor Prócoro” 
y nos preguntó ¿qué es lo que quieren? Por lo que le indican que huele mucho a gasolina y 
desean pasar a ver qué es lo que pasa, en ese momento mi compañera ANASTACIA escuchó a 
una persona que no reconoció ni identificó de ninguna manera, decir: “aquí venden gasolina 
muy barata” por lo que procedimos a solicitar nuevamente el acceso al inmueble por lo que el 
Señor Prócoro nos deja pasar; en el interior del inmueble encontramos 30 tambos de 60 litros 
llenos de combustible del denominado Gasolina Magna de 82 octanos y 45 tambos de 60 litros 
cada uno con gasolina Premium de 92 octanos. Al preguntarle al señor Prócoro que hace esa 
gasolina en ese lugar nos respondió que el solo era el velador del terreno. Por lo que procedimos 
a hacer la detención del sujeto ante la posible comisión de robo y venta de combustible. Siendo 
todo lo que deseo manifestar y previa lectura  de su dicho en este acto lo ratifico firmando al 
margen y calce de todas sus partes para su debida constancia legal."

#Depuramos el texto de:

# Espacios, enters, espaciados
docs <- gsub("[[:cntrl:]]", " ", docs)

# Quitamos acentos
docs <- chartr("áéíóú", "aeiou", tolower(docs))

#Removemos signos de puntuación
docs <- removePunctuation(docs)

#Quitamos las "palabras de alto" que son todos los articulos y palabras del discurso
#pero que no tienen sustancia

stopwords("spanish")

docs <- removeWords(docs, words = stopwords("spanish"))

#eliminamos números
docs <- removeNumbers(docs)

#Quitamos espacios extras
docs <- stripWhitespace(docs)


##################
##ANALISIS DE CORPUS
##################

###con el paquete "tm"- Minería de Texto en inglés establemos un corpus
#Con nuestro documento preparado, procedemos a crear nuestro Corpus, es decir, 
#esto es nuestro acervo de documentos a analizar.

nov_corpus <- Corpus(VectorSource(docs))

#vemo que ejecutó correctamente
nov_corpus
#Mapearemos nuestro Corpus como un documento de texto plano
nov_ptd <- tm_map(nov_corpus, PlainTextDocument)


##################
##NUBE DE PALABRAS
##################
wordcloud(nov_ptd, max.words = 80, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))


##################
##FRECUENCIAS DE PALABRAS
##################

#Mapearemos nuestro Corpus indicando que es una matriz de términos, 
#de esta manera podremos hacer realizar operaciones como identificar asociaciones entre palabras.

nov_tdm <- TermDocumentMatrix(nov_corpus)
nov_tdm

nov_mat <- as.matrix(nov_tdm)
dim(nov_mat)

#Obtenemos las sumas de renglones (rowSums) odenadas de mayor a menor 
#(sort con decreasing = TRUE)para conocer la frecuencia de cada palabra y 
#después transformamos los resultados a objeto de clase data.frame de dos columnas, 
#palabra y frec, que nos permitirá graficar fácilmente su contenido.


nov_mat <- nov_mat %>% rowSums() %>% sort(decreasing = TRUE)
nov_mat <- data.frame(palabra = names(nov_mat), frec = nov_mat)


#Gráficas de frecuencia
#Crearemos un par de gráficas. Primero, la frecuencia de uso de las palabras más frecuentes en Niebla.

#Para esto usaremos ggplot2, que tiene su propia gramática para construir gráficas. 
#Para fines de este documento, no nos detendremos a explicar a detalle su uso. 
#Lo relevante aquí es notar que estamos obteniendo la información para construir 
#las gráficas solicitando renglones del objeto nov_mat

nov_mat[1:10, ] %>%
  ggplot(aes(palabra, frec)) +
  geom_bar(stat = "identity", color = "black", fill = "#87CEFA") +
  geom_text(aes(hjust = 1.3, label = frec)) + 
  coord_flip() + 
  labs(title = "Diez palabras más frecuente",  x = "Palabras", y = "Número de usos")

##################
##Asociaciones entre palabras
##################

#Veamos ahora cómo se asocian algunas palabras con la función findAssocs. 
#Como podemos introducir un vector, podemos obtener las asociaciones de varias palabras a la vez.
#Es importante recordar que con esto no estamos pidiendo la asociacion de estas cuatro palabras entre si, 
#sino las asociaciones para cada una de las cuatro, que no necesariamente deben coincidir.
#Esta también nos pide el límite inferior de correlación (corlimit) para mostrarnos. V
#alores cercanos a 1 indican que las palabras aparecen casi siempre asociadas una con otra, 
#valores cercanos a 0 nos indican que nunca o casi nunca lo hacen.

findAssocs(nov_tdm, terms = c("procoro", "gasolina", "inmueble"), corlimit = .001)

# Las palabramas más frecuentes no se encontraron correlacionadas.
