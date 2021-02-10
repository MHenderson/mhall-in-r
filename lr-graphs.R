library(dplyr)
library(tidygraph)

# Here we attempt to construct the bipartite graph
# corresponding to the following latin rectangle
# (as a partial latin square) directly, from information
# about which symbols are missing from which columns.

# 1 3 2
# . . .
# . . .

## Input

l_order <- 3

c1 <- c(1) # used in column 1
c2 <- c(3) # used in column 2
c3 <- c(2) # used in column 3

## The Rest

column_vertices <- paste0("c", 1:l_order)
symbol_vertices <- paste0("s", 1:l_order)

l_nodes <- data.frame(name = c(column_vertices, symbol_vertices),
                      type = c(rep(TRUE, 3), rep(FALSE, 3)))

all_symbols <- 1:3

c1_df <- data.frame(
  to = paste0("s", setdiff(all_symbols, c1))
) %>%
  mutate(from = "c1")

c2_df <- data.frame(
  to = paste0("s", setdiff(all_symbols, c2))
) %>%
  mutate(from = "c2")

c3_df <- data.frame(
  to = paste0("s", setdiff(all_symbols, c3))
) %>%
  mutate(from = "c3")

l_edges <- bind_rows(c1_df, c2_df, c3_df)

bg <- tbl_graph(nodes = l_nodes, edges = l_edges)

# find a maximum matching
m <- max_bipartite_match(bg)

# names of edges in the matching
matching_names <- match(m$matching, names(m$matching))

# add a matching indicator to the edges
bgc <- bg %>%
  activate(edges) %>%
  mutate(
    matching = to == matching_names[from]
  )

# just the matching itself, as a graph
mg <- bgc %>%
  activate(edges) %>%
  filter(matching)

# just the edges of the matching
EE <- ends(mg, E(mg))

# the new row
as.numeric(gsub("s", "", EE[,2]))

# remove edges of matching
bg2 <- bgc %>%
  activate(edges) %>%
  filter(!matching)

# get fresh maximum matching
m2 <- max_bipartite_match(bg2)

matching_names <- match(m2$matching, names(m2$matching))

bgc <- bg2 %>%
  activate(edges) %>%
  mutate(
    matching = to == matching_names[from]
  )

# just the matching itself, as a graph
mg <- bgc %>%
  activate(edges) %>%
  filter(matching)

# just the edges of the matching
EE <- ends(mg, E(mg))

# the new row
as.numeric(gsub("s", "", EE[,2]))
