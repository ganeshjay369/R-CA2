#NI CRIME DATASET

#To set the working directory and unzipping the file "NI-CRIMEDATA"
getwd()
setwd("C:/Users/JAYACHANDRAN/CA2/")

# To unzip and extract NICrimedata
zipfile <- "C:/Users/JAYACHANDRAN/CA2/NI Crime Data.zip"
unzip(zipfile)

setwd("C:/Users/JAYACHANDRAN/CA2/NI Crime Data/")
getwd()

#Task1: To amalgamate the crime data from each csv file to one dataset
csv_files <- list.files(full.names = TRUE,recursive=TRUE)
csv_files

AllNICrimeData <- Reduce(rbind, lapply(csv_files, read.csv))

# To count and show the number of rows in newly saved AllCrimeDataset
nrow(AllNICrimeData)

head(AllNICrimeData)

#To write the combined crime data "AllNICrimedata" dataset to csv file
write.csv(AllNICrimeData, file = "C:/Users/JAYACHANDRAN/CA2/AllNICrimeData.csv", row.names = TRUE )


#Task 2: Modifying the structure and removing the attributes

AllNICrimeData <- AllNICrimeData[ -c(1, 3, 4, 8, 9, 11, 12) ]

#To show the structure of the modified AllNICrimedata dataset
str(AllNICrimeData)


head(AllNICrimeData)
nrow(AllNICrimeData)

#AllNICrimeData[AllNICrimeData == " "] <- NA



head(AllNICrimeData)
str(AllNICrimeData)

# Task 3: Factorizing the Crime type attribute
#To check the class type of the dataset
class(AllNICrimeData$Crime.type)

#To change the class type of the attribute Crime type to "Factor"
levels(AllNICrimeData$Crime.type) <- as.factor(AllNICrimeData$Crime.type)

# To display the modified structure after converting to factor class type
str(AllNICrimeData)


# Task 4: Modifying the Location attribute to remove string "On or near" by using gsub.
AllNICrimeData$Location <- lapply(AllNICrimeData$Location,gsub, pattern ="On or near", replacement ="",
                                  fixed= TRUE)


head(AllNICrimeData)

#Modified the blank spaces with "NA" identifier
AllNICrimeData[AllNICrimeData == " "] <- NA



head(AllNICrimeData)
str(AllNICrimeData)

#Task 5: Choose 1000 random samples of crime data from the AllNICrimeData dataset

# To remove the NA identifier for Location attribute before choosing random samples
new_NICrimedata <- subset(AllNICrimeData, !is.na(AllNICrimeData$Location))
head(new_NICrimedata)

# To choose 1000 random sample from dataset
random_crime_sample <- data.frame(new_NICrimedata[sample(nrow(new_NICrimedata), 1000), ])
View(random_crime_sample)

# To load the library for importing package
library(dplyr)
#  To convert uppercase for the  attributes location in random_crime_sample 
random_crime_sample$AllNICrimeData.Location <- toupper(random_crime_sample$Location)

#Reading postcode CSV file
CleanNIPostcode <-read.csv("C:/Users/JAYACHANDRAN/CA2/CleanNIPostcodeData.csv", stringsAsFactors = FALSE)


# creating a new dataset that contains postcode and primary thorfare information from NIPostcodes dataset
new_pcode <- CleanNIPostcode[, c(6, 13)]
head(new_pcode, 5)

# deleting the duplicate values in primary thorfare column
new_pcode <- new_pcode[!duplicated(new_pcode$`Primary Thorfare`),]
# column names for new dataset
colnames(new_pcode) <- c("Primary Thorfare", "Postcode")
str(new_pcode)

# add a new column to the random crime sample dataset and place the values as NA
random_crime_sample$Postcode <-NA
head(random_crime_sample, 5)


#Task 6: Appending the Postcodes to random crime sample dataset.

# To add the  postcode  column data values by matching the location with primary thorfare in new_pcode
random_crime_sample$Postcode <- new_pcode$Postcode[match(random_crime_sample$Location, 
                                                      new_pcode$`Primary Thorfare`)]

# To show the structure of randomcrime sample dataset
str(random_crime_sample)


head(random_crime_sample)

#To view the random_crime_sample
View(random_crime_sample)

#To show the number of rows of random_crime_sample
nrow(random_crime_sample)


#The modified random crime sample was saved into csv file random_crime_sample.csv
write.csv(random_crime_sample, "random_crime_sample.csv")

str(random_crime_sample)
class(random_crime_sample)

# Task 7: Updating the random sample and loading it to updated_random_sample

# The random crime sample data are stored to dataset updated_random_sample
updated_random_sample <- data.frame(random_crime_sample)

# The column names are stored in updated_random_sample
colnames(updated_random_sample) <- c("Month", "Longitude", "Latitude", "Location", "Crime.type", "Postcode")

head(updated_random_sample, 3)

# Updated random sample data are stored into chart_data dataset
chart_data <- updated_random_sample

# To sort the chart_data based on crime type and Postcode
chart_data <- chart_data[order(chart_data$Postcode == "BT1", chart_data$Crime.type), ]
chart_data

#  To create a new chart dataset that contains postcode = "BT1"
new_chart <- filter(chart_data, grepl('BT1', Postcode))
new_chart
new_chart[order(new_chart$Postcode == 'BT1', new_chart$Crime.type), ]
str(new_chart)

# To show the summary of crime type as per  location and postcode

crime_type <- data.frame(new_chart$Crime.type)
library(plyr)
crime_type <- ddply(crime_type, .(new_chart$Crime.type), nrow)
colnames(crime_type) <- c("Crime_type", "Count")
crime_type

#Task 8: To create a bar plot of the crime type from the chart data.

CrimeData <- table(chart_data$Crime.type)
barplot(CrimeData, main = "Crime Type Frequency", xlab = "Crime Type", ylab = "Frequency",
        col = "red", border = "black",
        density = 100)


