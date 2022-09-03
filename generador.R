t <- 20  #Número de intervalos
N <- 150 #Número de participantes
a <- 0 #Extremo inferior intervalo
b <- 1 #Extremo superior intervalo
l <- (b - a)/t #longitud del intervalo 

Sample <- runif(N, a, b)
sortSample <- sort(Sample)
SampleDensity <- c(1:t)

for(i in SampleDensity){
  SampleDensity[i] <- 0
}

e <- 1
counter <- 0
for(j in sortSample){
    if(j<=l*e) {counter <- counter +1
    }
    else {
      SampleDensity[e] <- counter
      e <- e+1
      counter <- 0
    }
    
}

sum(SampleDensity)
SampleDensity
for(i in c(1:t)) print(cat(i,' ',SampleDensity[i]))

