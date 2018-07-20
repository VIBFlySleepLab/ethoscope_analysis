#1: setting directory of data files
DATA_DIR <- "C://Users/u0118120/Documents/ethoscope"
list.files(DATA_DIR)
setwd(DATA_DIR)

#2: Loading libraries 
library(behavr)
library(scopr)
library(sleepr)

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

#6: setting Zeitgeber (ZT0). here light starts at 06:00 AM; ZT0 is the reference hour
## caching option: when you load data, it stores a snapshot in ethoscope folder; next time you load will be faster because from snapshot

system.time(
dt <- load_ethoscope(metadata_subset,
                     reference_hour=6.0, 
                     FUN = sleepr::sleep_annotation,
                     cache = "ethoscope_cache",
                     verbose=FALSE)
)

#7: Loading library 
library(sleepr)
library(ggetho)

#8: sleep analysis [visualise all our sleep data] (1st plot)
ggetho(dt, aes(z=asleep)) +
  stat_ld_annotations(height = 1)+
  stat_tile_etho() 

#9: data curation and removing dead animals automaticly. 
#* In case it is not work, delete the dead fly from the metadata file and rerun script.
#** curated data has another name so we can see the difference [dt vs dt_curated] 
library(sleepr)
dt_curated <- curate_dead_animals(dt)
summary(dt_curated)
#*** which animals have been removed
setdiff(dt[, id, meta=T],
        dt_curated[, id, meta=T])

#10: sleep analysis [visualise curated sleep data] (2nd plot)
ggetho(dt_curated, aes(z=asleep)) +
  stat_ld_annotations(height = 1)+
  stat_tile_etho() 
#11: moving analysis 
ggetho(dt, aes(x=t, z=moving))+
   stat_ld_annotations()+      
   stat_bar_tile_etho()
-----------------------------------------------
#11:***DATA_Subset**** # activate when important e.g exclude first day; sleep deprivation
  
#dt_curated <- subset(dt_curated,  t>= 432000 )
#dt_curated <- subset(dt_curated,  t< 432000 )
#dt_curated_SD <- subset(dt_curated, xxx> t & t>=xxx ) 
dt_curated <- dt_curated[t %between% c(days(1), days(2.5))]

#choose days for visualisation [start_datetime & stop_datetime , in seconds] when light start at 06:00 AM
#day 	hour	time	startpoint
#1	  06	  ZT0         0 -   43200
#1	  18	  ZT12	  43200 -   86400
#2	  30	  ZT0	    86400 -  129600
#2	  42	  ZT12	 129600 -  172800
#3	  54	  ZT0	   172800 -  216000
#3	  66	  ZT12	 216000 -  259200
#4	  78	  ZT0	   259200 -  302400
#4	  90	  ZT12	 302400 -  345600
#5	  102	  ZT0	   345600 -  388800
#5	  114	  ZT12	 388800 -  432000
#6	  126	  ZT0	   432000 -  475200
#6	  138	  ZT12	 475200 -  518400
#7    50	  ZT0	   518400 -  561600
#7	  162	  ZT12	 561600 -  604800
#8	  174	  ZT0	   604800 -  604800
#8	  186	  ZT12	 648000 -  691200
#9	  198	  ZT0	   691200 -  734400
#9	  210	  ZT12	 734400 -  777600
#10	  222	  ZT0	   777600 -  820800
#10	  234	  ZT12	 820800 -  864000

-------------------
# Summarise data per animal for sleep analysis
# L phase (light) should be any point between ZT0 and ZT12 - [0,12), [24,36), ...
# D phase (dark) should be any point between ZT12 and ZT24 - [12,24), [36,48),...
summary_dt <- 
  rejoin(dt_curated [,
                     .(
                       sleep_fraction = mean(asleep)
                     ),
                     by=id])
summary_dt
# Adding some phase information
dt_curated[, phase := ifelse(t %% hours(24) < hours(12), "L", "D")]

# improve summary to the last column 
summary_dt <- 
  rejoin(dt_curated[,
                    .(
                      sleep_fraction_all = mean(asleep),
                      sleep_fraction_l = mean(asleep[phase == "L"]),
                      sleep_fraction_d = mean(asleep[phase == "D"])
                    ),
                    ,by=id])
summary_dt

# Melting All sleep, L and D sleep (run anyway) 
summary_dt_melted <- melt(summary_dt, measure.vars = patterns("sleep_fraction_"),
                          variable.name = "phase", value.name = "sleep_fraction")


#Sleep architecture 
#* Bout analysis
library(sleepr)
bout_dt <- bout_analysis(asleep, dt)
bout_dt <- bout_dt[asleep == TRUE, -"asleep"]


#** Architecture description
bout_dt[,
        .(n_bouts = .N,
          mean_bout_length = mean(duration)),
        by=id]
#*** Latency to sleep; 
      #The latency describes how long it takes for an animal to initiate its first sleep bout.
      #Some researchers are also interested in the latency to the longest bout.
      #In this example, lets say we focus on the second day (and not the night - 24 to 36 hours).
bout_dt_second_day <- bout_dt[t %between%  c(days(1), days(1) + hours(12))]
bout_dt_second_day[, t:= t - days(1)]
      # We express t relatively to the first day
bout_summary <- bout_dt_second_day[,.(
  latency = t[1], # the first bout is at t[1] 
  first_bout_length = duration[1],
  latency_to_longest_bout = t[which.max(duration)],
  length_longest_bout = max(duration),
  n_bouts = .N,
  mean_bout_length = mean(duration)
),
by=id]
bout_summary

# Merging all statistics for sleep latency
overall_summary <- summary_dt[bout_summary]
overall_summary
