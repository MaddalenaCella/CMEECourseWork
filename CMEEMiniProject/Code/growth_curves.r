#!/bin/env R

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: growth_curves.R
#
# Description: script that plots growth curves and displays fit of models for a subset of species
#
# Arguments: 0
#
# Input: Rscript growth_curves.R
#
# Output: plots in the form of .pdf files in ../Results subdirectory
#
# Date: January 2021

rm(list=ls())

#required packages
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(patchwork))
suppressPackageStartupMessages(library(minpack.lm))
library(dplyr, warn.conflicts = FALSE)

# Suppress summarise info
options(dplyr.summarise.inform = FALSE)

## import tidied datasets
above15<- read.csv("../Data/tidy_above15.csv") 
below15<- read.csv("../Data/tidy_below15.csv")

## look at the growth curves of three random species grown at different temperatures
Tt_3 <- subset(above15, above15$num_id==3)
Tt_1 <- subset(below15, below15$num_id==1)
Ag_a<-subset(above15, above15$num_id==111) 
Ag_b<-subset(below15, below15$num_id==110) 
Lp_a <- subset(above15, above15$num_id==147)
Lp_b <- subset(below15, below15$num_id==144)

#create pdf file with growth curves 
pdf(file='../Results/Comp_curves.pdf', width=10, height=7)
a <- ggplot(Tt_3, aes(x=Time, y=LogN))+
geom_point(size=2, colour='red', shape=4)+
labs(x='Time(hours)', y='Log(number of cells)')+
theme_bw()

b <- ggplot(Tt_1, aes(x=Time, y=LogN))+
geom_point(size=2, colour='blue', shape=4)+
labs(x='Time(hours)', y='Log(number of cells)')+
theme_bw()

c <- ggplot(Ag_a, aes(x=Time, y=LogN))+
geom_point(size=2, colour='red', shape=4)+
labs(x='Time(hours)', y='Log(CFU)')+
theme_bw()

d <- ggplot(Ag_b, aes(x=Time, y=LogN))+
geom_point(size=2, colour='blue', shape=4)+
labs(x='Time(hours)', y='Log(CFU)')+
theme_bw()

e <- ggplot(Lp_a, aes(x=Time, y=LogN))+
geom_point(size=2, colour='red', shape=4)+
labs(x='Time(hours)', y='Log(number of cells)')+
theme_bw()

f <- ggplot(Lp_b, aes(x=Time, y=LogN))+
geom_point(size=2, colour='blue', shape=4)+
labs(x='Time(hours)', y='Log(number of cells)')+
theme_bw()

(a+b) / (c+d) / (e+f)
invisible(dev.off())

###functions###

fit_logistic_model <- function(data_set, starting_parameters){
log_model_out=data.frame()
set.seed(1234)
r_max_range= runif(100, min=0, max=starting_parameters$r_max_start +1)
N_0_range= rnorm(100, mean=starting_parameters$N_0_start, sd=1)
N_max_range= rnorm(100, mean=starting_parameters$N_max_start, sd=1)
for (i in 1:100){
        r_max_start = sample(r_max_range,1)
        N_0_start = sample(N_0_range,1)
        N_max_start = sample(N_max_range,1)
        fit_logistic_test = suppressWarnings(try(nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=data_set,
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start)),silent=TRUE))
        summ_test=summary(fit_logistic_test)
    if(as.vector(summ_test)[2]!="try-error"){
            fit_logistic= suppressWarnings(nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=data_set,
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start)))
log_model_out=fit_logistic}}
return(log_model_out)  
}

get_starting_parameters_b <- function(data_set){
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

##function to fit the logistic model
logistic_model <- function(t, r_max, N_max, N_0){ # The classic logistic equation
  return(N_0 * N_max * exp(r_max * t)/(N_max + N_0 * (exp(r_max * t) - 1)))
}

##model fitting to first subset
#quadratic
fit_a<- lm(PopBio ~ poly(Time,2), data=Tt_3) #AIC:1209
fit_b <- lm(PopBio ~ poly(Time,2), data=Tt_1)#AIC:959

Tt_3$predicted <- log(abs(predict(fit_a)))
Tt_1$predicted <- log(abs(predict(fit_b)))

#cubic
fit_c<- lm(PopBio ~ poly(Time,3), data=Tt_3) #AIC= 1194
fit_d <- lm(PopBio ~ poly(Time,3), data=Tt_1) #AIC=948

Tt_3$predictedc <- log(abs(predict(fit_c)))
Tt_1$predictedc <- log(abs(predict(fit_d)))

#logistic
start_3<-get_starting_parameters_b(Tt_3)
start_1<-get_starting_parameters_b(Tt_1)

log_model_3<- fit_logistic_model(Tt_3, start_3)#AIC
#coef(log_model_3)
log_model_1<- fit_logistic_model(Tt_1, start_1)
#coef(log_model_1)

#logistic points for plotting: model above 15
timepoints <- seq(from=min(Tt_3$Time), to=max(Tt_3$Time), length.out=max(Tt_3$Time))

logistic_points <- log(logistic_model(t = timepoints, 
          r_max = coef(log_model_3)["r_max"], 
          N_max = coef(log_model_3)["N_max"], 
          N_0 = coef(log_model_3)["N_0"]))

df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic model"
names(df1) <- c("Time", "LogN", "model")

#logistic points to plot:model below 15
timepoints <- seq(from=min(Tt_1$Time), to=max(Tt_1$Time), length.out=max(Tt_3$Time))

logistic_points <- log(abs(logistic_model(t = timepoints, 
          r_max = coef(log_model_1)["r_max"], 
          N_max = coef(log_model_1)["N_max"], 
          N_0 = coef(log_model_1)["N_0"])))

df2 <- data.frame(timepoints, logistic_points)
df2$model <- "Logistic model"
names(df2) <- c("Time", "LogN", "model")

#model fitting the second subset Ag_b

start_Aa<-get_starting_parameters_b(Ag_a)
start_Ab<-get_starting_parameters_b(Ag_b)

#quadratic
fit_Aa<- lm(PopBio ~ poly(Time,2), data=Ag_a)
fit_Ab <- lm(PopBio ~ poly(Time,2), data=Ag_b)

#cubic
fit_Aa_c<- lm(PopBio ~ poly(Time,3), data=Ag_a)
fit_Ab_c <- lm(PopBio ~ poly(Time,3), data=Ag_b)

#logistic
log_model_Aa<-fit_logistic_model(Ag_a, start_Aa)

log_model_Ab <- fit_logistic_model(Ag_b, start_Ab)

#logistic points for plotting: model above 15
timepoints <- seq(from=min(Ag_a$Time), to=max(Ag_a$Time), length.out=max(Ag_a$Time))

logistic_points <- log(logistic_model(t = timepoints, 
          r_max = coef(log_model_Aa)["r_max"], 
          N_max = coef(log_model_Aa)["N_max"], 
          N_0 = coef(log_model_Aa)["N_0"]))

df3 <- data.frame(timepoints, logistic_points)
df3$model <- "Logistic model"
names(df3) <- c("Time", "LogN", "model")

#logistic points to plot:model below 15
timepoints <- seq(from=min(Ag_b$Time), to=max(Ag_b$Time), length.out=max(Ag_b$Time))

logistic_points <- log(abs(logistic_model(t = timepoints, 
          r_max = coef(log_model_Ab)["r_max"], 
          N_max = coef(log_model_Ab)["N_max"], 
          N_0 = coef(log_model_Ab)["N_0"])))

df4 <- data.frame(timepoints, logistic_points)
df4$model <- "Logistic model"
names(df4) <- c("Time", "LogN", "model")

#fitting the third subset
# Lp_b

start_La<-get_starting_parameters_b(Lp_a)
start_Lb<-get_starting_parameters_b(Lp_b)

#quadratic
fit_La<- lm(PopBio ~ poly(Time,2), data=Lp_a)
fit_Lb <- lm(PopBio ~ poly(Time,2), data=Lp_b)

#cubic
fit_La_c<- lm(PopBio ~ poly(Time,3), data=Lp_a)
fit_Lb_c <- lm(PopBio ~ poly(Time,3), data=Lp_b)

#logistic
log_model_La<-fit_logistic_model(Lp_a, start_La)
log_model_Lb <- fit_logistic_model(Lp_b, start_Lb)

#logistic points for plotting: model above 15
timepoints <- seq(from=min(Lp_a$Time), to=max(Lp_a$Time), length.out=max(Lp_a$Time))

logistic_points <- log(logistic_model(t = timepoints, 
          r_max = coef(log_model_La)["r_max"], 
          N_max = coef(log_model_La)["N_max"], 
          N_0 = coef(log_model_La)["N_0"]))

df5 <- data.frame(timepoints, logistic_points)
df5$model <- "Logistic model"
names(df5) <- c("Time", "LogN", "model")

#logistic points to plot:model below 15
timepoints <- seq(from=min(Lp_b$Time), to=max(Lp_b$Time), length.out=max(Lp_b$Time))

logistic_points <- log(abs(logistic_model(t = timepoints, 
          r_max = coef(log_model_Lb)["r_max"], 
          N_max = coef(log_model_Lb)["N_max"], 
          N_0 = coef(log_model_Lb)["N_0"])))

df6 <- data.frame(timepoints, logistic_points)
df6$model <- "Logistic model"
names(df6) <- c("Time", "LogN", "model")

# coef(log_model_La)
# coef(log_model_Lb)

#combined graphs
##from:visualing residuals drsimonj.svbtle.com
pdf(file='../Results/Comp_graphs.pdf', width=10, height=7)
a <- ggplot(Tt_3, aes(x=Time, y=LogN))+
stat_smooth(method='lm', formula= y~poly(x,2), se=FALSE, color='lightpink')+
stat_smooth(method='lm', formula= y~poly(x,3), se=FALSE, color='lightblue')+
geom_line(data = df1, aes(x = Time, y = LogN), size = 1, color='green4',alpha=0.7)+
geom_point(size=1, colour='red', shape=4, alpha=0.5)+
theme_bw()+
labs(x='Time(hours)', y='Log(number of cells)')

b <- ggplot(Tt_1, aes(x=Time, y=LogN))+
stat_smooth(method='lm', formula= y~poly(x,2), se=FALSE, aes(color='lightpink'))+
stat_smooth(method='lm', formula= y~poly(x,3), se=FALSE, aes(color='lightblue'))+
geom_line(data = df2, aes(x = Time, y = LogN, col='green4'), size = 1, alpha=0.7)+
scale_color_identity(name='Model fitted',
                     breaks=c('lightpink','lightblue','green4'),
                    labels=c('Quadratic', 'Cubic','Logistic'),
                     guide='legend')+
geom_point(size=1, colour='blue', shape=4, alpha=0.5)+
theme_bw()+
labs(x='Time(hours)', y='Log(number of cells)')


##from:visualing residuals drsimonj.svbtle.com
c <- ggplot(Ag_a, aes(x=Time, y=LogN))+
stat_smooth(method='lm', formula= y~poly(x,2), se=FALSE, color='lightpink')+
stat_smooth(method='lm', formula= y~poly(x,3), se=FALSE, color='lightblue')+
geom_line(data = df3, aes(x = Time, y = LogN), size = 1, color='green4', alpha=0.7)+
geom_point(size=1, colour='red', shape=4, alpha=0.5)+
theme_bw()+
labs(x='Time(hours)', y='Log(CFU)')

d <- ggplot(Ag_b, aes(x=Time, y=LogN))+
stat_smooth(method='lm', formula= y~poly(x,2), se=FALSE, aes(color='lightpink'))+
stat_smooth(method='lm', formula= y~poly(x,3), se=FALSE, aes(color='lightblue'))+
geom_line(data = df4, aes(x = Time, y = LogN, col='green4'), size = 1, alpha=0.7)+
scale_color_identity(name='Model fitted',
                     breaks=c('lightpink','lightblue','green4'),
                    labels=c('Quadratic', 'Cubic','Logistic'),
                     guide='legend')+
geom_point(size=1, colour='blue', shape=4, alpha=0.5)+
theme_bw()+
labs(x='Time(hours)', y='Log(CFU)')

##from:visualing residuals drsimonj.svbtle.com
e <- ggplot(Lp_a, aes(x=Time, y=LogN))+
stat_smooth(method='lm', formula= y~poly(x,2), se=FALSE, color='lightpink')+
stat_smooth(method='lm', formula= y~poly(x,3), se=FALSE, color='lightblue')+
geom_line(data = df5, aes(x = Time, y = LogN), size = 1, color='green4', alpha=0.7)+
geom_point(size=1, colour='red', shape=4, alpha=0.5)+
theme_bw()+
labs(x='Time(hours)', y='Log(Number of cells)')

f <- ggplot(Lp_b, aes(x=Time, y=LogN))+
stat_smooth(method='lm', formula= y~poly(x,2), se=FALSE, aes(color='lightpink'))+
stat_smooth(method='lm', formula= y~poly(x,3), se=FALSE, aes(color='lightblue'))+
geom_line(data = df6, aes(x = Time, y = LogN, col='green4'), size = 1, alpha=0.7)+
scale_color_identity(name='Model fitted',
                     breaks=c('lightpink','lightblue','green4'),
                    labels=c('Quadratic', 'Cubic','Logistic'),
                     guide='legend')+
geom_point(size=1, colour='blue', shape=4, alpha=0.5)+
theme_bw()+
labs(x='Time(hours)', y='Log(Number of cells)')

(a+b)/(c+d)/(e+f)
invisible(dev.off())
