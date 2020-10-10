ui <- dashboardPage(
  dashboardHeader(title = "Customer Segmentation",titleWidth = 250),
  dashboardSidebar(
    width = 250,
    sidebarMenu(
    menuItem("Data View", tabName = "DataSource", icon = icon("file")),
    menuItem("Univariate Analysis",  tabName = "Univariate", icon = icon("bar-chart")),
    menuItem("K-means Clustering", tabName = "Kmeans", icon = icon("dot-circle-o")),
    menuItem("PCA", tabName = "pca", icon = icon("sliders")),
    menuItem("Results",tabName = "result", icon = icon("info-circle"))
   
    )
  ),
  dashboardBody(
    
    
    tabItems(
    
      tabItem(tabName = "DataSource",
              # fluidRow(
              #   DT::dataTableOutput("AD")
              # )
              tabBox( title = "Data View",width = 10,
                tabPanel("Data Preview",DT::dataTableOutput("AD")),
                tabPanel("Data Structure", verbatimTextOutput("strData")),
                tabPanel("Summary", verbatimTextOutput("sumry")),
                tabPanel("Descriptive Statistics", verbatimTextOutput("ds"))
                
              )
  ),
  tabItem(tabName = "Univariate",
          fluidRow(
            box(
               withSpinner(plotlyOutput(
                  "Univariate", height = 450, width = 850
               )), width = 10
            ),
            box(
              
              width = 2,
              selectInput("variable","Variable:", choices = NULL)
            )
          )
          
          ),
  tabItem(tabName = "Kmeans",
          fluidRow(
            tabBox( title = "Optimal Cluster Number",width = 15,
            tabPanel("Elbow Method", plotOutput("EM")),
            tabPanel("Silhouette Analysis", 
                     box(
                       
                       sliderInput("n", "Number of Clusters", value=2, min=2, max=10)),
                     fluidRow(
                       uiOutput("plots")
                     )
                     
                     ),
            tabPanel("Optimal Cluster",plotOutput("OC"),h3("Gap Statistic Method"),plotOutput("GS"),verbatimTextOutput("CL"))
            )
            )
          ),
  tabItem(tabName = "pca",h3("Clustering Results using the First Two Principle Components"), box(verbatimTextOutput("pc"))
          ),
  tabItem(tabName = "result",  
          fluidRow(
            box(plotOutput("RS"),width=10),
            box(
              h6("Cluster 6 and 4 - These clusters represent the customer_data with the medium income salary as well as the medium annual spend of salary"),
              
              h6("Cluster 1 - This cluster represents the customer_data having a high annual income as well as a high annual spend"),
              
              h6("Cluster 3 - This cluster denotes the customer_data with low annual income as well as low yearly spend of income."),
              
              h6("Cluster 2 - This cluster denotes a high annual income and low yearly spend."),
              
              h6("Cluster 5 - This cluster represents a low annual income but its high yearly expenditure."),
              width =10
            )
            ),
         
          )
         
)
  
  )  
)