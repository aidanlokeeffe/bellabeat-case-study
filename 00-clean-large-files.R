# Change working directory
setwd("C:/Users/aidan/OneDrive/Desktop/bellabeat-case-study")

# Load in packages
install.packages("tidyverse")
library(tidyverse)

# minute_intensities_wide
data <- read_csv("./fitabase-data-4.12.16-5.12.16/minute_intensities_wide.csv")
View(data)

# Count the missing values
sum(is.na(data))

# Check for duplicate entries
unique_row_id <- paste(data$Id, data$ActivityHour)
sum(duplicated(unique_row_id))

# See if the ranges of values in the other columns are correct
for (col in colnames(data)[-c(1,2)]) {
  print(unique(data[col]))
}
# All of the values are no less than 0, no greater than 3, this is good
### CLEAN

# minute_steps_wide
data <- read_csv("./fitabase-data-4.12.16-5.12.16/minute_steps_wide.csv")
View(data)
### LEFT OFF HERE

