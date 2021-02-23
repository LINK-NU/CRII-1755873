#!/usr/bin/env Rscript

# Install Packages
# install.packages("cem")

# Import Packages
library(cem)
library(readr)
library(xtable)
library(ggplot2)
library(dplyr)
library(reshape)
library(lme4)
library(diptest)

# Set working directory
setwd("~/Documents/CRII/DonorsChoose")
# Import Data
charity <- read.csv("./Data/charity_cem_all.csv")

# Independent Variables (Crowd Features)
charity$NumContributors <- as.numeric(charity$NumContributors)
charity$CovInterEventTime <- as.numeric(charity$CovInterEventTime)
charity$CovContributionAmount <- as.numeric(charity$CovContributionAmount)
charity$TimeToFirstContribution..sec. <- as.numeric(charity$TimeToFirstContribution..sec.)
charity$Duration..days. <- as.numeric(charity$Duration..days.)

dip.test(charity$NumContributors, simulate.p.value = FALSE)
dip.test(charity$CovInterEventTime, simulate.p.value = FALSE)
dip.test(charity$CovContributionAmount, simulate.p.value = FALSE)
dip.test(charity$TimeToFirstContribution..sec., simulate.p.value = FALSE)
dip.test(charity$Duration..days., simulate.p.value = FALSE)

# Pre-Treatment Control Variables (Platform Features)
charity$primary_focus_area <-  as.factor(charity$primary_focus_area)
charity$grade_level <-  as.factor(charity$grade_level)
charity$school_metro <-  as.factor(charity$school_metro)
charity$resource_type <-  as.factor(charity$resource_type)
charity$teacher_prefix <-  as.factor(charity$teacher_prefix)
charity$AmountRequested <-  as.numeric(charity$AmountRequested)

# Dependent Variable (Class Feature)
charity$Status <-  as.numeric(charity$Status)

# Compare class sizes

ct <- which(charity$Status==0)
tr <- which(charity$Status==1)

ntr <- length(tr)
nct <- length(ct)

table(charity$Status)

# Platform variables: pre-treatment covariates (not randomly assigned)
vars.platform <- c("school_metro", "primary_focus_area", "grade_level", "resource_type", "teacher_prefix", "AmountRequested", 'Status')

# Focus on these pre-treatment covariates
# Compute L1 statistic, as well as several unidimensional measures of imbalance
imbalance(group = charity$Status, data = charity[vars.platform], drop = "Status")

# Automated Coarsening
mat <- cem(treatment = "Status", data = charity[vars.platform], drop = "Status", eval.imbalance = TRUE, keep.all = TRUE, k2k=TRUE)
# mat # L1 Statistic
mat

# Categorical variables levels
# levels(charity$school_metro)
# levels(charity$primary_focus_area)
# levels(charity$resource_type)
# levels(charity$grade_level)
# levels(charity$teacher_prefix)

# Numerical Variables
# table(charity$AmountRequested)

# qplot(data = charity, AmountRequested, geom = "histogram", binwidth=0.1)

# relax matches
tab <- relax.cem(mat, charity, depth = 1, perc = 0.3)

## SATT: Estimating the causal effect from cem output

# Appeal
att(mat, NumContributors ~ Status, data = charity, model="logit")
# Momentum
att(mat, CovInterEventTime ~ Status, data = charity, model="logit")
# Variation
att(mat, CovContributionAmount ~ Status, data = charity, model="logit")
# Latency
att(mat, TimeToFirstContribution..sec. ~ Status, data = charity, model="logit")
# Engagement
att(mat, Duration..days. ~ Status, data = charity, model="logit")

write.csv(mat$X, file = "./Data/cem_results.csv")


