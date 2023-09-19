# ###############################################################
# Transforms data for reports and plotting;
#
# Requires:
# source(covid.2019.ru.libraries.r)
# source("covid.2019.ru.loading_data_and_misc.20230525.r")
# source("covid.2019.ru.processing_increment.20230525.r")
# source("covid.2019.ru.integrating_increment.20230525.r") # Do not run when restoring environment with no new data downloaded;
# source("covid.2019.ru.integrating_increment.CRDH.20230525.r")

# "TIME" "REPORT_TIMESTAMP" "CONFIRMED" "RECOVERED" "DEATHS" "HOSPITALISED"

covid.2019.ru.ISOweeks.df <- covid.2019.ru.ISOweeks.ls[[1]]
for(i in 2:regions.count){
	covid.2019.ru.ISOweeks.df$CONFIRMED <- covid.2019.ru.ISOweeks.df$CONFIRMED + covid.2019.ru.ISOweeks.ls[[i]]$CONFIRMED
	covid.2019.ru.ISOweeks.df$RECOVERED <- covid.2019.ru.ISOweeks.df$RECOVERED + covid.2019.ru.ISOweeks.ls[[i]]$RECOVERED
	covid.2019.ru.ISOweeks.df$DEATHS <- covid.2019.ru.ISOweeks.df$DEATHS + covid.2019.ru.ISOweeks.ls[[i]]$DEATHS
	covid.2019.ru.ISOweeks.df$HOSPITALISED <- covid.2019.ru.ISOweeks.df$HOSPITALISED + covid.2019.ru.ISOweeks.ls[[i]]$HOSPITALISED
	}

# Deriving plotting objects;

covid.2019.ru.ISOweeks.plotting.ls <- covid.2019.ru.ISOweeks.ls

for(i in 1:regions.count){
	covid.2019.ru.ISOweeks.plotting.ls[[i]]$TIME <- strptime(covid.2019.ru.ISOweeks.ls[[i]]$TIME, format = "%Y-%m-%d %H:%M:%S")
	covid.2019.ru.ISOweeks.plotting.ls[[i]]$REPORT_TIMESTAMP <- strptime(covid.2019.ru.ISOweeks.ls[[i]]$REPORT_TIMESTAMP, format = "%Y-%m-%d %H:%M:%S")
	}

covid.2019.ru.ISOweeks.plotting.df <- covid.2019.ru.ISOweeks.df
covid.2019.ru.ISOweeks.plotting.df$TIME <- strptime(covid.2019.ru.ISOweeks.df$TIME, format = "%Y-%m-%d %H:%M:%S")
covid.2019.ru.ISOweeks.plotting.df$REPORT_TIMESTAMP <- strptime(covid.2019.ru.ISOweeks.df$REPORT_TIMESTAMP, format = "%Y-%m-%d %H:%M:%S")

# Calculating summary table and reporting variables;
# Results in .ISOweeks.top.txt, .ISOweeks.cumulated_CONFIRMED.txt, .ISOweeks.cumulated_DEATHS.txt

# Defining bad base;

.ISOweeks.bad_base <- median(ISOweek.regional.increment.CRDH$sick_incr *
	ISOweek.regional.increment.CRDH$hospitalized) +
	1.5 * IQR(ISOweek.regional.increment.CRDH$sick_incr *
		ISOweek.regional.increment.CRDH$hospitalized)

# Selecting the worst;

.ISOweeks.top <- subset(ISOweek.regional.increment.CRDH, 
	(ISOweek.regional.increment.CRDH$sick_incr *
	ISOweek.regional.increment.CRDH$hospitalized) > .ISOweeks.bad_base)[, c("title", "sick_incr", "hospitalized", "died_incr")]
.ISOweeks.top <- .ISOweeks.top[order(-.ISOweeks.top$sick_incr), ]
	.ISOweeks.top$title <- gsub("область", "обл.", .ISOweeks.top$title)
	.ISOweeks.top$title <- gsub("край", "кр.", .ISOweeks.top$title)
	.ISOweeks.top$title <- gsub("Республика ", "", .ISOweeks.top$title)
	.ISOweeks.top$title <- gsub(" республика", " респ.", .ISOweeks.top$title)
.ISOweeks.top$txt <- paste(
	.ISOweeks.top$title, "::",
	.ISOweeks.top$sick_incr, ":",
	.ISOweeks.top$hospitalized, ":",
	.ISOweeks.top$died_incr)

.ISOweeks.REPORT_TIMESTAMP <- reporting.REPORT_TIMESTAMP
.ISOweeks.WEEK_END <- gsub(" .*", "", reporting.TIME.new, perl = TRUE)

.ISOweeks.cumulated_CONFIRMED <- sum(covid.2019.ru.ISOweeks.plotting.df$CONFIRMED)
.ISOweeks.cumulated_DEATHS <- sum(covid.2019.ru.ISOweeks.plotting.df$DEATHS)

.ISOweeks.cumulated_DEATHS.txt <- gsub("(?=[0-9]{3}$)", ",", .ISOweeks.cumulated_DEATHS, perl = TRUE)
.ISOweeks.cumulated_CONFIRMED.txt <- gsub("(?=[0-9]{3}$)|((?=[0-9]{6}$))", ",", .ISOweeks.cumulated_CONFIRMED, perl = TRUE)

.ISOweeks.lastweek_CONFIRMED <- as.character(tail(covid.2019.ru.ISOweeks.plotting.df$CONFIRMED, 1))
.ISOweeks.lastweek_DEATHS <- tail(covid.2019.ru.ISOweeks.plotting.df$DEATHS, 1)

.ISOweeks.14_100 <- round(sum(tail(covid.2019.ru.ISOweeks.plotting.df$CONFIRMED, 2))/(146447424/1E+05), 2)

# Rendering textual report;

render("../Rmd/ISOweeks.report.Rmd", output_format = c("md_document", "html_document"))
render("../Rmd/ISOweeks.report_telegram.Rmd", output_format = c("md_document", "html_document"))
