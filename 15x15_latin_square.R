library(here)
library(igraph)
library(tidygraph)
library(tidyverse)

source(here("R", "add_rows.R"))
source(here("R", "edge_tbl.R"))
source(here("R", "next_row.R"))
source(here("R", "to_tidygraph.R"))

l_order <- 15

first_row <- 1:l_order

expand_grid(row = 1:1, column = 1:l_order) %>%
  mutate(symbol = first_row) %>%
  add_rows(2:l_order) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  geom_text(aes(label = symbol), size = 5, colour = "white") +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )

ggsave(file = "15x15_latin_square.png", width = 8, height = 8)
