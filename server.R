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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   output$regId <- renderText(input$reg)
   
   track <- eventReactive(input$recalc, {
     cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
   }, ignoreNULL = FALSE)
   
   output$mapTrack <- renderLeaflet({
     leaflet() %>%
       addTiles() %>%
       addMarkers(data = track(), 
                  popup = paste(input$reg, input$origin, input$hour, sep = " ")) %>%
       addPolylines(lng=track()[,1], lat=track()[,2])
   })
})
