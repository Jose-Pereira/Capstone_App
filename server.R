library(tm)
#read the data
Pred4DB = read.csv ("data/FinalPred4DB", stringsAsFactors=FALSE)
Pred3DB = read.csv ("data/FinalPred3DB", stringsAsFactors=FALSE)
Pred2DB = read.csv ("data/FinalPred2DB", stringsAsFactors=FALSE)


shinyServer(function(input, output) { # server is defined within
  # these parentheses
  output$textDisplay <- renderText({ # mark function as reactive
    # and assign to
    # output$textDisplay for
    # passing to ui.R
     value = VCorpus(VectorSource (input$value))
#aca tengo q hacerle transformaciones a lo escrito, tolower, whitespaces, puntuacion
#todo a minuscula
     value = tm_map(value, content_transformer(tolower))
#Remove Punctuation
     value = tm_map(value, removePunctuation)
#Remove Numbers, since im not planning on predict them 
     value = tm_map(value, removeNumbers)
#Remove Whitespace.
     value = tm_map(value, stripWhitespace)
#desgloso frase en numero de palabras en base al espacio
    value = unlist (strsplit (as.character(value[[1]]), split = " "))
    #length (value) para saber el numero de palabras
    #si la frase tiene una palabra buscala en BD2
if (length (value) == 0 ){ 
  print ("The app is waiting for your input") 
  #si la frase tiene una palabra buscala en BD2
} else if (length (value) == 1){ 
  Pred2DB$pred[grep (value, Pred2DB$base)]
} else if (length (value) == 2) { 
  Pred3DB$pred[grep (paste(value, collapse = " "), Pred3DB$base)]
} else if (length (value) == 3) { 
  Pred4DB$pred[grep (paste(value, collapse = " "), Pred4DB$base)]
} else { #si es mayor, a lo que puedo buscar en el fourgran lo recorto para poder buscarlo en el fourgran
  #de esta forma el fourgran es mi primera opcion
  ini = length(value)-2
  phrase = paste(value [ini:length(value)], collapse = " ")
  Pred4DB$pred[grep (phrase, Pred4DB$base)]
  #si el fourgran no da resultado vamos al threegran
  ini = length(value)-1
  phrase = paste(value [ini:length(value)], collapse = " ")
  Pred3DB$pred[grep (phrase, Pred3DB$base)]
  #si no hay en el threegran vamos al bigran
  ini = length(value)
  phrase = value [length(value)]
  Pred2DB$pred[grep (phrase, Pred2DB$base)]  
}
  })
})


