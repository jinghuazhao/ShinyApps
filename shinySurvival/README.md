This is a very early attempt to seed Shiny projects via the familiar survival analysis, 

whose source code is available from [https://github.com/jinghuazhao/ShinyApps/](https://github.com/jinghuazhao/ShinyApps/)

An end-user can upload his/her own data for a survival analysis and download the analysis report. The following aspects are experimented with data 
from R/survival package:

```r
library(survival)
head(lung)
write.csv(survival::lung,file="lung.csv",quote=FALSE,row.names=FALSE)
```

### Upload data

This is a local file in .csv or .tsv format such as `lung.tsv` from above.

### Kaplan-Meier curve

Once the data is uploaded, this gives a Kaplan-Meier curve.

### Download data

This is an option to download a file in .tsv format.

### Generate report

This is a PDF file containing the commands and plots.
