## Test script for JSON data

library(rjson)
setwd("~/R/working/FlightData")

#fileS <- c("2016-06-20-0000Z.json",
#              "2016-06-20-0001Z.json",
#              "2016-06-20-0002Z.json")

dataFile <- "Main_database.csv"

loadData <- function(fileName,dataFile) {

  jsonData <- fromJSON(file = fileName)
  acLists <- jsonData$acList

  nullToNA <- function(x) {
    x[lapply(x, is.null)] <- NA
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
  
  write.table(acData,file = dataFile,
              append = TRUE, 
              sep = ",", 
              col.names = TRUE)
}

fileS <- list.files()

for (i in 1:length(fileS)) {
  loadData(fileS[i],"Main_database.csv")
}

## function to load the data for a single aircraft

acPath <- function(acReg) {
  newData <- read.csv("Main_database.csv", header = TRUE, row.names = NULL)

  acData <- newData[!is.na(newData$Reg),]
  acData <- acData[acData$Reg==acReg,]

  jsonData <- fromJSON(file = paste(as.character(acData[1,]$File),".json",sep=""))
  acInfo <- jsonData$acList

  targetData <- acInfo[[as.numeric(acData[1,1])]]$Cos
  targetData[lapply(targetData,is.null)==TRUE] <- NA
  fullData <- matrix(unlist(targetData), ncol = 4, byrow=TRUE)

  for (i in 2:nrow(acData)) {
  
    jsonData <- fromJSON(file = paste(as.character(acData[i,]$File),".json",sep=""))
    acInfo <- jsonData$acList
  
    targetData <- acInfo[[as.numeric(acData[i,1])]]$Cos
    targetData[lapply(targetData,is.null)==TRUE] <- NA
    targetData <- matrix(unlist(targetData), ncol = 4, byrow=TRUE)
  
    fullData <- rbind(fullData,targetData)
  }
  
  fullData <- unique(fullData)
  colnames(fullData) <- c("Lat", "Lon", "Time", "Alt")
  fullData
}

testData <- acPath("G-EUPD")

## Plot a trajectory on the map

library(leaflet)

myMap <- testData %>%
  leaflet() %>%
  addTiles() %>%
  addMarkers(data = testData, lng = ~Lon, lat = ~Lat)
myMap

##


## 


jsonData <- fromJSON(file = paste(as.character(xr[1,]$File),".json",sep=""))
acInfo <- jsonData$acList

nullToNA <- function(x) {
  x[sapply(x, is.null)] <- NA
  return(x)
}

xt <- unlist(nullToNAL(acInfo[[24]]$Cos))
xt <- matrix(xt, ncol = 4, byrow = TRUE)

jsonData <- fromJSON(file = paste(as.character(xr[2,]$File),".json",sep=""))
acInfo <- jsonData$acList

xc <- acInfo[[as.numeric(xr[2,1])]]$Cos
xc[lapply(xc,is.null)==TRUE] <- NA
xc <- unlist(xc)
xc <- matrix(xc, ncol = 4, byrow=TRUE)

rbind(xt,xc)



xm <- unlist(nullToNA(acInfo[[xr[2,]$row.names]]$Cos))
xm <- matrix(xt, ncol = 4, byrow = TRUE)
rbind(xt,xm)



acData <- data.frame(Id=unlist(sapply(acLists,function(x) {x$Id})))
acData$Type <- unlist(nullToNA(sapply(acLists,function(x) {x$Type})))



for (i in 1:length(xr)){
  jsonData <- fromJSON(file = as.character(xr$File))
  acInfo <- jsonData$acList
  
  nullToNA <- function(x) {
    x[sapply(x, is.null)] <- NA
    return(x)
  }
  
  acData <- data.frame(Id=unlist(sapply(acLists,function(x) {x$Id})))
  acData$Type <- unlist(nullToNA(sapply(acLists,function(x) {x$Type})))
}

loadAC <- function(dataFile, acReg) {
  acData <- read.csv(dataFile)
  
  
  
}

