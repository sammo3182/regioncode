if (!require(pacman)) install.packages("pacman")

library(pacman)
p_load(
  qs,
  tidyverse,
  ggplot2
)

# 哥哥你在这边需要将示例文档导入成对象exampledata
# 重命名示例文档的行政编码变量为codeData
# 导入uiowa调色板
source('./uiowa_palette.R')
# 地图数据
library()
chinaMap <- qread('./chinaMap.qs')
# 合并两个数据
chinaMap$df_China <- exampledataraw %>% 
  right_join(chinaMap$df_China, by = 'codeData')
# 画地图
chinaMap$df_China
## This is the code to match attribute data to the corresponding areas in the map file
# Preset for the 9lines
chinaMap <- qread('./chinaMap.qs')
exampledataraw <- qread('./exampleDataRaw.qs')

exampledataraw <- exampledataraw %>% 
  rename(codeData = code)
chinaMap$df_China <- exampledataraw %>% 
  right_join(chinaMap$df_China, by = 'codeData')

source('./uiowa_palette.R')

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

# only support .qs file
paste2map <- function(map_name, data_name, year_col, from_year, to_year = '2015'){
  data <- year_convert(name = data_name, year_col = year_col, from_year = from_year, to_year = to_year)
  
  data <- data %>% 
    rename(codeData = year_col)
  chinaMap$df_China <- data %>% 
    right_join(chinaMap$df_China, by = 'codeData')
}
