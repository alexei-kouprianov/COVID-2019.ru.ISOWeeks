# ###############################################################
# Loading and trimming increment;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20231031.r")

ISOweek.regional.increment.CRDH <- read.table("../data/post_2023-10-31/post_2023-10-31.regions.txt", h = FALSE, sep = "\t", stringsAsFactors=FALSE)

colnames(ISOweek.regional.increment.CRDH) <- c("title", "hospitalized", "healed_incr", "sick_incr", "died_incr")
ISOweek.regional.increment.CRDH <- ISOweek.regional.increment.CRDH[, c(1, 4, 3, 5, 2)]

# Reorder regions in ISOweek.regional.increment.CRDH
ISOweek.regional.increment.CRDH <- ISOweek.regional.increment.CRDH[order(as.character(ISOweek.regional.increment.CRDH$title)), ]

ISOweek.regional.increment.CRDH <- cbind.data.frame(ISOweek.loci, ISOweek.regional.increment.CRDH)
ISOweek.regional.increment.CRDH$LOCUS.0 <- as.character(ISOweek.regional.increment.CRDH$LOCUS.0)
ISOweek.regional.increment.CRDH$LOCUS <- as.character(ISOweek.regional.increment.CRDH$LOCUS)
ISOweek.regional.increment.CRDH$POPULATION <- ISOweek.population$POPULATION.20230101.total

# Loading and trimming timestamp was transferred to covid.2019.ru.loading_data_and_misc.20230525.r;

# Calculating reporting TIME;
# This section results in text vector of length 1 reporting.TIME.new;

reporting.TIME.last <- tail(covid.2019.ru.ISOweeks.ls[[1]]$TIME, 1)
reporting.TIME.new <- as.character(strptime(reporting.TIME.last, format = "%Y-%m-%d %H:%M:%S") + 60*60*24*7)

# Integrating increment: preparation;
# This section makes final preparations for integrating increment into covid.2019.ru.ISOweeks.ls;

ISOweek.regional.increment.CRDH$LOCUS <- factor(ISOweek.regional.increment.CRDH$LOCUS, levels = covid.2019.ru.ISOweeks.ls.names)

ISOweek.regional.increment.CRDH.s <- ISOweek.regional.increment.CRDH[order(ISOweek.regional.increment.CRDH$LOCUS), ]
