library(ggplot2)
library(here)
library(keedwell)

l_order <- 15

L <- first_row_natural(l_order) |>
  add_rows(2:l_order)

ggplot(L, aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  geom_text(aes(label = symbol), size = 5, colour = "white") +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )

ggsave(file = here("plots", "15x15_latin-square.png"), width = 8, height = 8)
