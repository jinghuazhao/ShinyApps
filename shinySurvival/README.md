This is a very early attempt to seed Shiny projects via the familiar survival analysis whose source code is available from

[https://github.com/jinghuazhao/ShinyApps/](https://github.com/jinghuazhao/ShinyApps/)

An end-user can upload his/her own data for a survival analysis and download the analysis report. The following aspects are experimented with data 
from R/survival package as follows:

```r
library(survival)
head(lung)
write.csv(survival::lung,file="lung.csv",quote=FALSE,row.names=FALSE)
```

### Upload data

This takes a local file in .csv or .tsv format, such as `lung.tsv` from above.

### Kaplan-Meier curve

Once the data is uploaded, this gives a Kaplan-Meier curve.

```r
plot(survfit(Surv(time, status) ~ 1, data = data()), xlab = "Days",  ylab = "Overall survival probability")
```
In the future it would be possible to select appropriate variables and models.

### Download data

This is an option to download a file in .tsv format.

### Generate report

This is a PDF file containing the commands and plots. For the current example, we have

```r
coxfit <- coxph(Surv(time, status) ~ age + sex + wt.loss, data = user_data)

# Survival curves by sex with adjustment for age and wt.loss
# A new data frame is generated containing two rows, one for each value of sex;
# the other covariates are fixed to their average values
new_df <- with(user_data,
               data.frame(sex = c(1, 2),
                          age = rep(mean(age, na.rm = TRUE), 2),
                          wt.loss = rep(mean(wt.loss, na.rm = TRUE), 2)
               )
)
new_df

library(survminer)
fit <- survfit(coxfit, newdata = new_df)
ggsurvplot(fit, conf.int = TRUE, palette = "Dark2", censor = FALSE,
           surv.median.line = "hv", data=user_data)
```
