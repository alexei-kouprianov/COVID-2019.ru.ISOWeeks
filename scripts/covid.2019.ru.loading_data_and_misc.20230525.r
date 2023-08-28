# ###############################################################
# Loads data and miscellanea;
#
# Requires source(covid.2019.ru.libraries.r);

# Loading a misc loci file;

ISOweek.loci <- read.table("../misc/loci.20230525.txt", h = TRUE, sep = "\t")
ISOweek.population <- read.table("../misc/population.20230101.txt", h = TRUE, sep = "\t")

# Loading data from the XLSX backup file;
# This section loads the XLSX backup file and results in covid.2019.ru.ISOweeks.ls list object;

covid.2019.ru.ISOweeks.ls.names <- getSheetNames("../data/xlsx/data.ISOweeks.xlsx")
covid.2019.ru.ISOweeks.ls <- as.list(NULL)
regions.count <- length(covid.2019.ru.ISOweeks.ls.names)

for(i in 1:regions.count){
	covid.2019.ru.ISOweeks.ls[[i]] <- read.xlsx("../data/xlsx/data.ISOweeks.xlsx", sheet = i)
	}
names(covid.2019.ru.ISOweeks.ls) <- covid.2019.ru.ISOweeks.ls.names
