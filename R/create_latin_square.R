create_latin_square <- function(l_order) {
  expand_grid(row = 1:1, column = 1:l_order) %>%
    mutate(symbol = 1:l_order) %>%
    embedding(l_order = l_order, rows = 2:l_order)
}
