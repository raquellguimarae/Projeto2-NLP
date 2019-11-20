getwd()
setwd("c:/PROJETOS_GIT/Projetos_NLP/NuvemDePalavras")


# Instale os pacotes abaixo:
#install.packages("tm")
#install.package("SnowballC")
#install.packages("wordcloud")
#install.packages("RColorBrewer")

# Carregue os pacotes:
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Crie um arquivo com várias palavras repetidas e salve no diretório do script.
#Neste exemplo criei um arquivo com vários nomes de frutas.

# Atribuindo o arquivo a um objeto chamado "arquivo"
arquivo <- "frutas.txt"

# Lendo o arquivo
texto <- readLines(arquivo)


# Criando uma coleção de documentos com o objeto Corpus.
# Este objeto é utilizado para se trabalhar análise estatística dentro de strings e permite o tratamento de uma grande massa de texto:
docs <- Corpus(VectorSource(texto))

# Verificando todos os dados encontrados:
inspect(docs)


# Convertendo o texto para minúsculo:
docs <- tm_map(docs, content_transformer(tolower))


# Removendo números:
docs <- tm_map(docs, removeNumbers)


# Juntando as palavras que aparecem com maior frequência:
docs <- tm_map(docs, stemDocument)

# Criando uma matriz:
tdm <- TermDocumentMatrix(docs)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)



# Mostra as palavras que mais aparecem e a frequência:
head(d, 10)


# Construindo a nuvem de palavras (wordcloud):
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))

#words = lista de palavras
#freq = frequência de palavras
#min.freq = 1 -> frequência mínima para que uma palavra apareça
#max.words=200 -> máximo de palavras que devem aparecer
#random.order=FALSE -> as palavras com maior frequência aparecem no centro da nuvem e em tamanho maior
#rot.per -> grau de rotação das palavras
#colors -> cores da menor frequência para a maior frequência

#----------------------------------------------------------

# Tabela de frequência:
findFreqTerms(tdm, lowfreq = 4)
findAssocs(tdm, terms = "freedom", corlimit = 0.3)
head(d, 10)


# Gráfico de barras com as palavras mais frequentes:
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="gray", main ="Palavras Mais Frequentes",
        ylab = "Frequências de Palavras")



