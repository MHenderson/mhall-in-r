library(here)
library(igraph)
library(tidygraph)
library(tidyverse)

source(here("R", "create_latin_square.R"))
source(here("R", "embedding.R"))
source(here("R", "edge_tbl.R"))
source(here("R", "to_tidygraph.R"))

l_order <- 56

first_row <- 1:l_order

# randomising the first row has only a small effect
# first_row <- sample(1:l_order)

expand_grid(row = 1:1, column = 1:l_order) %>%
  mutate(symbol = first_row) %>%
  embedding(l_order = l_order, rows = 2:l_order) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  #geom_text(aes(label = symbol), size = 5, colour = "white") +
  #geom_segment(data = vertical_lines(195), aes(x = x, y = y, xend = xend, yend = yend)) +
  #geom_segment(data = horizontal_lines(195), aes(x = x, y = y, xend = xend, yend = yend)) +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  ) +
  scale_fill_viridis_c(option = "magma")
  #scale_fill_distiller(palette = "RdPu")
  #scale_fill_scico(palette = 'davos')

#ggsave(file="ls.svg", width=12, height=12)
#ggsave(file="ls.png", width=12, height=12)
