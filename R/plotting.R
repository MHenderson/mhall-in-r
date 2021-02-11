vertical_lines <- function(n) {
  tibble(
    x    = 0:n + 0.5,
    xend = 0:n + 0.5,
    y    = rep(0.5, n + 1),
    yend = rep(n + .5, n + 1)
  )
}

horizontal_lines <- function(n) {
  tibble(
    x    = rep(0.5, n + 1),
    xend = rep(n + 0.5, n + 1),
    y    = 0:n + 0.5,
    yend = 0:n + 0.5
  )
}
