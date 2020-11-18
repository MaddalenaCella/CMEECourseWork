rm(list=ls())
#population growth dataset
library(dplyr)
library(tidyverse)
library(broom)
##data exploration
data<- read.csv("../Data/LogisticGrowthData.csv") #dim(data)= 4387 12
metadata<- read.csv("../Data/LogisticGrowthMetaData.csv")

#save citations present in data frame
cit <- paste0(unique(data$Citation),"\\\\")

#check units of response and indep variables
resp_var_units <- unique(data$PopBio_units)
print(resp_var_units) #OD_595    N         CFU       DryWeight
##OD (optical density) based on Stevenson et al., 2016 (General calibration of microbial growth in microplate readers) it is fair to assume than OD=N
##CFU (colony forming unit)
ind_var_units <- unique(data$Time_units)
#print(ind_var_units) #hours

data$ID <- paste(data$Species,"_", data$Temp, "_",data$Medium, "_",data$Citation)
#print(unique(data$ID))

#create an id column where every unique id has a number
data <-within(data, num_id <- match(ID, unique(ID)))

#remove negative time values by adding to every item in the column data$Time the same value (25.263)
data$Time <-data[,2] + 25.263 #now the minum value for time is 0

#remove redundant columns(Species,Temp,Medium,Citation,ID)
data_tidy<- subset(data, select= -c(Species,Temp,Citation,ID))

#create unique datasets

Data_N <- subset(data_tidy, PopBio_units =="N")
Data_N_id_q <- Data_N %>% group_by(num_id) %>% #test quadratic linear model on data for each population
do(lm_quadratic= glance(lm(PopBio ~ poly(Time,2), data=.))) %>%
unnest(lm_quadratic) 


Data_N_id_c <- Data_N %>% group_by(num_id) %>% #test cubic linear model on data for each population
do(lm_cubic= glance(lm(PopBio ~ poly(Time,3), data=.))) %>%
unnest(lm_cubic)
Data_N_id_c$AIC #i get some -Inf values
AIC_num_1 <- (Data_N_id_c$AIC) 

par(mfrow=c(2,1))
hist(Data_N_id_q$AIC)
hist(Data_N_id_c$AIC)
hist(diff_qc)
#why -Inf values????

diff_qc <- 0 #calculate difference between AIC of cubic and quadratic equation
for (i in 1:length(AIC_num_1)) {
        if (unique(AIC_num_1[i]) != "-Inf"){
        diff_qc[i]<- AIC_num[i]-AIC_num_1[i]
}
}
mean_diff_qc <- mean(diff_qc, na.rm=T) #it appears that in general quadratic has a better fit fo the data

##try to apply the model to all the column
Tot_quad <- data_tidy %>% group_by(num_id) %>% #test cubic linear model on data for each population
do(lm_quadratic= glance(lm(PopBio ~ poly(Time,2), data=.))) %>%
unnest(lm_quadratic)

Tot_cub <- data_tidy %>% group_by(num_id) %>% #test cubic linear model on data for each population
do(lm_cubic= glance(lm(PopBio ~ poly(Time,3), data=.))) %>%
unnest(lm_cubic)

diff_qc_tot <- 0 #calculate difference between AIC of cubic and quadratic equation
for (i in 1:length(Tot_cub$AIC)) {
        if (unique(Tot_cub$AIC[i]) != "-Inf"){
        diff_qc_tot[i]<- (Tot_quad$AIC)[i]- (Tot_cub$AIC)[i]
}
}
mean_diff_qc <- mean(diff_qc_tot, na.rm=T) 
#even in the overall dataset the difference in AIC between cubic and quadratic suggests that quadratic has a better fit for the data
cat("The overall difference in the AIC score between the quadratic and the cubic equation is:", mean_diff_qc)
cat("This suggests that the quadratic equation has a better fit for our data")

##get starting values for non-linear models
require("minpack.lm")
##first: rmax
Data_N$LogN <- log(abs(Data_N$PopBio))
LogN <- Data_N$LogN #absolute value because otherwise NaN are produced from negative values

##function for model to fit
logistic_model <- function(t, r_max, N_max, N_0){ # The classic logistic equation
  return(N_0 * N_max * exp(r_max * t)/(N_max + N_0 * (exp(r_max * t) - 1)))
}

# first we need some starting parameters for the model
starting_parameters <- Data_N %>% group_by(num_id) %>%
summarise(N_0_start = min(PopBio), # lowest population size
N_max_start = max(PopBio), # highest population size
r_max_start = max(abs(diff(LogN)))/2)# use our linear estimate from before)

#merge Data_N with starting parameters
starting_parameters<- data.frame(starting_parameters)

merged_data_N <- merge(Data_N, starting_parameters, by.x = "num_id", by.y="num_id", all = TRUE)

summary <- 0
for (i in 1:length(unique(merged_data_N$num_id))){
    fit_logistic <- nlsLM(PopBio ~ logistic_model(t = Time, r_max, N_max, N_0), merged_data_N,
                      list(r_max= merged_data_N[,12], N_0 = merged_data_N[,10], N_max = merged_data_N[,11]))
    summary[i]<- summary(fit_logistic)[i]}

summary <- merged_data_N %>% group_by(num_id) %>% #test logistic eq
do(fit_logistic= nlsLM(PopBio ~ logistic_model(Time, r_max_start, N_max_start, N_0_start))) 
smaller_subset <- subset(merged_data_N, num_id =="89")

N_0_start <- unique(smaller_subset$N_0_start) # lowest population size
N_max_start <- unique(smaller_subset$N_max_start) # highest population size
r_max_start <- 0.5 <- with this value i get the model to converge

fit_logistic <- nlsLM(PopBio ~ logistic_model(t = Time, r_max, N_max, N_0), smaller_subset,
                      list(r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))

merged_data_N$PopBio <-merged_data_N[,4] + 668

N_0_start_t <- 3.777e+02 # lowest population size
N_max_start_t <- 2.007e+04 # highest population size
r_max_start_t <- 7.776e-03 #<- with this value i get the model to converge

#try a smaller subset
smaller_subset <- subset(merged_data_N, num_id =="90")

N_0_start_t <- 3.777e+02 # lowest population size
N_max_start_t <- 2.007e+04 # highest population size
r_max_start_t <- 7.776e-03

fit_logistic <- nlsLM(PopBio ~ logistic_model(t = Time, r_max, N_max, N_0), smaller_subset,
                      list(r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))
##estimates from this 

#make pop start at 0

fit_logistic_t <- nlsLM(PopBio ~ logistic_model(t = Time, r_max, N_max, N_0), merged_data_N,
                      list(r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))

gompertz_model <- function(t, r_max, N_max, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
    return(log(N_max / N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/log(N_max / N_0) + 1)))
}

gompertz_model2 <- function(t, r_max, N_max, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(log(N_0) + (log(N_max) - log(N_0)) * exp(-exp(r_max * exp(1) * (t_lag - t)/((log(N_max) - log(N_0)) * log(10)) + 1)))
}

fit_gompertz <- nlsLM(PopBio ~ gompertz_model2(t = Time, r_max, N_max, N_0, t_lag), smaller_subset,
                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))
                    
#missing value or infinite generated 

'''
#create 4 data subsets for analysis based on response variable unit
data_OD <- subset(data, PopBio_units =="OD_595") #dim()= 1878 12
data_N <- subset(data, PopBio_units =="N") #dim()= 1284 12
data_CFU <- subset(data, PopBio_units =="CFU") #dim()= 1171 12
data_DryWeight <- subset(data, PopBio_units =="N") #dim()= 1284 12
'''

