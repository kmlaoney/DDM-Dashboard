library(shiny)

# Use package xlsx to open xlsx files and ", 1" to make first row variables
library(xlsx)

# Use whatever directory to locate the Immigrat Eligibility Data excel file
Immigrant <- read.xlsx("/Users/maloney/Downloads/Immigrant.xlsx", 1)

# Defining errors for dataframe
errorI551CU <- c(Immigrant$Documentation == "I-551 CU6", Immigrant$Documentation == "I-551 CU7")

errorI551F <- 
  c(Immigrant$Documentation=="I-551 F11",
    Immigrant$Documentation=="I-551 F16", 
    Immigrant$Documentation=="I-551 F21", 
    Immigrant$Documentation=="I-551 F22",
    Immigrant$Documentation=="I-551 F26",
    Immigrant$Documentation=="I-551 F27",
    Immigrant$Documentation=="I-551 F28",
    Immigrant$Documentation=="I-551 F29",
    Immigrant$Documentation=="I-551 F43",
    Immigrant$Documentation=="I-551 F44")

errorI688B <- 
  c(Immigrant$Documentation=="I-688B 12a4",
    Immigrant$Documentation=="I-688B 12a5")

errorI766a10 <- 
  c(Immigrant$Documentation == "I-766 a10")

errorI94 <-
  c(Immigrant$Documentation == "I-94 212d5",
    Immigrant$Documentation == "I-94 K3 and I-130")

error194Ioos <- 
  c(Immigrant$Documentation == "I-94 order of supervision")

errorprimafacie <- 
  c( Immigrant$Documentation == "prima facie")

# Making a table of data for Number of errors per document per center
doc <- table (Immigrant$Documentation, Immigrant$Center)

# Converting this previous table into a data frame
doc.frame <- as.data.frame (doc)

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  output$ErrorPlot <- renderPlot({
    
   dat <- doc.frame[doc.frame$Var2 == input$center, ]
    
    # Render a barplot
    plot(dat$Freq, dat$Var1, 
            ylab="Number of Errors",
            xlab="Documents")
  })
})

