edge_tbl <- function(R, i, l_order = 3) {

  all_symbols <- 1:l_order

  # symbols used in column i
  used <- R %>% filter(column == i) %>% pull(symbol)

  # symbols missing from column i
  missing <- setdiff(all_symbols, used)

  # edge data frame for column i
  edge_df <- tibble(
    to = paste0("s", missing)
  ) %>%
    mutate(from = paste0("c", i))

  return(edge_df)
}
