rm(list=ls())

dec = ","
delim = ","
### 1. Abrir bases de datos ####
MGN <- read.csv("/home/jenny/Desktop/Bases_general/Bogota/CNPV2018_MGN_A2_11.CSV",
                sep = delim)

VIVIENDAS <- read.csv("/home/jenny/Desktop/Bases_general/Bogota/CNPV2018_1VIV_A2_11.CSV",
                      sep = delim)

HOGAR <- read.csv("/home/jenny/Desktop/Bases_general/Bogota/CNPV2018_2HOG_A2_11.CSV",
                  sep = delim)

PERSONA <- read.csv("/home/jenny/Desktop/Bases_general/Bogota/CNPV2018_5PER_A2_11.CSV",
                    sep = delim)


colnames(VIVIENDAS)
colnames(HOGAR)
colnames(PERSONA)
### 2. Unir y limpiar bases de datos ####
#2.1. Identificacion de vivienda con hogares
drops <- c("TIPO_REG")
df <- merge(VIVIENDAS[ , !(names(VIVIENDAS) %in% drops)], 
            HOGAR, by = c("COD_ENCUESTAS",  "U_DPTO", "U_MPIO", "UA_CLASE", "U_VIVIENDA" ), all.y = TRUE)

drops <- c("TIPO_REG")
df <- merge(df[ , !(names(df) %in% drops)], 
            PERSONA, by = c("COD_ENCUESTAS",  "U_DPTO", "U_MPIO", "UA_CLASE", "U_VIVIENDA" ), all.y = TRUE)

colnames(df)
my_cols <- c("COD_ENCUESTAS", "U_DPTO", "U_MPIO", "UA_CLASE", "U_VIVIENDA", "U_EDIFICA", "P_NROHOG",
             "P_NRO_PER", "P_SEXO", "P_EDADR", "P_PARENTESCOR", "PA1_GRP_ETNIC", "PA_LUG_NAC",
             "PA_VIVIA_5ANOS", "PA_VIVIA_1ANO")

df[df(my_cols)]

rm(VIVIENDAS, HOGAR, PERSONA)
my_col <- 
  df <- merge(df, MGN, by = c("COD_ENCUESTAS",  "U_DPTO", "U_MPIO", "UA_CLASE", "U_EDIFICA", "U_VIVIENDA"), 
              all.y = TRUE)
