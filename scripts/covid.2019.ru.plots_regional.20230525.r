# ###############################################################
# Plots infographics;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20230525.r")
# source("covid.2019.ru.processing_increment.20230525.r")
# source("covid.2019.ru.integrating_increment.20230525.r") # Do not run when restoring environment with no new data downloaded;
# source("covid.2019.ru.transforming_data.20230525.r")
# source("covid.2019.ru.plots.20230525.r") # Important : prepares drawing constants used in the present script too;

# ###############################################################
# Rebuilding directory tree;
# ###############################################################

dir.create("../plots/regions/", recursive = TRUE)
dir.create("../plots/regions/overview_log10/", recursive = TRUE)
dir.create("../plots/regions/confirmed/", recursive = TRUE)
dir.create("../plots/regions/hospitalized/", recursive = TRUE)
dir.create("../plots/regions/deaths/", recursive = TRUE)

# ###############################################################
# Summary plots / regional level;
# ###############################################################

for(i in 1:regions.count){
	png(file = paste0("../plots/regions/overview_log10/COVID-19.CHD.",
			gsub(" ", "_", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
			".log.png"),
		width = 1618, height = 1000, res = 120, pointsize = 14)

	par(mar = c(6, 4, 2, 2)+.1)

	plot(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		log10(covid.2019.ru.ISOweeks.plotting.ls[[i]]$CONFIRMED + 1),
		type = "n",
		main = gsub("annex.", "[annex.]", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
		xlab = "",
		ylab = "Cases per week, log scale",
		axes = FALSE
		)
	rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -2, ytop = 10, col = "#EEEEEE", border = "#EEEEEE")
	points(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		log10(covid.2019.ru.ISOweeks.plotting.ls[[i]]$CONFIRMED + 1),
		type = "h",
		col = colorBlind7[1],
		lwd = h.plotline_width
		)
	points(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		log10(covid.2019.ru.ISOweeks.plotting.ls[[i]]$HOSPITALISED + 1),
		type = "h",
		col = colorBlind7[3],
		lwd = h.plotline_width
		)
	points(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		log10(covid.2019.ru.ISOweeks.plotting.ls[[i]]$DEATHS + 1),
		type = "h",
		col = 1,
		lwd = h.plotline_width
		)

	axis(2, at = 0:6, labels = c(1, 10, 100, "1K", "10K", "100K", "1M"))
	axis.POSIXct(1,
		at = timeticks.quarters,
		format = "%Y-%m-%d",
		las = 2)
	axis.POSIXct(1,
		at = timeticks.months,
		labels = FALSE,
		tcl = -.25)

	dev.off()
	}

for(i in 1:regions.count){
	png(file = paste0("../plots/regions/confirmed/COVID-19.CONFIRMED.",
			gsub(" ", "_", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
			".log.png"),
		width = 1618, height = 1000, res = 120, pointsize = 14)

	par(mar = c(6, 4, 2, 2)+.1)

	plot(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		covid.2019.ru.ISOweeks.plotting.ls[[i]]$CONFIRMED,
		type = "n",
		main = gsub("annex.", "[annex.]", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
		xlab = "",
		ylab = "COVID-19 cases per week",
		axes = FALSE
		)
	rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -1E+05, ytop = 2E+06, col = "#EEEEEE", border = "#EEEEEE")
	points(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		covid.2019.ru.ISOweeks.plotting.ls[[i]]$CONFIRMED,
		type = "h",
		col = colorBlind7[1],
		lwd = h.plotline_width
		)

	axis(2)

	axis.POSIXct(1,
		at = timeticks.quarters,
		format = "%Y-%m-%d",
		las = 2)
	axis.POSIXct(1,
		at = timeticks.months,
		labels = FALSE,
		tcl = -.25)

	dev.off()
	}

for(i in 1:regions.count){
	png(file = paste0("../plots/regions/hospitalized/COVID-19.HOSPITALISED.",
			gsub(" ", "_", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
			".log.png"),
		width = 1618, height = 1000, res = 120, pointsize = 14)

	par(mar = c(6, 4, 2, 2)+.1)

	plot(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		covid.2019.ru.ISOweeks.plotting.ls[[i]]$HOSPITALISED,
		ylim = c(0, max(covid.2019.ru.ISOweeks.plotting.ls[[i]]$HOSPITALISED, na.rm = TRUE)),
		type = "n",
		main = gsub("annex.", "[annex.]", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
		xlab = "",
		ylab = "COVID-19 hospitalizations per week",
		axes = FALSE
		)
	rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -1E+04, ytop = 2E+05, col = "#EEEEEE", border = "#EEEEEE")
	points(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		covid.2019.ru.ISOweeks.plotting.ls[[i]]$HOSPITALISED,
		type = "h",
		col = colorBlind7[3],
		lwd = h.plotline_width)

	axis(2)

	axis.POSIXct(1,
		at = timeticks.quarters,
		format = "%Y-%m-%d",
		las = 2)
	axis.POSIXct(1,
		at = timeticks.months,
		labels = FALSE,
		tcl = -.25)

	dev.off()
	}

for(i in 1:regions.count){
	png(file = paste0("../plots/regions/deaths/COVID-19.DEATHS.",
			gsub(" ", "_", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
			".log.png"),
		width = 1618, height = 1000, res = 120, pointsize = 14)
	par(mar = c(6, 4, 2, 2)+.1)

	plot(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		covid.2019.ru.ISOweeks.plotting.ls[[i]]$DEATHS,
		type = "n",
		main = gsub("annex.", "[annex.]", names(covid.2019.ru.ISOweeks.plotting.ls)[i]),
		xlab = "",
		ylab = "COVID-19 deaths per week",
		axes = FALSE
		)
	rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -1E+03, ytop = 2E+04, col = "#EEEEEE", border = "#EEEEEE")
	points(covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME,
		covid.2019.ru.ISOweeks.plotting.ls[[i]]$DEATHS,
		type = "h",
		col = 1,
		lwd = h.plotline_width)

	axis(2)

	axis.POSIXct(1,
		at = timeticks.quarters,
		format = "%Y-%m-%d",
		las = 2)
	axis.POSIXct(1,
		at = timeticks.months,
		labels = FALSE,
		tcl = -.25)

	dev.off()
	}
