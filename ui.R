library(shiny)

# batting statistic
batdata <- c("G", "AB",	"R", "H", "2B", "3B",	"HR",	"RBI", "SB", "CS", "BB", "SO",
             "IBB", "HBP", "SH", "SF", "GIDP")

# pitching statistic
pitchdata <- c("W", "L", "G", "GS", "CG", "SHO", "SV", "IPouts",	"H", "ER",
               "HR", "BB", "SO", "BAOpp", "ERA", "IBB",	"WP",	"HBP", "BK", "BFP",	
               "GF", "R", "SH",	"SF",	"GIDP")

# fielding statistic
fielddata <- c("G", "GS",	"InnOuts", "PO", "A", "E", "DP", "PB",	"WP", "SB", 
               "CS", "ZR")

shinyUI(fluidPage(
  titlePanel("MLB Data Statistics"),
  h4("Created by Jonathan Hernandez"),
  h4("Email: jayhernandez1987@gmail.com"),
  h4("This Application uses R and the R shiny package and MySQL on the backend
     to display MLB data as visual bar graphs and as a data table."),
  h4("Data comes from the Sean Lahman Database",
     a("(click here).",
       href = "http://www.seanlahman.com/baseball-archive/statistics/",
       target = "_blank")),
  h4("Data description can be",
     a("found here.",
       href = "http://seanlahman.com/files/database/readme2014.txt",
       target = "_blank")),
  h4("You input in the first and last name of the baseball player you want to
     lookup and the type of position and depending on the position, get a drop down
     selection to see what baseball statistic to graph"),
  h4("Github Repository where source code is found:",
     a("github link", href = "https://github.com/jonathan1987",
       target = "_blank")),
  # to be displayed on the left hand side
  # (introduction, radio buttons, text input, and batting data)
  sidebarPanel(
    radioButtons("position", "Position Type",
                 c("Batting", "Pitching", "Fielding")),
    # first name and last name inputs
    textInput("fname", "First Name", "Derek"),
    textInput("lname", "Last Name", "Jeter"),
    # conditional menu based on the input of the position type
    conditionalPanel(condition = "input.position == 'Batting'",
                     selectInput("bdata", "Batting Data (to Plot)", batdata, selected = 'HR')),
    conditionalPanel(condition = "input.position == 'Pitching'",
                     selectInput("pdata", "Batting Data (to Plot)", pitchdata, selected = 'SO')),
    conditionalPanel(condition = "input.position == 'Fielding'",
                     selectInput("fdata", "Batting Data (to Plot)", fielddata, selected = 'InnOuts'))
    ),
  
  # main panel (gets displayed on the right hand side, the plot)
  mainPanel({
    plotOutput("plot")
  }),
  
  # data table output
  tableOutput("mlb_player_data")
))