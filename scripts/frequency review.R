# starter script

#source("00 - resilience prep.R")

library(tidyverse)
library(sjmisc)
library(janitor)
library(skimr)
library(psych)

dat <- read_dta("data/cleaned/mesp_household_baseline_survey_cleaning_inprogress.dta") 

datNames <- data.frame(names(dat))

names(dat)

# q_504 / Indicator 1 knowledge of dev work within community ----

  # overall

  # by county

  # by language of survey (q_211)

  # by ??

  # by ??

# q_517 use government services ---- 

  # overall

  # by county

  # by language of survey (q_211)

  # by ??

  # by ??

# q_519 satisfaction with public services ---- 

  # overall (all categories)

frq(dat$q_519)

  # for disaggregations, collapse ordinal variable to binary:

dat <- dat %>%
  mutate(services = ifelse(q_519 >2 1, 1,0))

  # by county

  # by language of survey (q_211)

  # by ??

  # by ??

# conflict in last six months ---- 

frq(dat$q_601)

  # by county

  # by language of survey (q_211)

  # by ??

  # by ??

