install.packages(c("usmap"))
library(usmap)

plot_usmap(data = snap, values = "2023", regions = "states") +
  scale_fill_continuous(
    name = "Timeliness (%)",
    low = "red", high = "green", label = scales::comma
  ) +
  labs(title = "SNAP Timeliness Rates by State (2023)") +
  theme(legend.position = "right")

plot_usmap(data = snap, values = "2019", regions = "states") +
  scale_fill_continuous(
    name = "Timeliness (%)",
    low = "red", high = "green", label = scales::comma
  ) +
  labs(title = "SNAP Timeliness Rates by State (2019)") +
  theme(legend.position = "right")


for (yr in c("2012","2019","2023")) {
  p <- plot_usmap(data = snap, values = yr, regions = "states") +
    scale_fill_continuous(
      name = "Timeliness (%)",
      low = "red", high = "green", label = scales::comma
    ) +
    labs(title = paste("SNAP Timeliness Rates by State (", yr, ")", sep="")) +
    theme(legend.position = "right")
  print(p)
}

library(ggplot2)
library(patchwork)

years_to_plot <- c("2012","2019","2023")

plots <- lapply(years_to_plot, function(yr) {
  plot_usmap(data = snap, values = yr, regions = "states") +
    scale_fill_continuous(low = "red", high = "green", name="Timeliness (%)") +
    labs(title = paste("SNAP Timeliness by State (", yr, ")", sep="")) +
    theme(legend.position="right")
})

wrap_plots(plots)

snap$diff_23_19 <- snap$`2023` - snap$`2019`

plot_usmap(data = snap, values = "diff_23_19", regions = "states") +
  scale_fill_gradient2(
    low = "red", mid = "white", high = "green", midpoint = 0,
    name = "Change (2023 - 2019)"
  ) +
  labs(title = "Change in SNAP Timeliness (2019 → 2023)") +
  theme(legend.position = "right")
