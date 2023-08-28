# ###############################################################
# Plots infographics;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20230525.r")
# source("covid.2019.ru.processing_increment.20230525.r")
# source("covid.2019.ru.integrating_increment.20230525.r") # Do not run when restoring environment with no new data downloaded;
# source("covid.2019.ru.transforming_data.20230525.r")

# ###############################################################
# Rebuilding directory tree;
# ###############################################################

dir.create("../plots/", recursive = TRUE)

# ###############################################################
# Preparing plotting constants;
# ###############################################################

h.plotline_width <- 2

colorBlind7  <- c(
	"#E69F00", # 1 : light orange
	"#56B4E9", # 2 : light blue
	"#009E73", # 3 : greenish blue
	"#F0E442", # 4 : pale yellow
	"#0072B2", # 5 : dark blue
	"#D55E00", # 6 : orange
	"#CC79A7", # 7 : purple
	"#EEEEEE" # 8 : light grey
	)

timeticks.quarters <- strptime(
	c("2020-01-01",
	"2020-03-31",
	"2020-06-30",
	"2020-09-30",
	"2020-12-31",
	"2021-03-31",
	"2021-06-30",
	"2021-09-30",
	"2021-12-31",
	"2022-03-31",
	"2022-06-30",
	"2022-09-30",
	"2022-12-31",
	"2023-03-31",
	"2023-06-30",
	"2023-09-30",
	"2023-12-31"
		),
	format = "%Y-%m-%d")

shadow_year.xleft <- as.numeric(timeticks.quarters[c(5, 13)])
shadow_year.xright <- as.numeric(timeticks.quarters[c(9, 17)])

timeticks.months <- strptime(
	c("2020-01-01",
	"2020-01-31",
	"2020-02-29",
	"2020-03-31",
	"2020-04-30",
	"2020-05-31",
	"2020-06-30",
	"2020-07-31",
	"2020-08-31",
	"2020-09-30",
	"2020-10-31",
	"2020-11-30",
	"2020-12-31",
	"2021-01-31",
	"2021-02-28",
	"2021-03-31",
	"2021-04-30",
	"2021-05-31",
	"2021-06-30",
	"2021-07-31",
	"2021-08-31",
	"2021-09-30",
	"2021-10-31",
	"2021-11-30",
	"2021-12-31",
	"2022-01-31",
	"2022-02-28",
	"2022-03-31",
	"2022-04-30",
	"2022-05-31",
	"2022-06-30",
	"2022-07-31",
	"2022-08-31",
	"2022-09-30",
	"2022-10-31",
	"2022-11-30",
	"2022-12-31",
	"2023-01-31",
	"2023-02-28",
	"2023-03-31",
	"2023-04-30",
	"2023-05-31",
	"2023-06-30",
	"2023-07-31",
	"2023-08-31",
	"2023-09-30",
	"2023-10-31",
	"2023-11-30",
	"2023-12-31"
		),
	format = "%Y-%m-%d")

# ###############################################################
# Summary plots / country level;
# ###############################################################

png("../plots/01.COVID-19.Russia.CHD.log.png", width = 1618, height = 1000, res = 120, pointsize = 14)
par(mar = c(6, 4, 2, 2)+.1)

plot(covid.2019.ru.ISOweeks.plotting.df$TIME,
	log10(covid.2019.ru.ISOweeks.plotting.df$CONFIRMED + 1),
	type = "n",
	main = "Russian Federation",
	xlab = "",
	ylab = "Cases per week, log scale",
	axes = FALSE
	)
rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -2, ytop = 10, col = "#EEEEEE", border = "#EEEEEE")
points(covid.2019.ru.ISOweeks.plotting.df$TIME,
	log10(covid.2019.ru.ISOweeks.plotting.df$CONFIRMED + 1),
	type = "h",
	col = colorBlind7[1],
	lwd = h.plotline_width
	)
points(covid.2019.ru.ISOweeks.plotting.df$TIME,
	log10(covid.2019.ru.ISOweeks.plotting.df$HOSPITALISED + 1),
	type = "h",
	col = colorBlind7[3],
	lwd = h.plotline_width
	)
points(covid.2019.ru.ISOweeks.plotting.df$TIME,
	log10(covid.2019.ru.ISOweeks.plotting.df$DEATHS + 1),
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

png("../plots/02.COVID-19.Russia.CONFIRMED.png", width = 1618, height = 1000, res = 120, pointsize = 14)
par(mar = c(6, 4, 2, 2)+.1)

plot(covid.2019.ru.ISOweeks.plotting.df$TIME,
	covid.2019.ru.ISOweeks.plotting.df$CONFIRMED,
	type = "n",
	main = "Russian Federation",
	xlab = "",
	ylab = "COVID-19 cases per week",
	axes = FALSE
	)
rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -1E+05, ytop = 2E+06, col = "#EEEEEE", border = "#EEEEEE")
points(covid.2019.ru.ISOweeks.plotting.df$TIME,
	covid.2019.ru.ISOweeks.plotting.df$CONFIRMED,
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

png("../plots/03.COVID-19.Russia.HOSPITALISED.png", width = 1618, height = 1000, res = 120, pointsize = 14)
par(mar = c(6, 4, 2, 2)+.1)

plot(covid.2019.ru.ISOweeks.plotting.df$TIME,
	covid.2019.ru.ISOweeks.plotting.df$HOSPITALISED,
	ylim = c(0, max(covid.2019.ru.ISOweeks.plotting.df$HOSPITALISED, na.rm = TRUE)),
	type = "n",
	main = "Russian Federation",
	xlab = "",
	ylab = "COVID-19 hospitalizations per week",
	axes = FALSE
	)
rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -1E+04, ytop = 2E+05, col = "#EEEEEE", border = "#EEEEEE")
points(covid.2019.ru.ISOweeks.plotting.df$TIME,
	covid.2019.ru.ISOweeks.plotting.df$HOSPITALISED,
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

png("../plots/04.COVID-19.Russia.DEATHS.png", width = 1618, height = 1000, res = 120, pointsize = 14)
par(mar = c(6, 4, 2, 2)+.1)

plot(covid.2019.ru.ISOweeks.plotting.df$TIME,
	covid.2019.ru.ISOweeks.plotting.df$DEATHS,
	type = "n",
	main = "Russian Federation",
	xlab = "",
	ylab = "COVID-19 deaths per week",
	axes = FALSE
	)
rect(xleft = shadow_year.xleft, xright = shadow_year.xright, ybottom = -1E+03, ytop = 2E+04, col = "#EEEEEE", border = "#EEEEEE")
points(covid.2019.ru.ISOweeks.plotting.df$TIME,
	covid.2019.ru.ISOweeks.plotting.df$DEATHS,
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

png("../plots/05.COVID-19.Russia.CONFIRMED_rating.png", width = 1000, height = 1618, res = 120, pointsize = 12)
par(mar = c(4, 10, 6, 2)+.1, cex.axis = .7)

barplot(sort(ISOweek.regional.increment.CRDH.s$sick_incr),
	horiz = TRUE,
	col = colorBlind7[1],
	names.arg = ISOweek.regional.increment.CRDH.s$LOCUS.graph[order(ISOweek.regional.increment.CRDH.s$sick_incr)],
	las = 2,
	main = "Russian Federation, COVID-19 cases per week",
	xlab = "",
	ylab = "",
	axes = FALSE
	)

axis(1, cex = 3)
axis(3, cex = 3)

dev.off()

png("../plots/06.COVID-19.Russia.CONFIRMED_100K_rating.png", width = 1000, height = 1618, res = 120, pointsize = 12)
par(mar = c(4, 10, 6, 2)+.1, cex.axis = .7)

barplot(sort(ISOweek.regional.increment.CRDH$C.P100),
	horiz = TRUE,
	col = colorBlind7[1],
	names.arg = ISOweek.regional.increment.CRDH.s$LOCUS.graph[order(ISOweek.regional.increment.CRDH$C.P100)],
	las = 2,
	main = "Russian Federation, COVID-19 cases per 100 K per week",
	xlab = "",
	ylab = "",
	axes = FALSE
	)

axis(1, cex = 3)
axis(3, cex = 3)

dev.off()

png("../plots/07.COVID-19.Russia.HOSPITALISED_rating.png", width = 1000, height = 1618, res = 120, pointsize = 12)
par(mar = c(4, 10, 6, 2)+.1, cex.axis = .7)

barplot(sort(ISOweek.regional.increment.CRDH.s$hospitalized),
	horiz = TRUE,
	col = colorBlind7[3],
	names.arg = ISOweek.regional.increment.CRDH.s$LOCUS.graph[order(ISOweek.regional.increment.CRDH.s$hospitalized)],
	las = 2,
	main = "Russian Federation, COVID-19 hospitalizaions per week",
	xlab = "",
	ylab = "",
	axes = FALSE
	)

axis(1, cex = 3)
axis(3, cex = 3)

dev.off()

png("../plots/08.COVID-19.Russia.HOSPITALISED_100K_rating.png", width = 1000, height = 1618, res = 120, pointsize = 12)
par(mar = c(4, 10, 6, 2)+.1, cex.axis = .7)

barplot(sort(ISOweek.regional.increment.CRDH$H.P100),
	horiz = TRUE,
	col = colorBlind7[3],
	names.arg = ISOweek.regional.increment.CRDH.s$LOCUS.graph[order(ISOweek.regional.increment.CRDH$H.P100)],
	las = 2,
	main = "Russian Federation, COVID-19 hospitalizaions per 100 K per week",
	xlab = "",
	ylab = "",
	axes = FALSE
	)

axis(1, cex = 3)
axis(3, cex = 3)

dev.off()
