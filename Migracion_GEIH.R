rm(list=ls())

library(survey)
library(data.table)

setwd("/home/jenny/Desktop/Bases_general/GEIH")
dec= ","
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

##1.1. Cabecera ####
l <- list()
for (i in list_total) {
  df.now <- assign(paste0(i, "-Cabecera"), 
         read.csv(paste0("./", i, ".csv/", "Cabecera - Características generales (Personas).csv"), sep = ";", dec=dec))
  l[[i]] <- df.now
}

df_cabecera <- do.call(rbind,l)
for (i in list_total) {
  rm(list=c(paste0(i, "-Cabecera")))
}
rm(list = c("list_year1", "list_year2"))

##1.2. Area ####
l <- list()
for (i in list_total) {
  df.now <- assign(paste0(i, "-Area"), 
                   read.csv(paste0("./", i, ".csv/", "╡rea - Características generales (Personas).csv"), sep = ";", dec=dec))
  l[[i]] <- df.now
}

df_area <- do.call(rbind,l)
for (i in list_total) {
  rm(list=c(paste0(i, "-Area")))
}

##1.3. Rest ####
l <- list()
for (i in list_total) {
  df.now <- assign(paste0(i, "-Resto"), 
                   read.csv(paste0("./", i, ".csv/", "Resto - Características generales (Personas).csv"), sep = ";", dec=dec))
  l[[i]] <- df.now
}

df_resto <- do.call(rbind,l)
for (i in list_total) {
  rm(list=c(paste0(i, "-Resto")))
}

##1.4. Migracion ####
l <- list()
for (i in list_total) {
  df.now <- assign(paste0(i, "-Migracion"), 
                   read.csv(paste0("./", i, ".csv/", "Migracion.csv"), sep = ";", dec=dec))
  l[[i]] <- df.now
}

df_migracion <- do.call(rbind,l)
for (i in list_total) {
  rm(list=c(paste0(i, "-Migracion")))
}
rm(list = c("df.now"))


##2. Unir bases y filtrar municipio ####
df <- rbindlist(list(df_area, df_cabecera, df_resto), fill = TRUE)
setnames(df_migracion, old = c('Directorio','Secuencia_p', 'Orden', 'Mes', 'Fex_c_2011'), 
         new = c('DIRECTORIO','SECUENCIA_P', 'ORDEN', 'MES', 'fex_c_2011'))

df <- merge(df, df_migracion, 
            by = c('DIRECTORIO','SECUENCIA_P', 'ORDEN', 'MES', 'fex_c_2011'), all.y = TRUE)

df <- df[which(df$AREA == "11")]

##3. Encuesta con ponderaciones ####
df_ponderada <- svydesign(data = df, id=~1, weights = ~fex_c_2011)
print ("Población por municipios")
svytable(~P756S3, design= df_ponderada)

