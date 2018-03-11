#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)

# Load data lists

loadAC <- function(dataFile, acReg) {
  
  nullToNA <- function(x) {
    x[sapply(x, is.null)] <- NA
    return(x)
  }
  
  acData <- read.csv(dataFile)
  
  fileList <- acData[acData$Reg == acReg,]$File
  
  for (i in 1:length(fileList)) {
    
    jsonData <- fromJSON(file = paste(fileList[i],".json", sep=""))
    acLists <- jsonData$acList
    
    thisReg <- unlist(nullToNA(sapply(acLists,function(x) {x$Reg})))
    
    listPos <- which(thisReg==acReg & !is.na(thisReg))
    
    acPos <- acLists[[listPos]]$Cos
    
    if (!is.null(acPos)) {
      acPos <- unlist(nullToNA(acPos))
      if (!exists("acMatrix")) 
        acMatrix <- matrix(acPos, ncol = 4, byrow = TRUE)
      else
        acMatrix <- rbind(acMatrix,matrix(acPos, ncol = 4, byrow = TRUE))
    }
    
  }
  
  return(acMatrix)
  
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   output$regId <- renderText(input$reg)
   
   track <- eventReactive(input$recalc, {
      loadAC("~/R/working/FlightData/Main_database.csv","G-OZBF")
   }, ignoreNULL = FALSE)
   
   output$mapTrack <- renderLeaflet({
     leaflet() %>%
       addTiles() %>%
       addMarkers(data = track(), 
                  popup = paste(input$reg, input$origin, input$hour, sep = " ")) %>%
       addPolylines(lng=track()[,1], lat=track()[,2])
   })
})
