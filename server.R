#palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
#          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output, session) {
  selectedData <- reactive({
    mtcars[, c(input$xcol, input$ycol)]
  })

  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })

  xVariable <- reactive({
    input$xcol
  })

  yVariable <- reactive({
    input$ycol
  })

  nClusters <- reactive({
    input$clusters
  })

  mtcars$legend <- row.names(mtcars)

  output$mtcarsTable = renderDataTable({
    mtcars
  }, options = list(orderClasses = TRUE))

  output$plot1 <- renderPlot({
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 2)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    title(main = paste(xVariable(), " vs. ", yVariable(), " with ", nClusters(), "clusters"))
  })

  output$plot2 <- renderPlot({
    x <- mtcars[order(mtcars[, xVariable()]),]
    x$cyl2 <- factor(x$cyl)
    x$color[x$cyl2 == 4] <- "firebrick"
    x$color[x$cyl2 == 6] <- "darkorchid"
    x$color[x$cyl2 == 8] <- "gold"
    dotchart(x[, xVariable()], labels = row.names(x), cex = .7, groups = x$cyl2,
             main=paste(xVariable(), " values of car models\n(Grouped by Number of cylinders)"),
             xlab=xVariable(), gcolor = "black", color = x$color)
  })

  output$plot3 <- renderPlot({
    x <- mtcars[order(mtcars[, yVariable()]),]
    x$cyl2 <- factor(x$cyl)
    x$color[x$cyl2 == 4] <- "firebrick"
    x$color[x$cyl2 == 6] <- "darkorchid"
    x$color[x$cyl2 == 8] <- "gold"
    dotchart(x[, yVariable()], labels = row.names(x), cex = .7, groups = x$cyl2,
             main = paste(yVariable(), " values of car models\n(Grouped by Number of cylinders)"),
             xlab = yVariable(), gcolor = "black", color = x$color)
  })
})
