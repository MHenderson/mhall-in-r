library(ggplot2)
library(here)
library(keedwell)

l_order <- 80

L <- first_row_natural(l_order) |>
  add_rows(2:l_order)

ggplot(L, aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  ) +
  scale_fill_viridis_c(option = "magma")

ggsave(file = here("plots", "80x80_latin-square.png"), width = 8, height = 8)
