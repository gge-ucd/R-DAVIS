library(tidyverse)
library(lubridate)

flights <- read_csv("data/nyc_13_flights.csv")
weather <- read_csv("data/nyc_13_weather.csv")
planes <- read_csv("data/nyc_13_planes.csv")

flights <- flights %>% 
  select(-X18, -X19)

flights %>% 
  filter(str_detect(sched_dep_time, "\""))

# this column is character when it should be numeric. you could open a spreadsheet software to look for errors that might make it characters instead of numeric.
flights$sched_dep_time

# let's look for NA values
sum(is.na(flights$sched_dep_time))

# no NA values... let's try converting this column

num_dep_time <- as.numeric(flights$sched_dep_time)

# oooh, NAs introduced by coercion... so there were some values that could not be changed to numeric. let's find them

# this returns a logical vector for whether or not our value got turned into an NA
is.na(num_dep_time)

# we can use that logical vector to subset our original flights vector, and find the values that could not be coerced to numeric with as.numeric()
flights$sched_dep_time[is.na(num_dep_time)]

# ahhhhhhh looks like some characters got inserted into the CSV. let's replace this value with a value that matches the rest of the column

flights$sched_dep_time[is.na(num_dep_time)] <- "933"
  
# no NAs introduced now!
as.numeric(flights$sched_dep_time)

# let's permanently convert that column

flights <- flights %>% 
  mutate(sched_dep_time = as.numeric(sched_dep_time))

# now it's the proper double column type
flights


# Joins -------------------------------------------------------------------

fw <- left_join(flights, weather)

fwp <- left_join(fw, planes)

# this dataframe now has all the rows of flights, plus the info on weather and planes that relate to those flights
fwp

# we need to add a departure delay column, but to calculate this we'll need to make some actual datetime columns using lubridate
flights %>% 
  mutate(dep_delay = dep_time - sched_dep_time) %>% 
  select(month, day, dep_time, sched_dep_time, dep_delay)

# first let's make our scheduled departure time into a datetime column instead. looks like scheduled dep time has all its components in the year, month, day, hour, and minute columns
fwp <- fwp %>% 
  mutate(sched_dep_time = ymd_hm(paste(year, month, day, hour, minute)))

# ok, now for actual departure time. for this one, hours and minutes are collapsed into one numeric value that can have 4 digits (2320) or 3 (730). we need them to all have the same length, so we'd want 730 to become 0730. I googled and found the str_pad function, which takes a value, a width, and pads it out with some value until it's that length. so the following code says "take a value, figure out if you need to add 0s to get it to length 4, and then add enough 0s that it becomes 4 characters long"

fwp <- fwp %>% 
  mutate(dep_time = str_pad(dep_time, width = 4, pad = "0"),
         dep_time = ymd_hm(paste(year, month, day, dep_time))) %>% 
  mutate(dep_delay = difftime(dep_time, sched_dep_time)) 

# let's take a look at those new values we made
fwp %>% 
  select(month, day, dep_time, sched_dep_time, dep_delay) %>% 
  arrange(dep_delay) %>% 
  print(n = 100)

# hmmmmmm, looks like we had some issues when flights were scheduled to leave late one day and actually left early in the morning the next day

# i'm going to decide that any flight that left more than 1800 seconds (30 minutes) "early" was actually a scenario where it was supposed to leave one day and got delayed all the way until sometime the next day. So I find these cases and add 1 day to the departure time, and leave the other cases alone. then I recalculate dep_delay
fwp <- fwp %>%
  mutate(dep_time = case_when(
    dep_delay < -1800 ~ dep_time + days(1),
    TRUE ~ dep_time
  )) %>%
  mutate(dep_delay = difftime(dep_time, sched_dep_time))


# Plots -------------------------------------------------------------------

# plotting dep_delay against precipitation (dividing by 60 so we got minutes instead of seconds for the delay)
fwp %>% 
  ggplot(aes(x = precip, y = dep_delay/60)) +
  geom_point() +
  geom_smooth(method = "lm")

# plotting departure delay over date, looking across carriers
fwp %>% 
  filter(month %in% 9:12) %>% 
  mutate(date = ymd(paste(year, month, day))) %>% 
  group_by(date, carrier) %>% 
  summarise(mean_dep_delay = mean(dep_delay, na.rm = T)) %>% 
  ggplot(aes(x = date, y = mean_dep_delay)) +
  geom_point(aes(color = carrier), alpha = 0.5) +
  facet_wrap(~carrier)

# making table of mean temperatures for each airport
fwp %>% 
  mutate(date = ymd(paste(year, month, day))) %>% 
  group_by(origin, date) %>% 
  summarise(mean_temp = mean(temp, na.rm = T)) %>% 
  pivot_wider(names_from = origin, values_from = mean_temp, names_prefix = "mean_temp_") %>% 
  knitr::kable()

# combination violin and scatterplot facetted by "raining"
fwp %>% 
  mutate(raining = precip > 0) %>% 
  ggplot(aes(x = dep_delay, y = manufacturer)) +
  geom_jitter(alpha = 0.2) +
  geom_violin(alpha = 0.2) +
  facet_wrap(~raining)
