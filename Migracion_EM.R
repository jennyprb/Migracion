rm(list=ls())

library(survey)

dec = ","
### 1. Abrir bases de datos ####
Identificacion <- read.csv("/home/jenny/Desktop/Bases_general/Encuenta_Multiproposito/2017/Identificacion ( Capitulo A).csv",
                           sep = ";", dec=dec)

Hogar <- read.csv("/home/jenny/Desktop/Bases_general/Encuenta_Multiproposito/2017/Condiciones habitacionales del hogar   (Capitulo C).csv",
                  sep = ";", dec=dec)

Demografia <- read.csv("/home/jenny/Desktop/Bases_general/Encuenta_Multiproposito/2017/Composicion del hogar y demografia ( Capitulo E).csv",
                       sep = ";", dec=dec)


### 2. Unir y limpiar bases de datos ####
#2.1. Identificacion de vivienda con hogares
drops <- c("SECUENCIA", "SECUENCIA_P", "ORDEN")

df <- merge(Identificacion[ , !(names(Identificacion) %in% drops)], 
            Hogar, by = c("DIRECTORIO",  "FEX_C"), all.y = TRUE)

table(df$SECUENCIA_P)
table(Demografia$SECUENCIA_P)

drops <- c("ORDEN", "SECUENCIA_P")
df <- merge(df[ , !(names(df) %in% drops)], Demografia, 
            by = c("DIRECTORIO_HOG", "DIRECTORIO", "FEX_C"), all.y = TRUE)

#2.2. Arreglar paises en NPCEP11AC
table(df$NPCEP11A)
table(df$NPCEP11AC)
levels(df$NPCEP11AC)

df$NPCEP11AC[df$NPCEP11AC %in% c("CARACAS VENEZUELA", "MARACAIBO VENEZUELA", "VEMEZUELA", "VENEZOLANA", 
                                 "Venezuela", "VENEZUELA MARACAIBO", "VENEZULA", "CARACAS VENEZULA",
                                 "VANAZUELA", "VENENSUELA", "VENEZOLANO", "VENEZUELA VARINAS", 
                                 "VENEZULA MARACAIBO", "FRIAS VENEZUELA", "VANEZUELA", "VENENZUELA",
                                 "VENEZOLANOS", "VENEZUELA CARACAS", "VENEZUELQ", "VENRZUELA", "VEEZUELA",
                                 "VENESUELA", "venezuela", "VENEZUELA ISLA CARIBE", "VENEZUELW", 
                                 "VEZUELA", "CARACAS")] <- "VENEZUELA"

df$NPCEP11AC[df$NPCEP11AC %in% c("E.U", "EE.UU", "ESTADOS UNIDOS PENSILVANIA", "HUSTON TEXAS",
                                 "NY", "EEUU", "ESTADOS UNIDIOS", "ESTADOS.UNIDOS", "EE UU",
                                 "NEW YORK", "USA", "ESTADOSUNIDOS", "HOUSTON TEXAS", "MIAMI",
                                 "Estados unidos", "LAS VEGAS")] <- "ESTADOS UNIDOS"

df$NPCEP11AC[df$NPCEP11AC %in% c("FEANCIA", "Paris", "FRANCIA PARIS", "Francia", "PARIS",
                                 "FRACIA")] <- "FRANCIA"
df$NPCEP11AC[df$NPCEP11AC %in% c("ITALIS ROMA", "Italia", "ROMA", "ITALIA FIORENCE" )] <- "ITALIA"
df$NPCEP11AC[df$NPCEP11AC %in% c("MEXICO  - BERACRUZ", "MEXICO PUEBLA", "MEXICO, GUADALAJARA, JALISCO",
                                 "MEXICO - BERACRUZ", "MEXICO D.F.", "MEXICO DF", "MEJICO")] <- "MEXICO"

df$NPCEP11AC[df$NPCEP11AC %in% c("ISRAIL")] <- "ISRAEL"
df$NPCEP11AC[df$NPCEP11AC %in% c("BARCELONA", "ESPAÑA", "BARCELONA ESPANA", "MADRID ESPANA")] <- "ESPANA"
df$NPCEP11AC[df$NPCEP11AC %in% c("BRAZIL")] <- "BRASIL"
df$NPCEP11AC[df$NPCEP11AC %in% c("FRIBURGO ALEMANIA", "BERLIN")] <- "ALEMANIA"
df$NPCEP11AC[df$NPCEP11AC %in% c("LA PAZ BOLIVIA", "PAZ BOLIVIA")] <- "BOLIVIA"
df$NPCEP11AC[df$NPCEP11AC %in% c("LIMA", "PERÚ", "LIMA PERU", "PERU LIMA", "Peru")] <- "PERU"
df$NPCEP11AC[df$NPCEP11AC %in% c("SALVADOR", "SAN SALVADOR", "SAN SALVAFOR")] <- "EL SALVADOR"
df$NPCEP11AC[df$NPCEP11AC %in% c("UNGRIA")] <- "HUNGRIA"
df$NPCEP11AC[df$NPCEP11AC %in% c("QUITO", "ECUADOR QUITO", "QUITO ECUADOR")] <- "ECUADOR"
df$NPCEP11AC[df$NPCEP11AC %in% c("LONDRES")] <- "INGLATERRA"
df$NPCEP11AC[df$NPCEP11AC %in% c("PRAGA")] <- "POLONIA"
df$NPCEP11AC[df$NPCEP11AC %in% c("URUGUAY MONTEVIDEO", "URUGUAI")] <- "URUGUAY"
df$NPCEP11AC[df$NPCEP11AC %in% c("IRLANDA,")] <- "IRLANDA"
df$NPCEP11AC[df$NPCEP11AC %in% c("KOREA  DEL SUR", "KOREA DEL SUR", "KOREA", "KOREA DEL SUR")] <- "COREA DEL SUR"
df$NPCEP11AC[df$NPCEP11AC %in% c("CUIDAD DE GUATEMALA")] <- "GUATEMALA"
df$NPCEP11AC[df$NPCEP11AC %in% c("MOSKU","RUSSIA", "Rusia", "MOSCU")] <- "RUSIA"
df$NPCEP11AC[df$NPCEP11AC %in% c("SANTO DOMINGO", "REP DOMINICANA")] <- "REPUBLICA DOMINICANA"
df$NPCEP11AC[df$NPCEP11AC %in% c("EL CAIRO EGIPTO")] <- "EGIPTO"
df$NPCEP11AC[df$NPCEP11AC %in% c("Holanda")] <- "HOLANDA"
df$NPCEP11AC[df$NPCEP11AC %in% c("SAN JOSE COSTA RICA", "SAN JOSE COSTARICA", "SAN JOSE DE COSTARRICA")] <- "COSTA RICA"
df$NPCEP11AC[df$NPCEP11AC %in% c("TOKIO")] <- "JAPON"
df$NPCEP11AC[df$NPCEP11AC %in% c("VALPARAISO CHILE", "SANTIAGO - CHILE" )] <- "CHILE"
df$NPCEP11AC[df$NPCEP11AC %in% c("BUENOS AIRES ARGENTINA")] <- "ARGENTINA"
df$NPCEP11AC[df$NPCEP11AC %in% c("SANTIAGO DE CUBA")] <- "CUBA"

#df$NPCEP11AC[df$NPCEP11AC %in% c("CIBERIA")] <- "SIBERIA"
#df$NPCEP11AC[df$NPCEP11AC %in% c("IMALASIA")] <- "MALASIA"
#df$NPCEP11AC[df$NPCEP11AC %in% c("BEIRUT", "LIBANO BEIRUT", "LIBANO BAABDA")] <- "LIBANO"
#df$NPCEP11AC[df$NPCEP11AC %in% c("MOSAMBIQUE", "MOSANBIQUE")] <- "MOZAMBIQUE"
#df$NPCEP11AC[df$NPCEP11AC %in% c("AHITI")] <- "HAITI"

df$NPCEP11AC <- droplevels(df$NPCEP11AC)


### 3. Descriptivos ####
#Creación de base de datos ponderada
df_ponderada <- svydesign(data = df, id=~1, weights = ~FEX_C)
print ("Población por municipios")
svytable(~DPTOMPIO, design= df_ponderada)

localidad_total <- as.data.frame(svytable(~LOCALIDAD_TEX, design= df_ponderada)) 
names(localidad_total)[names(localidad_total) == "Freq"] <- "Total"

localidad_nacionalidad <- as.data.frame(round(svytable(~NPCEP11AC + LOCALIDAD_TEX, design= df_ponderada ), 2)) 
localidad_nacionalidad <- localidad_nacionalidad[localidad_nacionalidad$NPCEP11AC == "VENEZUELA", c(2,3)]
names(localidad_nacionalidad)[names(localidad_nacionalidad) == "Freq"] <- "Venezolanos"

poblacion <- merge(localidad_total, localidad_nacionalidad, by = c("LOCALIDAD_TEX"), all.y = TRUE)


#round(prop.table(svytable(~NPCEP11AC + LOCALIDAD_TEX, design= df_ponderada ), 1) * 100, 2)


