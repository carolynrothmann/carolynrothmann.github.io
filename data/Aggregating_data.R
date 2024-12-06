#Loading packages
library(dplyr)
library(lubridate)

# Import the CSV file
data <- read.csv("/Users/carolinabarbosa/Library/CloudStorage/OneDrive-Colostate/WR417_planning/Fall_2024/Labs_assignment/wr417_2023_data/concise_df_wide.csv")

# Convert the time column to a date-time format
data$DT_round_mst <- ymd_hms(data$DT_round_mst)

# Aggregate to hourly data
hourly_data <- data %>%
  mutate(hour = floor_date(DT_round_mst, "hour")) %>%
  group_by(site, hour) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE), .groups = "drop") 

print(head(hourly_data))

# Aggregate to daily data
daily_data <- data %>%
  mutate(date = as_date(DT_round_mst)) %>%
  group_by(site, date) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE),.groups = "drop") 

print(head(daily_data))



