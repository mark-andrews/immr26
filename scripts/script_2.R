library(immr)
library(tidyverse)
library(lmerTest)

# Nested data -------------------------------------------------------------


M_15 <- lmer(mathscore ~ ses + (ses|schoolid), data = classroom)
summary(M_15)


M_16 <- lmer(mathscore ~ ses + (ses|schoolid) + (ses|classid), data = classroom)
summary(M_16)


M_17 <- lmer(mathscore ~ ses + (ses|schoolid) + (ses||classid), data = classroom)
summary(M_17)

M_18 <- lmer(mathscore ~ ses + (ses|schoolid) + (1|classid), data = classroom)

anova(M_15, M_18)

# this is not a good idea
M_19 <- lmer(mathscore ~ ses + (ses|schoolid) + (1|classid2), data = classroom)

M_20 <- lmer(mathscore ~ ses + (1|schoolid/classid2), data = classroom)
M_21 <- lmer(mathscore ~ ses + (1|schoolid) + (1|schoolid:classid2), data = classroom)

fixef(M_20)
fixef(M_21)

VarCorr(M_20)
VarCorr(M_21)


M_22 <- lmer(mathscore ~ ses + (ses|schoolid) + (1|schoolid:classid2), data = classroom)
fixef(M_22)
fixef(M_18)
VarCorr(M_22)
VarCorr(M_18)

# Crossed data structures -------------------------------------------------

M_23 <- lmer(rt ~ (1|item) + (1|participant), data = blp_short2)

# mathscore ~ ses + (ses|schoolid) + (ses|classid)
M_23 <- lmer(rt ~ freq + (freq|item) + (freq|participant), data = blp_short2)

# this makes sense
M_24 <- lmer(rt ~ freq + (freq|participant), data = blp_short2)
# but this does not ...
M_25 <- lmer(rt ~ freq + (freq|item), data = blp_short2)


M_26 <- lmer(rt ~ freq + (1|item) + (freq|participant), 
             data = mutate(blp_short2, freq = scale(freq)[,1]))

summary(M_26)


# R^2 in multilevel linear models, linear mixed effects models ------------

# R^2 in good old fashioned linear models
M_27 <- lm(dist ~ speed, data = cars)
summary(M_27)$r.sq

var(cars$dist)
var(predict(M_27))
var(predict(M_27)) / var(cars$dist)

var(predict(M_27)) /(var(predict(M_27)) + var(residuals(M_27)))

# prediction in linear mixed effects models
predict(M_9) |> head()
add_predictions(pvtrt, model = M_9)

predict(M_9, re.form = NA) |> head() # fixed effects only used for predictions

# rough estimate of MARGINAL R^2
var(predict(M_9, re.form = NA)) / var(pvtrt$rt)

# rough estimate of CONDITIONAL R^2
var(predict(M_9)) / var(pvtrt$rt)

library(performance)
r2_nakagawa(M_9)


science_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/immr26/refs/heads/main/data/science.csv") |> 
  mutate(like2 = factor(like, ordered = TRUE))

M_28 <- lmer(like ~ PrivPub + (1|school), data = science_df)

library(ordinal)
M_29 <- clmm(like2 ~ PrivPub + (1|school), data = science_df)
  

# Power analysis / sample size determination ------------------------------
library(pwr)
# if every power analysis could be as easy as this
pwr.t.test(n=100, d = 0.3)

# We'll do power analysis for this model
# lmer(rt ~ day + (day|id), data = pvtrt)


fixed_b <- c(250, 5)

V <- matrix(c(600, 0,
              0, 35), nrow=2)

s <- 25

library(simr)

fake_model <- makeLmer(
  y ~ day + (day|id),
  data = pvtrt,
  fixef = fixed_b,
  VarCorr = V,
  sigma = s
)

powerSim(fake_model, test = fixed("day"), nsim = 1000)
