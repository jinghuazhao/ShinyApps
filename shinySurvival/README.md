This is a very early attempt to seed Shiny projects via the familiar survival analysis whose source code is available from

[https://github.com/jinghuazhao/ShinyApps/](https://github.com/jinghuazhao/ShinyApps/)

An end-user can upload his/her own data for analysis and download the analysis report. The following aspects are experimented with data from 
R/survival package as follows:




```r
library(survival)
write.csv(survival::lung,file="lung.csv",quote=FALSE,row.names=FALSE)
knitr::kable(head(lung),caption="The lung data from R/survival package")
```



Table: The lung data from R/survival package

| inst| time| status| age| sex| ph.ecog| ph.karno| pat.karno| meal.cal| wt.loss|
|----:|----:|------:|---:|---:|-------:|--------:|---------:|--------:|-------:|
|    3|  306|      2|  74|   1|       1|       90|       100|     1175|      NA|
|    3|  455|      2|  68|   1|       0|       90|        90|     1225|      15|
|    3| 1010|      1|  56|   1|       0|       90|        90|       NA|      15|
|    5|  210|      2|  57|   1|       1|       90|        60|     1150|      11|
|    1|  883|      2|  60|   1|       0|      100|        90|       NA|       0|
|   12| 1022|      1|  74|   1|       1|       50|        80|      513|       0|

### Data

This takes a local file in .csv or .tsv format, such as `lung.tsv` from above.

### Model

Once the data is uploaded, this defines the model as in the example gives a Kaplan-Meier curve.

<img src="www/km-1.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" />
### Download

This is a template for download results.

### Report

This is a file containing the commands and plots. For the current example, we have

<img src="www/cox-1.png" title="plot of chunk cox" alt="plot of chunk cox" style="display:block; margin: auto" style="display: block; margin: auto;" />
