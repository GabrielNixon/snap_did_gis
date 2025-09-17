library(tidyverse)
library(GGally)
library(scales)

# Load the CSV (if not already loaded)
snap <- read_csv("/content/snap_timeliness_wide.csv.csv", show_col_types = FALSE)

# Convert to long format for easier plotting
snap_long <- snap %>%
  pivot_longer(-state, names_to = "year", values_to = "rate") %>%
  mutate(year = as.integer(year))

# -------------------------------
# Basic summaries
# -------------------------------
summary(snap)
colSums(is.na(snap))   # check missing values per year

snap_long %>%
  group_by(year) %>%
  summarise(
    mean_rate = mean(rate, na.rm = TRUE),
    min_rate  = min(rate, na.rm = TRUE),
    max_rate  = max(rate, na.rm = TRUE),
    sd_rate   = sd(rate, na.rm = TRUE)
  )

# -------------------------------
# 1. Distribution per year
# -------------------------------
ggplot(snap_long, aes(x = rate)) +
  geom_histogram(binwidth = 2, fill = "steelblue", color = "white") +
  facet_wrap(~year, scales = "free_y") +
  labs(title = "Distribution of SNAP Timeliness by Year",
       x = "Timeliness Rate (%)", y = "Number of States")

# -------------------------------
# 2. Boxplots over time
# -------------------------------
ggplot(snap_long, aes(x = factor(year), y = rate)) +
  geom_boxplot(fill = "orange", alpha = 0.7) +
  labs(title = "SNAP Timeliness by Year (Boxplots)",
       x = "Year", y = "Timeliness Rate (%)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# -------------------------------
# 3. Trends for selected states
# -------------------------------
states_focus <- c("California", "Texas", "New York", "Florida")
snap_long %>%
  filter(state %in% states_focus) %>%
  ggplot(aes(x = year, y = rate, color = state, group = state)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(title = "SNAP Timeliness Trends (Selected States)",
       x = "Year", y = "Timeliness Rate (%)")

# -------------------------------
# 4. Correlation between years
# -------------------------------
snap %>%
  select(-state) %>%
  ggpairs(title = "Correlation of Timeliness Across Years")
