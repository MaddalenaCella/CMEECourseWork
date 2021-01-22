#!/bin/env R

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: FittedData.R
#
# Description: script that fits models to data
#
# Arguments: 0
#
# Input: Rscript FittedData.R
#
# Output: six csv files in ../Results subdirectory containing relevant information from model fitting
#
# Date: January 2021

rm(list=ls())
options(warn=-1) #to suppress tidyverse warning summarise()
#packages
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(minpack.lm))
suppressPackageStartupMessages(library(broom))
library(dplyr, warn.conflicts = FALSE)

# Suppress summarise info
options(dplyr.summarise.inform = FALSE)


#read tidy dasets
above15<- read.csv("../Data/tidy_above15.csv") 
below15<- read.csv("../Data/tidy_below15.csv")

##functions##

#function that obtain starting parameters for non-linear model fitting
get_starting_parameters <- function(data_set){
    starting_parameters= data.frame()
    for (id in unique(data_set$num_id)){
        sub= subset(data_set, data_set$num_id==id)
        N_0_start= min(sub$PopBio)
        N_max_start= max(sub$PopBio)
         
        #now rmax
        rdata <- sub
        #ref_model <- lm(sub$LogN~sub$Time)
        r_max_start <- 0#ref_model$coefficients[2]
        y_intercept <-0 #ref_model$coefficients[1]
        R_squared <-0 #summary(ref_model)$adj.r.squared
        for (j in 1:(dim(sub)[1]-2)){
        #rdata=rbind(rdata[j,], rdata[j+1,])
            rdata <- rdata[-c(which(sub$Time==max(sub$Time))),]
            if (length(unique(rdata$Time))!= 1){
                new_model <- try(lm(rdata$LogN~rdata$Time), silent=T)
                if (class(new_model)!='try-error'){
                    r_max_new <- new_model$coefficients[2]
                    y_int_new <- new_model$coefficients[1]
                    R_s_new <- summary(new_model)$adj.r.squared
                if (isTRUE(R_s_new>R_squared) & isTRUE(r_max_new>r_max_start)){
                r_max_start <- r_max_new
                y_intercept <- y_int_new
                R_squared <- R_s_new
                }
            }
        }      
    }
            
        r_max_start= r_max_start
        t_lag_start <- -y_intercept/r_max_start
        if (isTRUE(t_lag_start<0)){#maybe remove this
            t_lag_start<-1
        }
        dataframe= data.frame(num_id=id, N_0_start=N_0_start, N_max_start=N_max_start, r_max_start=r_max_start, t_lag_start=t_lag_start)
        starting_parameters=rbind(starting_parameters, dataframe)
    }
    return(starting_parameters) }

#logistic function
logistic_model <- function(t, r_max, N_max, N_0){ # The classic logistic equation
  return(N_0 * N_max * exp(r_max * t)/(N_max + N_0 * (exp(r_max * t) - 1)))
}

##fit quadratic, cubic models to dataset 'above'
data_quad <- above15 %>% group_by(num_id,Species)%>%
do(lm_quadratic= glance(lm(PopBio ~ poly(Time,2), data=.)))%>%
unnest(lm_quadratic) 
fit_quad<- data.frame(data_quad)

data_cub <- above15 %>% group_by(num_id,Species)%>%
do(lm_cubic= glance(lm(PopBio ~ poly(Time,3), data=.))) %>%
unnest(lm_cubic)
fit_cub<- data.frame(data_cub)

##fit quadratic, cubic models to dataset 'below'
data_quad_b <- below15 %>% group_by(num_id, Species)%>%
do(lm_quadratic= glance(lm(PopBio ~ poly(Time,2), data=.))) %>% #use log to make models more comparable also with non-linear that normally want the log
unnest(lm_quadratic)
fit_quad_below<- data.frame(data_quad_b)

data_cub_b <- below15 %>% group_by(num_id, Species)%>%
do(lm_cubic= glance(lm(PopBio ~ poly(Time,3), data=.))) %>% 
unnest(lm_cubic)
fit_cub_below<- data.frame(data_cub_b)

##get starting parameters for logistic model
start_above15 <- suppressWarnings(get_starting_parameters(above15))
start_below15 <- suppressWarnings(get_starting_parameters(below15))

#fit logistic model to the data and returns a dataframe with AIC, BIC, predicted values and resiuduals
log_fit=data.frame()
for (id in unique(above15$num_id)){
set.seed(1234)
r_max_range= runif(100, min=0, max=start_above15$r_max_start +1)
    N_0_range= rnorm(100, mean=start_above15$N_0_start[start_above15$num_id==id], sd=1)
    N_max_range= rnorm(100, mean=start_above15$N_max_start[start_above15$num_id==id], sd=1)
for (i in 1:100){
        r_max_start = sample(r_max_range,1)
        N_0_start = sample(N_0_range,1)
        N_max_start = sample(N_max_range,1)
        fit_logistic_test = suppressWarnings(try(nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=subset(above15, above15$num_id==id),
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start)),silent=TRUE)) #, control=list(maxiter=500)
        summ_test=summary(fit_logistic_test)
    if(as.vector(summ_test)[2]!="try-error"){
            fit_logistic= suppressWarnings(nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=subset(above15, above15$num_id==id),
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start))) #, control=list(maxiter=500)
            summ=summary(fit_logistic)
            predictions=as.data.frame(predict(fit_logistic))
            AIC= AIC(fit_logistic)
            BIC=BIC(fit_logistic)
            dataframe= data.frame(ID=id, r_max_start=r_max_start, N_0_start= N_0_start, N_max_start= N_max_start, residuals=summ$residuals, predictions=predictions$predict, AIC= AIC, BIC=BIC)
            log_fit=rbind(log_fit, dataframe)}}}

log_fit_below=data.frame()
for (id in unique(below15$num_id)){
set.seed(1234)
r_max_range= runif(100, min=0, max=start_below15$r_max_start +1)
    N_0_range= rnorm(100, mean=start_below15$N_0_start[start_below15$num_id==id], sd=1)
    N_max_range= rnorm(100, mean=start_below15$N_max_start[start_below15$num_id==id], sd=1)
for (i in 1:100){
        r_max_start = sample(r_max_range,1)
        N_0_start = sample(N_0_range,1)
        N_max_start = sample(N_max_range,1)
        fit_logistic_test = try(nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=subset(below15, below15$num_id==id),
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start), control=list(maxiter=500)),silent=TRUE)
        summ_test=summary(fit_logistic_test)
    if(as.vector(summ_test)[2]!="try-error"){
            fit_logistic= nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=subset(below15, below15$num_id==id),
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start), control= list(maxiter=500))
            summ=summary(fit_logistic)
            predictions=as.data.frame(predict(fit_logistic))
            AIC= AIC(fit_logistic)
            BIC=BIC(fit_logistic)
            dataframe= data.frame(ID=id, r_max_start=r_max_start, N_0_start= N_0_start, N_max_start= N_max_start, residuals=summ$residuals, predictions=predictions$predict, AIC= AIC, BIC=BIC)
            log_fit_below=rbind(log_fit_below, dataframe)}}}

##export fit data as csv files
write.csv(fit_quad, '../Results/Quadfit.csv', row.names=TRUE)
write.csv(fit_quad_below, '../Results/Quadfitbelow.csv', row.names=TRUE)
write.csv(fit_cub, '../Results/Cubfit.csv', row.names=TRUE)
write.csv(fit_cub_below, '../Results/Cubfitbelow.csv', row.names=TRUE)
write.csv(log_fit, '../Results/Logfit.csv', row.names=TRUE)
write.csv(log_fit_below, '../Results/Logfitbelow.csv', row.names=TRUE)
