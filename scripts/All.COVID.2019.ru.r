# To be run from main project scripts folder;

source("covid.2019.ru.loading_data_and_misc.20230525.r")

# If fork checks for potential intcrement integration mistakes;

if(tail(covid.2019.ru.ISOweeks.ls[[1]]$REPORT_TIMESTAMP, 1) != reporting.REPORT_TIMESTAMP){

            source("covid.2019.ru.processing_increment.20230525.r")
            source("covid.2019.ru.integrating_increment.20230525.r") # Do not run when restoring environment with no new data downloaded;
            source("covid.2019.ru.integrating_increment.CRDH.20230525.r")
            source("covid.2019.ru.transforming_data.20230525.r")
            source("covid.2019.ru.plots.20230525.r")
            source("covid.2019.ru.plots_regional.20230525.r")

        } else{print("Fatal error: two last instances of REPORT_TIMESTAMP identical!")}
