#!/usr/bin/env Rscript

# Install Packages
# install.packages("cem")
# install.packages("reshape")
# install.packages("lme4")

# Import Packages
library(cem)
library(readr)
library(xtable)
library(ggplot2)
library(dplyr)
library(reshape)
library(lme4)

# Set working directory
setwd("~/Documents/CRII/Seedrs")
# Import Data
equity <- read.csv("./Data/equity_cem.csv")

# Independent Variables (Crowd Features)
equity$NumContributors <- as.numeric(equity$NumContributors)
equity$CovInterEventTime <- as.numeric(equity$CovInterEventTime)
equity$CovContributionAmount <- as.numeric(equity$CovContributionAmount)
equity$TimeToFirstContribution..sec. <- as.numeric(equity$TimeToFirstContribution..sec.)
equity$Duration..days. <- as.numeric(equity$Duration..days.)

# Pre-Treatment Control Variables (Platform Features)
equity$AmountRequested <- as.numeric(equity$AmountRequested)
equity$EquityPercent <- as.numeric(equity$EquityPercent)
equity$PreMoneyValuation <- as.numeric(equity$PreMoneyValuation)
equity$NumEntrepreneurs <- as.numeric(equity$NumEntrepreneurs)
equity$EisComplinat <- as.factor(equity$EisComplinat)
equity$SeisCompliant <- as.factor(equity$SeisCompliant)
equity$PassedQuiz <- as.factor(equity$PassedQuiz)
equity$SelfCertification <- as.factor(equity$SelfCertification)

# Dependent Variable (Class Feature)
equity$Status <- as.numeric(equity$Status)

# Compare class sizes
tr <- which(equity$Status==1) # Funded Projects
ct <- which(equity$Status==0) # Failed Projects

ntr <- length(tr)
nct <- length(ct)

min(equity$Status)
max(equity$Status)

mean(equity$Status[tr]) - mean(equity$Status[ct])

# Platform variables: pre-treatment covariates (not randomly assigned)
vars.platform <- c("AmountRequested", "EquityPercent", "PreMoneyValuation", "NumEntrepreneurs", "SeisCompliant", "EisComplinat", "PassedQuiz", "SelfCertification", "Status")

# Focus on these pre-treatment covariates
# Compute L1 statistic, as well as several unidimensional measures of imbalance
imbalance(group = equity$Status, data = equity[vars.platform], drop = "Status")

# Automated Coarsening
mat <- cem(treatment = "Status", data = equity[vars.platform], drop = "Status", eval.imbalance = TRUE, keep.all = TRUE, k2k=TRUE)
mat # L1 Statistic


# Categorical variables levels
levels(equity$SeisCompliant)
levels(equity$EisComplinat)
levels(equity$PassedQuiz)
levels(equity$SelfCertification)

# Numerical Variables
table(equity$EquityPercent)
table(equity$PreMoneyValuation)

# qplot(data = equity, EquityPercent, geom = "histogram", binwidth=.01)

# relax matches
tab <- relax.cem(mat, equity, depth = 1, perc = 0.3)


## SATT: Estimating the causal effect from cem output

# Appeal
att(mat, NumContributors ~ Status, data = equity, model="logit")
# Momentum
att(mat, CovInterEventTime ~ Status, data = equity, model="logit")
# Variation
att(mat, CovContributionAmount ~ Status, data = equity, model="logit")
# Latency
att(mat, TimeToFirstContribution..sec. ~ Status, data = equity, model="logit")
# Engagement
att(mat, Duration..days. ~ Status, data = equity, model="logit")

write.csv(mat$X, file = "./Data/cem_results.csv")

