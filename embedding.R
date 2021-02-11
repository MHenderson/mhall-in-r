library(here)
library(igraph)
library(tidygraph)
library(tidyverse)

source(here("R", "edge_tbl.R"))
source(here("R", "embedding.R"))
source(here("R", "to_tidygraph.R"))

r <- data.frame(row = c(1, 1, 1), column = c(1, 2, 3), symbol = c(1, 3, 2))

embedding(r)

r <- tibble(
  row = c(rep(1, 4), rep(2, 4)),
  column = rep(1:4, 2),
  symbol = c(1, 2, 3, 4, 2, 3, 4, 1)
)

embedding(r, l_order = 4, rows = 3:4)
