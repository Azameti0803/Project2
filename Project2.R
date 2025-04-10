# Install and load necessary libraries
install.packages("readxl")  # Install the package
install.packages("openxlsx")
install.packages("lubridate")
install.packages("MASS")  # Install if not already installed
install.packages("VIM")
install.packages("corrplot")
install.packages("pscl")
install.packages("randomForest")
install.packages("Metrics")   # Install Metrics package (if not installed)
install.packages("caret") 
install.packages("corrplot")  # Install the package (only needed once)
install.packages("gt")
install.packages("tidyverse")  # For data manipulation and visualization
install.packages("ggplot2")    # For advanced plotting
install.packages("dplyr")      # For data manipulation
install.packages("reshape2")
install.packages("AER")
###########################load packages
# Load necessary libraries
library(broom)
library(dplyr)
library(tidyselect)
# Load the AER package
# Load caret package
library(caret)
library(AER)    # For overdispersion test
library(reshape2)
library(car)   # For VIF
library(vcd)   # For Cramér's 
library(dplyr)
library(xtable)
library(tidyr)
library(gt)  # For creating a nicely formatted table
library(knitr)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(corrplot)  # Load the package
library(openxlsx)
library(readxl)  # Load the package
library(caret)
library(Metrics)              # Load the package
library(randomForest)

library(MASS)  # Load the package
library(pscl)
library(ggplot2)
library(dplyr)
library(stats)
library(VIM)
library(lubridate)
library(splines)  # Needed for natural splines if required


#selecting the file containing the dataset
filepath <- file.choose()
print(filepath)  # Display the selected file path

# Extract directory path
dirpath <- dirname(filepath)

# Set working directory
setwd(dirpath)

writeLines(filepath, "filepath.txt")

# Read the saved file path
filepath <- readLines("filepath.txt")

# Load the data
projectdata <- read_xlsx(filepath)
View(projectdata)

# Inspect the first few rows
head(projectdata)


# Check the structure of the dataset
str(projectdata)

# Summary statistics
summary(projectdata)

# Check for missing values
colSums(is.na(projectdata))

# Check for duplicates
sum(duplicated(projectdata))
class(projectdata$Date)
# Convert the Date column from character to Date
projectdata$Date <- as.Date(projectdata$Date, format = "%m/%d/%Y")

# Extract the year
projectdata$year <- format(projectdata$Date, "%Y")

# Extract the month
projectdata$month <- format(projectdata$Date, "%m")

# Extract the day
projectdata$day <- format(projectdata$Date, "%d")

class(projectdata$km)

# Remove commas and convert the km column to numeric
projectdata$km <- as.numeric(gsub(",", ".", projectdata$km))
projectdata$km[is.na(projectdata$km)] <- 
  median(projectdata$km, na.rm = TRUE)

sum(is.na(projectdata$km))


# Extract the hour as numeric value
class(projectdata$hour)
projectdata$hour_of_day <- as.numeric(format(projectdata$hour, "%H"))
class(projectdata$hour_of_day)




# Convert categorical columns to factors
str(projectdata)
class(projectdata)
projectdata <- projectdata %>%
  mutate(
    week_day = as.factor(week_day),
    weather_timestamp = as.factor(weather_timestamp),
    road_type = as.factor(road_type),
    road_delineation = as.factor(road_delineation),
    state = as.factor(state),
    city = as.factor(city),
    road_direction = as.factor(road_direction),
    wheather_condition = as.factor(wheather_condition),
    cause_of_accident = as.factor(cause_of_accident),
    type_of_accident = as.factor(type_of_accident),
    regional = as.factor(regional)
  )
projectdata$year <- as.numeric(projectdata$year)
projectdata$month <- as.numeric(projectdata$month)
projectdata$day <- as.numeric(projectdata$day)




detach("package:MASS", unload = TRUE)
class(projectdata)
str(projectdata)

# Select only the variables of concern
variablesofinterest <- c("year", "month", "day", "week_day", 
                           "hour_of_day", "weather_timestamp", 
                           "wheather_condition", 
                           "road_type", "road_direction", "road_delineation",
                           "km","vehicles_involved","people", "deaths")
names(projectdata)
print(variablesofinterest)
class(variablesofinterest)


# Create a new dataframe with the selected variables
library(MASS)
library(dplyr)

variablesofinterest <- c("year", "month", "day", "week_day", 
                         "hour_of_day", "weather_timestamp", 
                         "wheather_condition", 
                         "road_type", "road_direction", "road_delineation",
                         "km", "vehicles_involved", "people", "deaths")





filtereddata <- projectdata %>% dplyr::select(all_of(variablesofinterest))



# View the structure of the new dataframe
str(filtereddata)

View(filtereddata)

summary(projectdata)
summary(filtereddata)


# Save the subsetted dataframe
write.csv("filtereddata.csv", row.names = FALSE)














