## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE------------------------------------------------
library(metawho)

## ------------------------------------------------------------------------
library(metawho)

### specify hazard ratios (hr)
hr    <- c(0.30, 0.11, 1.25, 0.63, 0.90, 0.28)
### specify lower bound for hr confidence intervals
ci.lb <- c(0.09, 0.02, 0.82, 0.42, 0.41, 0.12)
### specify upper bound for hr confidence intervals
ci.ub <- c(1.00, 0.56, 1.90, 0.95, 1.99, 0.67)
### trials
trial <- c("Rizvi 2015", "Rizvi 2015",
          "Rizvi 2018", "Rizvi 2018",
          "Hellmann 2018", "Hellmann 2018")
### subgroups
subgroup = rep(c("Male", "Female"), 3)

entry <- paste(trial, subgroup, sep = "-")
### combine as data.frame

wang2019 =
   data.frame(
        entry = entry,
        trial = trial,
        subgroup = subgroup,
        hr = hr,
        ci.lb = ci.lb,
        ci.ub = ci.ub,
        stringsAsFactors = FALSE
       )

deft_prepare(wang2019)

## ----load_wang2019-------------------------------------------------------
library(metawho)
data("wang2019")

wang2019

## ------------------------------------------------------------------------
# The 'Male' is the reference
(res = deft_do(wang2019, group_level = c("Male", "Female")))

## ---- fig.width=7--------------------------------------------------------
forest(res$subgroup$model, showweights = TRUE)

## ---- fig.width=7--------------------------------------------------------
forest(res$subgroup$model, showweights = TRUE, atransf = exp, 
       slab = res$subgroup$data$trial,
       xlab = "Hazard ratio")
op = par(no.readonly = TRUE)
par(cex = 0.75, font = 2)
text(-11, 4.5, "Trial(s)", pos = 4)
text(9, 4.5, "Hazard Ratio [95% CI]", pos = 2)
par(op)

