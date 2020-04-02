library(shiny)

ui <- fluidPage(
  h1("Example app"),
  sidebarLayout(
    sidebarPanel(
      numericInput("nrows", "Number of rows", 10)
    ),
    mainPanel(
      plotOutput("plot"),
      tableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  # Assignment: Factor out the head(cars, input$nrows) so
  # that the code isn't duplicated and the operation isn't
  # performed twice for each change to input$nrows.
  
  output$plot <- renderPlot({
    plot(head(cars, input$nrows))
  })
  
  output$table <- renderTable({
    head(cars, input$nrows)
  })
  
  # solution
  data <- reactive({ # reactive expression
    head(cars, input$nrows)
    })
  
   output$plot <- renderPlot({
    plot(data()) # notice the ()
  })
  
  output$table <- renderTable({
    data()
  })
  
  # anti-solution 1: better for larger app with longer codes
  values <- reactiveValues(df = cars) # make a value object using reactiveValues
  observe({ # still run several times
    values$df <- head(cars, input$nrows) # can't do df <- head(cars, input$nrows) directly. 
    }) # Shiny doesn't deal with regular variable. It only deal with reactive variables
  
  output$plot <- renderPlot({
    plot(values$df)
    })
  
  output$table <- renderTable({
    values$df
    })
}

shinyApp(ui, server)
