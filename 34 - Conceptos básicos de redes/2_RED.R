URL1 <- "https://raw.githubusercontent.com/CristinaA-Venzor/Analistas/main/Nodes1.csv"
nodes <- read.csv(URL1, header=T, as.is=T)
URL2 <- "https://raw.githubusercontent.com/CristinaA-Venzor/Analistas/main/Edges1.csv"
links <- read.csv(URL2, header=T, as.is=T) 
library("igraph")
net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 

#Examinamos la información
head(nodes)

head(links)

nrow(nodes); length(unique(nodes$id))

nrow(links); nrow(unique(links[,c("from", "to")]))

# Aristas (edges) del sociograma
E(net)

# Vértices
V(net)


#Para realizar el conteo de vertices
nombres <- nodes[, 1:2]
nombres
a <- as.matrix(net[])
a

# Peso de los nodos
edge_attr(net)
pesos <- links[, c(1,4)]
View(pesos)
#Cohesión
rowSums(a)


plot(net)
net <- simplify(net, remove.multiple = F, remove.loops = T)
simplify(net, edge.attr.comb = list(weight="sum","ignore"))
plot(net, edge.arrow.size=.1, edge.color="gray",vertex.color="orange", vertex.frame.color="#ffffff",vertex.label=V(net)$actor,
     vertex.label.color="black", vertex.size=10, vertex.label.dist=.5, vertex.label.cex= .6)
