# South Sudan Resilience
# data cleaning

dat <- read_dta("data/cleaned/mesp_household_baseline_survey_cleaning_inprogress.dta") %>%
  filter(!is.na(ea),
         ea!=730703001103,
         ea!=930601003203,
         ea!=930606001204)

datNames <- data.frame(names(dat))

names(dat)

frq(dat$state)
frq(dat$county)

cnty_st <- dat %>%
  group_by(state, county) %>%
  summarize(n=n()) %>%
  mutate(freq=n/nrow(dat))

cnty_st

sum(cnty_st$freq)


# EAs ---- 

frq(dat$ea)

ea <- dat %>%
  group_by(ea) %>%
  summarize(n=n()) %>%
  #filter(n>1) %>%
  arrange(desc(n))

ea
tail(ea)

?svydesign
options(survey.lonely.psu="remove")

svydat <- svydesign(data = dat,
                    ids = ~ea,
                    strata = ~county)

svyrdat <- dat %>%
  as_survey_design(ids = ea,
                   strata=county)

frq(dat$q_504)

dat <- dat %>%
  mutate(donor = ifelse(q_504 == 1, 1,0),
         conflict=ifelse(q_601==1, 1,0))

describe(dat$donor)
describe(dat$conflict)

donor_desc <- dat %>%
  summarize(mn=mean(donor, na.rm=T),
            sd=sd(donor, na.rm=T),
            se=std.error(donor))

donor_desc
# 52%, sd .5, se .00732

?svymean

svymean(~donor,
        na.rm=T,
        deff="replace",
        design=svydat)

# .52, se .0183

sqrt(6.3)
.0183*1.96
# margin 3.6 percent

.0183/.00732
# 2.5 deff

?icc

head(ea)

m <- mean(ea$n)

m
# 19.2

library(samplesize4surveys)
?ICC
rho <- ICC(y=dat$donor,
           cl=dat$ea)

rho

library(Hmisc)
?deff
deff(dat$donor, dat$ea, type="kish")


blood.pressure <- rnorm(1000, 120, 15)
clinic <- sample(letters, 1000, replace=TRUE)
deff(blood.pressure, clinic, type="kish")


library(PracTools)
deff(y=dat$donor,
     clvar=dat$ea)



frq(dat$q_601)

describe(dat$conflict)

conflict_desc <- dat %>%
  summarize(mn=mean(conflict, na.rm=T),
            sd=sd(conflict, na.rm=T),
            se=std.error(conflict))

conflict_desc
# mn .349, sd .477, se .00698

svymean(~conflict,
        na.rm=T,
        deff="replace",
        design=svydat)

# mn .3492, se .0156, DEFF 5.02

sqrt(5.02)
# 2.241

.0156/.00698
# 2.235
