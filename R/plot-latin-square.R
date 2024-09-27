plot_latin_square <- function(R) {
  ggplot(R, aes(column, row)) +
    geom_tile(aes(fill = symbol)) +
    scale_y_reverse() +
    coord_fixed() +
    theme_void() +
    theme(legend.position  = "none")
}
