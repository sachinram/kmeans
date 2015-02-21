#loading the required packages
library("shiny")
library("shinydashboard")

shinyServer(function(input, output){
  datasetInput <- reactive({
    inFile <- input$file1
    
    if(is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header, sep = input$sep,
             quote = input$quote)
  })

  output$summary <- renderPrint({
    dataset <- datasetInput()
    my.summary(dataset)
  })
  
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
  output$xcol <- renderUI({
    df <- datasetInput()
    if (is.null(df)) 
      return(NULL)
    items <- numericNames(df)
    names(items) <- items
    selectInput("xcol", "Select x variable from:", items)
  })
  
  output$ycol <- renderUI({
    df <- datasetInput()
    if (is.null(df)) 
      return(NULL)
    items <- numericNames(df)
    names(items) <- items
    selectInput("ycol", "Select y variables from:", items, multiple = T)
  })
  
  output$clusters <- renderUI({
    df <- datasetInput()
    if (is.null(df))
      return(NULL)
    numericInput(inputId = "clusters", label = "Number of Clusters:", value = 2, max = 20)
  })
  
  output$algorithms <- renderUI({
    df <- datasetInput()
    if (is.null(df))
      return(NULL)
    selectInput(inputId = "algorithms", label = "Select Algorithm:", 
                choices = list("Hartigan-Wong" = 1, "Lloyd" = 2, "Forgy" = 3, "MacQueen" = 4), 
                selected = 1)
    
  })
  
  selectedData <- reactive({
    df <- datasetInput()
    if (is.null(df)) 
      return(NULL)
    df[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    df <- datasetInput()
    if (is.null(df)) 
      return(NULL)
    kmeans(selectedData(), input$clusters, input$algorithms)
  })
  
  output$plot1 <- renderPlot({
    if (is.null(input$file1)) 
      return()
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 2)
  })
})
