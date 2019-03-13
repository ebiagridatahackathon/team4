# Hackathon:  Initiating Linked Public Datasets for Agriculture and Food

This document describes the work of team 4 :
+ Monika Solanki (Agrimetrics)
+ Marc Rossello (EBI)
+ Aravind Venkatesan (EBI)
+ Bastiaan Brak (AHDB)
+ Jan Taubert (KWS)

## What was our challenge?
+ Measure the yield of a variety under different drought conditions
+ Given the Field explorer datasets and the RL trial data for 2013-2017, can we detect varietal differences to the summer drought?

## Which data did we use?
+ Agrimetrics field APIs
+ RL Trial data: Varietal Yld + Trial location

## Which methods did we use?
+ Calculate a measure of drought over relevant time range that varieties experienced for a given trial and location. We looked at the CEH Drought portal, using the 1-month and 3-month SPI. https://eip.ceh.ac.uk/apps/droughts/ 
+ Relate Yld to this measure of drought and see if varieties respond differently (simple scatter diagram)
+ R package for calculation Standardized Precipitation-Evapotranspiration Index (SPEI)and the Standardized Precipitation Index (SPE). As proxy for drought index. (https://rdrr.io/cran/SPEI/man/SPEI-package.html)


