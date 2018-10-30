# R-DAVIS

**R for Data Analysis &amp; Visualization in Science**

This is the repository for website used to teach the quarter-long graduate seminar course, R-DAVIS. Course content integrates and builds on Data Carpentry Ecology lessons, and is taught as part of the curriculum for students in the Graduate Group in Ecology at the University of California, Davis, USA.

## Package Dependencies

Because much of the varied content found in the lessons, there are a number of package dependencies to be aware of. This list may not be complete, but before building the site locally, these packages should be installed:

`c("tidyverse", "ggplot2", "tidyr", "readr", "dplyr", "purrr", "emojifont",
"viridis", "mapdata", "maps", "mapview", "measurements", "gapminder", "broom",
"gutenbergr", "tidytext", "patchwork", "cowplot", "hexbin", "geosphere", "ggmap",
"ggthemes", "magrittr", "leaflet", "plotly", "knitr")`

## Build Site Locally

The [course website](https://gge-ucd.github.io/R-DAVIS/) can be rebuilt locally by using the "`Build`" tab in RStudio. Assuming the above packages are installed on your machine:

 - Open the R-DAVIS project in RStudio. Click on the `Build` tab, and "*More*", select "*Clean All*".
 - Then select `Build Website`. This process make take a few minutes.

## Releases
 
See the [`Releases`](https://github.com/gge-ucd/R-DAVIS/releases) tab in this repo to find the completed version for a given year. We expect further development of the website for future iterations as the course improves in the future.

