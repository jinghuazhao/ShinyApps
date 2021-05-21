This is a very early attempt to seed Shiny projects via the familiar survival analysis whose source code is available from

[https://github.com/jinghuazhao/ShinyApps/](https://github.com/jinghuazhao/ShinyApps/)

An end-user can upload his/her own data for analysis and download the analysis report. The following aspects are experimented with data from 
R/survival package as follows:

```r
library(survival)
write.csv(survival::lung,file="lung.csv",quote=FALSE,row.names=FALSE)
```

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
