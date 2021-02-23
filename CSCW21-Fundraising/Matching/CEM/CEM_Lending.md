## SATT: Estimating the causal effect from cem output

# Appeal
att(mat, NumContributors ~ Status, data = lending, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##               G0    G1
## All       114536 29013
## Matched     7150  7150
## Unmatched 107386 21863
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 1.790959 (p.value=0.000000)
## 95% conf. interval: [1.590595, 1.991322]
# Momentum
att(mat, CovInterEventTime ~ Status, data = lending, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##               G0    G1
## All       114536 29013
## Matched     7150  7150
## Unmatched 107386 21863
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 1.074863 (p.value=0.000000)
## 95% conf. interval: [0.936068, 1.213658]
# Variation
att(mat, CovContributionAmount ~ Status, data = lending, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##               G0    G1
## All       114536 29013
## Matched     7150  7150
## Unmatched 107386 21863
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 1.236335 (p.value=0.000000)
## 95% conf. interval: [1.105450, 1.367220]
# Latency
att(mat, TimeToFirstContribution..sec. ~ Status, data = lending, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##               G0    G1
## All       114536 29013
## Matched     7150  7150
## Unmatched 107386 21863
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: -1.535896 (p.value=0.000000)
## 95% conf. interval: [-1.618180, -1.453612]
# Engagement
att(mat, Duration..days. ~ Status, data = lending, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##               G0    G1
## All       114536 29013
## Matched     7150  7150
## Unmatched 107386 21863
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: -0.680682 (p.value=0.000000)
## 95% conf. interval: [-0.747724, -0.613640]