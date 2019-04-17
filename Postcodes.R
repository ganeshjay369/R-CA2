
#Task1 :Show the total number of rows, the structure of the data frame, and first 10 rows of the data frame containing all of the NIPostcode data.
getwd()
setwd("C:/Users/JAYACHANDRAN/R CA2")

# To read the NIPostcodes csv file
NIpostcodesdata <- read.csv("C:/Users/JAYACHANDRAN/R CA2/NIPostcodes.csv", header = FALSE)

# To show the total number of rows
nrow(NIpostcodesdata)

# To show the structure of the dataframe
str(NIpostcodesdata)

# To show first 10 rows of the dataframe
head(NIpostcodesdata, n=10)
str(NIpostcodesdata)
ncol(NIpostcodesdata)

#Task2 : Add a suitable title for each attribute of the data.
colnames(NIpostcodesdata) <- c("Organisation_Name", "Sub-building_Name", "Building_Name", "Number",
                               "Primary_Thorfare", "Alt_Thorfare", "Secondary_Thorfare", "Locality",
                               "Townland", "Town", "County", "Postcode", "x-coordinates", "y-coordinates",
                               "Primary_key(identifier)")

head(NIpostcodesdata, n=10)
str(NIpostcodesdata)
#Adding Column names in the postcode dataset dataframe
#colnames(NIPostcode_data) <- column_names

#Task 3 : Remove or replace missing entries with a suitable identifier. Decide whether it is best to remove missing data or to recode it.
#The NIpostcodes dataset has many blank values in most of the cloumns. Removing these blanks will omit 95% of the data. 
#Replacing the empty values with 'NA' is the best option.

NIpostcodesdata[NIpostcodesdata==""] <- NA

head(NIpostcodesdata, n=10)
str(NIpostcodesdata)
tail(NIpostcodesdata)

#Task 4 : To show total number and mean missing values for each column mean missing values for each column
#summary(NIpostcodesdata)

#sum(is.na(NIpostcodesdata))

#mean((is.na(NIpostcodesdata)))

#sum(is.na(NIpostcodesdata$Postcode))
#table(is.na(NIpostcodesdata$Postcode))


#To display sum of NA's in each column using sapply, we created dataset df_sum
df_sum <- data.frame(sapply(NIpostcodesdata, function(y) sum(length(which(is.na(y))))))
#To show the result of the dataset
df_sum


#To display the mean of NA's in each column using sapply, we created dataset df_mean
df_mean <- data.frame(sapply(NIpostcodesdata, function(y) mean(is.na(y))))
#To show the result of the dataset
df_mean
#To show the structure of the dataset
str(NIpostcodesdata)


#Task 5 :To Modify the County attribute to be a categorising factor.
#To check the class type of the dataset
class(NIpostcodesdata$County)

#To change the class type of the attribute County to "Factor"
levels(NIpostcodesdata$County) <- as.factor(NIpostcodesdata$County)
class(NIpostcodesdata$County)

# To show the structure of the dataset
str(NIpostcodesdata)

head(NIpostcodesdata)

#Task 6 : Move the primary key identifier to the start of the dataset.

NIpostcodesdata<-NIpostcodesdata[,c(15, 1:14)]

head(NIpostcodesdata)
str(NIpostcodesdata)

#Step7 : Create a new dataset called Limavady_data. Store within it only information that has 
#locality, townland and town containing the name Limavady. Store this information in an 
#external csv file called Limavady.


#Task 7: To create new dataset Limavady and stored only locality "town"
Limavady_data <- subset(my_data, my_data$Town =='LIMAVADY', select = c(9:11))

# To store the limavady dataset information to Limavady csv file
write.csv(Limavady_data, file = "C:/Users/JAYACHANDRAN/R CA2/Limavady.csv", row.names = FALSE )

summary(Limavady_data)
str(Limavady_data)



#Filtering out the data with Limavady town.
#Limavady_data <- Limavady_data[Limavady_data$Town == 'LIMAVADY',]
#nrow(Limavady_data)
#exporting the Limavady dataset.
#write.csv(Limavady_data, "C:/Users/JAYACHANDRAN/R CA2/Limavady.csv")

#Task 8 : Save the modified NIPostcode dataset in a csv file called CleanNIPostcodeData. 
write.csv(NIpostcodesdata, "C:/Users/JAYACHANDRAN/R CA2/CleanNIPostcodeData.csv")
