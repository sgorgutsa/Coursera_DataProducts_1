#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Application UI
shinyUI(fluidPage(

    # Application title
    titlePanel("BMI Calculator"),

    # Sidebar with choice of imperial / metric system, weigh & height inputs
    sidebarPanel(
        helpText("Enter your weight and height to find your BMI"),  
        selectInput("metric_imperial", label = h6("Select the measurement"), choices = list("Metric" = 1, "Imperial" = 2), selected = 1),
        conditionalPanel(
            condition ="input.metric_imperial == 1",
            numericInput("metric_weight", label = h6("Weight: [kg]"),min = 1, value = NULL),
            numericInput("metric_height", label = h6("Height: [cm]"),min = 1, value = NULL),
        ),
        conditionalPanel(
            condition ="input.metric_imperial  == 2",
            numericInput("weight_lbs", label = h6("Weight: [lbs]"),min = 1, value = NULL),
            fluidRow(
                column(6,
                       numericInput("height_feet", label = h6("Height: [feet]"),min = 1, value = NULL),
                ),
                column(6,
                       numericInput("height_inch", label = h6("[inches]"),min = 1, value = NULL),
                )
            )
            
        
        ),
     
        actionButton("action_Calc", label = "Submit!")        
    ),

        # Show BMI table
        mainPanel(
            p(h5("")), textOutput("text_weight"),
            #textOutput("text_height"),  p(h5("Body Mass Index(BMI):")),
            textOutput("text_bmi"),
            textOutput("healthy_weight"),
            plotOutput(outputId = "distPlot"),
        )
    )
)
