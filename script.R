## Test script for JSON data

library(rjson)
setwd("~/R/working/FlightData")

fileName <- c("2016-06-20-0000Z.json",
              "2016-06-20-0001Z.json",
              "2016-06-20-0002Z.json")
dataFile <- "Main_database.csv"

loadData <- function(fileName,dataFile) {

  jsonData <- fromJSON(file = fileName)
  acLists <- jsonData$acList

  nullToNA <- function(x) {
    x[sapply(x, is.null)] <- NA
    return(x)
  }

  acData <- data.frame(Id=unlist(sapply(acLists,function(x) {x$Id})))
  acData$Type <- unlist(nullToNA(sapply(acLists,function(x) {x$Type})))
  acData$ICAO <- unlist(nullToNA(sapply(acLists,function(x) {x$Icao})))
  acData$Reg <- unlist(nullToNA(sapply(acLists,function(x) {x$Reg})))
  acData$From <- unlist(nullToNA(sapply(acLists,function(x) {x$From})))
  acData$To <- unlist(nullToNA(sapply(acLists,function(x) {x$To})))
  acData$Call <- unlist(nullToNA(sapply(acLists,function(x) {x$Call})))
  acData$File <- substr(fileName,1,nchar(fileName)-5)
  
  acData <- as.data.frame(acData)
  
  write.csv(acData,dataFile,append = TRUE, sep = ",")
  
#  oldData <- read.csv(dataFile)
#  oldData <- oldData[,2:9]
#  newData <- rbind(oldData,acData)
#  write.csv(newData,dataFile)
  
}

for (i in 1:length(fileName)) {
  loadData(fileName[i],"Main_database.csv")
}

jsonData <- fromJSON(file = "2016-06-20-0000Z.json")
acLists <- jsonData$acList

nullToNA <- function(x) {
  x[sapply(x, is.null)] <- NA
  return(x)
}

paramList <- c("Id", 
               "Rcvr", 
               "HasSig", 
               "Icao", 
               "Bad", 
               "Reg", 
               "FSeen", 
               "TSecs", 
               "CMsgs", 
               "Alt", 
               "GAlt", 
               "AltT", 
               "Tisb", 
               "TrkH", 
               "Type", 
               "Mdl", 
               "Man", 
               "CNum", 
               "Op", 
               "OpIcao", 
               "Sqk", 
               "VsiT", 
               "WTC", 
               "Species", 
               "Engines", 
               "EngType", 
               "EngMount", 
               "Mil", 
               "Cou", 
               "HasPic", 
               "Interested", 
               "FlightsCount", 
               "Gnd", 
               "SpdTyp", 
               "CallSus", 
               "TT", 
               "Trt", 
               "Year", 
               "Sig",
               "InHg",
               "TAlt",
               "Call",
               "Lat",
               "Long",
               "PosTime",
               "Mlat",
               "Spd",
               "Trak",
               "TTrk",
               "From",
               "To",
               "Stops",
               "Help",
               "Vsi",
               "Tag",
               "ResetTrail")

extractData <- function(x) {
  tempData <- data.frame(Id = unlist(nullToNA(x$Id)),
                         Rcvr = unlist(nullToNA(x$Rcvr)),
                         HasSig= unlist(nullToNA(x$HasSig)),
                         Icao= unlist(nullToNA(x$Icao)),
                         Bad= unlist(nullToNA(x$Bad)),
                         Reg= unlist(nullToNA(x$Reg)),
                         FSeen= unlist(nullToNA(x$FSeen)),
                         TSecs= unlist(nullToNA(x$TSecs)),
                         CMsgs= unlist(nullToNA(x$CMsgs)),
                         Alt= unlist(nullToNA(x$Alt)),
                         GAlt= unlist(nullToNA(x$GAlt)),
                         AltT= unlist(nullToNA(x$AltT)),
                         Tisb= unlist(nullToNA(x$Tisb)),
                         TrkH= unlist(nullToNA(x$TrkH)),
                         Type= unlist(nullToNA(x$Type)),
                         Mdl= unlist(nullToNA(x$Mdl)),
                         Man= unlist(nullToNA(x$Man)),
                         CNum= unlist(nullToNA(x$CNum)),
                         Op= unlist(nullToNA(x$Op)),
                         OpIcao= unlist(nullToNA(x$OpIcao)),
                         Sqk= unlist(nullToNA(x$Sqk)),
                         VsiT= unlist(nullToNA(x$VsiT)),
                         WTC= unlist(nullToNA(x$WTC)),
                         Species= unlist(nullToNA(x$Species)),
                         Engines= unlist(nullToNA(x$Engines)),
                         EngType= unlist(nullToNA(x$EngType)),
                         EngMount= unlist(nullToNA(x$EngMount)),
                         Mil= unlist(nullToNA(x$Mil)),
                         Cou= unlist(nullToNA(x$Cou)),
                         HasPic= unlist(nullToNA(x$HasPic)),
                         Interested= unlist(nullToNA(x$Interested)),
                         FlightsCount= unlist(nullToNA(x$FlightsCount)),
                         Gnd= unlist(nullToNA(x$Gnd)),
                         SpdTyp= unlist(nullToNA(x$SpdTyp)),
                         CallSus= unlist(nullToNA(x$CallSus)),
                         TT= unlist(nullToNA(x$TT)),
                         Trt= unlist(nullToNA(x$Trt)),
                         Year= unlist(nullToNA(x$Year)),
                         Sig= unlist(nullToNA(x$Sig)),
                         InHg= unlist(x$InHg),
                         TAlt= unlist(x$TAlt),
                         Call= unlist(nullToNA(x$Call)),
                         Lat= unlist(x$Lat),
                         Long= unlist(x$Long),
                         PosTime= unlist(x$PosTime),
                         Mlat= unlist(x$Mlat),
                         Spd= unlist(nullToNA(x$Spd)),
                         Trak= unlist(x$Trak),
                         TTrk= unlist(x$TTrk),
                         From= unlist(x$From),
                         To= unlist(x$To),
                         Stops= unlist(x$Stops),
                         Help= unlist(x$Help),
                         Vsi= unlist(nullToNA(x$Vsi)),
                         Tag= unlist(x$Tag),
                         ResetTrail= unlist(x$ResetTrail))
  tempData
}



xp <- lapply(acInfo,extractData)
df <- do.call("rbind", xp)

xp <- lapply(acInfo,extractData)
head(xp)


xp <- as.data.frame(xp)

acData <- data.frame(Id=unlist(sapply(acLists,function(x) {x$Id})))
acData$Type <- unlist(nullToNA(sapply(acLists,function(x) {x$Type})))
acData$ICAO <- unlist(nullToNA(sapply(acLists,function(x) {x$Icao})))
acData$Reg <- unlist(nullToNA(sapply(acLists,function(x) {x$Reg})))
acData$From <- unlist(nullToNA(sapply(acLists,function(x) {x$From})))
acData$To <- unlist(nullToNA(sapply(acLists,function(x) {x$To})))
acData$Call <- unlist(nullToNA(sapply(acLists,function(x) {x$Call})))
acData$File <- substr(fileName,1,nchar(fileName)-5)

acData <- as.data.frame(acData)

write.table(acData,file = "Main_database.csv",
          append = TRUE, 
          sep = ",", 
          col.names = FALSE)