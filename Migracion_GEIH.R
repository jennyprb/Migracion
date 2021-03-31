rm(list=ls())

library(survey)

setwd("/home/jenny/Desktop/Bases_general/GEIH")

### 1. Abrir bases de datos ####
#Definir meses 
year1 <- 2018
col1 <- c(9:12) 

year2 <- 2019
col2 <- c(1:8) 

mes <- as.factor(c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
                                  "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"))
mes <- factor(mes, ordered = TRUE, levels = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
                                           "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"))

list_year1 <- list()
for (i in mes[col1]) {
  list_year1[[i]] <-paste0(year1, "/", i)
}

list_year2 <- list()
for (i in mes[col2]) {
  list_year2[[i]] <-paste0(year2, "/", i)
}

list_total <- append(list_year1, list_year2)


l <- list()
for (i in list_total) {
  df.now <- assign(paste0(i, "-Cabecera"), 
         read.csv(paste0("./", i, ".csv/", "Cabecera - Vivienda y Hogares.csv"), sep = ";"))
  l[[i]] <- df.now
}

df_cabecera <- do.call(rbind,l)
for (i in list_total) {
  rm(list=c(paste0(i, "-Cabecera"), "df.now", "list_year1", "list_year2"))
}



for (i in mes[col1]) {
  assign(paste0(year1, "-", i, "-Area"), 
         read.csv(paste0("./", year1, "/", i, ".csv/", "╡rea - Vivienda y Hogares.csv"), sep = ";"))
}



