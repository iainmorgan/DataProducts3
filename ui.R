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
library(dplyr)

#sampleTrack <- as.data.frame(lat = c(10:15),long = c(10:15))

tList <- c("-","A319","A320","A321")

regList <- "-"

origin <- "-"

hour <- "-"


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Aircraft Tracker"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("type","Aircraft type",tList),
  #     selectInput("hour","Hour of the day",hour),
  #     selectInput("origin","Departure airport",origin),
       selectInput("reg","Registration",regList),
       actionButton("recalc","Recalculate")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("regId"),
      leafletOutput("mapTrack"),
      plotOutput("profile", height = "150px")
    )
  )
))
