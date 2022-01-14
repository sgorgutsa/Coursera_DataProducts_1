#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    values <- reactiveValues()
    # Calculating the bmi    
    observe({
        input$action_Calc
        if(input$metric_imperial==1)
        {
            values$bmi <- isolate({
                input$metric_weight / ((input$metric_height/100) *(input$metric_height/100))
            })
        }
        else
        {
            values$bmi <- isolate({
                input$weight_lbs / ((input$height_feet*12+input$height_inch)^2)*703
            })
        }

        
        output$text_bmi <- renderText({
            if(input$action_Calc == 0) ""
            else 
                paste("Your BMI is:", values$bmi)
        })
})

    output$distPlot <- renderPlot({
        
        
        barplot(values$bmi, breaks = 5, col = "#75AADB", border = "white",
             xlab = "BMI classification according to WHO")
        
    })
    
})