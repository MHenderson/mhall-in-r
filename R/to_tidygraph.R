#' Convert a partial latin rectangle to tidygraph format
#'
#' Input is a latin rectangle as a data frame with
#' variables for row, column and symbol. Output is
#' a tidygraph representing the same latin rectangle.
#'
#' @param R
#'
#' @return
#' @export
#'
#' @examples
to_tidygraph <- function(R) {

  l_order <- 3

  c1 <- R %>% filter(row == 1, column == 1) %>% pull(symbol)
  c2 <- R %>% filter(row == 1, column == 2) %>% pull(symbol)
  c3 <- R %>% filter(row == 1, column == 3) %>% pull(symbol)

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

  tbl_graph(nodes = l_nodes, edges = l_edges)
}
