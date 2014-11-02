
library("data.table")
library("ggplot2")
# read filename
args <- commandArgs(trailingOnly = TRUE)
file <- args[1]
file
# create a summary: Size, Type, Mean, Error  
dt <- data.table(read.csv(file))
setkey(dt, Size, Type)
results = dt[,.(mean=mean(Time), sd=sd(Time), n=NROW(Time)), by="Size,Type"]
summary = data.frame(results[,.(Size, Type, mean, error = qnorm(0.975)*sd/sqrt(n))])
# plot
ggplot(summary, aes(x=Size, y=mean, colour=Type)) + 
    geom_errorbar(aes(ymin=mean-error, ymax=mean+error), width=.1) +
    geom_line() +
    geom_point() +
    scale_y_continuous(name="Time (s)") +
    scale_x_continuous(name="Array size")
