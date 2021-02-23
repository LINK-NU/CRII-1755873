## SATT: Estimating the causal effect from cem output

# Appeal
att(mat, NumContributors ~ Status, data = equity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##            G0  G1
## All       479 261
## Matched   198 198
## Unmatched 281  63
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 1.441204 (p.value=0.007133)
## 95% conf. interval: [0.391347, 2.491060]
# Momentum
att(mat, CovInterEventTime ~ Status, data = equity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##            G0  G1
## All       479 261
## Matched   198 198
## Unmatched 281  63
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 0.477487 (p.value=0.064729)
## 95% conf. interval: [-0.029168, 0.984142]
# Variation
att(mat, CovContributionAmount ~ Status, data = equity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##            G0  G1
## All       479 261
## Matched   198 198
## Unmatched 281  63
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 0.584149 (p.value=0.021921)
## 95% conf. interval: [0.084565, 1.083733]
# Latency
att(mat, TimeToFirstContribution..sec. ~ Status, data = equity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##            G0  G1
## All       479 261
## Matched   198 198
## Unmatched 281  63
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: -0.594363 (p.value=0.010961)
## 95% conf. interval: [-1.052284, -0.136442]
# Engagement
att(mat, Duration..days. ~ Status, data = equity, model="logit")
## Warning in eval(family$initialize): non-integer #successes in a binomial
## glm!
## 
##            G0  G1
## All       479 261
## Matched   198 198
## Unmatched 281  63
## 
## Logistic model on CEM matched data:
## 
## SATT point estimate: 0.141986 (p.value=0.548311)
## 95% conf. interval: [-0.321599, 0.605570]
