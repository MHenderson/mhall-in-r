edge_tbl <- function(R, i) {

  # symbols used in column 1
  c1 <- R %>% filter(column == i) %>% pull(symbol)

  all_symbols <- 1:3

  # symbols missing from column 1
  m1 <- setdiff(all_symbols, c1)

  # edge data frame for column 1
  c_df <- tibble(
    to = paste0("s", m1)
  ) %>%
    mutate(from = paste0("c", i))

  return(c_df)
}
