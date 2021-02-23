# install.packages("optmatch")

library(MatchIt)
library(cem)
library(optmatch)

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

vars.platform <- c("AmountRequested", "EquityPercent", "PreMoneyValuation", "NumEntrepreneurs", "SeisCompliant", "EisComplinat", "PassedQuiz", "SelfCertification")

# Dependent Variable (Class Feature)
equity$Status <- as.factor(equity$Status)

# Compare class sizes

ct <- which(equity$Status==0)
tr <- which(equity$Status==1)

ntr <- length(tr)
nct <- length(ct)


## KNN Match
nearest.match <- matchit(formula = Status ~ AmountRequested + EquityPercent + PreMoneyValuation + NumEntrepreneurs + EisComplinat + SeisCompliant + PassedQuiz + SelfCertification,
                 data = equity, 
                 method = "nearest")
nearest.match

# matched data
nearest.data <- match.data(nearest.match) 
write.csv(nearest.data, file = "./Data/equity_nearest_matched.csv")

# evaluate imbalance
nearest.imb <- imbalance(group=nearest.data$Status,
                     data=nearest.data[vars.platform],
                     drop=c("Status","distance",
                            "weights","subclass"))
nearest.imb$L1

## MDM Match
mdm.match <- matchit(formula = Status ~ AmountRequested + EquityPercent + PreMoneyValuation + NumEntrepreneurs + EisComplinat + SeisCompliant + PassedQuiz + SelfCertification, 
                     data = equity, method="full", distance = 'mahalanobis')
mdm.match

# matched data
mdm.data <- match.data(mdm.match) 
write.csv(mdm.data, file = "./Data/equity_mdm_matched.csv")

# evaluate imbalance
mdm.imb <- imbalance(group=mdm.data$Status,
                         data=mdm.data[vars.platform],
                         drop=c("Status","distance",
                                "weights","subclass"))
mdm.imb$L1

# plot(nearest.match, type='hist')

## CEM Match

AmountRequestedcut <- seq(0, max(equity$AmountRequested), by=.1)
EquityPercentcut <- seq(0, max(equity$EquityPercent), by=.1)
PreMoneyValuationcut <- seq(0, max(equity$PreMoneyValuation), by=.1)
NumEntrepreneurscut <- seq(0, max(equity$NumEntrepreneurs),by=.1)

# qplot(data = equity, NumEntrepreneurs, geom = "histogram", binwidth=.1)

my.cutpoints <- list(AmountRequested=AmountRequestedcut,
                     EquityPercent=EquityPercentcut,
                     PreMoneyValuation=PreMoneyValuationcut,
                     NumEntrepreneurs=NumEntrepreneurscut)

cem.match <- matchit(Status ~ AmountRequested + EquityPercent + PreMoneyValuation + NumEntrepreneurs + EisComplinat + SeisCompliant + PassedQuiz + SelfCertification,
                 data = equity, 
                 method = "cem",
                 cutpoints = my.cutpoints)

cem.match

# matched data
cem.data <- match.data(cem.match) 
write.csv(cem.data, file = "./Data/equity_cem_matched.csv")

# evaluate imbalance
cem.imb <- imbalance(group=cem.data$Status,
                     data=cem.data[vars.platform],
                     drop=c("Status","distance",
                            "weights","subclass"))

cem.imb$L1

# cem.match.att <- att(obj=cem.match, formula=Status ~ AmountRequested + EquityPercent + PreMoneyValuation + NumEntrepreneurs + EisComplinat + SeisCompliant + PassedQuiz + SelfCertification,
#                     data = cem.data[vars.platform], model="linear")


# plot(cem.match, type='hist')






