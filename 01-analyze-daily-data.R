# Change working directory
setwd("C:/Users/aidan/OneDrive/Desktop/bellabeat-case-study")

# Load in packages
install.packages("tidyverse")
library(tidyverse)

# I want to collect the number of days which each user used each functionality
weight <- read_csv("fitabase-data-4.12.16-5.12.16/weight.csv")
day_sleep <- read_csv("fitabase-data-4.12.16-5.12.16/day_sleep.csv")
day_activity <- read_csv("fitabase-data-4.12.16-5.12.16/day_activity.csv")

ids <- union(union(weight$Id,day_sleep$Id),day_activity$Id)
ids <- sort(ids)
length(ids) # It's 33

day_counts <- data.frame(Id=ids)
View(day_counts)

day_counts$WeightDays <- rep(0,33)
day_counts$SleepDays <- rep(0,33)
day_counts$ActivityDays <- rep(0,33)
View(day_counts)

for (i in 1:length(ids)) {
  id <- ids[i]
  weight_count <- sum(weight$Id == id)
  sleep_count <- sum(day_sleep$Id == id)
  activity_count <- sum(day_activity$Id == id)
  
  day_counts[i,"WeightDays"] = weight_count
  day_counts[i,"SleepDays"] = sleep_count
  day_counts[i,"ActivityDays"] = activity_count
}

write.csv(day_counts, file="transformed-data/functionality-use-days.csv", row.names = FALSE)

# Now that that is written, let's clear the environment and load it in
day_counts <- read_csv("transformed-data/functionality-use-days.csv")
View(day_counts)

summary(day_counts)

day_counts$WeightDays <- day_counts$WeightDays/31 * 100
day_counts$SleepDays <- day_counts$SleepDays/31 * 100
day_counts$ActivityDays <- day_counts$ActivityDays/31 * 100

write.csv(day_counts, file="transformed-data/functionality-use-percent.csv", row.names = FALSE)

# Now, we'll work with the proportion data instead
View(day_counts)

summary(day_counts)

median_use = data.frame(Functionality=c("Weight", "Sleep", "Activity"))
median_use$Median = c(0.2,16.13,100) # This value of 0.2 is used so the bar shows up on the plot, but it's actually 0

ggplot(data = median_use) + 
  geom_col(mapping=aes(x=Functionality, y=Median), fill="green2", width=.5) + 
  labs(x="Functionality", y="Percentage", title="Median Percentage of Days that Each Functionality was Used")

sum(day_counts$WeightDays <= 0) / length(day_counts$WeightDays)
sum(day_counts$SleepDays <= 0) / length(day_counts$SleepDays)

# I should make a table with this data too, as well as the other summary data, so that the viewers
# can make their own conclusions.
