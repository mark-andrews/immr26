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
