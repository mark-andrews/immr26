library(immr)
library(tidyverse)

rats_42 <- filter(rats, batch == 42) # batch 42 only

# analyse one group, batch 42
M_1 <- binomial_model(m, n, data = rats_42)

# complete pooling: ignore batch completely
M_2 <- binomial_model(m, n, data = rats)

# no pooling: separate analysis for each batch
M_3 <- binomial_model(m, n, group = batch, data = rats)

# multilevel model, which is a partial pooling model
M_4 <- binomial_model(m, n, group = batch, data = rats, multilevel = TRUE)

# visualize the distribution over batch level parameters
s <- rnorm(1e4, M_4$mu, M_4$tau)
hist(s, 25) # normal distribution over log odds
hist(plogis(s), 25) # inv logit transform of the normal

# Normal random effects models using lme4 ---------------------------------

alcohol_russia <- filter(alcohol, country == 'Russia')

M_5 <- lm(alcohol ~ 1, data = alcohol_russia)
coef(M_5)
sigma(M_5)

M_6 <- lm(alcohol ~ 1, data = alcohol) # complete pooling
coef(M_6)
sigma(M_6)

M_7 <- lm(alcohol ~ 0 + country, data = alcohol) # no pooling

# multilevel model
library(lme4)
M_8 <- lmer(alcohol ~ 1 + (1|country), data = alcohol)
summary(M_8)

# intra-class correlation coefficient
v <- as.data.frame(VarCorr(M_8))
variances <- v[,'vcov']
ICC <- variances[1]/sum(variances)

# these are the "mu" values, i.e. country specific means
coef(M_8)
ranef(M_8)


# Multilevel linear model, aka linear mixed effects -----------------------

ggplot(pvtrt, aes(x = day, y = rt, colour = id)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) +
  facet_wrap(~id) 
# 
M_9 <- lmer(rt ~ day + (day|id), data = pvtrt)
summary(M_9)

coef(M_9)


# random slopes, random intercepts, no correlation
M_10 <- lmer(rt ~ day + (day||id), data = pvtrt)
summary(M_10)

# null hypothesis test on correlation coefficient
anova(M_10, M_9)

M_11 <- lmer(rt ~ day + (1|id), data = pvtrt)
# M_11_alt <- lmer(rt ~ 1 + day + (1|id), data = pvtrt)
summary(M_11)

anova(M_11, M_10)

library(modelr)
add_predictions(pvtrt, model = M_11) |> 
  ggplot(aes(x = day, y = rt, colour = id)) + geom_point() +
  geom_line(aes(y = pred))

add_predictions(pvtrt, model = M_11) |> 
  ggplot(aes(x = day, y = rt, colour = id)) + geom_point() +
  geom_line(aes(y = pred)) +
  facet_wrap(~id)

anova(M_11, M_9)

# random slopes only
M_12 <- lmer(rt ~ 1 + day + (0 + day|id), data = pvtrt)








