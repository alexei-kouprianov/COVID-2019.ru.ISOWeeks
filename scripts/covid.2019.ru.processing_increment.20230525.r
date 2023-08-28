# ###############################################################
# Loading and trimming increment;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20230525.r")

ISOweek.data.raw <- fromJSON(file="../downloads/stopcoronavirus.storage.moment.20230525.json")

ISOweek.data.region_string <- NULL
ISOweek.regional.increment.CRDH <- NULL

for(i in 1:regions.count){
	ISOweek.data.region_string <- cbind.data.frame(
		ISOweek.data.raw[[i]]$title,
		ISOweek.data.raw[[i]]$sick_incr,
		ISOweek.data.raw[[i]]$healed_incr,
		ISOweek.data.raw[[i]]$died_incr,
		ISOweek.data.raw[[i]]$hospitalized
		)
	names(ISOweek.data.region_string) <- c("title", "sick_incr", "healed_incr", "died_incr", "hospitalized")
	ISOweek.regional.increment.CRDH <- rbind.data.frame(ISOweek.regional.increment.CRDH, ISOweek.data.region_string)
	}

# Reorder regions in ISOweek.regional.increment.CRDH
ISOweek.regional.increment.CRDH <- ISOweek.regional.increment.CRDH[order(as.character(ISOweek.regional.increment.CRDH$title)), ]

ISOweek.regional.increment.CRDH <- cbind.data.frame(ISOweek.loci, ISOweek.regional.increment.CRDH)
ISOweek.regional.increment.CRDH$LOCUS.0 <- as.character(ISOweek.regional.increment.CRDH$LOCUS.0)
ISOweek.regional.increment.CRDH$LOCUS <- as.character(ISOweek.regional.increment.CRDH$LOCUS)
ISOweek.regional.increment.CRDH$POPULATION <- ISOweek.population$POPULATION.20230101.total

# Loading and trimming timestamp;
# This section loads timestamp and results in text vector of length 1 reporting.REPORT_TIMESTAMP;

reporting.REPORT_TIMESTAMP <- read.table("../downloads/stopcoronavirus.timestamp.moment.20230525.txt", h = FALSE, stringsAsFactors = FALSE)
reporting.REPORT_TIMESTAMP <- as.character(strptime(reporting.REPORT_TIMESTAMP$V1, format = "%d.%m.%Y %H:%M:%S"))

# Calculating reporting TIME;
# This section results in text vector of length 1 reporting.TIME.new;

reporting.TIME.last <- tail(covid.2019.ru.ISOweeks.ls[[1]]$TIME, 1)
reporting.TIME.new <- as.character(strptime(reporting.TIME.last, format = "%Y-%m-%d %H:%M:%S") + 60*60*24*7)

# Integrating increment: preparation;
# This section makes final preparations for integrating increment into covid.2019.ru.ISOweeks.ls;

ISOweek.regional.increment.CRDH$LOCUS <- factor(ISOweek.regional.increment.CRDH$LOCUS, levels = covid.2019.ru.ISOweeks.ls.names)

ISOweek.regional.increment.CRDH.s <- ISOweek.regional.increment.CRDH[order(ISOweek.regional.increment.CRDH$LOCUS), ]
