## SATT: Estimating the causal effect from cem output

# Appeal
att(mat, NumContributors ~ Status, data = charity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##             G0     G1
## All       1295 214531
## Matched   1294   1294
## Unmatched    1 213237
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 0.864068 (p.value=0.004650)
## 95% conf. interval: [0.265714, 1.462422]
# Momentum
att(mat, CovInterEventTime ~ Status, data = charity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##             G0     G1
## All       1295 214531
## Matched   1294   1294
## Unmatched    1 213237
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 0.522143 (p.value=0.000688)
## 95% conf. interval: [0.220645, 0.823640]
# Variation
att(mat, CovContributionAmount ~ Status, data = charity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##             G0     G1
## All       1295 214531
## Matched   1294   1294
## Unmatched    1 213237
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 0.966268 (p.value=0.000000)
## 95% conf. interval: [0.648419, 1.284117]
# Latency
att(mat, TimeToFirstContribution..sec. ~ Status, data = charity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##             G0     G1
## All       1295 214531
## Matched   1294   1294
## Unmatched    1 213237
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: -0.025478 (p.value=0.751047)
## 95% conf. interval: [-0.182876, 0.131920]
# Engagement
att(mat, Duration..days. ~ Status, data = charity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##             G0     G1
## All       1295 214531
## Matched   1294   1294
## Unmatched    1 213237
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: -0.956404 (p.value=0.000000)
## 95% conf. interval: [-1.302551, -0.610256]