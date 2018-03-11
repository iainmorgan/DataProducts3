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

acList <- c("AC1","AC2","AC3","AC4","AC5")

origin <- c("AP1","AP2","AP3","AP4")

hour <- c("00:00 - 00:59",
          "01:00 - 01:59",
          "02:00 - 02:59",
          "03:00 - 03:59",
          "04:00 - 04:59",
          "05:00 - 05:59",
          "06:00 - 06:59",
          "07:00 - 07:59",
          "08:00 - 08:59",
          "09:00 - 09:59",
          "10:00 - 10:59",
          "11:00 - 11:59")

#sampleTrack <- as.data.frame(lat = c(10:15),long = c(10:15))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Aircraft Tracker"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("reg","Aircraft registration",acList),
       selectInput("origin","Origin airport",origin),
       selectInput("hour","Hour of the day",hour)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("regId"),
      leafletOutput("mapTrack"),
      actionButton("recalc","Recalculate")
    )
  )
))
