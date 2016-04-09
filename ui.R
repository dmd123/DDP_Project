library(shiny)
library(ggplot2)  # for the diamonds dataset
library(rvest)
library(DT)
library(xml2)
# Define the UI with this code
shinyUI(
        fluidPage(
                includeHTML("documentation.html"),
                fluidRow(
                        column(4, selectInput(inputId="Name", label = "Name:", choices = c("All", unique(as.character(LMP$Name))))),
                        column(4, selectInput(inputId="Type", label = "Type:", choices = c("All", unique(as.character(LMP$Type)))))
                ),
                fluidRow(DT::dataTableOutput("table"))
        )
)