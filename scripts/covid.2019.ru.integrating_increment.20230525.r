# ###############################################################
# Integrating increment;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20231031.r")
# source("covid.2019.ru.processing_increment.20231031.r")

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

# If fork double checks for increment integration mistakes;

if(tail(covid.2019.ru.ISOweeks.ls[[1]]$TIME, 2)[1] !=
    tail(covid.2019.ru.ISOweeks.ls[[1]]$TIME, 2)[2]){
        if(tail(covid.2019.ru.ISOweeks.ls[[1]]$REPORT_TIMESTAMP, 2)[1] !=
        tail(covid.2019.ru.ISOweeks.ls[[1]]$REPORT_TIMESTAMP, 2)[2]){

            # Saving XLSX backup file;

			write.xlsx(covid.2019.ru.ISOweeks.ls,
				file = "../data/xlsx/data.ISOweeks.xlsx",
				sheetName = covid.2019.ru.ISOweeks.ls.names,
				colWidths = "auto",
				firstRow = TRUE,
				firstCol = TRUE,
				rowNames = FALSE)

            } else{print("Fatal error: two last instances of REPORT_TIMESTAMP identical!")}
        } else{print("Fatal error: two last instances of TIME identical!")}
