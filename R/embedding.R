#' Embed latin rectangle in a latin square
#'
#' Input is a latin rectangle as a data frame with
#' variables for row, column and symbol. Output is
#' a latin square in the same format which contains
#' the given latin rectangle in the first rows.
#'
#' @param R
#'
#' @return
#' @export
#'
#' @examples
embedding <- function(R) {
  bg <- to_tidygraph(R)
  for (i in 2:3) {
    # find a maximum matching
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

    # just the edges of the matching
    EE <- ends(mg, E(mg))

    # Add new row to R
    R <- R %>%
      bind_rows(
        tibble(
          row = c(i, i, i),
          column = 1:3,
          symbol = as.numeric(gsub("s", "", EE[,2]))
        )
      )

    # remove edges of matching
    bg <- bg %>%
      activate(edges) %>%
      filter(!matching)
  }
  return(R)
}
