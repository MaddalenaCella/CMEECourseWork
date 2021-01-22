#!/bin/env R

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: Tempoverall.R
#
# Description: script that performs model fitting on a global dataset and checks for an effect of temperature on growth
#
# Arguments: 0
#
# Input: Rscript Tempoverall.R
#
# Output: a barplot Mod_bars_overall.pdf in ../Results subdirectory
#
# Date: January 2021

rm(list=ls())
options(warn=-1) #to suppress tidyverse warning summarise()
#population growth dataset
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(minpack.lm))
suppressPackageStartupMessages(library(tidyverse))
library(dplyr, warn.conflicts = FALSE)

# Suppress summarise info
options(dplyr.summarise.inform = FALSE)


#import tidy dasets
above15<- read.csv("../Data/tidy_above15.csv") 
below15<- read.csv("../Data/tidy_below15.csv")

#merge the two datasets
total_sub<- rbind(above15, below15)

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

quad_fit= data.frame()
for (id in unique(total_sub$num_id)){
    lm_quadratic= lm(PopBio ~ poly(Time,2), data=subset(total_sub, total_sub$num_id==id))
    summ=summary(lm_quadratic)
    #predictions=as.data.frame(predict(fit_logistic))
    AIC= AIC(lm_quadratic)
    BIC=BIC(lm_quadratic)
    dataframe= data.frame(ID=id, AIC= AIC, BIC=BIC, T=total_sub$Temp[total_sub$num_id==id], S=total_sub$Medium[total_sub$num_id==id], SP=total_sub$Species[total_sub$num_id==id])
    quad_fit=rbind(quad_fit, dataframe)}

cub_fit= data.frame()
for (id in unique(total_sub$num_id)){
    lm_cubic= lm(PopBio ~ poly(Time,3), data=subset(total_sub, total_sub$num_id==id))
    summ=summary(lm_cubic)
    #predictions=as.data.frame(predict(fit_logistic))
    AIC= AIC(lm_cubic)
    BIC=BIC(lm_cubic)
    dataframe= data.frame(ID=id, AIC= AIC, BIC=BIC, T=total_sub$Temp[total_sub$num_id==id],S=total_sub$Medium[total_sub$num_id==id], SP=total_sub$Species[total_sub$num_id==id])
    cub_fit=rbind(cub_fit, dataframe)}

start_total <- suppressWarnings(get_starting_parameters(total_sub))

#fit logistic model to the data and retiurns a dataframe with AIC, BIC, predicted values and resiuduals
log_fit=data.frame()
for (id in unique(total_sub$num_id)){
set.seed(1234)
r_max_range= runif(100, min=0, max=start_total$r_max_start +1)
    N_0_range= rnorm(100, mean=start_total$N_0_start[start_total$num_id==id], sd=1)
    N_max_range= rnorm(100, mean=start_total$N_max_start[start_total$num_id==id], sd=1)
for (i in 1:100){
        r_max_start = sample(r_max_range,1)
        N_0_start = sample(N_0_range,1)
        N_max_start = sample(N_max_range,1)
        fit_logistic_test = suppressWarnings(try(nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=subset(total_sub, total_sub$num_id==id),
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start)),silent=TRUE)) #, control=list(maxiter=500)
        summ_test=summary(fit_logistic_test)
    if(as.vector(summ_test)[2]!="try-error"){
            fit_logistic= suppressWarnings(nlsLM(formula=PopBio ~ logistic_model(t=Time, r_max, N_max, N_0),data=subset(total_sub, total_sub$num_id==id),
                      start=list(r_max= r_max_start, N_0 = N_0_start, N_max = N_max_start))) #, control=list(maxiter=500)
            summ=summary(fit_logistic)
            #predictions=as.data.frame(predict(fit_logistic))
            AIC= AIC(fit_logistic)
            BIC=BIC(fit_logistic)
            dataframe= data.frame(ID=id, r_max_start=r_max_start, N_0_start= N_0_start, N_max_start= N_max_start, AIC= AIC, BIC=BIC, T=total_sub$Temp[total_sub$num_id==id], S=total_sub$Medium[total_sub$num_id==id], SP=total_sub$Species[total_sub$num_id==id])
            log_fit=rbind(log_fit, dataframe)}}}

log_fit$ID<- as.factor(log_fit$ID)
log_fit$T<-as.numeric(log_fit$T)
log_fit$AIC<-as.numeric(log_fit$AIC)
log_fit_summ<- log_fit %>% dplyr::group_by(ID) %>%
dplyr::summarise(ID= ID[1],
         T= T[1],
          S= S[1],
          SP= SP[1],
         AIC= AIC[1],
         BIC= BIC[1])
#log_fit_summ

quad_fit$T<-as.numeric(quad_fit$T)
quad_fit$AIC<-as.numeric(quad_fit$AIC)
quad_fit_summ<- quad_fit %>% dplyr::group_by(ID) %>%
dplyr::summarise(ID= ID[1],
         T= T[1],
          S= S[1],
          SP=SP[1],
         AIC= AIC[1],
         BIC= BIC[1])

cub_fit$T<-as.numeric(cub_fit$T)
cub_fit$AIC<-as.numeric(cub_fit$AIC)
cub_fit_summ<- cub_fit %>% dplyr::group_by(ID) %>%
dplyr::summarise(ID= ID[1],
         T= T[1],
          S= S[1],
          SP=SP[1],
         AIC= AIC[1],
         BIC= BIC[1])

#add row of NA with ID=87
new.row<- data.frame(ID=87, stringsAsFactors=F)
df <-rbind.fill(log_fit_summ, new.row)

id_AIC <- data.frame()
for (id in unique(quad_fit_summ$ID)){
    AIC_Q <- quad_fit_summ$AIC[quad_fit_summ$ID==id]
    AIC_C <- cub_fit_summ$AIC[cub_fit_summ$ID==id]
    AIC_L <- df$AIC[df$ID==id]
    T<- quad_fit_summ$T[quad_fit_summ$ID==id]
    M<- quad_fit_summ$S[quad_fit_summ$ID==id]
    #SP<- quad_fit_summ$S[quad_fit_summ$ID==id]
    dataframe= data.frame(ID=id, T=T, M=M, AIC_Q=AIC_Q, AIC_C=AIC_C, AIC_L=AIC_L)#, weights=weights)#,AIC_G=AIC_G)
    id_AIC=rbind(id_AIC, dataframe)
}

new_AIC <- id_AIC %>% dplyr::group_by(ID) %>%
dplyr::summarise(min= min(AIC_C, AIC_Q, AIC_L, na.rm=TRUE)) #AIC_G,

merged_AIC <- merge(new_AIC, id_AIC, by="ID")

best_AIC= data.frame()
for(id in 1:length(unique(merged_AIC$ID))){
    if (isTRUE(merged_AIC$min[merged_AIC$ID==id]== merged_AIC$AIC_L[merged_AIC$ID==id])){
        best="Logistic"}
    else if(isTRUE(merged_AIC$min[merged_AIC$ID==id]== merged_AIC$AIC_C[merged_AIC$ID==id])){
        best="Cubic"}
    else if(isTRUE(merged_AIC$min[merged_AIC$ID==id]== merged_AIC$AIC_Q[merged_AIC$ID==id])){
        best="Quadratic"}

        dataframe=data.frame(ID=id, best= best)
        best_AIC= rbind(best_AIC, dataframe)
}


new_AIC <- merge(merged_AIC, best_AIC, by.x="ID")

#calculate akaike weights of models
aic.weights <- data.frame()
for (id in unique(new_AIC$ID)){
    all.aic<-c(new_AIC$AIC_Q[new_AIC$ID==id], new_AIC$AIC_L[new_AIC$ID==id], new_AIC$AIC_C[new_AIC$ID==id])
    delAIC<- all.aic-min(all.aic)
    reLik <- exp(-0.5*delAIC)
    aicweight <- reLik/sum(reLik)
    dataframe<- data.frame(ID=id, aicweight_Q= aicweight[1], aic_weight_L=aicweight[2], aic_weight_C=aicweight[3])
    aic.weights <- rbind(aic.weights, dataframe)
}

new_AIC<- merge(new_AIC, aic.weights, by.x='ID')

##barplot with proportion of growt curves for which each of the odels had a better fit
l<-length(new_AIC$best[new_AIC$best=="Logistic"])/length(new_AIC$best)*100
c<-length(new_AIC$best[new_AIC$best=="Cubic"])/length(new_AIC$best)*100
q<-length(new_AIC$best[new_AIC$best=="Quadratic"])/length(new_AIC$best)*100

plot_df<- data.frame(Data= c('Data','Data','Data'),
    Model= c('Logistic','Cubic','Quadratic'),
                     percentage_best=c(l,c,q))

pdf(file='../Results/Mod_bars_overall.pdf', width=7, height=7) 
q <- ggplot(data=plot_df, aes(x=Model, y=percentage_best))+
xlab('Model fitted')+ ylab('Best model(%)')+
geom_bar(stat='identity', fill='gray', color='black', width=0.6)+
geom_text(aes(label=round(percentage_best)), vjust=-0.5, size=4, position=position_dodge(0.5))+
theme_bw()+
theme(aspect.ratio=1)+
#scale_fill_brewer(palette='')+
scale_alpha(range=c(0.3,0.4))
q
invisible(dev.off())

##look if there is a correlation between T and model fit for the three models
#medium added as additional factor
corrWT_log <- summary(lm(aic_weight_L ~ T + M, data=new_AIC))

corrWT_cub <- summary(lm(aic_weight_C ~ T + M, data=new_AIC))

corrWT_quad<- summary(lm(aicweight_Q ~ T + M, data=new_AIC))


