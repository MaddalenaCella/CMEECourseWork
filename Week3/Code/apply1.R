## Build a random matrix
M <- matrix(rnorm(100), 10, 10) #rnorm() draw 100 random numbers
#and store them in a 10x10 matrix

## Take the mean of each row
RowMeans <- apply(M, 1, mean) #calculate the mean of each row (1)
print (RowMeans)

## Now the variance
RowVars <- apply(M, 1, var)
print (RowVars)

## By column (2)
ColMeans <- apply(M, 2, mean)
print (ColMeans)