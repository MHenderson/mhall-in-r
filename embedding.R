library(here)
library(igraph)
library(tidygraph)
library(tidyverse)

source(here("R", "embedding.R"))
source(here("R", "to_tidygraph.R"))

r <- data.frame(row = c(1, 1, 1), column = c(1, 2, 3), symbol = c(1, 3, 2))

embedding(r)
