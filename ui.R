


shinyUI(dashboardPage(
    dashboardHeader(title = "Sept. 2019 Taxi Trips in Chicago",titleWidth =450),
    dashboardSidebar(
        
        sidebarUserPanel("Sathya Muthukkumar",
                         image = "http://squirrelstaxi.com/wp-content/uploads/2018/09/taxi2.png"),
        sidebarMenu(
            menuItem("Map", tabName = "map", icon = icon("map")),
            menuItem("Data", tabName = "data", icon = icon("database"))
        ),
        selectizeInput(inputId = "origin",
                       label = "Community Area Start",
                       choices = sort(unique(taxi$pickup_community_area))),
        selectizeInput(inputId = "dest",
                       label = "Community Area End",
                       choices = sort(unique(taxi$dropoff_community_area)))
    ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = "map",
                    fluidRow(infoBoxOutput("timeBox"),
                             infoBoxOutput("distBox")),
                   
                    fluidRow(column(4, plotOutput("count", height = '800px')),  
                             column(4, plotOutput("fare_tip", height = '800px')),
                             column(4,img(src="https://upload.wikimedia.org/wikipedia/commons/2/24/Map_of_the_Community_Areas_and_%27Sides%27_of_the_City_of_Chicago.svg", 
                                          width="100%")))),
            tabItem(tabName = "data",
                    fluidRow(box(DT::dataTableOutput("table"), width = 12)))
        )
    )
)
)
