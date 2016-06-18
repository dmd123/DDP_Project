library(shiny)
<<<<<<< HEAD
library(rvest)
library(XML)
##
## Scrape website, load into data.frame, clean-up
## Used readHTMLTable function from XML package, could not get
## read_html function from rvest package to work here in this chunk of code
##
url <- "http://www.pjm.com/pub/account/lmpgen/lmppost.html"
LMP <- readHTMLTable(url, header = FALSE)[2]
LMP <- as.data.frame(LMP)
LMP[] <- lapply(LMP,as.character)
names(LMP)<-c(LMP[1,])
LMP <- LMP[-c(1),]
row.names(LMP) <- 1:nrow(LMP)
##
## Switched to read_html function from rvest package to scrape time
## Did additional clean-up, calculate difference between 5min interval and hourly prices
##
updatetime <- url %>% read_html() %>% html_nodes(xpath='/html/body/center[2]') %>% html_text()
LMP <- LMP[c(1,2,4,3)]
colnames(LMP)[3] <- paste("Hour ",substr(updatetime,18,19),sep="")
colnames(LMP)[4] <- paste("5min Interval ",substr(updatetime,18,19),":",substr(updatetime,21,22),sep="")
LMP[,3]<-as.numeric(LMP[,3])
LMP[,4]<-as.numeric(LMP[,4])
LMP$DIFF <- LMP[,4]-LMP[,3]
colnames(LMP)[5] <- paste("Difference")
##
## Produced output for ui.R
##
shinyServer(function(input, output) {
        data <- LMP
        output$typeUI <- renderUI({selectInput(inputId = 'Type', label = 'Node Type', choices=c("All", unique(data$Type)))})
        output$nameUI <- renderUI({selectInput(inputId = 'Name', label = 'Node Name', choices=c("All", unique(data$Name)))})
        output$table <- DT::renderDataTable(DT::datatable({
                if (!is.null(input$Name) & !is.null(input$Type)) {
                        if (input$Name != "All") {data <- data[data$Name == input$Name,]}
                        if (input$Type != "All") {data <- data[data$Type == input$Type,]}}
=======
library(ggplot2)
library(rvest)
library(DT)
# code here
url <- "http://www.pjm.com/pub/account/lmpgen/lmppost.html"
LMP <- html_table(url %>% read_html() %>% html_nodes(xpath='/html/body/center[4]/table'))
LMP <- as.data.frame(LMP)
names(LMP)<-c(LMP[1,])
LMP <- LMP[-c(1),]
row.names(LMP) <- 1:nrow(LMP)
updatetime <- url %>% read_html() %>% html_nodes(xpath='/html/body/center[2]') %>% html_text()
LMP <- LMP[c(1,2,4,3)]
colnames(LMP)[3] <- paste("HE",substr(updatetime,18,19),sep="","_AVE")
colnames(LMP)[4] <- paste(substr(updatetime,18,19),":",substr(updatetime,21,22),sep="")
LMP[,3]<-as.numeric(LMP[,3])
LMP[,4]<-as.numeric(LMP[,4])
LMP$DIFF<-LMP[,4]-LMP[,3]

shinyServer(function(input, output) {
        output$table <- DT::renderDataTable(DT::datatable({
                data <- LMP
                if (input$Name != "All") {data <- data[data$Name == input$Name,]}
                if (input$Type != "All") {data <- data[data$Type == input$Type,]}
>>>>>>> 5259d71b00263863cf0d8b540346a88335fdc389
                data
        }))
})