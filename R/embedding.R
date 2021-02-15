#' Embed latin rectangle in a latin square
#'
#' Input is a latin rectangle as a data frame with
#' variables for row, column and symbol. Output is
#' a latin square in the same format which contains
#' the given latin rectangle in the first rows.
#'
#' Use can optionally provide a vector of row indices.
#' Only those rows will be filled if that optional
#' vector is provided.
#'
#' @param R latin rectangle
#' @param l_order size of latin square to embed into
#' @param rows empty rows to be filled
#'
#' @return
#' @export
#'
#' @examples
embedding <- function(R, l_order = 3, rows = 2:l_order) {

  for (i in rows) {

    R <- R %>%
      bind_rows(
        tibble(
          row = rep(i, l_order),
          column = 1:l_order,
          symbol = next_row(R, l_order)
        )
      )

  }

  return(R)
}
