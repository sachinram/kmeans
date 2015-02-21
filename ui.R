library("shinydashboard")
library("shiny")

dashboardPage(
  dashboardHeader(title = "k-means"),
  
  dashboardSidebar(
    fileInput('file1', 'Choose CSV File', accept=c('text/csv', 
                                                   'text/comma-separated-values,text/plain', 
                                                   '.csv')),
    
    numericInput("obs", "Number of observations to view:", 10),
    helpText("Note: while the data view will show only the specified",
             "number of observations, the summary will still be based",
             "on the full dataset."),
    tags$hr(),
    checkboxInput('header', 'Header', TRUE),
    radioButtons('sep', 'Separator',
                 c(Comma=',', Semicolon=';', Tab='\t'), ','),
    
    radioButtons('quote', 'Quote',
                 c(None='', 'Double Quote'='"', 'Single Quote'="'"), '"'),
    
    tags$hr(),
    uiOutput("xcol"),
    uiOutput("ycol"),
    uiOutput("clusters"),
    uiOutput("ui.action"),
    uiOutput("algorithms")
  ),
  
  dashboardBody(fluidRow(h4("Observations"), 
                         tableOutput("view"),
                         h4("Summary"), 
                         verbatimTextOutput("summary")),
                plotOutput("plot1")
                
  )
)
