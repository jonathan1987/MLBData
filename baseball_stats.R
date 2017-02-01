dqueryLahmanBatting <- function(firstName, lastName, con) {
  query <- paste("select * from BaseballBattingQuery where FirstName = \'",
                 firstName, "\' and LastName = \'", lastName, "\';", sep = "")
  
  baseball_batting_data <- dbGetQuery(con, query)
  baseball_batting_data
}

queryLahmanPitching <- function(firstName, lastName, con) {
  query <- paste("select * from BaseballPitchingQuery where FirstName = \'",
                 firstName, "\' and LastName = \'", lastName, "\';", sep = "")
  
  baseball_pitching_data <- dbGetQuery(con, query)
  baseball_pitching_data
}

queryLahmanFielding <- function(firstName, lastName, con) {
  query <- paste("select * from BaseballFieldingQuery where FirstName = \'",
                 firstName, "\' and LastName = \'", lastName, "\';", sep = "")
  
  baseball_fielding_data <- dbGetQuery(con, query)
  baseball_fielding_data
}
