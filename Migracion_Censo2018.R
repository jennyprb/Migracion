rm(list=ls())

dec = ","
delim = ","
### 1. Abrir bases de datos ####
MGN <- read.csv("/home/jenny/Desktop/Bases_general/Censo/Bogota/CNPV2018_MGN_A2_11.CSV",
                sep = delim)

VIVIENDAS <- read.csv("/home/jenny/Desktop/Bases_general/Censo/Bogota/CNPV2018_1VIV_A2_11.CSV",
                      sep = delim)

HOGAR <- read.csv("/home/jenny/Desktop/Bases_general/Censo/Bogota/CNPV2018_2HOG_A2_11.CSV",
                  sep = delim)

PERSONA <- read.csv("/home/jenny/Desktop/Bases_general/Censo/Bogota/CNPV2018_5PER_A2_11.CSV",
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
names(df)[names(df) == "H_NROHOG"] <- "P_NROHOG"
df <- merge(df[ , !(names(df) %in% drops)], 
            PERSONA, by = c("COD_ENCUESTAS",  "U_DPTO", "U_MPIO", "UA_CLASE", "U_VIVIENDA", "P_NROHOG" ))

colnames(df)
my_cols <- c("COD_ENCUESTAS", "U_DPTO", "U_MPIO", "UA_CLASE", "U_VIVIENDA", "U_EDIFICA", "P_NROHOG",
             "P_NRO_PER", "P_SEXO", "P_EDADR", "P_PARENTESCOR", "PA1_GRP_ETNIC", "PA_LUG_NAC",
             "PA_VIVIA_5ANOS", "PA_VIVIA_1ANO")

df <- df[my_cols]
rm(VIVIENDAS, HOGAR, PERSONA)
df <- merge(df, MGN, by = c("COD_ENCUESTAS",  "U_DPTO", "U_MPIO", "UA_CLASE", "U_EDIFICA", "U_VIVIENDA"))
rm(MGN)

### 3. Análisis exploratorio ####
localidad_total <- as.data.frame(table(df$COD_DANE_ANM, df$PA_LUG_NAC)) 
table(df$COD_DANE_ANM)
names(localidad_total)[names(localidad_total) == "Freq"] <- "Total"

localidad_nacionalidad <- as.data.frame(round(svytable(~NPCEP11AC + LOCALIDAD_TEX, design= df_ponderada ), 0)) 
localidad_nacionalidad <- localidad_nacionalidad[localidad_nacionalidad$NPCEP11AC == "VENEZUELA", c(2,3)]
names(localidad_nacionalidad)[names(localidad_nacionalidad) == "Freq"] <- "Venezolanos"
