shinyUI(pageWithSidebar(
  headerPanel('Motor Trend Car Road Tests data and k-means clustering'),
  sidebarPanel(
    h3('Control panel'),
    br(),
    selectInput('xcol', 'X variable', names(mtcars)),
    selectInput('ycol', 'Y variable', names(mtcars),
                selected=names(mtcars)[[2]]),
    numericInput('clusters', 'Number of clusters', 3,
                 min = 1, max = 9),
    br(),
    p('Switch to the ',strong('\"Plots\"'),
      ' tab in the right to use this controls for generating clusters.')
  ),
  mainPanel(
    h3('Application details'),
    p('The following data was extracted from the 1974 Motor Trend US magazine,
      and comprises fuel consumption and 10 aspects of automobile design
      and performance for 32 automobiles.'),
    p('You can explore the dataset in the ', strong('Data'), ' tab
      or evaluate graphics in the ', strong('Plots'), ' tab. Please visit the GitHub repo ',
      a(href = 'https://lattes.shinyapps.io/shiny-app/', 'here'), ' to see the source code.',
      style = "padding: 15px; border: 1px solid #000000; background-color: gainsboro; margin: 15px 0;"),
    tabsetPanel(
      tabPanel('Data',
               dataTableOutput('mtcarsTable')),
      tabPanel('Plots',
               h2('Cluster classification using k-means'),
               br(),
               plotOutput('plot1'),
               h2('Selected variables'),
               plotOutput('plot2'),
               plotOutput('plot3'))
    )
  )
))
