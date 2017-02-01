library(shiny)

if (!require(RMySQL)) install.packages("RMySQL")
if (!require(dplyr)) install.packages("dplyr")
if (!require(ggplot2)) install.packages("ggplot2")

source("baseball_stats.R")

shinyServer(function(input, output, session) {
  
  baseball_query <- reactive({
    con <- dbConnect(MySQL(), user = "<db_username_you_create>", password = "<yourpassword>",
                     dbname = "stats", host = "127.0.0.1")
    on.exit(dbDisconnect(conn = con), add = TRUE)
    
    # since the inputs are the same as the suffix of the database view instead
    # of using if statements, just use a single string, parse and execute the 
    # sql command
    func <- paste("queryLahman", input$position,
                  "(input$fname, input$lname, con)", sep = "")
    baseballData <- eval(parse(text = func))
  })
  
  # reactive input based on the type of position which will determine what kind
  # of baseball statistic to use
  baseball.stat <- reactive({
    switch(input$position,
           "Batting" = input$bdata,
           "Pitching" = input$pdata,
           "Fielding" = input$fdata)
  })
  
  # output of the data table based on the First name and last name that was
  # inputted
  output$mlb_player_data <- renderTable({
    # get the data minus the playerID field
    select(baseball_query(), -playerID)
  })
  
  # output of the visual plot; the plot graphs the year vs <baseball statistic>
  # given the first name and last name
  # players with the same first name and last name are facetted by birth name
  # are graphed seperately
  output$plot <- renderPlot({
    tmp <- baseball_query()[, baseball.stat()] # placeholder of the baseball
    # statistc baseball result
    ggplot(data = baseball_query(), aes(year,as.numeric(tmp), fill = BirthName)) +
      ggtitle(paste("year vs", baseball.stat())) +
      theme(plot.title = element_text(size = 30)) +
      theme(axis.title.x = element_blank()) +
      ylab(baseball.stat()) +
      theme(axis.title = element_text(size = 20)) +
      geom_bar(stat = "identity") +
      facet_grid(BirthName ~.) +
      theme(strip.text = element_text(size = 15))
  })
})
