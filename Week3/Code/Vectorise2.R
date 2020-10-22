# This script contains two functions (one vectorised and one not) and aims to compare their runtime. 
# Both functions give the expected number (or density) Nt+1 of individuals in generation 
# t+1 as a function of the number of individuals in the previous generation t when stochasticity is added
#
# ARGUMENTS
# None
#
# INPUT
# None
#
# OUTPUT
# time it takes for the non-vectorised and vectorised functions stochrick and stockrickvect to run

rm(list=ls())

stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)){#loop through the populations: for every pop in row 1
    
    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr,pop] <- N[yr-1,pop] * exp(r * (1 - N[yr - 1,pop] / K) + rnorm(1,0,sigma))
    
    }
  
  }
 return(N)

}

print("Stochastic Ricker takes:")
print(system.time(res1<-stochrick()))

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

stochrickvect<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100) #runif() generates random deviates from a min of .5 to a max of 1.5
{
  #initialize
  N<-matrix(NA,numyears,length(p0)) #length() returns object number inside
  N[1,]<- vector(,length(p0)) #preallocate the pop sizes at time 0 that are generated randomly
  
    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr,] <- N[yr-1,] * exp(r * (1 - N[yr - 1,] / K) + rnorm(1,0,sigma)) #leaving a blank automatically loops through all the populations
    }
 return(N)
}

print("Vectorised Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))