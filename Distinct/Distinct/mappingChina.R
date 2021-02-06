library(qs)
library(ggplot2)
library(tidyverse)

exampledataraw <- qread('/Users/sunyufei/Downloads/exampleDataRaw.qs')
exampledataraw <- exampledataraw %>% 
  rename(codeData = code)
source('/Users/sunyufei/Desktop/uiowa_palette.R')
exampledata <- qread('/Users/sunyufei/Desktop/exampledata.qs')
exampledata <- exampledata %>% 
  rename(codeData = coderaw)
exampledata <- exampledata %>% 
  select(codeData,ADCODE99)
chinaMap <- qread('/Users/sunyufei/Downloads/chinaMap.qs')
chinaMap$df_China <- exampledata %>% 
  right_join(chinaMap$df_China, by = 'ADCODE99')
chinaMap$df_China <- exampledataraw %>% 
  right_join(chinaMap$df_China, by = 'codeData')

chinaMap$df_China$codeData[chinaMap$df_China$codeData==3426] <- 3401
chinaMap$df_China$codeData[chinaMap$df_China$codeData==5003] <- 5002
chinaMap$df_China$codeData[chinaMap$df_China$codeData==6541] <- 6540


## This is the code to match attribute data to the corresponding areas in the map file
#chinaMap$df_China <- select(data_showing, code99, score) %>%
#  distinct %>% 
#  right_join(chinaMap$df_China, by = "code99")

# Preset for the 9lines
chinaMap <- qread('/Users/sunyufei/Desktop/chinaMap.qs')
exampledataraw <- qread('/Users/sunyufei/Downloads/exampleDataRaw.qs')
exampledataraw <- exampledataraw %>% 
  rename(codeData = code)
chinaMap$df_China <- exampledataraw %>% 
  right_join(chinaMap$df_China, by = 'codeData')

source('/Users/sunyufei/Desktop/uiowa_palette.R')

Width<-9
Height<-9
long_Start<-124
lat_Start<-16

# Drawing the map
map_showing <- ggplot() +
    geom_polygon(
        data = chinaMap$df_China,
        aes(
            x = long,
            y = lat,
            group = interaction(class, group),
            fill = score
        ),
        # colour = "grey69",
        size = 0.25
    ) +
    geom_rect(
        aes(
            xmin = long_Start,
            xmax = long_Start + Width + 0.3,
            ymin = lat_Start - 0.3,
            ymax = lat_Start + Height
        ),
        fill = NA,
        colour = "black",
        size = 0.25
    ) +
    geom_line(
        data = chinaMap$df_NanHaiLine,
        aes(x = long, y = lat, group = ID),
        colour = "black",
        size = 1
    ) +
    scale_fill_uiowa(discrete = FALSE) + # using a specific color palette
    coord_cartesian() +
    ylim(15, 55) +
    # guides(
    #   fill = guide_legend(override.aes = list(size = 1))) +
    ylab("Latitude") + xlab("Longitude") +
    # theme_minimal() +
    theme(legend.position = c(0.1, 0.2),
          legend.background = element_blank(),
          legend.key.size = unit(0.3, "cm"))