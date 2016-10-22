
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)

shinyServer(fluidPage(
  # Application title
  titlePanel("Memory Utilsation with fitted Regression line (N+2 model)"),
  plotOutput("RegPlot"),
  titlePanel("Memory Utilsation in each host in HVA"),
  plotOutput("RawPlot")
  
))