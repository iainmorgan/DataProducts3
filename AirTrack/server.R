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

inpData <- read.csv("Reglist.csv", stringsAsFactors = FALSE, header = FALSE)

list319 <- distinct(as.data.frame(inpData[inpData[,1]=="A319",]))
list319 <- list319[order(list319[,2]),]
list319 <- list319[!is.na(list319[,1]),]

list320 <- distinct(as.data.frame(inpData[inpData[,1]=="A320",]))
list320 <- list320[order(list320[,2]),]
list320 <- list320[!is.na(list320[,1]),]

list321 <- distinct(as.data.frame(inpData[inpData[,1]=="A321",]))
list321 <- list321[order(list321[,2]),]
list321 <- list321[!is.na(list321[,1]),]

inpList <- rbind(c("-","-"),
                 list319,
                 list320,
                 list321)

colnames(inpList) <- c("Type","Reg")

# regList <- distinct(as.data.frame(inpData$Reg))
# regList <- as.data.frame(regList[order(regList),])

# origin <- distinct(as.data.frame(inpData$From))
# origin <- as.data.frame(origin[order(origin),])

# hour <- c("00:00 - 00:59",
#          "01:00 - 01:59",
#          "02:00 - 02:59")

posData <- read.csv("Posdata.csv", stringsAsFactors = FALSE, header = FALSE)
colnames(posData) <- c("Reg","Lat","Lon","Time","Alt")
posData$Time <- as.POSIXct(as.numeric(posData$Time)/1000, origin="1970-01-01", tz="GMT")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   output$regId <- renderText(paste("Flight track for ",input$reg,sep=""))

   output$regProf <- renderText(paste("Flight profile for ",input$reg,sep=""))
      
   observeEvent(input$type, {
     outList <- inpList[inpList$Type==input$type,2]
     updateSelectInput(session, "reg", choices = outList)
   })
   
   track <- eventReactive(input$recalc, {
      posData[posData$Reg==input$reg & !is.na(posData$Alt),]
   }, ignoreNULL = FALSE)
   
   output$mapTrack <- renderLeaflet({
     leaflet() %>%
       addTiles() %>%
#       addMarkers(data = track(), 
#                  popup = paste(track()[,1], " ", track()[,4], " ", track()[,5],"ft", sep = "")) %>%
       addPolylines(lng=track()[,3], lat=track()[,2])
   })
   
   output$plotProfile <- renderPlot({
     g <- ggplot(data = track(), aes(x = track()$Time, y = track()$Alt)) 
     g <- g + geom_step()
     g <- g + coord_cartesian(ylim = c(0,42000))
     g <- g + labs(title = "Flight profile", x = "Time", y = "Altitude (ft)")
     g
   })
})
