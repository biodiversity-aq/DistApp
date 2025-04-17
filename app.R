# app.R
library(shiny)
library(ggplot2)
library(SOmap)
library(sf)
library(DT)

# --- Configuration ---
config <- list(
  data_dir = "processed_data",
  map_config = list(
    base_size = 16,
    font_family = "Roboto"
  )
)

# --- UI Definition ---
ui <- fluidPage(
  titlePanel("DistApp - Circum-Antarctic Modelled Data Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      width = 3,
      selectInput(
        "map_type",
        "Select Map Type",
        choices = c(
          "Fabri-Ruiz Bioregions" = "fabri_ruiz",
          "Hindell Habitat Importance" = "hindell",
          "Pinkerton Primary Productivity" = "pinkerton",
          "Freer Habitat Suitability" = "freer"
        )
      ),
      checkboxInput("show_coastline", "Show Coastline", value = TRUE),
      checkboxInput("show_ccamlr", "Show CCAMLR Areas", value = FALSE),
      downloadButton("download_plot", "Download Plot"),
      downloadButton("download_data", "Download Data")
    ),
    
    mainPanel(
      width = 9,
      plotOutput("map_plot", height = "600px"),
      DTOutput("data_table")
    )
  )
)

# --- Server Logic ---
server <- function(input, output) {
  
  # Load the selected map
  selected_map <- reactive({
    req(input$map_type)
    readRDS(file.path(config$data_dir, paste0("plot_", input$map_type, ".rds")))
  })
  
  # Render the map plot
  output$map_plot <- renderPlot({
    p <- selected_map()
    
    # Add coastline if requested
    if (input$show_coastline) {
      # Add coastline layer here if needed
    }
    
    # Add CCAMLR areas if requested
    if (input$show_ccamlr) {
      # Add CCAMLR areas layer here if needed
    }
    
    p
  })
  
  # Download handler for the plot
  output$download_plot <- downloadHandler(
    filename = function() {
      paste0(input$map_type, "_plot.png")
    },
    content = function(file) {
      ggsave(
        file,
        plot = selected_map(),
        width = 10,
        height = 8,
        dpi = 300
      )
    }
  )
  
  # Download handler for the data
  output$download_data <- downloadHandler(
    filename = function() {
      paste0(input$map_type, "_data.csv")
    },
    content = function(file) {
      # Extract data from the plot object
      plot_data <- ggplot_build(selected_map())$data[[1]]
      write.csv(plot_data, file, row.names = FALSE)
    }
  )
  
  # Render data table
  output$data_table <- renderDT({
    # Extract data from the plot object
    plot_data <- ggplot_build(selected_map())$data[[1]]
    datatable(
      plot_data,
      options = list(
        scrollX = TRUE,
        pageLength = 10
      )
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)