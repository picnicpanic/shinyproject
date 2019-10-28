rm(list = ls())
library(dplyr)
library(lubridate)
filenames = list.files(pattern="*.csv")
ldf = lapply(filenames, read.csv)
ldf_relevant = lapply(ldf, subset, select = c("trip_start_timestamp","trip_seconds","trip_miles","pickup_community_area","dropoff_community_area","fare","tips","trip_total","payment_type","company"))
finaldf <- do.call("rbind", ldf_relevant)
finaldf_no_na=na.omit(finaldf)
write.csv(finaldf_no_na,'C:/Users/Sathya/Desktop/NYCDSA/Project2/2019_sep_taxi.csv', row.names = FALSE)
sep_2019_taxi=read.csv(file='2019_sep_taxi.csv')
sep_2019_taxi$trip_start_timestamp=date(sep_2019_taxi$trip_start_timestamp)
nosmallgrps=sep_2019_taxi %>% group_by(company) %>% filter(n() >= 50000)
newdf=ungroup(nosmallgrps)
write.csv(newdf,'C:/Users/Sathya/Desktop/NYCDSA/Project2/2019_sep_taxi.csv', row.names = FALSE)
sep_2019_taxi=read.csv(file='2019_sep_taxi.csv')
sep_2019_taxi$trip_start_timestamp=date(sep_2019_taxi$trip_start_timestamp)
sep_2019_taxi$day=wday(sep_2019_taxi$trip_start_timestamp,label=TRUE)
write.csv(sep_2019_taxi,'C:/Users/Sathya/Desktop/NYCDSA/Project2/2019_sep_taxi.csv', row.names = FALSE)




