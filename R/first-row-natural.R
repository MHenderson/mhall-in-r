first_row_natural <- function(n) {
  tidyr::expand_grid(row = 1:1, column = 1:n) |>
    dplyr::mutate(symbol = 1:n)
}
