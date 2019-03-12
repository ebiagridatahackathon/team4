#!/usr/bin/env Rscript

# parse command line argument and construct paths for input and output data
args = commandArgs(trailingOnly=TRUE)
filename <- paste0(args[1],".csv", collapse = NULL)
lat <- as.double(args[2])
path_weather_data <- paste0("weather_data", "/", filename, collapse = NULL)
path_output_data <- paste0("output", "/", filename, collapse = NULL)
path_output_jpeg <- paste0("output", "/", args[1],".jpg", collapse = NULL)
path_output_avg <- paste0("output", "/", args[1], "_avg.csv", collapse = NULL)

# library needs to be installed
library(SPEI)
# load monthly weather data for 2009 to 2017 for current location
envdata <- read.table(header = TRUE, sep = ",", path_weather_data)
attach(envdata)
names(envdata)

# simple med temp based model
envdata$PET <- thornthwaite(envdata$TMED, lat)
# calculate SPEI for 1 month sliding
spei1 <- spei(envdata$PRCP-envdata$PET,1)

# write SPEI calculated values
write.csv(spei1$fitted, file = path_output_data, row.names=FALSE)
# plot SPEI values as graph, x axis is years, y axis is -2 (dry) to 2 (wet)
jpeg(path_output_jpeg)
plot(spei1, main=args[1])
dev.off()

# hardcoded sliding 3 months window (May, June, July)
means <- c(
       mean(c(spei1$fitted[5],spei1$fitted[6],spei1$fitted[7])), 
       mean(c(spei1$fitted[17],spei1$fitted[18],spei1$fitted[19])),
       mean(c(spei1$fitted[29],spei1$fitted[30],spei1$fitted[31])),
       mean(c(spei1$fitted[41],spei1$fitted[42],spei1$fitted[43])),
       mean(c(spei1$fitted[53],spei1$fitted[54],spei1$fitted[55])),
       mean(c(spei1$fitted[65],spei1$fitted[66],spei1$fitted[67])),
       mean(c(spei1$fitted[77],spei1$fitted[78],spei1$fitted[79])),
       mean(c(spei1$fitted[89],spei1$fitted[90],spei1$fitted[91])),
       mean(c(spei1$fitted[101],spei1$fitted[102],spei1$fitted[103]))
      )
# hardcoded years of weather data from Field Explorer
names <- c(
	paste0(args[1], ",2009", collapse = NULL),
	paste0(args[1], ",2010", collapse = NULL),
	paste0(args[1], ",2011", collapse = NULL),
	paste0(args[1], ",2012", collapse = NULL),
	paste0(args[1], ",2013", collapse = NULL),
	paste0(args[1], ",2014", collapse = NULL),
	paste0(args[1], ",2015", collapse = NULL),
	paste0(args[1], ",2016", collapse = NULL),
	paste0(args[1], ",2017", collapse = NULL)
      )

# write 3 months average per year
write.table(means, file = path_output_avg, col.names = FALSE, sep = ",", row.names = names, quote = FALSE)
