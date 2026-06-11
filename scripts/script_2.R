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


M_26 <- lmer(rt ~ freq + (1|item) + (freq|participant), data = blp_short2)





