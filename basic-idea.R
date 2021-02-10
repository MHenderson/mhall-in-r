library(tidygraph)

ls_order <- 3

# create graph from ls
bg <- create_bipartite(ls_order, ls_order, directed = FALSE, mode = "out")

bg <- bg %>%
  activate(nodes) %>%
  mutate(name = c(paste0("c", seq_len(3)), paste0("s", seq_len(3)))) %>%
  activate(edges) %>%
  mutate(
    name = letters[1:ls_order^2]
  )

# filter out the edges that correspond to the
# latin rectangle we are trying to extend
bg <- bg %>%
  filter(
    name %in% c("b", "c", "d", "e", "g", "i")
  )

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
