#which linear model--> quadratic or cubic--> look this up

t <- seq(0, 22, 2) #sequence from 0 to 22 by 2
N <- c(32500, 33000, 38000, 105000, 445000, 1430000, 3020000, 4720000, 5670000, 5870000, 5930000, 5940000)

set.seed(700) # set seed to ensure you always get the same random sequence (initial value 1234)  

data <- data.frame(t, N + rnorm(length(time),sd=.01)) # add some random error, rnorm() simulates random variates with a normal distribution

names(data) <- c("Time", "N")

head(data)

#plot this data
ggplot(data, aes(x = Time, y = N)) + 
    geom_point(size = 3) +
    labs(x = "Time (Hours)", y = "Population size (cells)")

#in exponential growth at a constant rate, the growth rate can be simply 
#calculated as the difference in the log of two population sizes, over time. 
#We will log-transform the data and estimate by eye where growth looks exponential.
data$LogN <- log(data$N)

# visualise
ggplot(data, aes(x = t, y = LogN)) + 
    geom_point(size = 3) +
    labs(x = "Time (Hours)", y = "log(cell number)")

#By eye the logged data looks fairly linear between hours 4 and 10, so we’ll use 
#that time-period to calculate the growth rate.

(data[data$Time == 10,]$LogN - data[data$Time == 4,]$LogN)/(10-4)

#o account for some error in measurement, we shouldn’t really take the data points directly, 
#but fit a linear model through them instead, where the slope gives our growth rate.

lm_growth <- lm(LogN ~ Time, data = data[data$Time > 2 & data$Time < 12,])
summary(lm_growth)


##fitting a non-linear model to the data
logistic_model <- function(t, r_max, N_max, N_0){ # The classic logistic equation
  return(N_0 * N_max * exp(r_max * t)/(N_max + N_0 * (exp(r_max * t) - 1)))
}

# first we need some starting parameters for the model
N_0_start <- min(data$N) # lowest population size
N_max_start <- max(data$N) # highest population size
r_max_start <- 0.62 # use our linear estimate from before

fit_logistic <- nlsLM(N ~ logistic_model(t = Time, r_max, N_max, N_0), data,
                      list(r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))

summary(fit_logistic)

# plot it:
timepoints <- seq(0, 22, 0.1)

logistic_points <- logistic_model(t = timepoints, r_max = coef(fit_logistic)["r_max"], N_max = coef(fit_logistic)["N_max"], N_0 = coef(fit_logistic)["N_0"])
df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic equation"
names(df1) <- c("Time", "N", "model")

ggplot(data, aes(x = Time, y = N)) +
  geom_point(size = 3) +
  geom_line(data = df1, aes(x = Time, y = N, col = model), size = 1) +
  theme(aspect.ratio=1)+ # make the plot square 
  labs(x = "Time", y = "Cell number")

#What would this function look like on a log-transformed axis?
ggplot(data, aes(x = Time, y = LogN)) +
  geom_point(size = 3) +
  geom_line(data = df1, aes(x = Time, y = log(N), col = model), size = 1) +
  theme(aspect.ratio=1)+ 
  labs(x = "Time", y = "log(Cell number)")

#now will fit the four growth models. First let’s specify the function objects for the additional there models:
gompertz_model <- function(t, r_max, N_max, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
    return(log(N_max / N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/log(N_max / N_0) + 1)))
}

gompertz_model2 <- function(t, r_max, N_max, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(log(N_0) + (log(N_max) - log(N_0)) * exp(-exp(r_max * exp(1) * (t_lag - t)/((log(N_max) - log(N_0)) * log(10)) + 1)))
}

#i love you <3

baranyi_model <- function(t, r_max, N_max, N_0, t_lag){  # Baranyi model (Baranyi 1993)
   return(N_max + log10((-1+exp(r_max*t_lag) + exp(r_max*t))/(exp(r_max*t) - 1 + exp(r_max*t_lag) * 10^(N_max-N_0))))
 }

buchanan_model <- function(t, r_max, N_max, N_0, t_lag){ # Buchanan model - three phase logistic (Buchanan 1997)
   return(N_0 + (t >= t_lag) * (t <= (t_lag + (N_max - N_0) * log(10)/r_max)) * r_max * (t - t_lag)/log(10) + (t >= t_lag) * (t > (t_lag + (N_max - N_0) * log(10)/r_max)) * (N_max - N_0))
 }

N_0_start <- min(data$N)
N_max_start <- max(data$N)
t_lag_start <- data$Time[which.max(diff(diff(data$LogN)))]
r_max_start <- max(diff(data$LogN))/mean(diff(data$Time))

fit_logistic <- nlsLM(N ~ logistic_model(t = Time, r_max, N_max, N_0), data,
                      list(r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))

fit_gompertz <- nlsLM(LogN ~ gompertz_model2(t = Time, r_max, N_max, N_0, t_lag), data,
                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))

#this one gives me problems
fit_baranyi <- nlsLM(LogN ~ baranyi_model(t = Time, r_max, N_max, N_0, t_lag), data,
               list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))

#this one gives problems as well
fit_buchanan <- nlsLM(LogN ~ buchanan_model(t = Time, r_max, N_max, N_0, t_lag), data,
                list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))

summary(fit_logistic)
summary(fit_baranyi)
summary(fit_buchanan)
summary(fit_gompertz)

timepoints <- seq(0, 24, 0.1)

logistic_points <- logistic_model(t = timepoints, r_max = coef(fit_logistic)["r_max"], N_max = coef(fit_logistic)["N_max"], N_0 = coef(fit_logistic)["N_0"])

baranyi_points <- baranyi_model(t = timepoints, r_max = coef(fit_baranyi)["r_max"], N_max = coef(fit_baranyi)["N_max"], N_0 = coef(fit_baranyi)["N_0"], t_lag = coef(fit_baranyi)["t_lag"])

buchanan_points <- buchanan_model(t = timepoints, r_max = coef(fit_buchanan)["r_max"], N_max = coef(fit_buchanan)["N_max"], N_0 = coef(fit_buchanan)["N_0"], t_lag = coef(fit_buchanan)["t_lag"])

gompertz_points <- gompertz_model(t = timepoints, r_max = coef(fit_gompertz)["r_max"], N_max = coef(fit_gompertz)["N_max"], N_0 = coef(fit_gompertz)["N_0"], t_lag = coef(fit_gompertz)["t_lag"])

df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic"
names(df1) <- c("t", "LogN", "model")

df2 <- data.frame(timepoints, baranyi_points)
df2$model <- "Baranyi"
names(df2) <- c("t", "LogN", "model")

df3 <- data.frame(timepoints, buchanan_points)
df3$model <- "Buchanan"
names(df3) <- c("t", "LogN", "model")

df4 <- data.frame(timepoints, gompertz_points)
df4$model <- "Gompertz"
names(df4) <- c("t", "LogN", "model")

#see the difference between Gompertz and Logistic
model_frame <- rbind(df1,df4)

ggplot(data, aes(x = t, y = LogN)) +
  geom_point(size = 3) +
  geom_line(data = model_frame, aes(x = t, y = LogN, col = model), size = 1) +
    theme_bw() + # make the background white
    theme(aspect.ratio=1)+ # make the plot square 
    labs(x = "Time", y = "log(Abundance)")

#which one is the best model??
head(data)
RSS_Log <- sum(residuals(fit_logistic)^2)  # Residual sum of squares
TSS_Log <- sum((data$N - mean(data$N))^2)  # Total sum of squares #should i use logN or not
RSq_Log <- 1 - (RSS_Log/TSS_Log)  # R-squared value

RSS_Gom <- sum(residuals(fit_gompertz)^2)  # Residual sum of squares
TSS_Gom <- sum((data$N - mean(data$N))^2)  # Total sum of squares
RSq_Gom <- 1 - (RSS_Gom/TSS_Gom)  # R-squared value

RSq_Log 
RSq_Gom

n <- nrow(data) #set sample size
pLog <- length(coef(fit_logistic)) # get number of parameters in power law model
pGom <- length(coef(fit_gompertz)) # get number of parameters in quadratic model

AIC_Log <- n + 2 + n * log((2 * pi) / n) +  n * log(RSS_Log) + 2 * pLog
AIC_Gom <- n + 2 + n * log((2 * pi) / n) + n * log(RSS_Gom) + 2 * pGom
AIC_Log - AIC_Gom

AIC(fit_logistic) - AIC(fit_gompertz)
BIC(fit_logistic) - BIC(fit_gompertz)