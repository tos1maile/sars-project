function(input, output, session) {
  
  lats <- -90:90
  lons <- -180:180
  
  output$timeMap <- renderLeaflet({
    tidySARSdata %>% 
      filter(firstOnset <= input$dateSlider) %>% 
      leaflet() %>% 
      setView(lng = 10, lat = 20, zoom = 1.5) %>% 
      addTiles() %>% 
      addMarkers(~longitude, ~latitude)
  })
  
  output$sexPlot <- renderPlot({
    sextidySARSdata %>%
      filter(areas == input$region) %>%
      arrange(Incidence) %>%
      ggplot(aes(Sex,Incidence, fill = Sex)) + 
      geom_histogram(stat= "identity")+
      theme(axis.text.x = element_text(angle = 0, hjust = 1))
  })
  
  output$HDIplot <- renderPlot({
    tidySARSdata %>% 
      filter(continent == input$continentBox) %>% 
      ggplot(aes(x = total, y = deaths)) + geom_jitter(aes(colour = HDIquart))
  })
  
  output$continentPlot <- renderPlot({
    tidySARSdata %>% 
      ggplot(aes(x = total, y = deaths)) + geom_jitter(aes(colour = continent))
  })
  
  output$casesAndDeathsDF <- renderDataTable({
    tidySARSdata %>% 
      filter(continent == input$continentBox) %>% 
      select(areas, total, deaths, HDI)
  })
  
}
