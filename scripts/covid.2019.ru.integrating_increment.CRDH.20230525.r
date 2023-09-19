# ###############################################################
# Transforms data for reports and plotting;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20230525.r")
# source("covid.2019.ru.processing_increment.20230525.r")
# source("covid.2019.ru.integrating_increment.20230525.r") # Do not run when restoring environment with no new data downloaded;

ISOweek.regional.increment.CRDH.s$LOCUS.graph <- gsub("annex.", "[annex.]", ISOweek.regional.increment.CRDH.s$LOCUS)
ISOweek.regional.increment.CRDH$C.P100 <- ISOweek.regional.increment.CRDH$sick_incr/(ISOweek.regional.increment.CRDH$POPULATION/1E+05)
ISOweek.regional.increment.CRDH$H.P100 <- ISOweek.regional.increment.CRDH$hospitalized/(ISOweek.regional.increment.CRDH$POPULATION/1E+05)
