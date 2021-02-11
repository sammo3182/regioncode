library(readxl)
temp <- read_excel('./data/missing/temp.xlsx')
save(temp, file = './data/missing/temp.csv')
