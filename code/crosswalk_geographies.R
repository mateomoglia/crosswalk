#--------------------------------------------------------------
#
#   Create a table with all CODGEO between 2011:2022
#   and the crosswalk to BV2022 and ZE2020.
#
#   Source: INSEE
#
#--------------------------------------------------------------

path = "/Users/mmoglia/Dropbox/research/raw_data"

# Open BV 2022 -----
# The data are in 2022 geography (BV2022 and CODGEO2022)
bv.com = read_sf(paste0(path,"/shp/bv2022/com_bv2022_2022.shp")) %>%
  as.data.frame() %>%
  dplyr::select(codgeo,bv2022) %>%
  rename("codgeo2022"="codgeo") 

# Open ZE2020 -----
# The data are in 2020 geography (ZE2020 and CODGEO2020)
ze.com = read_sf(paste0(path,"/shp/ze2020/fond_ZE2020_geo20.shp")) %>%
  as.data.frame() %>%
  dplyr::select(code,ze2020) %>%
  rename("codgeo2020"="code")

# Open ECPI ----
# The data re in 2019 geography (EPCI2019 and CODGEO2019)
epci.com = readxl::read_xlsx(paste0(path,"/crosswalk/raw/epcicom2019.xlsx")) %>%
  select(insee,siren) %>%
  rename("codgeo2019"="insee",
         "epci2019"="siren")
ept.com = readxl::read_xlsx(paste0(path,"/crosswalk/raw/ept2019.xlsx")) %>%
  rename("siren_ept"="siren") %>%
  mutate(codgeo2019=as.character(codgeo2019))
epci.com = left_join(epci.com,ept.com) %>%
  mutate(epci2019 = ifelse(is.na(siren_ept),epci2019,siren_ept)) %>% select(-siren_ept)

mars.com = read.csv2(paste0(path,"/crosswalk/raw/epcicom2015.csv")) %>%
  filter(dep_epci=="13") %>%
  rename("siren_mars"="siren_epci",
         "codgeo2019"="insee") %>%
  mutate(codgeo2019=as.character(codgeo2019)) %>% select(siren_mars,codgeo2019)
epci.com = left_join(epci.com,mars.com) %>%
  mutate(epci2019 = ifelse(is.na(siren_mars),epci2019,siren_mars)) %>% select(-siren_mars)

# Open all crosswalk and rename from COGuaison

year = c(1968,1975,1982,1990,1999,2008,2013,2019)
cog1968.pass = as.data.frame(PASSAGE_1968_1975_insee) %>%
  select(starts_with("cod")) %>%
  rename("codgeo1975" = "cod1975",
         "codgeo1968" = "cod1968")

cog1975.pass = as.data.frame(PASSAGE_1975_1982_insee) %>%
  select(starts_with("cod")) %>%
  rename("codgeo1975" = "cod1975",
         "codgeo1982" = "cod1982")

cog1982.pass = as.data.frame(PASSAGE_1982_1990_insee) %>%
  select(starts_with("cod")) %>%
  rename("codgeo1990" = "cod1990",
         "codgeo1982" = "cod1982")

cog1990.pass = as.data.frame(PASSAGE_1990_1999_insee) %>%
  select(starts_with("cod")) %>%
  rename("codgeo1990" = "cod1990",
         "codgeo1999" = "cod1999")

cog1999.pass = as.data.frame(PASSAGE_1999_2008_insee) %>%
  select(starts_with("cod")) %>%
  rename("codgeo2008" = "cod2008",
         "codgeo1999" = "cod1999")

for(i in 2008:2022){
  j = i+1
  dta = as.data.frame(get(paste0("PASSAGE_",i,"_",j,"_insee"))) %>%
    select(starts_with("cod")) 
  dta = dta %>% setNames(names(dta) %>% stringr::str_replace("cod20","codgeo20")) 
  assign(paste0("cog",i,".pass"),dta)
}

rm(i,j,dta)

# Add the new geographies to BV2022 ------

bv.com.all = bv.com %>%
  full_join(cog2021.pass) %>%
  mutate(codgeo2021 = ifelse(is.na(codgeo2021),codgeo2022,codgeo2021)) %>%
  full_join(cog2020.pass) %>%
  mutate(codgeo2020 = ifelse(is.na(codgeo2020), codgeo2021, codgeo2020)) %>%
  full_join(cog2019.pass) %>%
  mutate(codgeo2019 = ifelse(is.na(codgeo2019), codgeo2020, codgeo2019)) %>%
  full_join(cog2018.pass) %>%
  mutate(codgeo2018 = ifelse(is.na(codgeo2018), codgeo2019, codgeo2018)) %>%
  full_join(cog2017.pass) %>%
  mutate(codgeo2017 = ifelse(is.na(codgeo2017), codgeo2018, codgeo2017)) %>%
  full_join(cog2016.pass,relationship = "many-to-many") %>%
  mutate(codgeo2016 = ifelse(is.na(codgeo2016), codgeo2017, codgeo2016)) %>%
  full_join(cog2015.pass) %>%
  mutate(codgeo2015 = ifelse(is.na(codgeo2015), codgeo2016, codgeo2015)) %>%
  full_join(cog2014.pass) %>%
  mutate(codgeo2014 = ifelse(is.na(codgeo2014), codgeo2015, codgeo2014)) %>%
  full_join(cog2013.pass) %>%
  mutate(codgeo2013 = ifelse(is.na(codgeo2013), codgeo2014, codgeo2013)) %>%
  full_join(cog2012.pass) %>%
  mutate(codgeo2012 = ifelse(is.na(codgeo2012), codgeo2013, codgeo2012)) %>%
  full_join(cog2011.pass,relationship = "many-to-many") %>%
  mutate(codgeo2011 = ifelse(is.na(codgeo2011), codgeo2012, codgeo2011)) %>%
  full_join(cog2010.pass) %>%
  mutate(codgeo2010 = ifelse(is.na(codgeo2010), codgeo2011, codgeo2010)) %>%
  full_join(cog2009.pass) %>%
  mutate(codgeo2009 = ifelse(is.na(codgeo2009), codgeo2010, codgeo2009)) %>%
  full_join(cog2008.pass) %>%
  mutate(codgeo2008 = ifelse(is.na(codgeo2008), codgeo2009, codgeo2008)) %>%
  full_join(cog1999.pass) %>%
  mutate(codgeo1999 = ifelse(is.na(codgeo1999), codgeo2008, codgeo1999))  %>%
  full_join(cog1990.pass,relationship = "many-to-many") %>%
  mutate(codgeo1990 = ifelse(is.na(codgeo1990), codgeo1999, codgeo1990))  %>%
  full_join(cog1982.pass,relationship = "many-to-many") %>%
  mutate(codgeo1982 = ifelse(is.na(codgeo1982), codgeo1990, codgeo1982))  %>%
  full_join(cog1975.pass,relationship = "many-to-many") %>%
  mutate(codgeo1975 = ifelse(is.na(codgeo1975), codgeo1982, codgeo1975)) %>%
  full_join(cog1968.pass,relationship = "many-to-many") %>%
  mutate(codgeo1968 = ifelse(is.na(codgeo1968), codgeo1975, codgeo1968)) 
rm(list = ls()[grepl("cog", ls())])

# Merge with the ZE2020 and ECPI2019 ------
bv.com.ze.all = full_join(bv.com.all,ze.com)
bv.com.ze.ecpi.all = full_join(bv.com.ze.all,epci.com)

# Export -----   
write.csv2(bv.com.ze.ecpi.all,paste0(path,"/crosswalk/output/crosswalk.csv"),row.names=F)
write.dta(bv.com.ze.ecpi.all,paste0(path,"/crosswalk/output/crosswalk.dta"))

rm(epci.com,bv.com.ze.all,bv.com,bv.com.all,ze.com)
