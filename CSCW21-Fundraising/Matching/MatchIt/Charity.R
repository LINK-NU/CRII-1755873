library(MatchIt)
library(cem)

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

# Pre-Treatment Control Variables (Platform Features)
charity$primary_focus_area <-  as.factor(charity$primary_focus_area)
charity$grade_level <-  as.factor(charity$grade_level)
charity$school_metro <-  as.factor(charity$school_metro)
charity$resource_type <-  as.factor(charity$resource_type)
charity$teacher_prefix <-  as.factor(charity$teacher_prefix)
charity$AmountRequested <-  as.numeric(charity$AmountRequested)

# Platform variables: pre-treatment covariates (not randomly assigned)
vars.platform <- c("school_metro", "primary_focus_area", "grade_level", "resource_type", "teacher_prefix", "AmountRequested")

# Dependent Variable (Class Feature)
charity$Status <-  as.numeric(charity$Status)

# Compare class sizes

ct <- which(charity$Status==0)
tr <- which(charity$Status==1)

ntr <- length(tr)
nct <- length(ct)

## KNN Match
nearest.match <- matchit(formula = Status ~ AmountRequested + teacher_prefix + resource_type + school_metro + grade_level + primary_focus_area,
                         data = charity, 
                         method = "nearest")
nearest.match

# matched data
nearest.data <- match.data(nearest.match) 
write.csv(nearest.data, file = "./Data/charity_nearest_matched.csv")

# evaluate imbalance
nearest.imb <- imbalance(group=nearest.data$Status,
                         data=nearest.data[vars.platform],
                         drop=c("Status","distance",
                                "weights","subclass"))
nearest.imb$L1

# plot(nearest.match, type='hist')

## CEM Match

AmountRequestedcut <- seq(0, max(charity$AmountRequested), by=.1)

# qplot(data = equity, NumEntrepreneurs, geom = "histogram", binwidth=.1)

my.cutpoints <- list(AmountRequested=AmountRequestedcut)

cem.match <- matchit(Status ~ AmountRequested + teacher_prefix + resource_type + school_metro + grade_level + primary_focus_area,
                     data = charity, 
                     method = "cem",
                     cutpoints = my.cutpoints)

cem.match

# matched data
cem.data <- match.data(cem.match) 
write.csv(cem.data, file = "./Data/charity_cem_matched.csv")

# evaluate imbalance
cem.imb <- imbalance(group=cem.data$Status,
                     data=cem.data[vars.platform],
                     drop=c("Status","distance",
                            "weights","subclass"))

cem.imb$L1


# plot(cem.match, type='hist')



