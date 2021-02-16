mhall-in-r
================
Matthew Henderson
15/02/2021

## Introduction

This repository contains code for generating latin squares based on a
theorem of Marshall Hall Jr. (Hall 1945) which states:

### Theorem 1

> Given a rectangle of n - r rows and n columns such that each of the
> numbers 1, 2, …, n occurs in every row and no number occurs twice in
> any column, then there exist r rows which may be added to the given
> rectangle to form a latin square.

In `R/add_rows.R` the function `add_rows` takes as input a latin
rectangle (represented by a data frame) and outputs a new data frame
representing a latin rectangle with additional rows.

In this report we describe how `add_rows` works and present some
generated outputs.

## Representing latin rectangles as data frames

A latin rectangle can be represented by a data frame with variables
`row`, `column`, and `symbol`.

For example, the latin rectangle

![](figure/first_example-1.png)<!-- -->

can be represented by the data frame:

``` r
tibble(
     row = c(rep(1, 3), rep(2, 3)),
     col = rep(1:3, 2),
  symbol = c(1, 2, 3, 2, 3, 1)
)
#> # A tibble: 6 x 3
#>     row   col symbol
#>   <dbl> <int>  <dbl>
#> 1     1     1      1
#> 2     1     2      2
#> 3     1     3      3
#> 4     2     1      2
#> 5     2     2      3
#> 6     2     3      1
```

`expand_grid` makes it even easier to construct such a data frame from a
vector representing the symbols.

``` r
expand_grid(row = 1:2, column = 1:3) %>%
  mutate(symbol = c(1, 2, 3, 2, 3, 1))
#> # A tibble: 6 x 3
#>     row column symbol
#>   <int>  <int>  <dbl>
#> 1     1      1      1
#> 2     1      2      2
#> 3     1      3      3
#> 4     2      1      2
#> 5     2      2      3
#> 6     2      3      1
```

One benefit of this representation is that it makes it easy to use
tidyverse packages. For example, we can plot latin rectangles with
`ggplot2`.

``` r
expand_grid(row = 1:2, column = 1:3) %>%
  mutate(symbol = c(1, 2, 3, 2, 3, 1)) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  geom_text(aes(label = symbol), colour = "white") +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )
```

![](figure/first_plot-1.png)<!-- -->

## Extending latin rectangles

`add_rows` has two arguments. The first is a data frame representing a
latin rectangle, the second is a vector of row indices.

The output of `add_rows` is a new data frame representing a latin
rectangle obtained from the input latin rectangle by adding new rows
corresponding to the given row indices.

So, for example, to add a third row to the latin rectangle given in the
previous section we call `add_rows` with indices `c(3)` (or `3:3`).

``` r
expand_grid(row = 1:2, column = 1:3) %>%
  mutate(symbol = c(1, 2, 3, 2, 3, 1)) %>%
  add_rows(3:3)
#> # A tibble: 9 x 3
#>     row column symbol
#>   <int>  <int>  <dbl>
#> 1     1      1      1
#> 2     1      2      2
#> 3     1      3      3
#> 4     2      1      2
#> 5     2      2      3
#> 6     2      3      1
#> 7     3      1      3
#> 8     3      2      1
#> 9     3      3      2
```

Extending a 2 x 4 latin rectangle to a 3 x 4 latin rectangle, for
example, and plotting the resulting output:

``` r
expand_grid(row = 1:2, column = 1:4) %>%
  mutate(symbol = c(1, 2, 3, 4, 2, 3, 4, 1)) %>%
  add_rows(3:3) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  geom_text(aes(label = symbol), colour = "white") +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )
```

![](figure/extend_and_plot_pipeline-1.png)<!-- -->

To complete a latin rectangle to a latin square we just have to specify
n - r rows to be added, where r is the order of the original latin
rectangle.

``` r
expand_grid(row = 1:2, column = 1:4) %>%
  mutate(symbol = c(1, 2, 3, 4, 2, 3, 4, 1)) %>%
  add_rows(3:4) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  geom_text(aes(label = symbol), colour = "white") +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )
```

![](figure/completing-1.png)<!-- -->

## Existence of latin squares

Theorem 1 is an existence proof for latin squares. A 1 x n latin square
is just a permutation of 1, …, n and therefore exists for all n. Theorem
1 ensures that the 1 x n latin rectangle can be extended to an n x n
latin square. Therefore latin squares exist for all n.

For example, to construct a latin square of order 12, start with the
latin rectangle

![](figure/first_row-1.png)<!-- -->

and use `add_rows` to add eleven more rows.

``` r
expand_grid(row = 1:1, column = 1:12) %>%
  mutate(symbol = 1:12) %>%
  add_rows(2:12) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  geom_text(aes(label = symbol), colour = "white") +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )
```

![](figure/existence_plot-1.png)<!-- -->

## Examples

There are three scripts in this repository for generating PNG images of
latin squares constructed by the method described above. The resulting
images are surprising in some cases for the regularity they display and
in cases surprising for their disorder.

### Latin square of order 15

See `15x15_latin_square.R`

``` r
l_order <- 15

first_row <- 1:l_order

expand_grid(row = 1:1, column = 1:l_order) %>%
  mutate(symbol = first_row) %>%
  add_rows(2:l_order) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  geom_text(aes(label = symbol), size = 5, colour = "white") +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  )

ggsave(file = "15x15_latin_square.png", width = 8, height = 8)
```

![](15x15_latin_square.png)

### Latin square of order 80

See `80x80_latin_square.R`

``` r
l_order <- 80

first_row <- 1:l_order

expand_grid(row = 1:1, column = 1:l_order) %>%
  mutate(symbol = first_row) %>%
  add_rows(rows = 2:l_order) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  ) +
  scale_fill_viridis_c(option = "magma")

ggsave(file = "80x80_latin_square.png", width = 8, height = 8)
```

![](80x80_latin_square.png)

### Latin square of order 495

See `495x495_latin_square.R`

``` r

l_order <- 495

first_row <- 1:l_order

expand_grid(row = 1:1, column = 1:l_order) %>%
  mutate(symbol = first_row) %>%
  add_rows(rows = 2:l_order) %>%
  ggplot(aes(column, row)) +
  geom_tile(aes(fill = symbol)) +
  scale_y_reverse() +
  coord_fixed() +
  theme_void() +
  theme(
    legend.position  = "none",
  ) +
  scale_fill_scico(palette = 'davos')

ggsave(file = "495x495_latin_square.png", width = 8, height = 8)
```

![](495x495_latin_square.png)

## Appendix: Implementation details

The `add_rows` function actually doesn’t do very much. It just loops
through the rows specified by the user, calls the `next_row` function to
find a candidate next row and then augments the input rectangle with the
new row.

Most of the work is done inside the `next_row` function.

In the `next_row` function the input latin rectangle is converted into a
bipartite graph (using the `to_tidygraph`) function. This bipartite
graph has one vertex partition representing the columns of the latin
rectangle and another vertex partition representing the symbols. The
graph contains an edge for every symbol not used in a column. In other
words the column vertices are joined to all of the symbol vertices,
except the ones that represent symbols already used in that column.

A compatible next row corresponds to a matching in this bipartite graph.
The `max_bipartite_match` function from `igraph` can find such a
matching.

One the matching is found, the rest of the `next_row` function converts
the matching into a vector of symbols to be used in the next row.

### The symbol-missing-from-column bipartite graph

The bipartite graph used by the `next_row` function is created by the
`to_tidygraph` function. Input to this function is a latin rectangle in
the partial orthongal array data frame format. Output is a `tbl_graph`
from the `tidygraph` package representing the bipartite graph described
in the previous section.

``` r
library(ggraph)

expand_grid(row = 1:1, column = 1:12) %>%
  mutate(symbol = 1:12) %>%
  add_rows(2:6) %>%
  to_tidygraph(l_order = 12) %>%
  ggraph(layout = "auto") +
  geom_edge_link() +
  geom_node_label(aes(label = name)) +
  theme_void()
```

![](figure/bipartite_graph-1.png)<!-- -->

## References

<div id="refs" class="references">

<div id="ref-hallExistenceTheoremLatin1945">

Hall, Marshall. 1945. “An Existence Theorem for Latin Squares.”
*Bulletin of the American Mathematical Society* 51 (Number 6, Part 1):
387–88. <https://projecteuclid.org/euclid.bams/1183506980>.

</div>

</div>
