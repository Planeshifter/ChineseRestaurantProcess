
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
source('ChineseRestaurantProcess.R', echo=TRUE)

shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
     
    # generate and plot an rnorm distribution with the requested
    # number of observations
    dist <- chinese_restaurant_process(input$num_customers,input$alpha)
    p = qplot(x=as.factor(dist))+geom_bar() + labs(x="Table",y="# Customers at Table")
    print(p)
  })
  
  output$convPlot <- renderPlot({
    
    cust_vec = 1:1000
    expected = sapply(cust_vec, function(x) {num_tables(x,input$alpha)})
    bound = sapply(cust_vec, function(x) {upper_bound(x,input$alpha)})
    df1 = data.frame(cust_vec, expected = expected, bound = bound)
    p = ggplot(df1,aes(x=cust_vec,y=expected))+geom_line(col="steelblue")+geom_line(aes(x=cust_vec,y=bound),col="red",lty=3)+labs(x="# of Customers",y="Expected # of Tables")
    print(p)
  })
  
})
