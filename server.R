library(shiny)
library(ggplot2)
library(rvest)
library(DT)
library(xml2)
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
                data
        }))
})