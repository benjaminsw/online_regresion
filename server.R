
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
library(reshape2)

server <- shinyServer(function(input, output, session){
  
  df <- as.data.frame(read.csv(text="datetime, host1, host2, host3, host4, host5, total"))
  data <- as.data.frame(read.csv(text="datetime, host1, host2, host3, host4, host5, total"))
  
  # Function to get new observations
  get_new_data <- function(){
    host1 <- sample(20:75, 1)
    host2 <- sample(20:75, 1)
    host3 <- sample(20:75, 1)
    host4 <- sample(20:75, 1)
    host5 <- sample(20:75, 1)
    total <- host1 + host2 + host3 + host4 + host5 
    datetime <- format(Sys.time())
    return(c(datetime,host1, host2, host3, host4, host5, total))
  }
  
  # Initialize my_data
  df[nrow(df)+1,] <- get_new_data()
  data <<- df
  
  # Function to update my_data
  update_data <- function(){
    df[nrow(df)+1.0,] <<- get_new_data()
    data <<- df[rev(rownames(df)),]
  }
  
  
  # Plot the 30 most recent values
  output$RegPlot <- renderPlot({
    invalidateLater(5000, session)
    update_data()
    plotdata <- data[1:10,]
    ggplot(plotdata, aes(datetime, total, group=1)) + geom_line() + 
      geom_smooth(method = "lm", se = FALSE) + 
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  output$RawPlot <- renderPlot({
    invalidateLater(5000, session)
    #update_data()
    plotdata <- data[1:10,1:6]
    meltdata <- melt(plotdata, id = "datetime")
    ggplot(meltdata, aes(x=datetime, y=value, group = variable, colour = variable)) + 
      geom_line() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
})
