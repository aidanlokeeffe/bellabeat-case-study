# Change working directory
setwd("C:/Users/aidan/OneDrive/Desktop/bellabeat-case-study")

# Load in packages
install.packages("tidyverse")
library(tidyverse)

# Load in the sleep duration data
sleep_durations <- read_csv("transformed-data/sleep_durations.csv")
View(sleep_durations)

# Rewrite the duration column to be in hours, not timediff
sleep_durations$duration <- as.numeric(sleep_durations$duration)/3600

# Group the data by the user ID
sleep_by_user <- sleep_durations %>% 
  group_by(Id) %>% 
  summarize(mean_duration=mean(duration), sd_duration=sd(duration), num_sessions=length(duration))
View(sleep_by_user)

hist(sleep_by_user$mean_duration)
hist(sleep_by_user$sd_duration)

# Filter out the Ids corresponding to outliers 4558609924, 2320127002, 7007744171, 1844505072
# These are indices 3, 6, 13, and 20
sleep_by_user <- sleep_by_user[-c(3,6,13,20),]
View(sleep_by_user)

hist(sleep_by_user$mean_duration)
hist(sleep_by_user$sd_duration)


sum(sleep_by_user$mean_duration < 8) / length(sleep_by_user$mean_duration)
sum(sleep_by_user$sd_duration > 2) / length(sleep_by_user$sd_duration)

plot(sleep_by_user$mean_duration,sleep_by_user$sd_duration)
