library(sf)
library(tidyverse)
install.packages("janitor")
library(janitor)

#read csvfile
library(here)
timeseries <- read_csv(here('GIS_practical','HDR21-22_Composite_indices_complete_time_series.csv'))

#read shp
world_countries <- st_read(here('GIS_practical','World_Countries_(Generalized)','World_Countries__Generalized_.shp'))
world_countries <- world_countries %>%
  clean_names()

#calculate difference
df <- timeseries %>%
  select(iso3,country,gii_2010,gii_2019) %>%
  mutate(diff=gii_2019 - gii_2010)

#join
shape <- left_join(world_countries, df, by =c('country' = 'country'))

#plot
library(tmap)
library(tmaptools)
tmap_mode("plot")
shape %>%
  qtm(.,fill = "diff")

