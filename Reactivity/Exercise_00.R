library(shiny)

ui <- fluidPage(
  h1("Example app"),
  sidebarLayout(
    sidebarPanel(
      numericInput("nrows", "Number of rows", 10)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  # Assignment: Plot the first input$nrows columns of a
  # data frame of your choosing, using head() and plot()
  output$plot <- renderPlot({ # renderPlot tells shiny the way to update output$plot, rather than what/when to do
    plot(head(cars, inputs$nrows)) # shiny will decide when/what to do
    })
  # option2: anti-solution
  observe({ # observer will respond to every reactive value in the code
    df <- head(cars, input$nrows) # will plot even when there was no nrows input
    output$plot <- renderPlot(plot(df)) 
    })
}

shinyApp(ui, server)
