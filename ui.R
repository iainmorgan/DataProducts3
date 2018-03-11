#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

#sampleTrack <- as.data.frame(lat = c(10:15),long = c(10:15))

inpData <- read.csv("~/R/working/FlightData/Main_database.csv", stringsAsFactors = FALSE)

tList <- distinct(as.data.frame(inpData$Type))

regList <- distinct(as.data.frame(inpData$Reg))
regList <- as.data.frame(regList[order(regList),])

origin <- distinct(as.data.frame(inpData$From))
origin <- as.data.frame(origin[order(origin),])

hour <- c("00:00 - 00:59",
          "01:00 - 01:59",
          "02:00 - 02:59")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Aircraft Tracker"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("type","Aircraft type",tList),
       selectInput("hour","Hour of the day",hour),
       selectInput("origin","Departure airport",origin),
       selectInput("reg","Registration",regList)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("regId"),
      leafletOutput("mapTrack"),
      actionButton("recalc","Recalculate")
    )
  )
))
