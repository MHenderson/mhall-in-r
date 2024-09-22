library(targets)

tar_option_set(
  packages = c("ggplot2", "here", "keedwell", "tibble")
)

list(
  tar_target(
       name = l_order,
    command = 15
  ),
  tar_target(
    name = latin_square,
    command = {
      first_row_natural(l_order) |>
        add_rows(2:l_order)
    }
  ),
  tar_target(
    name = plot_latin_square,
    command = {
      ggplot(latin_square, aes(column, row)) +
        geom_tile(aes(fill = symbol)) +
        geom_text(aes(label = symbol), size = 5, colour = "white") +
        scale_y_reverse() +
        coord_fixed() +
        theme_void() +
        theme(
          legend.position  = "none",
        )
    }
  ),
  tar_target(
    name = save_plot,
    command = ggsave(
          plot = plot_latin_square,
      filename = here("plots", "15x15_latin-square.png"),
         width = 8,
        height = 8
    )
  )
)
