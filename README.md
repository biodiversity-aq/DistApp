# 🗺️ DistApp - Interactive visualization of DistAnt data

This repository contains the source code for a Shiny application designed to visualize various geospatial data layers from the Southern Ocean and Antarctic region (ecological model outputs: species distribution and similar models), originating from the DistAnt project (SCAR EG-ABI, Expert Group on Biodiversity Informatics) in conjunction with ADVANCE (Royal Belgian Institute of Natural Sciences) and the Integrated Digital East Antarctica program at the Australian Antarctic Division.
## 🔎 Overview

The Shiny application provides an interactive interface to explore maps of benthic bioregions, habitat importance, sea ice productivity, and habitat for certain species, based on scientific publications. The data is pre-processed to ensure optimal performance within the application.

## 🗂️ Repository Structure
```
DistApp/
├── preprocess_data.R       # R script to download (from SourceCooperative) and pre-process data for Shiny
├── app.R                   # Source code for the Shiny application
└── README.md               # This file
```

## 📦 Prerequisites

Before you can run the application, ensure you have the following installed:

* **R (>= 4.0.0)**: The statistical programming language used for data pre-processing and the Shiny application. You can download it from [R Project](https://www.r-project.org/).
* **RStudio (recommended)**: An integrated development environment (IDE) for R, making code writing and execution easier. Downloadable from [RStudio](https://rstudio.com/).
* **The following R libraries**: These will be automatically installed if not already present when running the scripts, but you can also install them manually:
    * `shiny`
    * `ggplot2`
    * `SOmap`
    * `sf`
    * `raster`
 
* **Git**: Used to clone the data repository (if using the GitHub option). You can download it from [Git](https://github.com/biodiversity-aq/DistApp.git).

## Installation and execution

Follow these steps to set up and run the application:

1.  **Clone the repository (if you haven't already):**

    ```bash
    git clone https://github.com/biodiversity-aq/DistApp.git
    cd DistApp
    ```

2.  **Retrieve data (from GitHub) and pre-process:**

    Execute the R script `preprocess_data.R`. This script will:
    * Clone (if necessary) or update (if already cloned) the data repository from SourceCooperative into the `data_source_coop` directory.
    * Load the necessary data.
    * Perform pre-processing to optimize for display in Shiny.
    * Save the pre-processed plot objects in `.rds` format within the `processed_data` directory.

    To run the script, open R or RStudio, navigate to the repository directory (`DistApp`), and execute:

    ```R
    source("preprocess_data.R")
    ```

3.  **Launch the Shiny application:**

    Once the pre-processing is complete, you can launch the Shiny application by running the `app.R` script in R or RStudio:

    ```R
    shiny::runApp("app.R")
    ```

    Alternatively, if you are in RStudio, you can simply open the `app.R` file and click the "Run App" button in the top right of the editor.

    The Shiny application will then open in your web browser.

## Usage

The Shiny application features a sidebar panel where you can select the data layer to visualize:
(Initial selection of layers)
* **Benthic Bioregions (Fabri-Ruiz et al.)**
* **Habitat Importance (Hindell et al.)**
* **Sea Ice Productivity (Pinkerton & Hayward)**
* **Krefftichthys Habitat (Freer et al.)**

Select a layer from the dropdown menu to display the corresponding map in the main panel. The maps are pre-rendered for smooth navigation. 

## Notes

* Data pre-processing is a crucial step to ensure the performance of the Shiny application. Run `preprocess_data.R` whenever the source data is updated on the GitHub repository.
* The application is designed to display static visualizations based on the pre-processed data. Additional information (metadata) about each layer and more advanced interactive features may be added to the user interface in future updates.

## Contributions

Contributions to the project are welcome. If you would like to improve the application, fix bugs, or add new features, feel free to create a pull request on this repository.

## License

This project is open source under the [MIT License].
