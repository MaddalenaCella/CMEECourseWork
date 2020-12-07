#!/bin/env Rscript

# Author: Maddalena Cella mc2820@ic.ac.uk
# Script: PP_Regress.R
# Description: script that draws and saves a multi-panel figure as pdf, containing subplots of regressions of predator mass on prey mass for the different types of feeding interaction.
# it additionally saves a csv file with the results of the regression analyses
# Input: Rscript PP_Regress.R
# Output: 1 plot (PP_Regress.pdf) in Results directory and a csv file (PP_Regress_Results.csv) in Results directory
# Arguments:0
# Date: October 2020

rm(list=ls())

library(dplyr)
library(ggplot2)

Ed <- read.csv("../Data/EcolArchives-E089-51-D1.csv", header=T)

#initialize multi-paneled plot
xscale <- 1e-7
for (i in 1:2){
    xscale[i+1]<- xscale[1]*(1e4)^i} #scale for x axis based on graph
yscale<- 1e-6
for (i in 1:3){
    yscale[i+1]<-yscale[1]*(1e4)^i} #scale for y axis based on graph

pdf("../Results/PP_Regress.pdf", 13, 11)
ggplot(data= Ed, aes(x = Prey.mass, y = Predator.mass, colour= Predator.lifestage)) +  
geom_point(shape = I(3))+
geom_smooth(method="lm", formula= y~ x, se= TRUE, fullrange=TRUE, size= 0.4)+ #get Warining messages here
facet_grid(Type.of.feeding.interaction ~ ., scales = "free")+
xlab("Prey mass in grams") + ylab("Predator mass in grams")+
scale_x_continuous(trans= "log10", breaks= xscale)+ #transform axis in log scale with breaks defined above (xscale)
scale_y_continuous(trans= "log10", breaks= yscale)+ #transform axis in log scale with breaks defined above (yscale)
theme_bw()+
theme(strip.text=element_text(size=11), #text size of the facet
    legend.position="bottom", 
    legend.direction="horizontal")+
guides(colour=guide_legend(nrow=1)) #this puts all the legend items in one line

dev.off()

#All that you are being asked for here is results of an analysis of Linear regression on subsets of the data corresponding to available Feeding Type ×Predator life Stage combination — not a multivariate linear model with these two as separate covariates!
#The regression results should include the following with appropriate headers (e.g., slope, intercept, etc, in each Feeding type ×
#×life stage category): regression slope, regression intercept, R2
#F-statistic value, and p-value of the overall regression (Hint: Review the Stats week!
#group_by and summarise 

#create subsets of the data by feeding types
MyDF.I <- subset(Ed, Type.of.feeding.interaction=='insectivorous')
MyDF.P <- subset(Ed, Type.of.feeding.interaction=='piscivorous')
MyDF.PL <- subset(Ed, Type.of.feeding.interaction=='planktivorous')
MyDF.PR <- subset(Ed, Type.of.feeding.interaction=='predacious')
MyDF.PP <- subset(Ed, Type.of.feeding.interaction=='predacious/piscivorous')

#function that extracts coefficients, R2, f and p-values
fun1<-function(x){
  res<-c(x$coefficients[1],
         x$coefficients[2],
         summary(x)$r.squared,
         summary(x)$fstatistic,
         pf(summary(x)$fstatistic[1], summary(x)$fstatistic[2], 
         summary(x)$fstatistic[3], lower.tail=FALSE)) #pf calcultes p-value from prob distr
    names(res)<-c("intercept","slope","r.squared",
                "F-statistic","df", "dist", "p-value")
    res.df <- data.frame(res)
  return(res.df)}   

##MyDF.I
counter <- 0
for ( i in unique(MyDF.I$Predator.lifestage) ){
  #create a subset data 
  data_sub <- subset(MyDF.I, Predator.lifestage == i)
  
  counter <- counter + 1
  #create the linear model. If it is the first loop,
  #then the model name will be lm_ins1
  j <- assign(paste("lm_I",counter,sep = ""), lm(Prey.mass ~ Predator.mass, data_sub))

  #show many lms created
  assign(paste("lm_I", counter, sep = ""), fun1(j))
}
##MyDF.P
counter <- 0
for ( i in unique(MyDF.P$Predator.lifestage) ){
  #create a subset data 
  data_sub <- subset(MyDF.P, Predator.lifestage == i)
  
  counter <- counter + 1
  #create the linear model. If it is the first loop,
  #then the model name will be lm_ins1
  j <- assign(paste("lm_P",counter,sep = ""), lm(Prey.mass ~ Predator.mass, data_sub))

  #show many lms created
  assign(paste("lm_P", counter, sep = ""), fun1(j))
}
##MyDF.PL
counter <- 0
for ( i in unique(MyDF.PL$Predator.lifestage) ){
  #create a subset data 
  data_sub <- subset(MyDF.PL, Predator.lifestage == i)
  
  counter <- counter + 1
  #create the linear model. If it is the first loop,
  #then the model name will be lm_ins1
  j <- assign(paste("lm_PL",counter,sep = ""), lm(Prey.mass ~ Predator.mass, data_sub))

  #show many lms created
  assign(paste("lm_PL", counter, sep = ""), fun1(j))
}
##MyDF.PR
counter <- 0
for ( i in unique(MyDF.PR$Predator.lifestage) ){
  #create a subset data 
  data_sub <- subset(MyDF.PR, Predator.lifestage == i)
  
  counter <- counter + 1
  #create the linear model. If it is the first loop,
  #then the model name will be lm_ins1
  j <- assign(paste("lm_PR",counter,sep = ""), lm(Prey.mass ~ Predator.mass, data_sub))

  #show many lms created
  assign(paste("lm_PR", counter, sep = ""), fun1(j))
}
##MyDF.PP
counter <- 0
for ( i in unique(MyDF.PP$Predator.lifestage) ){
  #create a subset data 
  data_sub <- subset(MyDF.PP, Predator.lifestage == i)
  
  counter <- counter + 1
  #create the linear model. If it is the first loop,
  #then the model name will be lm_ins1
  j <- assign(paste("lm_PP",counter,sep = ""), lm(Prey.mass ~ Predator.mass, data_sub))

  #show many lms created
  
  assign(paste("lm_PP", counter, sep = ""), fun1(j))
}

# bind by columns
resh <- cbind(lm_I1, lm_P1, lm_P2, lm_P3, lm_P4, lm_P5, lm_PL1, lm_PL2, lm_PL4,
             lm_PL5, lm_PR1, lm_PR2, lm_PR3, lm_PR4, lm_PR5, lm_PR6, lm_PP1)
# name the columns
colnames(resh)<- c("lm_I1", "lm_P1", "lm_P2", "lm_P3", "lm_P4", "lm_P5", "lm_PL1", "lm_PL2", "lm_PL4",
             "lm_PL5", "lm_PR1", "lm_PR2", "lm_PR3", "lm_PR4", "lm_PR5", "lm_PR6", "lm_PP1")
final <- data.frame(t(resh))[,-c(5:6)] #transpose the results so that the regression outputs are the columns and the models are the rows, remove df and variance column

#write csv with Summary in it
write.csv(final, "../Results/PP_Regress_Results.csv")



