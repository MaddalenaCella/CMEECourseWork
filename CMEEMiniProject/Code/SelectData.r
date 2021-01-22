#!/bin/env R

# Author: Maddalena Cella (mc2820@ic.ac.uk)
#
# Script: SelectData.R
#
# Description: script that analyses the performances of the three models fitted to the data
#
# Arguments: 0
#
# Input: Rscript SelectData.R
#
# Output: a barplot Mod_bars.pdf in ../Results subdirectory
#
# Date: January 2021

rm(list=ls())
options(warn=-1) #to suppress tidyverse warning summarise() ##doesn't work
##packages
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(tidyverse))
library(dplyr, warn.conflicts = FALSE)

# Suppress summarise info
options(dplyr.summarise.inform = FALSE)


##Imports
quad_fit<-read.csv('../Results/Quadfit.csv')
quad_fit_below<-read.csv('../Results/Quadfitbelow.csv')
cub_fit<-read.csv('../Results/Cubfit.csv')
cub_fit_below<-read.csv('../Results/Cubfitbelow.csv')
log_fit<-read.csv('../Results/Logfit.csv')
log_fit_below<-read.csv('../Results/Logfitbelow.csv')

#rename num_id column to ID
quad_fit$ID <-quad_fit$num_id
quad_fit_below$ID <- quad_fit_below$num_id
cub_fit$ID <- quad_fit$num_id
cub_fit_below$ID <- cub_fit_below$num_id

## create dataframe to store AICs of each model (quadratic, logistic and cubic)
id_AIC <- data.frame()
for (id in unique(quad_fit$ID)){
    AIC_Q <- quad_fit$AIC[quad_fit$ID==id]
    AIC_C <- cub_fit$AIC[cub_fit$ID==id]
    AIC_L <- log_fit$AIC[log_fit$ID==id][1]
    ##weights=akaike.weights(AIC_Q, AIC_C, AIC_L)
    dataframe= data.frame(ID=id, AIC_Q=AIC_Q, AIC_C=AIC_C, AIC_L=AIC_L)#, weights=weights)#,AIC_G=AIC_G)
    id_AIC=rbind(id_AIC, dataframe)
}

#create dataset with the lowest AIC value out of the three
new_AIC <- id_AIC %>% dplyr::group_by(ID) %>%
dplyr::summarise(min= min(AIC_C, AIC_Q, AIC_L, na.rm=TRUE)) #
#new_AIC
#id_AIC

#merge old dataset with minimum dataset
merged_AIC <- merge(new_AIC, id_AIC, by.x ="ID")

#additional column with name of the best model for a particular dataset
best_AIC= data.frame()
for(id in unique(merged_AIC$ID)){
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

new_AIC<- new_AIC %>% mutate(model_n=as.integer(factor(best, levels=unique(best))))

##now for the below_15 dataset

id_AIC_below <- data.frame()
for (id in unique(quad_fit_below$ID)){
    AIC_Q <- quad_fit_below$AIC[quad_fit_below$ID==id]
    AIC_C <- cub_fit_below$AIC[cub_fit_below$ID==id]
    AIC_L <- log_fit_below$AIC[log_fit_below$ID==id][1]
    #AIC_G <- gomp_fit_below$AIC[gomp_fit_below$ID==id][1]
    dataframe= data.frame(ID=id, AIC_Q=AIC_Q, AIC_C=AIC_C, AIC_L=AIC_L) #, AIC_G=AIC_G)
    id_AIC_below=rbind(id_AIC_below, dataframe)
}

new_AIC_below <- id_AIC_below %>% group_by(ID) %>%
dplyr::summarise(min= min(AIC_C, AIC_Q, AIC_L, na.rm=TRUE)) #AIC_G,

merged_AIC_below <- merge(id_AIC_below, new_AIC_below, by.x="ID")

best_AIC_below= data.frame()
for(id in 1:length(unique(merged_AIC_below$ID))){
   if (isTRUE(merged_AIC_below$min[merged_AIC_below$ID==id]== merged_AIC_below$AIC_L[merged_AIC_below$ID==id])){
        best="Logistic"}
    else if(isTRUE(merged_AIC_below$min[merged_AIC_below$ID==id]== merged_AIC_below$AIC_C[merged_AIC_below$ID==id])){
        best="Cubic"}
    else if(isTRUE(merged_AIC_below$min[merged_AIC_below$ID==id]== merged_AIC_below$AIC_Q[merged_AIC_below$ID==id])){
        best="Quadratic"}

        dataframe=data.frame(ID=id, best= best)
        best_AIC_below= rbind(best_AIC_below, dataframe)
}


new_AIC_below <- merge(merged_AIC_below, best_AIC_below, by.x="ID")

new_AIC_below<- new_AIC_below %>% mutate(model_n=as.integer(factor(best, levels=unique(best))))

## create barplots with the percentage of curves that had a better fit with logistic, quadratic or cubic model

#above dataset
l<-length(new_AIC$best[new_AIC$best=="Logistic"])/length(new_AIC$best)*100
c<-length(new_AIC$best[new_AIC$best=="Cubic"])/length(new_AIC$best)*100
q<-length(new_AIC$best[new_AIC$best=="Quadratic"])/length(new_AIC$best)*100

#below dataset
lb<-length(new_AIC_below$best[new_AIC_below$best=="Logistic"])/length(new_AIC_below$best)*100
cb<-length(new_AIC_below$best[new_AIC_below$best=="Cubic"])/length(new_AIC_below$best)*100
qb<-length(new_AIC_below$best[new_AIC_below$best=="Quadratic"])/length(new_AIC_below$best)*100

#comprehensive dataset for plotting 
plot_df<- data.frame(Subset= c('Above15','Above15','Above15','Below15','Below15','Below15'),
     Model= c('Logistic','Cubic','Quadratic','Logistic','Cubic','Quadratic'),
                      percentage_best=c(l,c,q,lb,cb,qb))
# save plot as pdf
pdf(file='../Results/Mod_bars.pdf', width=7, height=7) 

p <- ggplot(data=plot_df, aes(x=Model, y=percentage_best, fill=Subset))+
xlab('Model fitted')+ ylab('Best model(%)')+
geom_bar(stat='identity', color='black', width=0.6, position=position_dodge())+
geom_text(aes(label=round(percentage_best)), vjust=-0.5, size=4, position=position_dodge(0.5))+
theme_bw()+
theme(aspect.ratio=1)+
scale_fill_brewer(palette='Pastel1')+
scale_alpha(range=c(0.3,0.4))
p
invisible(dev.off())
 


