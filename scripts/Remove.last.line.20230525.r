rows_minus_one <- nrow(covid.2019.ru.ISOweeks.ls[[1]])-1

for(i in 1:regions.count){
	covid.2019.ru.ISOweeks.ls[[i]] <- covid.2019.ru.ISOweeks.ls[[i]][1:rows_minus_one, ]
	}
