
library(shiny)
library(dplyr)
library(psych)
library(plotrix)
library(plotly)
library(DT)
library(shinydashboard)
library(shinyjs)
library(evaluate)
library(shinycssloaders)
library(evaluate)
library(ggplot2)
library(purrr)
library(cluster) 
library(gridExtra)
library(grid)
library(NbClust)
library(factoextra)


getfile <- reactive({
  inFile <- read.csv("Mall_Customers.csv")
})
  
#Data View
server <- function(input, output,session) {
  
  
  observe({
    #browser()
     updateSelectInput(session, "variable", choices = colnames(getfile()))
    
  })
   output$AD<-DT::renderDataTable({
      getfile()
    },options = list(lengthMenu = c(5, 30, 50), pageLength = 5, scrollX = TRUE, scrollY = '200px', autoWidth = TRUE))
   output$strData<-renderPrint({
     str(getfile())
   })
   output$sumry<-renderPrint({
     summary(getfile())
   })
   output$ds<-renderPrint({
     data = getfile()
     df = select_if(data,is.numeric)
     describe(df)
   })
   iss <- function(k) {
     customer_data = getfile()
     kmeans(customer_data[,3:5],k,iter.max=100,nstart=100,algorithm="Lloyd" )$tot.withinss
   }
   output$EM<-renderPlot({
     set.seed(123)
     k.values <- 1:10
     iss_values <- map_dbl(k.values, iss)
     # k =c(k.values)
     # iss = c(iss_values)
     # data = data.frame(k,iss)
    
     plot(k.values, iss_values,
          type="b", pch = 19, frame = TRUE, col="red",
          xlab="Number of clusters K",
          ylab="Total intra-clusters sum of squares")
    

   })
   max_plots<-10
   get_plot_output_list <- function(max_plots, input_n) {
     
    
     # Insert plot output objects the list
     plot_output_list <- lapply(2:input_n, function(i) {
       plotname <- paste("plot", i, sep="")
       plot_output_object <- plotOutput(plotname, height = 280, width = 250)
       
       k2<-kmeans(getfile()[,3:5],i,iter.max=100,nstart=50,algorithm="Lloyd")
       plot_output_object <- renderPlot({
         plot(silhouette(k2$cluster,dist(getfile()[,3:5],"euclidean")),
            
              col = "red"   
         )
        
       })
     })
     
     do.call(tagList, plot_output_list) # needed to display properly.
     
     return(plot_output_list)
   }
   
   observe({
     output$plots <- renderUI({ get_plot_output_list(max_plots, input$n) })
   })
   
   output$OC<-renderPlot({

     fviz_nbclust(getfile()[,3:5], kmeans, method = "silhouette")
   })
   output$GS<-renderPlot({
     set.seed(125)
     stat_gap <- clusGap(getfile()[,3:5], FUN = kmeans, nstart = 25,
                         K.max = 10, B = 50)
     fviz_gap_stat(stat_gap)
   })
   output$CL<-renderPrint({
     k6<-kmeans(getfile()[,3:5],6,iter.max=100,nstart=50,algorithm="Lloyd")
     k6
   })
   output$pc<-renderPrint({
     pcclust=prcomp(customer_data[,3:5],scale=FALSE) #principal component analysis
     print(summary(pcclust))
     pcclust$rotation[,1:2]
   })
   
   output$RS<-renderPlot({
     set.seed(1)
     k6<-kmeans(customer_data[,3:5],6,iter.max=100,nstart=50,algorithm="Lloyd")
     ggplot(getfile(), aes(x =Annual.Income..k.., y = Spending.Score..1.100.)) + 
       geom_point(stat = "identity", aes(color = as.factor(k6$cluster) ),size =5) +
       scale_color_discrete(name=" ",
                            breaks=c("1", "2", "3", "4", "5","6"),
                            labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5","Cluster 6")) +
       ggtitle("Segments of Mall Customers", subtitle = "Using K-means Clustering") + theme(axis.text=element_text(size=12), 
            axis.title=element_text(size=14,face="bold"),
            legend.title = element_text(color = "blue", size = 14),
            legend.text = element_text(color = "red", size = 10))
                                                                           
   })
 
   output$Univariate = renderPlotly({
      dt = getfile()
      attach(dt)
      ch = input$variable
      plotly::subplot(
         # Histogram
          dt%>% plot_ly(alpha = 1) %>% add_histogram(x = ~ get(ch)) %>%
            layout(bargap = 0.1, xaxis = list(title = paste0(input$variable)), yaxis = list(title = "No of records")),
         # Box Plot
         dt %>% plot_ly(alpha = 1) %>% add_boxplot(y = ~ get(ch), x = "") %>%
            layout(yaxis = list(title = paste0(input$variable))),
         nrows = 1, titleY = TRUE, margin = 0.05) %>% 
         layout(title = paste0("Distribution of ", input$variable),showlegend = FALSE)
   
   })

 
     
  
 
}
shinyApp(ui = ui, server = server)

