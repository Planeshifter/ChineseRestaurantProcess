
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Chinese Restaurant Process"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    tags$head( tags$script(src="https://cdn.mathjax.org/mathjax/2.0-latest/MathJax.js?config=TeX-AMS_HTML") ),
    sliderInput("num_customers", 
                "Number of Customers:", 
                min = 1, 
                max = 100, 
                value = 50),
    sliderInput("alpha",
                "Dispersion Parameter (\\( \\alpha \\)):",
                min = 0.1,
                max = 10,
                value = 1),
    plotOutput("distPlot")
    
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("Explanation",     
               div(id="CRP_explanation",HTML("The Chinese Restaurant Process (CRP) is one possible representation of the Dirichlet Process.
             The metaphor works as follows: 
            <ol>
            <li> We have a Chinese restaurant with infinitely many tables. At the start of the day, the restaurant is empty. </li>
            <li> When the first guest enters the restaurant, he sits at a new table and orders a dish. </li>
            <li>Each new guest who enters afterwards will start either a
             new table with probability  \\(\\frac{a}{a+n_k} \\) or decide to sit at the already occupied table \\( k \\) with probability 
             \\( \\frac{n}{a+n_k} \\)</li>
            </ol>
            As we can see, new customers have a higher probability to sit at tables with lots of guests.
                                             This often called \"the rich get richer\" property of the CRP is the reason
                                             why the CRP is a useful building block in clustering: Even though there are in principle
                                             infinitely many tables, only a finite, quite small subset will be occupied in practice."))), 
      tabPanel("Summary", verbatimTextOutput("summary")), 
      tabPanel("Number of Tables", div(id="Growth_explanation",HTML("How does the number of tables grow with the number of customers? The answer is logarithmically. We have that 
                                                                    \\( \\mathbb{E}(K) = O \\left(\\alpha \\log(n) \\right) \\)")),plotOutput("convPlot"))
    )
  )
))
