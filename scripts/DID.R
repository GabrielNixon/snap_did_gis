library(dplyr)
library(tidyr)
library(readr)

wide <- read_csv("/content/snap_timeliness_wide.csv.csv")

long <- wide %>%
  pivot_longer(-state, names_to = "year", values_to = "rate") %>%
  mutate(year = as.integer(year))
drops <- wide %>%
  mutate(drop = `2023` - `2019`) %>%
  select(state, drop)

long <- long %>%
  left_join(drops, by = "state") %>%
  mutate(
    treat = ifelse(drop <= -15, 1, 0),   # treatment = states with ≥15% drop
    post  = ifelse(year >= 2022, 1, 0)   # post-COVID years
  )

install.packages("fixest", repos = "https://cloud.r-project.org")
library(fixest)

did_model <- feols(rate ~ treat * post | state + year, data = long)
summary(did_model)

library(ggplot2)

long %>%
  filter(year >= 2012) %>%
  group_by(year, treat) %>%
  summarise(mean_rate = mean(rate, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = year, y = mean_rate, color = factor(treat))) +
  geom_line(size = 1.2) +
  geom_point() +
  labs(
    title = "Difference-in-Differences: SNAP Timeliness",
    subtitle = "Treatment = States with large drops post-2019",
    x = "Year", y = "Average Timeliness Rate (%)",
    color = "Treatment Group"
  ) +
  theme_minimal()
