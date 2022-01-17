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
            values$hw_min <- isolate({
                18.5* ((input$metric_height/100) *(input$metric_height/100))
            })
            values$hw_max <- isolate({
                24.9 * ((input$metric_height/100) *(input$metric_height/100))
            })
            output$healthy_weight <- renderText({
                if(input$action_Calc == 0) ""
                else 
                    paste("According to WHO healthy weight for your height is between ", round(values$hw_min), "and", round(values$hw_max), "kg.")
            })
        }
        else
        {
            values$bmi <- isolate({
                input$weight_lbs / ((input$height_feet*12+input$height_inch)^2)*703
            })
            values$hw_min <- isolate({
                18.5* ((input$height_feet*12+input$height_inch)^2)/703
            })
            values$hw_max <- isolate({
                24.9 * ((input$height_feet*12+input$height_inch)^2)/703
            })
            output$healthy_weight <- renderText({
                if(input$action_Calc == 0) ""
                else 
                    paste("According to WHO healthy weight for your height is between ", round(values$hw_min), "and", round(values$hw_max), "pounds.")
            })
        }

        
        output$text_bmi <- renderText({
            if(input$action_Calc == 0) ""
            else 
            paste("Your BMI is:", round(values$bmi,2))
            
        })
      
})

    output$distPlot <- renderPlot({
        
        #highlight bar depending on BMI value
        bmi_color <- c('ghostwhite','ghostwhite','ghostwhite','ghostwhite')
        # find to BMI category for current BMI value
        bar_index <- findInterval(values$bmi,c(18.5,24.9,29.9))
        bmi_color[bar_index+1] <- 'lightblue1'
        bmi_plot <- c(1,1,1,1)
        
        barplot(bmi_plot,
                names.arg = c("Underweight\n<18.5", "Healthy\n18.5-24.9", "Overweight\n25.0-30.0", "Obese\n>30.0"),
                yaxt="n",
                col = bmi_color )
        
    })
    

})