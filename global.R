library(dplyr)
library(lubridate)
library(shiny)
library(ggplot2)
library(tidyr)
library(googleVis)
library(shinydashboard)
library(DT)
library(googleVis)

taxi=read.csv('2019_sep_taxi.csv')
taxi$pickup_community_area <- factor(taxi$pickup_community_area)
taxi$dropoff_community_area<- factor(taxi$dropoff_community_area)

