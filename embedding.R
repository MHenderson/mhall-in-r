library(here)
library(igraph)
library(tidygraph)
library(tidyverse)

source(here("R", "edge_tbl.R"))
source(here("R", "embedding.R"))
source(here("R", "plotting.R"))
source(here("R", "to_tidygraph.R"))

r <- tibble(
  row    = c(1, 1, 1),
  column = c(1, 2, 3),
  symbol = c(1, 3, 2)
)

embedding(r)

r <- tibble(
  row    = c(rep(1, 4), rep(2, 4)),
  column = rep(1:4, 2),
  symbol = c(1, 2, 3, 4, 2, 3, 4, 1)
)

ggplot(r, aes(column, row)) +
  geom_tile(fill = "white") +
  geom_text(aes(label = symbol), size = 10, colour = "black") +
  geom_segment(data = vertical_lines(4), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_segment(data = horizontal_lines(4), aes(x = x, y = y, xend = xend, yend = yend)) +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )

L <- embedding(r, l_order = 4, rows = 3:4)

ggplot(L, aes(column, row)) +
  geom_tile(fill = "white") +
  geom_text(aes(label = symbol), size = 10, colour = "black") +
  geom_segment(data = vertical_lines(4), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_segment(data = horizontal_lines(4), aes(x = x, y = y, xend = xend, yend = yend)) +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )


