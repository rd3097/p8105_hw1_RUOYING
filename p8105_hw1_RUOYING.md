p8105_hw1_RUOYING
================
RUOYING DENG
2023-09-21

``` r
usethis::use_git_config(user.name ="rd3097", user.email = "rd3097@cumc.columbica.edu")
library("tidyverse")
```

    ## -- Attaching core tidyverse packages ------------------------ tidyverse 2.0.0 --
    ## v dplyr     1.1.3     v readr     2.1.4
    ## v forcats   1.0.0     v stringr   1.5.0
    ## v ggplot2   3.4.3     v tibble    3.2.1
    ## v lubridate 1.9.2     v tidyr     1.3.0
    ## v purrr     1.0.2     
    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()
    ## i Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library("moderndive")
```

## Problem 1

``` r
data("early_january_weather")
skimr::skim(early_january_weather)
```

|                                                  |                       |
|:-------------------------------------------------|:----------------------|
| Name                                             | early_january_weather |
| Number of rows                                   | 358                   |
| Number of columns                                | 15                    |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |                       |
| Column type frequency:                           |                       |
| character                                        | 1                     |
| numeric                                          | 13                    |
| POSIXct                                          | 1                     |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |                       |
| Group variables                                  | None                  |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| origin        |         0 |             1 |   3 |   3 |     0 |        1 |          0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate |    mean |     sd |      p0 |     p25 |     p50 |     p75 |    p100 | hist  |
|:--------------|----------:|--------------:|--------:|-------:|--------:|--------:|--------:|--------:|--------:|:------|
| year          |         0 |          1.00 | 2013.00 |   0.00 | 2013.00 | 2013.00 | 2013.00 | 2013.00 | 2013.00 | ▁▁▇▁▁ |
| month         |         0 |          1.00 |    1.00 |   0.00 |    1.00 |    1.00 |    1.00 |    1.00 |    1.00 | ▁▁▇▁▁ |
| day           |         0 |          1.00 |    8.04 |   4.31 |    1.00 |    4.00 |    8.00 |   12.00 |   15.00 | ▇▇▇▇▇ |
| hour          |         0 |          1.00 |   11.53 |   6.92 |    0.00 |    6.00 |   11.50 |   17.75 |   23.00 | ▇▇▆▇▇ |
| temp          |         0 |          1.00 |   39.58 |   7.06 |   24.08 |   33.98 |   39.02 |   44.96 |   57.92 | ▃▇▇▇▁ |
| dewp          |         0 |          1.00 |   28.06 |  10.73 |    8.96 |   19.94 |   26.06 |   35.06 |   53.06 | ▃▇▆▂▃ |
| humid         |         0 |          1.00 |   65.48 |  18.95 |   32.86 |   51.34 |   61.67 |   78.68 |  100.00 | ▃▇▆▂▅ |
| wind_dir      |         5 |          0.99 |  208.19 | 115.58 |    0.00 |  140.00 |  240.00 |  290.00 |  360.00 | ▅▁▂▇▆ |
| wind_speed    |         0 |          1.00 |    8.23 |   4.61 |    0.00 |    5.75 |    8.06 |   11.51 |   24.17 | ▅▇▆▂▁ |
| wind_gust     |       308 |          0.14 |   22.53 |   3.63 |   16.11 |   19.56 |   21.86 |   25.32 |   31.07 | ▅▇▃▇▁ |
| precip        |         0 |          1.00 |    0.00 |   0.01 |    0.00 |    0.00 |    0.00 |    0.00 |    0.19 | ▇▁▁▁▁ |
| pressure      |        38 |          0.89 | 1022.52 |   5.57 | 1010.80 | 1018.30 | 1022.05 | 1027.23 | 1034.40 | ▃▇▇▇▃ |
| visib         |         0 |          1.00 |    8.52 |   3.00 |    0.12 |    9.00 |   10.00 |   10.00 |   10.00 | ▁▁▁▁▇ |

**Variable type: POSIXct**

| skim_variable | n_missing | complete_rate | min                 | max                 | median              | n_unique |
|:--------------|----------:|--------------:|:--------------------|:--------------------|:--------------------|---------:|
| time_hour     |         0 |             1 | 2013-01-01 01:00:00 | 2013-01-15 23:00:00 | 2013-01-08 12:30:00 |      358 |

The variable names included in this datasets are origin, year, month,
day, hour, temp, dewp, humid, wind_dir, wind_speed, wind_gust, precip,
pressure, visib, time_hour.

The size of the data sets is that it has 358 rows.

The number of columns is 15.

The mean temperature of early january weather is 39.5821229 degrees.

``` r
ggplot(early_january_weather,aes(x = time_hour, y = temp, color = humid)) + geom_point()
```

![](p8105_hw1_RUOYING_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
This graph shows that the temperature tends to become higher during
early January, and achieves its highest peak at January 14th. The
temperature also vibrate a lot each day. The humidity acheives its
highest before January 14th.

``` r
ggsave("weather_scatterplot.pdf")
```

    ## Saving 7 x 5 in image

\#Problem 2

``` r
# create the dataframes
df = tibble(
  vec_numeric = rnorm(10),
  vec_logical = c(vec_numeric > 0),
  vec_char = c("Red", "Yellow", "Green", "Red", "Red", "Yellow", "Red", "Green", "Green", "Yellow"),
  vec_factor = factor(vec_char, level=c("Red", "Yellow", "Green"))
)  

df
```

    ## # A tibble: 10 x 4
    ##    vec_numeric vec_logical vec_char vec_factor
    ##          <dbl> <lgl>       <chr>    <fct>     
    ##  1     -0.115  FALSE       Red      Red       
    ##  2     -0.0274 FALSE       Yellow   Yellow    
    ##  3     -0.412  FALSE       Green    Green     
    ##  4      0.0164 TRUE        Red      Red       
    ##  5      0.386  TRUE        Red      Red       
    ##  6      1.08   TRUE        Yellow   Yellow    
    ##  7     -0.402  FALSE       Red      Red       
    ##  8     -1.26   FALSE       Green    Green     
    ##  9      0.476  TRUE        Green    Green     
    ## 10      1.98   TRUE        Yellow   Yellow

``` r
#calculate the mean value of each variable

numeric = mean(pull(df,vec_numeric))
logical = mean(pull(df, vec_logical))
char = mean(pull(df, vec_char))
```

    ## Warning in mean.default(pull(df, vec_char)): argument is not numeric or
    ## logical: returning NA

``` r
factor = mean(pull(df, vec_factor))
```

    ## Warning in mean.default(pull(df, vec_factor)): argument is not numeric or
    ## logical: returning NA

The mean of a random sample of size 10 from a standard Normal
distribution is 0.1729249. The mean of a logical vector indicating
whether elements of the sample are greater than 0 is 0.5. The mean of a
character vector of length 10 is NA. The mean of a factor vector of
length 10, with 3 different factor “levels” is NA.

The mean works for numeric and logical variables, but it doesn’t work
for character and factor variables.

``` r
# convert logical, character, and factor variables to be numerical
numeric_logical = as.numeric(logical)
numeric_character = as.numeric(char)
numeric_factor = as.numeric(factor)
```

Logical variable can be convert to numerical variable, where TRUE
convert to 1, and FALSE convert to 0. So the mean can be calculated as
0.5. Factor vector will be assigned a numeric value to each factor level
based on the order of appearance.The mean of factor variable is NA. For
character variable, it contains non-numeric characters, so it cannot be
convert to numerical variable, then the mean cannot be calculated.The
output of mean is NA.
