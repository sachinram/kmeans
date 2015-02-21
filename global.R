#load the required packages
library("YaleToolkit")

#function to return the numerical variables of the dataframe
numericNames <- function(data) {
  vec <- as.character(subset(whatis(data), type == "numeric")$variable.name)
  if (length(vec) == 0) vec <- ""
  
  return(vec)
}

#function to return the categorical varibles of the dataframe
categoricNames <- function(data) {
  vec <- as.character(subset(whatis(data), type != "numeric")$variable.name)
  if (length(vec) == 0) vec <- ""
  
  return(vec)
}

#function to print first quantile value
q1 <- function(x) { return(quantile(x, .25, na.rm = TRUE)) }

#function to print thrid quantile value
q3 <- function(x) { return(quantile(x, .75, na.rm = TRUE)) }

#function to return the summary of the dataframe includes min, first quantile, mean, median, sd, third quantile and max
my.summary <- function(data) {
  min.val <- sapply(as.data.frame(data), function(col) {
    if (is.numeric(type.convert(as.character(col)))) as.numeric(min(col, na.rm = TRUE)) else NA
  })
  q1.val <- sapply(as.data.frame(data), function(col) {
    if (is.numeric(type.convert(as.character(col)))) as.numeric(q1(col)) else NA
  })
  mean.val <-suppressWarnings(sapply(as.data.frame(data), mean, na.rm=TRUE))
  median.val <- sapply(as.data.frame(data), function(col) {
    if (is.numeric(type.convert(as.character(col)))) as.numeric(median(col, na.rm = TRUE)) else NA
  })
  sd.val <- sapply(as.data.frame(data), function(col) {
    if (is.numeric(type.convert(as.character(col)))) as.numeric(sd(col, na.rm = TRUE)) else NA
  })
  q3.val <- sapply(as.data.frame(data), function(col) {
    if (is.numeric(type.convert(as.character(col)))) as.numeric(q3(col)) else NA
  })
  max.val <- sapply(as.data.frame(data), function(col) {
    if (is.numeric(type.convert(as.character(col)))) as.numeric(max(col, na.rm = TRUE)) else NA
  })
  
  return(data.frame(min = min.val, q1 = q1.val, mean = mean.val, median = median.val, sd = sd.val, q3 = q3.val, max = max.val))
}
