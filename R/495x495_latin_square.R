library(ggplot2)
library(here)
library(keedwell)
library(scico)

l_order <- 495

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
  scale_fill_scico(palette = 'davos')

ggsave(file = here("plots", "495x495_latin-square.png"), width = 8, height = 8)
