## library
library(ggplot2)

## input
oo<-read.csv("../Data/EcolArchives-E089-51-D1.csv", header = T)
for(i in 1:dim(oo)[1]){
  if(as.character(oo[i,14])=="mg"){
#    oo[i,9]<-oo[i,9]/1000
    oo[i,13]<-oo[i,13]/1000
    oo[i,14]<-"g"
  }
};rm(i)


## data info collect
oo.0<-as.data.frame(matrix(nrow = length(unique(oo$Type.of.feeding.interaction))*length(unique(oo$Predator.lifestage)), ncol = 7))
colnames(oo.0)<-c("FeedingType", "LifeStageCategory", "slopeLinear", "interceptLinear","R2", "F-statistics", "p-val")
a.0<-levels(oo$Type.of.feeding.interaction)
a.1<-0;for(i in 1:length(a.0)){a.1<-c(a.1,rep(a.0[i],length(levels(oo$Predator.lifestage))))};a.1<-a.1[-1]
oo.0[,1]<-as.factor(a.1);oo.0[,2]<-as.factor(levels(oo$Predator.lifestage))
rm(i,a.0,a.1)
for(i in 1:dim(oo.0)[1]){
  oo.1<-length(oo$Predator.mass[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i] & oo$Predator.lifestage==oo.0$LifeStageCategory[i])])
  if(oo.1>0){
    print(paste("Usable results:",oo.0[i,1],";",oo.0[i,2]))
    oo.1<-oo[which(oo$Type.of.feeding.interaction==oo.0$FeedingType[i] & oo$Predator.lifestage==oo.0$LifeStageCategory[i]),]
    oo.2<-summary(lm(log(oo.1$Predator.mass)~log(oo.1$Prey.mass)))
    if(dim(oo.2$coefficients)[1]<2){
      oo.0[i,3]<-oo.0[i,6]<-oo.0[i,7]<-NA
    }else{
      oo.0[i,3]<-oo.2$coefficients[2,1] ##slopeLinear
      oo.0[i,6]<-unname(oo.2$fstatistic)[1] ## F-statistics
      oo.0[i,7]<-oo.2$coefficients[2,4] ## p-val

    }
    oo.0[i,4]<-oo.2$coefficients[1,1] ## interceptLinear
    oo.0[i,5]<-oo.2$adj.r.squared ## R2
  }
};oo.0<-oo.0[which(is.na(oo.0[,3])!=T),]
write.csv(oo.0,"../Results/PP_Regress_Res.csv",row.names = F, quote = F)