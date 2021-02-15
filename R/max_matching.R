max_matching <- function(bg) {

  m <- max_bipartite_match(bg)

  # names of edges in the matching
  matching_names <- match(m$matching, names(m$matching))

  # add a matching indicator to the edges
  bg <- bg %>%
    activate(edges) %>%
    mutate(
      matching = to == matching_names[from]
    )

  # just the matching itself, as a graph
  mg <- bg %>%
    activate(edges) %>%
    filter(matching)

  # remove edges of matching
  bg <- bg %>%
    activate(edges) %>%
    filter(!matching)

  return(list(bg = bg, mg = mg))

}
