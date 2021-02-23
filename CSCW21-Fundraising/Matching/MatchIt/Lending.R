library(MatchIt)
library(cem)

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

# Pre-Treatment Control Variables (Platform Features)
lending$AmountRequested <- as.numeric(lending$AmountRequested)
lending$BorrowerRate <- as.numeric(lending$BorrowerRate)
lending$MonthlyLoanPayment <- as.numeric((lending$MonthlyLoanPayment))
lending$ProsperScore <- as.factor(lending$ProsperScore)
lending$CreditGrade <- as.factor(lending$CreditGrade)
lending$DebtToIncomeRatio <- as.numeric(lending$DebtToIncomeRatio)
lending$IsBorrowerHomeowner <- as.factor(lending$IsBorrowerHomeowner)

# Platform variables: pre-treatment covariates (not randomly assigned)
vars.platform <- c("BorrowerRate", "ProsperScore", "CreditGrade", "DebtToIncomeRatio", "AmountRequested", "MonthlyLoanPayment", "IsBorrowerHomeowner")

# Dependent Variable (Class Feature)
lending$Status <- as.numeric(lending$Status)

# Compare class sizes
tr <- which(lending$Status==1)
ct <- which(lending$Status==0)

ntr <- length(tr)
nct <- length(ct)

## KNN Match
nearest.match <- matchit(formula = Status ~ AmountRequested + BorrowerRate + MonthlyLoanPayment + ProsperScore + CreditGrade + DebtToIncomeRatio + IsBorrowerHomeowner,
                         data = lending, 
                         method = "nearest")
nearest.match

# matched data
nearest.data <- match.data(nearest.match) 
write.csv(nearest.data, file = "./Data/lending_nearest_matched.csv")

# evaluate imbalance
nearest.imb <- imbalance(group=nearest.data$Status,
                         data=nearest.data[vars.platform],
                         drop=c("Status","distance",
                                "weights","subclass"))
nearest.imb$L1

# plot(nearest.match, type='hist')

## CEM Match

# AmountRequestedcut <- seq(0, max(lending$AmountRequested), by=.1)
# BorrowerRatecut <- seq(0, max(lending$BorrowerRate), by=.1)
# MonthlyLoanPaymentcut <- seq(0, max(lending$MonthlyLoanPayment), by=.1)
# DebtToIncomeRatiocut <- seq(0, max(lending$DebtToIncomeRatio),by=.1)

# qplot(data = equity, NumEntrepreneurs, geom = "histogram", binwidth=.1)

# my.cutpoints <- list(AmountRequested=AmountRequestedcut,
#                      BorrowerRate=BorrowerRatecut,
#                      MonthlyLoanPayment=MonthlyLoanPaymentcut,
#                      DebtToIncomeRatio=DebtToIncomeRatiocut)

cem.match <- matchit(Status ~ AmountRequested + BorrowerRate + MonthlyLoanPayment + ProsperScore + CreditGrade + DebtToIncomeRatio + IsBorrowerHomeowner,
                     data = lending, 
                     method = "cem") #,
                     # cutpoints = my.cutpoints)

cem.match

# matched data
cem.data <- match.data(cem.match) 
write.csv(cem.data, file = "./Data/lending_cem_matched.csv")

# evaluate imbalance
cem.imb <- imbalance(group=cem.data$Status,
                     data=cem.data[vars.platform],
                     drop=c("Status","distance",
                            "weights","subclass"))

cem.imb$L1


# plot(cem.match, type='hist')

