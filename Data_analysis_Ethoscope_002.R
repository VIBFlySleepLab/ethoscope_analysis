ggetho(dt_curated, aes(y=interactions, colour=background), time_wrap = hours(24), summary_FUN = sum, summary_time_window = mins(30))+
  stat_pop_etho(mapping = NULL, data = NULL, geom = "smooth", position = "identity", method = mean_se, method.args = list(),
                show.legend = NA, inherit.aes = TRUE)+
  stat_ld_annotations(mapping = NULL, data = NULL, position = "identity", ld_colours = c("white", "black"), ypos = "bottom", 
                      height = 0.03, period = hours(24), phase = 0, l_duration = hours(12), outline = "black", 
                      x_limits = c(NA, NA), na.rm = FALSE, show.legend = TRUE, inherit.aes = TRUE)


ggetho(dt_curated, aes(y=interactions, colour=background), time_wrap = hours(24), summary_FUN = sum, summary_time_window = mins(30))+
  stat_pop_etho(mapping = NULL, data = NULL, geom = "smooth", position = "identity", method = mean_se, method.args = list(),
                show.legend = NA, inherit.aes = TRUE)+
  stat_ld_annotations(mapping = NULL, data = NULL, position = "identity", ld_colours = c("white", "black"), ypos = "bottom", 
                      height = 0.03, period = hours(24), phase = 0, l_duration = hours(12), outline = "black", 
                      x_limits = c(NA, NA), na.rm = FALSE, show.legend = TRUE, inherit.aes = TRUE)




#***Plotting and analysis****
# Population plots # coulour = lines of compare & facet = layers
library(ggetho)
ggetho(dt_curated, aes(y=asleep, colour=sex)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(sex ~ .)
### above function can be used for different plotting
------------------------------------------------
# Sleep deprivation: plot tube rotations per 30mins against t
library(ggetho)
ggetho(dt_curated, aes(y=interactions, colour=food)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(region_id ~ .)
## also first make dt_curated file for the night of sleep deprivation e.g. dt_curated <- dt_curated[t %between% c(hours(60), hours(72))]
--------------------------------------------------
# individuals plots (3rd plot), for several ethoscopes, give each fly a unique number )(fly_no)
# coulour = lines to compare & facet = layers
library(ggetho)
ggetho(dt_curated, aes(y=asleep, colour=sex)) +
  stat_pop_etho() +
  stat_ld_annotations(height = 1, alpha=0.3, outline=NA) +
  facet_grid(fly_no ~ .)
### above function can be used for different plotting
------------------------------------------------
# Average for all animals within a 30min (4th plot) # coulour = lines to compare & facet = layers
ggetho(dt_curated, aes(y=asleep, colour=sex), time_wrap = hours(24)) +
  stat_pop_etho() +
  stat_ld_annotations() +
  facet_grid(Temperature ~ .) +
  scale_y_continuous(name= "Fraction of time sleeping",labels = scales::percent)

# Create plot for sum of interactions (rotations) for each fly every 30 min
#colour could be changed to sex, genotype, etc. summary_FUN could be sum, mean, etc, summary_time_window could be any time intervals

ggetho(dt_curated, aes(y=interactions, colour=background), time_wrap = hours(24), summary_FUN = sum, summary_time_window = mins(30))+
  stat_pop_etho(mapping = NULL, data = NULL, geom = "smooth", position = "identity", method = mean_se, method.args = list(),
                show.legend = NA, inherit.aes = TRUE)+
  stat_ld_annotations(mapping = NULL, data = NULL, position = "identity", ld_colours = c("white", "black"), ypos = "bottom", 
                      height = 0.03, period = hours(24), phase = 0, l_duration = hours(12), outline = "black", 
                      x_limits = c(NA, NA), na.rm = FALSE, show.legend = TRUE, inherit.aes = TRUE)


### above function can be used for different plotting
-------------------------------------------------------------------------------------------------------
# plotting sunmmery_dt file, sleep fraction during night time, day time or total sleep 
ggplot(summary_dt, aes(x=sex, y=sleep_fraction_d, fill=sex)) + 
  geom_boxplot(outlier.colour = NA) +
  geom_jitter(alpha=.5) +
  facet_grid(background ~ .) +
  scale_y_continuous(name= "Fraction of time sleeping",labels = scales::percent)
### above function can be used for different plotting
----------------------------------------------------------------------------------------
# Plotting three phases_ALL_Light phase _Dark phase
ggplot(summary_dt_melted, aes(x=food, y=sleep_fraction, fill=phase)) + 
  geom_boxplot(outlier.colour = NA) +
  geom_jitter(alpha=.5) +
  facet_grid(sex ~ .) +
  scale_y_continuous(name= "Fraction of time sleeping",labels = scales::percent)
### above function can be used for different plotting

---------------------------------------------------------------------------------------------------------
# Bout length vs time of the day (8th plot)
ggetho(bout_dt, aes(y=duration / 60, colour="background"), time_wrap = hours(24)) + 
  stat_pop_etho() + 
  facet_grid(sex ~ .) +
  scale_y_continuous(name= "Bout length (min)")

-------------------------------------------------------------------------------------------------------------
# relationship between bout length and bout number (9th plot)
ggplot(rejoin(bout_summary), aes(n_bouts, mean_bout_length, colour=food)) +
  geom_point() +
  facet_grid(temperature ~ .) + 
  scale_x_continuous(name="Number of bouts") +
  scale_y_continuous(name="Average bout duration (s)")
### above function can be used for different plotting
  -----------------------------------------------------------------------------------------------------
## plotting (10th plot) sleep latency
ggplot(overall_summary, aes(latency / 60, sleep_fraction_l, colour=sex)) +
  geom_point() +
  geom_smooth(method="lm", alpha=.1)+
  facet_grid(background ~ .)
--------------------------------------------------------

  
  
# Statistics
## Pairwise Wilcoxon tests
pairwise.wilcox.test(summary_dt[temperature=="22 oC", sleep_fraction_all], 
                     summary_dt[temperature=="22 oC", food])

pairwise.wilcox.test(summary_dt[temperature=="25 oC", sleep_fraction_all], 
                     summary_dt[temperature=="25 oC", food])
## Two way anova
model <- aov(sleep_fraction_all ~ food * food, summary_dt)
summary(model)
