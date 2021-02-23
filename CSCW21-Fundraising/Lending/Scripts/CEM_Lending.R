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
library(diptest)

# Set working directory
setwd("~/Documents/CRII/Prosper")
# Import Data
lending <- read.csv("./Data/lending_cem_all.csv")

# Independent Variables (Crowd Features)
lending$NumContributors <- as.numeric(lending$NumContributors)
lending$CovInterEventTime <- as.numeric(lending$CovInterEventTime)
lending$CovContributionAmount <- as.numeric(lending$CovContributionAmount)
lending$TimeToFirstContribution..sec. <- as.numeric(lending$TimeToFirstContribution..sec.)
lending$Duration..days. <- as.numeric(lending$Duration..days.)

dip.test(lending$NumContributors, simulate.p.value = FALSE)
dip.test(lending$CovInterEventTime, simulate.p.value = FALSE)
dip.test(lending$CovContributionAmount, simulate.p.value = FALSE)
dip.test(lending$TimeToFirstContribution..sec., simulate.p.value = FALSE)
dip.test(lending$Duration..days., simulate.p.value = FALSE)

# Pre-Treatment Control Variables (Platform Features)
lending$AmountRequested <- as.numeric(lending$AmountRequested)
lending$BorrowerRate <- as.numeric(lending$BorrowerRate)
lending$MonthlyLoanPayment <- as.numeric((lending$MonthlyLoanPayment))
lending$ProsperScore <- as.factor(lending$ProsperScore)
lending$CreditGrade <- as.factor(lending$CreditGrade)
lending$DebtToIncomeRatio <- as.numeric(lending$DebtToIncomeRatio)
lending$IsBorrowerHomeowner <- as.factor(lending$IsBorrowerHomeowner)

# Dependent Variable (Class Feature)
lending$Status <- as.numeric(lending$Status)

# Compare class sizes
tr <- which(lending$Status==1)
ct <- which(lending$Status==0)

# min(lending$Status)
# max(lending$Status)

ntr <- length(tr)
nct <- length(ct)

# Platform variables: pre-treatment covariates (not randomly assigned)
vars.platform <- c("BorrowerRate", "ProsperScore", "CreditGrade", "DebtToIncomeRatio", "AmountRequested", "MonthlyLoanPayment", "IsBorrowerHomeowner", 'Status')

# Focus on these pre-treatment covariates
# Compute L1 statistic, as well as several unidimensional measures of imbalance
imbalance(group = lending$Status, data = lending[vars.platform], drop = "Status")

# Automated Coarsening
mat <- cem(treatment = "Status", data = lending[vars.platform], drop = "Status", eval.imbalance = TRUE, keep.all = TRUE, k2k=TRUE)
mat # L1 Statistic

# Categorical variables levels
 # levels(lending$CreditGrade)
 # levels(lending$IsBorrowerHomeowner)
 # levels(lending$ProsperScore)

# Numerical Variables
# table(lending$AmountRequested)
# table(lending$BorrowerRate)
# table(lending$DebtToIncomeRatio)
# table(lending$MonthlyLoanPayment)

# qplot(data = lending, BorrowerRate, geom = "histogram", binwidth=0.1)

# relax matches
tab <- relax.cem(mat, lending, depth = 1, perc = 0.3)

## SATT: Estimating the causal effect from cem output

# Appeal
att(mat, NumContributors ~ Status, data = lending, model="logit")
# Momentum
att(mat, CovInterEventTime ~ Status, data = lending, model="logit")
# Variation
att(mat, CovContributionAmount ~ Status, data = lending, model="logit")
# Latency
att(mat, TimeToFirstContribution..sec. ~ Status, data = lending, model="logit")
# Engagement
att(mat, Duration..days. ~ Status, data = lending, model="logit")

write.csv(mat$X, file = "./Data/cem_results.csv")



