This is a very early attempt to seed Shiny projects via the familiar survival analysis whose source code is available from

[https://github.com/jinghuazhao/ShinyApps/](https://github.com/jinghuazhao/ShinyApps/)

An end-user can upload his/her own data for analysis and download the analysis report. The following aspects are experimented with data from 
R/survival package as follows:




```r
library(survival)
write.csv(survival::lung,file="lung.csv",quote=FALSE,row.names=FALSE)
```

# Data

This takes a local file in .csv or .tsv format, such as `lung.tsv` from above.

# Download

The input data can be saved in a variety of format -- is is actaully a template for downloading results.

# Model

Once the data is uploaded, this defines the model as in the example.

# Report

This is a file containing the commands and plots. For the current example, we have

## Kaplan-Meier curve

These were from vignettes of the survminer package.

<img src="www/km-1.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" /><img src="www/km-2.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" /><img src="www/km-3.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" /><img src="www/km-4.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" /><img src="www/km-5.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" /><img src="www/km-6.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" /><img src="www/km-7.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" /><img src="www/km-8.png" title="plot of chunk km" alt="plot of chunk km" style="display:block; margin: auto" style="display: block; margin: auto;" />

## Cox survival curve


<img src="www/cox-1.png" title="plot of chunk cox" alt="plot of chunk cox" style="display:block; margin: auto" style="display: block; margin: auto;" />
