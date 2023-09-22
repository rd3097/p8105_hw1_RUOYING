## ---- include = FALSE-----------------------------------------------
# knitr settings
knitr::opts_chunk$set(
  # Code output:
  warning = FALSE,
  message = FALSE,
  echo = TRUE,
  # Figure:
  out.width = "100%",
  fig.width = 16 / 2.5,
  fig.height = 9 / 2.5,
  fig.align = "center",
  fig.show = "hold",
  # Etc:
  collapse = TRUE,
  comment = "##"
  # tidy = FALSE
)

# Needed packages in vignette
library(moderndive)
library(ggplot2)
library(dplyr)
library(knitr)
library(broom)

# Needed packages internally
library(patchwork)

# Random number generator seed value
set.seed(76)

# Set ggplot defaults for rticles output:
if (!knitr::is_html_output()) {
  # Grey theme:
  theme_set(theme_light())

  scale_colour_discrete <- ggplot2::scale_colour_viridis_d
}


# Set output width for rticles:
options(width = 70)

## -------------------------------------------------------------------
library(moderndive)
library(ggplot2)
library(dplyr)
library(knitr)
library(broom)

## ---- echo=FALSE----------------------------------------------------
evals_sample <- evals %>%
  select(ID, prof_ID, score, age, bty_avg, gender, ethnicity, language, rank) %>%
  sample_n(5)

## ----random-sample-courses, echo=FALSE------------------------------
evals_sample %>%
  kable()

## -------------------------------------------------------------------
score_model <- lm(score ~ age, data = evals)

## -------------------------------------------------------------------
summary(score_model)

## -------------------------------------------------------------------
get_regression_table(score_model)

## -------------------------------------------------------------------
get_regression_points(score_model)

## -------------------------------------------------------------------
get_regression_summaries(score_model)

## ----interaction-model, fig.cap="Visualization of interaction model."----
# Code to visualize interaction model:
ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Age", y = "Teaching score", color = "Ethnicity")

## ----parallel-slopes-model, fig.cap="Visualization of parallel slopes model."----
# Code to visualize parallel slopes model:
ggplot(evals, aes(x = age, y = score, color = ethnicity)) +
  geom_point() +
  geom_parallel_slopes(se = FALSE) +
  labs(x = "Age", y = "Teaching score", color = "Ethnicity")

