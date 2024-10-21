# Use the tidyverse image as the parent image
FROM rocker/shiny-verse:4.2.2

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev
    #libcurl4-openssl-dev \
    #make
    #zlib1g-dev
    #libxml2.    

# Add R Libraries
RUN R -e "install.packages(c('shiny', 'tidyverse', 'lubridate', 'shinydashboard', 'shinyWidgets', 'shinythemes', 'scales', 'ggthemes', 'plotly', 'DT', 'openxlsx', 'jsonlite', 'forcats', 'purrr', 'cluster', 'arrow', 'ggfortify', 'bs4Dash', 'Rcpp', 'shinymanager'), repos = 'https://packagemanager.posit.co/cran/__linux__/focal/2023-11-30')"

## Copy files
COPY app.R /srv/shiny-server/
COPY scripts/. /srv/shiny-server/scripts/



# open port to traffic
EXPOSE 3838
#EXPOSE 3839


# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server

# run app
CMD ["/usr/bin/shiny-server"]


