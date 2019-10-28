



shinyServer(function(input, output, session){
    
    observe({
        dest <- unique(taxi %>%
                           filter(taxi$pickup_community_area == input$origin) %>%
                           .$dest)
        updateSelectizeInput(
            session, "dest",
            choices = dest,
            selected = dest[1])
    })
    
    taxi_reactive <- reactive({
        taxi %>%
            filter(pickup_community_area == input$origin & dropoff_community_area == input$dest) %>%
            group_by(company) %>%
            summarise(n = n(),
                      meanfare = mean(fare), 
                      meantips = mean(tips)
                      ) 
    })
    
    output$fare_tip<- renderPlot(
        taxi_reactive() %>%
            gather(key = type, value = amount, meanfare, meantips) %>%
            ggplot(aes(x = company, y = amount, fill = type)) +
            geom_col(position = "dodge") +
            ggtitle("Average Fare and Tip Amount") +
            labs(x= "Taxi Company", y="Amount in Dollars") +
            theme(text=element_text(size=20),axis.text.x = element_text(angle = 90, hjust = 1))
    )
    
    output$count <- renderPlot(
        taxi_reactive() %>%
            ggplot(aes(x = company, y = n)) +
            geom_col(fill = "lightblue") +
            ggtitle("Number of Trips")+
            labs(x= "Taxi Company", y="Number of Trips")+
            theme(text=element_text(size=20),axis.text.x = element_text(angle = 90, hjust = 1))
    )
  
    
    # show data using DataTable
    output$table <- DT::renderDataTable({
        datatable(taxi, rownames=FALSE)
           
    })
    
    # show statistics using infoBox
    output$timeBox <- renderInfoBox({
        means=taxi %>%
            filter(pickup_community_area == input$origin & dropoff_community_area == input$dest) %>%
            summarise(
                meanduration = mean(trip_seconds), 
                meandistance = mean(trip_miles)
            ) 
        infoBox("Mean Travel Time (Minutes)", round(means[1]/60,digits=2), icon = icon("hand-o-up"))
    })
    output$distBox <- renderInfoBox({
        means=taxi %>%
            filter(pickup_community_area == input$origin & dropoff_community_area == input$dest) %>%
            summarise(
                meanduration = mean(trip_seconds), 
                meandistance = mean(trip_miles)
            ) 
        infoBox("Mean Travel Distance (Miles)", round(means[2],digits=3), icon = icon("hand-o-up"))
    })
    
    
    
    
   
})


    