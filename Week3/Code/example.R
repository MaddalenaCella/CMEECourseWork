#R code

a <- 4
a

a * a
a_squared <- a * a

sqrt(a_squared)

v <- c(0, 1, 2, 3, 4)
v

is.vector(v)

mean(v)

var(v)
median(v)
sum(v)
prod(v+1)
length(v)

wing.width.cm <- 1.2 #Using dot notation
wing.length.cm <- c(4.7, 5.2, 4.8)

x <- (1 + (2 * 3))

v <- TRUE
v
class(v)

v <- 3.2
class(v)

v <- 2L
class(v)

v <- "A string"
class(v)

b <- class()
class(b)

is.na(b)

b <- 0/0
b

is.nan(b)

b <- 5/0
b

is.nan(b)

b <- 5/1E4
b
