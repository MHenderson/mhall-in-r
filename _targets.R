library(targets)

tar_option_set(
  packages = c("ggplot2", "here", "keedwell", "scico", "tibble")
)

list(
  tar_target(
       name = latin_square_15,
    command = first_row_natural(15) |> add_rows(2:15)
  ),
  tar_target(
       name = latin_square_80,
    command = first_row_natural(80) |> add_rows(2:80)
  ),
  tar_target(
       name = latin_square_495,
    command = first_row_natural(495) |> add_rows(2:495)
  ),
  tar_target(
    name = plot_latin_square_15,
    command = {
      ggplot(latin_square_15, aes(column, row)) +
        geom_tile(aes(fill = symbol)) +
        geom_text(aes(label = symbol), size = 5, colour = "white") +
        scale_y_reverse() +
        coord_fixed() +
        theme_void() +
        theme(legend.position  = "none")
    }
  ),
  tar_target(
    name = plot_latin_square_80,
    command = {
      ggplot(latin_square_80, aes(column, row)) +
        geom_tile(aes(fill = symbol)) +
        scale_y_reverse() +
        coord_fixed() +
        theme_void() +
        theme(legend.position  = "none") +
        scale_fill_viridis_c(option = "magma")
    }
  ),
  tar_target(
    name = plot_latin_square_495,
    command = {
      ggplot(latin_square_495, aes(column, row)) +
        geom_tile(aes(fill = symbol)) +
        scale_y_reverse() +
        coord_fixed() +
        theme_void() +
        theme(legend.position  = "none") +
        scale_fill_scico(palette = 'davos')
    }
  ),
  tar_target(
    name = save_plot_15,
    command = ggsave(
          plot = plot_latin_square_15,
      filename = here("plots", "15x15_latin-square.png"),
         width = 8,
        height = 8
    )
  ),
  tar_target(
    name = save_plot_80,
    command = ggsave(
          plot = plot_latin_square_80,
      filename = here("plots", "80x80_latin-square.png"),
         width = 8,
        height = 8
    )
  ),
  tar_target(
    name = save_plot_495,
    command = ggsave(
          plot = plot_latin_square_495,
      filename = here("plots", "495x495_latin-square.png"),
         width = 8,
        height = 8
    )
  )
)
