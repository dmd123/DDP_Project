<<<<<<< HEAD
shinyUI(
        fluidPage(
                includeHTML("documentation.html"),
                sidebarPanel(
                        h4(strong("Filter by Node")),
                        uiOutput("nameUI"),
                        uiOutput("typeUI")
                        ),
                mainPanel(
                        fluidRow(DT::dataTableOutput("table"))
                )
=======
library(shiny)
library(ggplot2)
library(rvest)
library(DT)
# Define the UI with this code
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

shinyUI(
        fluidPage(
                includeHTML("documentation.html"),
                fluidRow(
                        column(4, selectInput(inputId="Name", label = "Name:", choices = c("All", unique(as.character(LMP$Name))))),
                        column(4, selectInput(inputId="Type", label = "Type:", choices = c("All", unique(as.character(LMP$Type)))))
                ),
                fluidRow(DT::dataTableOutput("table"))
>>>>>>> 5259d71b00263863cf0d8b540346a88335fdc389
        )
)