#1: setting directory of data files
DATA_DIR <- "G://#Ethoscope_R_analysis"
list.files(DATA_DIR)
setwd(DATA_DIR)
ZT_light_ON = 11          # setting Zeitgeber (ZT0) , GMT =  BELGIUM time - 1hr  or -2 hr summer time.

#2: Loading libraries 
library(behavr)
library(scopr)
library(sleepr)
library(ggetho)

#3: loading and reading metadata file
metadata <- fread("metadata.csv")
metadata

#4: Linking, link metadata with ethoscope
metadata <- link_ethoscope_metadata(metadata, 
                                    result_dir = "ethoscope_results")
print(metadata)

#5: Loading raw data without dead or escaped animals [e.g status == "Ok","Dead", "Escaped"]
## this can be used to select animals with specific criteria
metadata_subset <- metadata[status == "OK"]
dt <- load_ethoscope(metadata_subset,
                     FUN = sleepr::sleep_annotation, 
                     verbose=FALSE)
summary(dt)
print(dt)


metadata_subset_region_id_1 <- metadata[region_id == "1"]
metadata_subset_region_id_2 <- metadata[region_id == "2"]
metadata_subset_region_id_3 <- metadata[region_id == "3"]
metadata_subset_region_id_4 <- metadata[region_id == "4"]
metadata_subset_region_id_5 <- metadata[region_id == "5"]
metadata_subset_region_id_6 <- metadata[region_id == "6"]
metadata_subset_region_id_7 <- metadata[region_id == "7"]
metadata_subset_region_id_8 <- metadata[region_id == "8"]
metadata_subset_region_id_9 <- metadata[region_id == "9"]
metadata_subset_region_id_10 <- metadata[region_id == "10"]
metadata_subset_region_id_11 <- metadata[region_id == "11"]
metadata_subset_region_id_12 <- metadata[region_id == "12"]
metadata_subset_region_id_13 <- metadata[region_id == "13"]
metadata_subset_region_id_14 <- metadata[region_id == "14"]
metadata_subset_region_id_15 <- metadata[region_id == "15"]
metadata_subset_region_id_16 <- metadata[region_id == "16"]
metadata_subset_region_id_17 <- metadata[region_id == "17"]
metadata_subset_region_id_18 <- metadata[region_id == "18"]
metadata_subset_region_id_19 <- metadata[region_id == "19"]
metadata_subset_region_id_20 <- metadata[region_id == "20"]

#-------------load_ethoscope-------------------
dt <- load_ethoscope(metadata_subset,
                     FUN = sleepr::sleep_annotation, 
                     verbose=FALSE)
summary(dt)
print(dt)


dt_region_id_1 <- load_ethoscope(metadata_subset_region_id_1,
                     FUN = sleepr::sleep_annotation, 
                     verbose=FALSE)

dt_region_id_2 <- load_ethoscope(metadata_subset_region_id_2,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_3 <- load_ethoscope(metadata_subset_region_id_3,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_4 <- load_ethoscope(metadata_subset_region_id_4,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_5 <- load_ethoscope(metadata_subset_region_id_5,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)


dt_region_id_6 <- load_ethoscope(metadata_subset_region_id_6,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_7 <- load_ethoscope(metadata_subset_region_id_7,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_8 <- load_ethoscope(metadata_subset_region_id_8,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_9 <- load_ethoscope(metadata_subset_region_id_9,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_10 <- load_ethoscope(metadata_subset_region_id_10,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_11 <- load_ethoscope(metadata_subset_region_id_11,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_12 <- load_ethoscope(metadata_subset_region_id_12,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_13 <- load_ethoscope(metadata_subset_region_id_13,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_14 <- load_ethoscope(metadata_subset_region_id_14,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_15 <- load_ethoscope(metadata_subset_region_id_15,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_16 <- load_ethoscope(metadata_subset_region_id_16,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_17 <- load_ethoscope(metadata_subset_region_id_17,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_18 <- load_ethoscope(metadata_subset_region_id_18,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_19 <- load_ethoscope(metadata_subset_region_id_19,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)

dt_region_id_20 <- load_ethoscope(metadata_subset_region_id_20,
                                 FUN = sleepr::sleep_annotation, 
                                 verbose=FALSE)



#6: setting Zeitgeber (ZT0). here light starts at 06:00 AM; ZT0 is the reference hour
## caching option: when you load data, it stores a snapshot in ethoscope folder; next time you load will be faster because from snapshot

system.time(
  dt <- load_ethoscope(metadata_subset,
                       reference_hour=ZT, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)



system.time(
  dt <- load_ethoscope(metadata_subset_region_id_1,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_2,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_3,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_4,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_5,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_6,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_7,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_8,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_9,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_10,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_11,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_12,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_13,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_14,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_15,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_16,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_17,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_18,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_19,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)

system.time(
  dt <- load_ethoscope(metadata_subset_region_id_20,
                       reference_hour=ZT_light_ON, 
                       FUN = sleepr::sleep_annotation,
                       cache = "ethoscope_cache",
                       verbose=FALSE)
)




##graphes
#----------------all individuals----------------------

library(ggetho)
ggetho(dt, aes(x=t, z=moving))+
  stat_ld_annotations()+      
  stat_bar_tile_etho()


library(ggetho)
ggetho(dt, aes(y=asleep, colour=motor)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(fly_no ~ .)

library(ggetho)
ggetho(dt, aes(y=interactions, colour=motor)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(fly_no ~ .)

#----------------Fly 1----------------------
library(ggetho)
ggetho(dt_region_id_1, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_1, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 2----------------------
library(ggetho)
ggetho(dt_region_id_2, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 3----------------------

  library(ggetho)
ggetho(dt_region_id_3, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_3, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 4----------------------

  library(ggetho)
ggetho(dt_region_id_4, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)



#----------------Fly 5----------------------

  library(ggetho)
ggetho(dt_region_id_5, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_5, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 6----------------------

  library(ggetho)
ggetho(dt_region_id_6, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 7----------------------

  library(ggetho)
ggetho(dt_region_id_7, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_7, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 8----------------------

  library(ggetho)
ggetho(dt_region_id_8, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 9----------------------

  library(ggetho)
ggetho(dt_region_id_9, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_9, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 10----------------------

  library(ggetho)
ggetho(dt_region_id_10, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 11----------------------

  library(ggetho)
ggetho(dt_region_id_11, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 12----------------------

  library(ggetho)
ggetho(dt_region_id_12, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_12, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 13----------------------

  library(ggetho)
ggetho(dt_region_id_13, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 14----------------------

  library(ggetho)
ggetho(dt_region_id_14, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_14, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 15----------------------

  library(ggetho)
ggetho(dt_region_id_15, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 16----------------------

  library(ggetho)
ggetho(dt_region_id_16, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_16, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 17----------------------

  library(ggetho)
ggetho(dt_region_id_17, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 18----------------------

  library(ggetho)
ggetho(dt_region_id_18, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_18, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

#----------------Fly 19----------------------

  library(ggetho)
ggetho(dt_region_id_19, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)


#----------------Fly 20----------------------

  library(ggetho)
ggetho(dt_region_id_20, aes(y= asleep,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)

library(ggetho)
ggetho(dt_region_id_20, aes(y= interactions,  colour=region_id)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(~ replicate)
