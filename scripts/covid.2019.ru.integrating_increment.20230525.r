# ###############################################################
# Integrating increment;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20230525.r")
# source("covid.2019.ru.processing_increment.20230525.r")

# This section integrates increment into covid.2019.ru.ISOweeks.ls;

regional.increment <- NULL
regional.increment.names <- c("TIME", "REPORT_TIMESTAMP", "CONFIRMED", "RECOVERED", "DEATHS", "HOSPITALISED")

for(i in 1:regions.count){
	regional.increment <- cbind.data.frame(reporting.TIME.new,
		reporting.REPORT_TIMESTAMP,
		ISOweek.regional.increment.CRDH.s[i, 4:7]
		)
		names(regional.increment) <- regional.increment.names
	covid.2019.ru.ISOweeks.ls[[i]] <- rbind.data.frame(covid.2019.ru.ISOweeks.ls[[i]], regional.increment)
	}

# Saving XLSX backup file;

write.xlsx(covid.2019.ru.ISOweeks.ls,
	file = "../data/xlsx/data.ISOweeks.xlsx",
	sheetName = covid.2019.ru.ISOweeks.ls.names,
	rowNames = FALSE)
