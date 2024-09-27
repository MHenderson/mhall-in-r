library(targets)

tar_option_set(
  packages = c("ggplot2", "here", "keedwell", "scico", "tibble")
)

tar_source()

list(
  tar_target(
       name = latin_square_12,
    command = first_row_natural(12) |> add_rows(2:12)
  ),
  tar_target(
       name = latin_square_13,
    command = first_row_natural(13) |> add_rows(2:13)
  ),
  tar_target(
       name = latin_square_14,
    command = first_row_natural(14) |> add_rows(2:14)
  ),
  tar_target(
       name = latin_square_15,
    command = first_row_natural(15) |> add_rows(2:15)
  ),
  tar_target(
       name = latin_square_16,
    command = first_row_natural(16) |> add_rows(2:16)
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
       name = plot_latin_square_12,
    command = plot_latin_square(latin_square_12) + geom_text(aes(label = symbol), size = 5, colour = "white")
  ),
  tar_target(
       name = plot_latin_square_13,
    command = plot_latin_square(latin_square_13)
  ),
  tar_target(
       name = plot_latin_square_14,
    command = plot_latin_square(latin_square_14)
  ),
  tar_target(
       name = plot_latin_square_15,
    command = plot_latin_square(latin_square_15)
  ),
  tar_target(
       name = plot_latin_square_16,
    command = plot_latin_square(latin_square_16)
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
    name = save_plot_12,
    command = ggsave(
          plot = plot_latin_square_12,
      filename = here("plots", "12x12_latin-square.png"),
         width = 8,
        height = 8
    )
  ),
  tar_target(
    name = save_plot_13,
    command = ggsave(
          plot = plot_latin_square_13,
      filename = here("plots", "13x13_latin-square.png"),
         width = 8,
        height = 8
    )
  ),
  tar_target(
    name = save_plot_14,
    command = ggsave(
          plot = plot_latin_square_14,
      filename = here("plots", "14x14_latin-square.png"),
         width = 8,
        height = 8
    )
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
    name = save_plot_16,
    command = ggsave(
          plot = plot_latin_square_16,
      filename = here("plots", "16x16_latin-square.png"),
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
