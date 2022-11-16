---
title: "Assignment 3, part 2"
output: 
  html_document: 
    keep_md: yes
---

__Name:__ Zun Wang

__Student ID:__ 915109847


```r
library(tidyverse)
```

```
## ── Attaching packages ────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.0     ✓ purrr   0.3.3
## ✓ tibble  2.1.3     ✓ dplyr   0.8.5
## ✓ tidyr   1.0.2     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.5.0
```

```
## ── Conflicts ───────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
headers <- readLines("../input/blastout.mega.WS11.tsv.gz", n = 4)
headers <- headers[4]
headers
```

```
## [1] "# Fields: query acc.ver, subject acc.ver, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score, subject title"
```

```r
headers <- headers %>%
str_remove("# Fields: ") %>%
str_split(", ") %>%
unlist() %>%
make.names() %>%
str_replace(fixed(".."), ".") %>%
str_replace("X.identity", "pct.identity")
headers
```

```
##  [1] "query.acc.ver"    "subject.acc.ver"  "pct.identity"     "alignment.length"
##  [5] "mismatches"       "gap.opens"        "q.start"          "q.end"           
##  [9] "s.start"          "s.end"            "evalue"           "bit.score"       
## [13] "subject.title"
```

```r
megaWS11 <- read_tsv("../input/blastout.mega.WS11.tsv.gz", col_names=headers, comment="#")
```

```
## Parsed with column specification:
## cols(
##   query.acc.ver = col_character(),
##   subject.acc.ver = col_character(),
##   pct.identity = col_double(),
##   alignment.length = col_double(),
##   mismatches = col_double(),
##   gap.opens = col_double(),
##   q.start = col_double(),
##   q.end = col_double(),
##   s.start = col_double(),
##   s.end = col_double(),
##   evalue = col_double(),
##   bit.score = col_double(),
##   subject.title = col_character()
## )
```

```r
megaWS28 <- read_tsv("../input/blastout.mega.WS28.tsv.gz", col_names=headers, comment="#")
```

```
## Parsed with column specification:
## cols(
##   query.acc.ver = col_character(),
##   subject.acc.ver = col_character(),
##   pct.identity = col_double(),
##   alignment.length = col_double(),
##   mismatches = col_double(),
##   gap.opens = col_double(),
##   q.start = col_double(),
##   q.end = col_double(),
##   s.start = col_double(),
##   s.end = col_double(),
##   evalue = col_double(),
##   bit.score = col_double(),
##   subject.title = col_character()
## )
```

```r
blastnWS11 <- read_tsv("../input/blastout.task_blastn.WS11.tsv.gz", col_names=headers, comment="#")
```

```
## Parsed with column specification:
## cols(
##   query.acc.ver = col_character(),
##   subject.acc.ver = col_character(),
##   pct.identity = col_double(),
##   alignment.length = col_double(),
##   mismatches = col_double(),
##   gap.opens = col_double(),
##   q.start = col_double(),
##   q.end = col_double(),
##   s.start = col_double(),
##   s.end = col_double(),
##   evalue = col_double(),
##   bit.score = col_double(),
##   subject.title = col_character()
## )
```

```r
dc_megaWS11 <- read_tsv("../input/blastout.task_dc-megablast.WS11.tsv.gz", col_names=headers, comment="#")
```

```
## Parsed with column specification:
## cols(
##   query.acc.ver = col_character(),
##   subject.acc.ver = col_character(),
##   pct.identity = col_double(),
##   alignment.length = col_double(),
##   mismatches = col_double(),
##   gap.opens = col_double(),
##   q.start = col_double(),
##   q.end = col_double(),
##   s.start = col_double(),
##   s.end = col_double(),
##   evalue = col_double(),
##   bit.score = col_double(),
##   subject.title = col_character()
## )
```

```r
tblastx <- read_tsv("../input/blastout.tblastx.tsv.gz", col_names=headers, comment="#")
```

```
## Parsed with column specification:
## cols(
##   query.acc.ver = col_character(),
##   subject.acc.ver = col_character(),
##   pct.identity = col_double(),
##   alignment.length = col_double(),
##   mismatches = col_double(),
##   gap.opens = col_double(),
##   q.start = col_double(),
##   q.end = col_double(),
##   s.start = col_double(),
##   s.end = col_double(),
##   evalue = col_double(),
##   bit.score = col_double(),
##   subject.title = col_character()
## )
```

```r
head(blastnWS11)
```

```
## # A tibble: 6 x 13
##   query.acc.ver subject.acc.ver pct.identity alignment.length mismatches
##   <chr>         <chr>                  <dbl>            <dbl>      <dbl>
## 1 Seq_H         MG772933                88.0            22868       2666
## 2 Seq_H         MG772933                88.9             6787        734
## 3 Seq_H         KY417146                80.7            26649       4861
## 4 Seq_H         KY417146                73.8             3213        788
## 5 Seq_H         KY417152                80.7            26646       4876
## 6 Seq_H         KY417152                73.9             3213        785
## # … with 8 more variables: gap.opens <dbl>, q.start <dbl>, q.end <dbl>,
## #   s.start <dbl>, s.end <dbl>, evalue <dbl>, bit.score <dbl>,
## #   subject.title <chr>
```

```r
summary(blastnWS11)
```

```
##  query.acc.ver      subject.acc.ver     pct.identity    alignment.length
##  Length:12545       Length:12545       Min.   : 62.60   Min.   :   30   
##  Class :character   Class :character   1st Qu.: 66.10   1st Qu.:  164   
##  Mode  :character   Mode  :character   Median : 68.16   Median :  382   
##                                        Mean   : 70.32   Mean   : 1695   
##                                        3rd Qu.: 73.53   3rd Qu.: 1486   
##                                        Max.   :100.00   Max.   :26651   
##    mismatches       gap.opens         q.start          q.end      
##  Min.   :   0.0   Min.   :  0.00   Min.   :    1   Min.   : 1906  
##  1st Qu.:  46.0   1st Qu.:  0.00   1st Qu.:12854   1st Qu.:13384  
##  Median : 114.0   Median :  4.00   Median :14723   Median :18905  
##  Mean   : 448.8   Mean   : 21.22   Mean   :16538   Mean   :18212  
##  3rd Qu.: 370.0   3rd Qu.: 23.00   3rd Qu.:20452   3rd Qu.:21376  
##  Max.   :4907.0   Max.   :132.00   Max.   :29755   Max.   :29838  
##     s.start          s.end           evalue            bit.score      
##  Min.   :    1   Min.   : 1863   Min.   :0.000e+00   Min.   :   55.4  
##  1st Qu.:12234   1st Qu.:12622   1st Qu.:0.000e+00   1st Qu.:   71.6  
##  Median :13743   Median :17980   Median :0.000e+00   Median :  127.0  
##  Mean   :15967   Mean   :17638   Mean   :7.718e-05   Mean   :  785.3  
##  3rd Qu.:19668   3rd Qu.:20566   3rd Qu.:1.250e-08   3rd Qu.:  325.0  
##  Max.   :30598   Max.   :30840   Max.   :1.000e-03   Max.   :28772.0  
##  subject.title     
##  Length:12545      
##  Class :character  
##  Mode  :character  
##                    
##                    
## 
```

```r
blast.results <- bind_rows(list(megaWS11=megaWS11,
                                megaWS28=megaWS28, 
                                blastnWS11=blastnWS11, 
                                dc_megaWS11=dc_megaWS11,
                                tblastx=tblastx), 
                           .id="strategy")
head(blast.results)
```

```
## # A tibble: 6 x 14
##   strategy query.acc.ver subject.acc.ver pct.identity alignment.length
##   <chr>    <chr>         <chr>                  <dbl>            <dbl>
## 1 megaWS11 Seq_H         MG772933                89.1            21702
## 2 megaWS11 Seq_H         MG772933                89               6791
## 3 megaWS11 Seq_H         MG772933                77.3              546
## 4 megaWS11 Seq_H         MG772934                88.7            18272
## 5 megaWS11 Seq_H         MG772934                89.1             6785
## 6 megaWS11 Seq_H         MG772934                92.7             3190
## # … with 9 more variables: mismatches <dbl>, gap.opens <dbl>, q.start <dbl>,
## #   q.end <dbl>, s.start <dbl>, s.end <dbl>, evalue <dbl>, bit.score <dbl>,
## #   subject.title <chr>
```

**Exercise 8:** What are the total number of hits for each search strategy? __hint:__ use `group_by()` and `summarize_()`. You do not need to type out the results so long as your knitted markdown has the answer output in a table.  You should need 1 to 3 lines of code for this and you should not need to run separate commands for the different search strategies.

```r
blast.results %>%
  group_by(strategy) %>%
  summarize(hit.count=n())
```

```
## # A tibble: 5 x 2
##   strategy    hit.count
##   <chr>           <int>
## 1 blastnWS11      12545
## 2 dc_megaWS11     10691
## 3 megaWS11        13992
## 4 megaWS28         1047
## 5 tblastx        385017
```

**Exercise 9:** For each search strategy, calculate:
* Average alignment length
* Maximum alignment length
* Total alignment length (sum of all alignment lengths)
* Average percent identity  
You do not need to type out the results so long as your knitted markdown has the answer output in a table.

```r
exercise9 <- blast.results %>%
  group_by(strategy) %>%
  summarize(avg.length = mean(alignment.length),
            max.length = max(alignment.length),
            totl.length = sum(alignment.length),
            avg.id = mean(pct.identity)
            )
exercise9
```

```
## # A tibble: 5 x 5
##   strategy    avg.length max.length totl.length avg.id
##   <chr>            <dbl>      <dbl>       <dbl>  <dbl>
## 1 blastnWS11       1695.      26651    21266991   70.3
## 2 dc_megaWS11      1964.      26651    21001676   69.8
## 3 megaWS11          922.      21702    12899763   75.7
## 4 megaWS28         6434.      21702     6736759   81.9
## 5 tblastx           107.       2824    41119360   48.9
```


**Exercise 10**: Explain the logic and function for each line of the code used to create `uniq.blast.results` above.  Why was `arrange` used and why with those arguments?  what is duplicated doing (__hint__, use `?duplicated` to see the help file), and why is `!` used in that line?


```r
uniq.blast.results <- blast.results %>% #store the results below to uniq.blast.results
    group_by(strategy, subject.acc.ver) %>% #group by both strategy and subject.acc.ver
    arrange(desc(alignment.length)) %>%  #align with order of ailgnment length from longest to shortest
    filter(!duplicated(subject.acc.ver)) #filter out duplicated ones with same subject.acc.ver
uniq.blast.results
```

```
## # A tibble: 10,538 x 14
## # Groups:   strategy, subject.acc.ver [10,538]
##    strategy query.acc.ver subject.acc.ver pct.identity alignment.length
##    <chr>    <chr>         <chr>                  <dbl>            <dbl>
##  1 blastnW… Seq_H         KC881006                80.7            26651
##  2 dc_mega… Seq_H         KC881006                80.7            26651
##  3 blastnW… Seq_H         KY417146                80.7            26649
##  4 dc_mega… Seq_H         KY417146                80.7            26649
##  5 blastnW… Seq_H         KC881005                80.6            26647
##  6 dc_mega… Seq_H         KC881005                80.6            26647
##  7 blastnW… Seq_H         KY417152                80.7            26646
##  8 dc_mega… Seq_H         KY417152                80.7            26646
##  9 blastnW… Seq_H         KF569996                80.6            26642
## 10 dc_mega… Seq_H         KF569996                80.6            26642
## # … with 10,528 more rows, and 9 more variables: mismatches <dbl>,
## #   gap.opens <dbl>, q.start <dbl>, q.end <dbl>, s.start <dbl>, s.end <dbl>,
## #   evalue <dbl>, bit.score <dbl>, subject.title <chr>
```

**Exercise 11:** Repeat the summary from Exercise 9, but now on the unique hits.  How do the results fit with your understanding of these different search strategies?

```r
exercise11 <- blast.results %>%
  group_by(strategy) %>%
  filter(!duplicated(subject.acc.ver)) %>%
  summarize(avg.length = mean(alignment.length),
            max.length = max(alignment.length),
            totl.length = sum(alignment.length),
            avg.id = mean(pct.identity),
            hit = n()
            )
exercise11
```

```
## # A tibble: 5 x 6
##   strategy    avg.length max.length totl.length avg.id   hit
##   <chr>            <dbl>      <dbl>       <dbl>  <dbl> <int>
## 1 blastnWS11       6345.      26651    15919576   67.3  2509
## 2 dc_megaWS11      6340.      26651    15857088   67.2  2501
## 3 megaWS11         2723.      21702     6824857   73.5  2506
## 4 megaWS28        13794.      21702     4510725   80.1   327
## 5 tblastx          1077.       2824     2902430   66.4  2695
```

```r
#Between mega resuilts, 28 is showed to have longer average length but less total length so less accurate than mega11.
#megablast generally have higher identity percentage, showing megablast's advantage on longer sequences
#The results between blastn and de_mega is very small
#tblastx is the one that uses aa sequence so it has least average length.
```

**Exercise 12**: For the full `blast.results` set (not the unique ones), answer the following questions for each search strategy.  You do not need to type out the results so long as your knitted markdown has the answer output in a table.

* What proportion of hits have an e-value of 0?
* What proportion of hits have a percent identity > 50?
* What proportion of hits have an E-value of 0 _and_ have a percent identity less than 50?

```r
exercise12 <- blast.results %>%
  group_by(strategy)%>%
  summarize(pe0 = mean(evalue == 0),pidtover50 = mean(pct.identity > 50),p3 = mean(evalue==0 & pct.identity < 50))
exercise12
```

```
## # A tibble: 5 x 4
##   strategy       pe0 pidtover50    p3
##   <chr>        <dbl>      <dbl> <dbl>
## 1 blastnWS11  0.145       1     0    
## 2 dc_megaWS11 0.170       1     0    
## 3 megaWS11    0.0715      1     0    
## 4 megaWS28    0.932       1     0    
## 5 tblastx     0.847       0.379 0.474
```

__hint__ There are at least two ways to answer the question above, one is using `filter()` and then checking the number of rows of the result.  The second takes advantage of the fact that the logical value TRUE also has the numeric value of 1, whereas false = 0.  So, for example, if we wanted to count the numbers > 5 in the sequence of numbers from 1:10.  If you take the second strategy you should only need to do one summarize statement.


**Exercise 13**: Why do you think `tblastx` so different?

```r
#tblastn uses translated amino acid sequence so it has least number of hits.
```

**JD:** -1 It had the most hits


**Exercise 14:** Use the commands above to create the data frame below from `uniq.blast.results` and store it in an object called `upset.table`.  Only the first 6 lines are shown.


```r
install.packages("UpSetR")
```

```
## Installing package into '/home/ubuntu/R/x86_64-pc-linux-gnu-library/3.6'
## (as 'lib' is unspecified)
```

```r
library(UpSetR)
```

```r
upset.table <- uniq.blast.results %>%
  select(subject.acc.ver,strategy)%>%
  table()%>%
  as.data.frame.matrix()
upset.table
```

```
##           blastnWS11 dc_megaWS11 megaWS11 megaWS28 tblastx
## AC_000192          1           1        1        0       1
## AF075257           0           0        0        0       1
## AF220295           1           1        1        0       1
## AF353511           1           1        1        0       1
## AF391541           1           1        1        0       1
## AF391542           1           1        1        0       1
## AY274119           1           1        1        1       1
## AY278487           1           1        1        1       1
## AY278488           1           1        1        1       1
## AY278489           1           1        1        1       1
## AY278490           1           1        1        1       1
## AY278491           1           1        1        1       1
## AY278554           1           1        1        1       1
## AY278741           1           1        1        1       1
## AY279354           1           1        1        1       1
## AY282752           1           1        1        1       1
## AY283794           1           1        1        1       1
## AY283795           1           1        1        1       1
## AY283796           1           1        1        1       1
## AY283797           1           1        1        1       1
## AY283798           1           1        1        1       1
## AY291315           1           1        1        1       1
## AY291451           1           1        1        1       1
## AY297028           1           1        1        1       1
## AY304486           1           1        1        1       1
## AY304488           1           1        1        1       1
## AY304495           1           1        1        1       1
## AY310120           1           1        1        1       1
## AY313906           1           1        1        1       1
## AY319651           1           1        1        0       1
## AY321118           1           1        1        1       1
## AY323977           1           1        1        1       1
## AY338174           1           1        1        1       1
## AY338175           1           1        1        1       1
## AY345986           1           1        1        1       1
## AY345987           1           1        1        1       1
## AY345988           1           1        1        1       1
## AY348314           1           1        1        1       1
## AY350750           1           1        1        1       1
## AY351680           1           1        1        1       1
## AY357075           1           1        1        1       1
## AY357076           1           1        1        1       1
## AY362698           1           1        1        1       1
## AY362699           1           1        1        1       1
## AY390556           1           1        1        1       1
## AY391777           1           1        1        0       1
## AY394850           1           1        1        1       1
## AY394978           1           1        1        1       1
## AY394979           1           1        1        1       1
## AY394983           1           1        1        1       1
## AY394985           1           1        1        1       1
## AY394986           1           1        1        1       1
## AY394987           1           1        1        1       1
## AY394989           1           1        1        1       1
## AY394990           1           1        1        1       1
## AY394991           1           1        1        1       1
## AY394992           1           1        1        1       1
## AY394993           1           1        1        1       1
## AY394994           1           1        1        1       1
## AY394995           1           1        1        1       1
## AY394996           1           1        1        1       1
## AY394997           1           1        1        1       1
## AY394998           1           1        1        1       1
## AY394999           1           1        1        1       1
## AY395000           1           1        1        1       1
## AY395001           1           1        1        1       1
## AY395002           1           1        1        1       1
## AY395003           1           1        1        1       1
## AY427439           1           1        1        1       1
## AY427798           0           0        0        0       1
## AY461660           1           1        1        1       1
## AY463059           1           1        1        1       1
## AY463060           1           1        1        1       1
## AY485277           1           1        1        1       1
## AY485278           1           1        1        1       1
## AY502923           1           1        1        1       1
## AY502924           1           1        1        1       1
## AY502925           1           1        1        1       1
## AY502926           1           1        1        1       1
## AY502927           1           1        1        1       1
## AY502928           1           1        1        1       1
## AY502929           1           1        1        1       1
## AY502930           1           1        1        1       1
## AY502931           1           1        1        1       1
## AY502932           1           1        1        1       1
## AY508724           1           1        1        1       1
## AY514485           1           1        1        0       1
## AY515512           1           1        1        1       1
## AY518894           1           1        1        0       1
## AY545914           1           1        1        1       1
## AY545915           1           1        1        1       1
## AY545916           1           1        1        1       1
## AY545917           1           1        1        1       1
## AY545918           1           1        1        1       1
## AY545919           1           1        1        1       1
## AY559081           1           1        1        1       1
## AY559082           1           1        1        1       1
## AY559083           1           1        1        1       1
## AY559084           1           1        1        1       1
## AY559085           1           1        1        1       1
## AY559086           1           1        1        1       1
## AY559087           1           1        1        1       1
## AY559088           1           1        1        1       1
## AY559089           1           1        1        1       1
## AY559090           1           1        1        1       1
## AY559091           1           1        1        1       1
## AY559092           1           1        1        1       1
## AY559093           1           1        1        1       1
## AY559094           1           1        1        1       1
## AY559095           1           1        1        1       1
## AY559096           1           1        1        1       1
## AY559097           1           1        1        1       1
## AY567487           1           1        1        0       1
## AY568539           1           1        1        1       1
## AY572034           1           1        1        1       1
## AY572035           1           1        1        1       1
## AY572038           1           1        1        1       1
## AY585228           1           1        1        0       1
## AY585229           1           1        1        0       1
## AY587882           0           0        0        0       1
## AY595412           1           1        1        1       1
## AY597011           1           1        1        1       1
## AY613947           1           1        1        1       1
## AY613948           1           1        1        1       1
## AY613949           1           1        1        1       1
## AY613950           1           1        1        1       1
## AY641576           1           1        1        0       1
## AY646283           1           1        1        0       1
## AY654624           1           1        1        1       1
## AY686863           1           1        1        1       1
## AY686864           1           1        1        1       1
## AY700211           1           1        1        0       1
## AY714217           1           1        1        1       1
## AY772062           1           1        1        1       1
## AY851295           1           1        1        0       1
## AY864805           1           1        1        1       1
## AY864806           1           1        1        1       1
## AY884001           1           1        1        1       1
## AY903459           1           1        1        0       1
## AY903460           1           1        1        0       1
## AY994055           1           1        1        0       1
## DQ001338           1           1        1        0       1
## DQ001339           1           1        1        0       1
## DQ010921           1           1        1        0       1
## DQ011855           1           1        1        0       1
## DQ022305           1           1        1        1       1
## DQ071615           1           1        1        1       1
## DQ084199           1           1        1        1       1
## DQ084200           1           1        1        1       1
## DQ182595           1           1        1        1       1
## DQ201447           1           1        1        0       1
## DQ286389           1           1        1        0       1
## DQ288927           1           1        1        0       1
## DQ339101           1           1        1        1       1
## DQ412042           1           1        1        1       1
## DQ412043           1           1        1        1       1
## DQ415896           1           1        1        1       1
## DQ415897           1           1        1        1       1
## DQ415898           1           1        1        1       1
## DQ415899           1           1        1        1       1
## DQ415900           1           1        1        1       1
## DQ415901           1           1        1        1       1
## DQ415902           1           1        1        1       1
## DQ415903           1           1        1        1       1
## DQ415904           1           1        1        1       1
## DQ415905           1           1        1        1       1
## DQ415906           1           1        1        1       1
## DQ415907           1           1        1        1       1
## DQ415908           1           1        1        1       1
## DQ415909           1           1        1        1       1
## DQ415910           1           1        1        1       1
## DQ415911           1           1        1        1       1
## DQ415912           1           1        1        1       1
## DQ415913           1           1        1        1       1
## DQ415914           1           1        1        1       1
## DQ443743           1           1        1        0       1
## DQ445911           1           1        1        0       1
## DQ445912           1           1        1        0       1
## DQ458789           0           0        0        0       1
## DQ640652           1           1        1        1       1
## DQ646405           1           1        1        0       1
## DQ648794           1           1        1        0       1
## DQ648856           1           1        1        1       1
## DQ648857           1           1        1        1       1
## DQ811784           1           1        1        0       1
## DQ811785           1           1        1        0       1
## DQ811786           1           1        1        0       1
## DQ811787           1           1        1        0       1
## DQ811788           1           1        1        0       1
## DQ811789           1           1        1        0       1
## DQ834384           1           1        1        0       1
## DQ848678           1           1        1        0       1
## DQ898157           0           0        0        0       1
## DQ898174           1           1        1        1       1
## DQ915164           1           1        1        0       1
## EF065505           1           1        1        0       1
## EF065506           1           1        1        0       1
## EF065507           1           1        1        0       1
## EF065508           1           1        1        0       1
## EF065509           1           1        1        0       1
## EF065510           1           1        1        0       1
## EF065511           1           1        1        0       1
## EF065512           1           1        1        0       1
## EF065513           1           1        1        0       1
## EF065514           1           1        1        0       1
## EF065515           1           1        1        0       1
## EF065516           1           1        1        1       1
## EF185992           1           1        1        0       1
## EF203064           1           1        1        0       1
## EF203065           1           1        1        0       1
## EF203066           1           1        1        0       1
## EF203067           1           1        1        0       1
## EF424615           1           1        1        0       1
## EF424616           1           1        1        0       1
## EF424617           1           1        1        0       1
## EF424618           1           1        1        0       1
## EF424619           1           1        1        0       1
## EF424620           1           1        1        0       1
## EF424621           1           1        1        0       1
## EF424622           1           1        1        0       1
## EF424623           1           1        1        0       1
## EF424624           1           1        1        0       1
## EU095850           1           1        1        0       1
## EU111742           1           1        1        0       1
## EU186072           1           1        1        0       1
## EU371559           1           1        1        1       1
## EU371560           1           1        1        1       1
## EU371561           1           1        1        1       1
## EU371562           1           1        1        1       1
## EU371563           1           1        1        1       1
## EU371564           1           1        1        1       1
## EU418975           1           1        1        0       1
## EU418976           1           1        1        0       1
## EU420137           1           1        1        0       1
## EU420138           1           1        1        0       1
## EU420139           1           1        1        0       1
## EU526388           1           1        1        0       1
## EU637854           1           1        1        0       1
## EU714028           1           1        1        0       1
## EU714029           1           1        1        0       1
## FJ376619           1           1        1        0       1
## FJ376620           1           1        1        0       1
## FJ376621           1           1        1        0       1
## FJ376622           1           1        1        0       1
## FJ415324           1           1        1        0       1
## FJ425184           1           1        1        0       1
## FJ425185           1           1        1        0       1
## FJ425186           1           1        1        0       1
## FJ425187           1           1        1        0       1
## FJ425188           1           1        1        0       1
## FJ425189           1           1        1        0       1
## FJ425190           1           1        1        0       1
## FJ588686           1           1        1        1       1
## FJ755618           1           1        1        0       1
## FJ882963           1           1        1        1       1
## FJ884686           1           1        1        0       1
## FJ884687           1           1        1        0       1
## FJ888351           1           1        1        0       1
## FJ904713           1           1        1        0       1
## FJ904714           1           1        1        0       1
## FJ904715           1           1        1        0       1
## FJ904716           1           1        1        0       1
## FJ904717           1           1        1        0       1
## FJ904718           1           1        1        0       1
## FJ904719           1           1        1        0       1
## FJ904720           1           1        1        0       1
## FJ904721           1           1        1        0       1
## FJ904722           1           1        1        0       1
## FJ904723           1           1        1        0       1
## FJ938051           1           1        1        0       1
## FJ938052           1           1        1        0       1
## FJ938053           1           1        1        0       1
## FJ938054           1           1        1        0       1
## FJ938055           1           1        1        0       1
## FJ938056           1           1        1        1       1
## FJ938057           1           1        1        0       1
## FJ938058           1           1        1        0       1
## FJ938059           1           1        1        0       1
## FJ938060           1           1        1        0       1
## FJ938061           1           1        1        0       1
## FJ938062           1           1        1        0       1
## FJ938063           1           1        1        0       1
## FJ938064           1           1        1        0       1
## FJ938065           1           1        1        0       1
## FJ938066           1           1        1        0       1
## FJ938067           1           1        1        0       1
## FJ938068           1           1        1        0       1
## FJ959407           1           1        1        1       1
## GQ152141           1           1        1        1       1
## GQ153539           1           1        1        1       1
## GQ153540           1           1        1        1       1
## GQ153541           1           1        1        1       1
## GQ153542           1           1        1        1       1
## GQ153543           1           1        1        1       1
## GQ153544           1           1        1        1       1
## GQ153545           1           1        1        1       1
## GQ153546           1           1        1        1       1
## GQ153547           1           1        1        1       1
## GQ153548           1           1        1        1       1
## GQ427173           1           1        1        0       1
## GQ427174           1           1        1        0       1
## GQ427175           1           1        1        0       1
## GQ427176           1           1        1        0       1
## GQ477367           1           1        1        0       1
## GQ504720           1           1        1        0       1
## GQ504721           1           1        1        0       1
## GQ504722           1           1        1        0       1
## GQ504723           1           1        1        0       1
## GQ504724           1           1        1        0       1
## GQ504725           1           1        1        0       1
## GU190215           1           1        1        1       1
## GU393331           1           1        1        0       1
## GU393332           1           1        1        0       1
## GU393333           1           1        1        0       1
## GU393334           1           1        1        0       1
## GU393335           1           1        1        0       1
## GU393336           1           1        1        0       1
## GU393337           1           1        1        0       1
## GU393338           1           1        1        0       1
## GU553361           1           1        1        0       1
## GU553362           1           1        1        0       1
## GU553363           1           1        1        1       1
## GU553364           1           1        1        1       1
## GU553365           1           1        1        1       1
## GU593319           1           1        1        0       1
## GU937797           1           1        1        0       1
## HM034837           1           1        1        1       1
## HM211098           1           1        1        0       1
## HM211099           1           1        1        0       1
## HM211100           1           1        1        0       1
## HM211101           1           1        1        0       1
## HM245923           1           1        1        0       1
## HM245924           1           1        1        0       1
## HM245925           1           1        1        0       1
## HM245926           1           1        1        0       1
## HM746600           0           0        0        0       1
## HM776941           1           1        1        0       1
## HQ012367           1           1        1        0       1
## HQ012368           1           1        1        0       1
## HQ012369           1           1        1        0       1
## HQ012370           1           1        1        0       1
## HQ012371           1           1        1        0       1
## HQ012372           1           1        1        0       1
## HQ392469           1           1        1        0       1
## HQ392470           1           1        1        0       1
## HQ392471           1           1        1        0       1
## HQ392472           1           1        1        0       1
## HQ462571           1           1        1        0       1
## HQ595344           1           0        0        0       0
## HQ595345           1           0        0        0       0
## HQ607365           0           0        0        0       1
## HQ607366           0           0        0        0       1
## HQ848267           1           1        1        0       1
## HQ850618           1           1        1        0       1
## HQ853282           0           0        0        0       1
## HQ853283           0           0        0        0       1
## HQ853284           0           0        0        0       1
## HQ853285           0           0        0        0       1
## HQ853286           0           0        0        0       1
## HQ853287           0           0        0        0       1
## HQ853288           0           0        0        0       1
## HQ853289           0           0        0        0       1
## HQ853290           0           0        0        0       1
## HQ853291           0           0        0        0       1
## HQ853292           0           0        0        0       1
## HQ890526           1           1        1        1       1
## HQ890527           1           1        1        1       1
## HQ890528           1           1        1        1       1
## HQ890529           1           1        1        1       1
## HQ890530           1           1        1        1       1
## HQ890531           1           1        1        1       1
## HQ890532           1           1        1        1       1
## HQ890533           1           1        1        1       1
## HQ890534           1           1        1        1       1
## HQ890535           1           1        1        1       1
## HQ890536           1           1        1        1       1
## HQ890537           1           1        1        1       1
## HQ890538           1           1        1        1       1
## HQ890539           1           1        1        1       1
## HQ890540           1           1        1        1       1
## HQ890541           1           1        1        1       1
## HQ890542           1           1        1        1       1
## HQ890543           1           1        1        1       1
## HQ890544           1           1        1        1       1
## HQ890545           1           1        1        1       1
## HQ890546           1           1        1        1       1
## JF274479           1           1        1        0       1
## JF292902           1           1        1        1       1
## JF292903           1           1        1        1       1
## JF292904           1           1        1        1       1
## JF292905           1           1        1        1       1
## JF292906           1           1        1        1       1
## JF292907           1           1        1        1       1
## JF292908           1           1        1        1       1
## JF292909           1           1        1        1       1
## JF292910           1           1        1        1       1
## JF292911           1           1        1        1       1
## JF292912           1           1        1        1       1
## JF292913           1           1        1        1       1
## JF292914           1           1        1        1       1
## JF292915           1           1        1        1       1
## JF292916           1           1        1        1       1
## JF292917           1           1        1        1       1
## JF292918           1           1        1        1       1
## JF292919           1           1        1        1       1
## JF292920           1           1        1        1       1
## JF292921           1           1        1        1       1
## JF292922           1           1        1        1       1
## JF330898           1           1        1        1       1
## JF330899           1           1        1        0       1
## JF732903           1           1        1        0       1
## JF775523           0           0        0        0       1
## JF775524           0           0        0        0       1
## JF775525           0           0        0        0       1
## JF775526           0           0        0        0       1
## JF775527           0           0        0        0       1
## JF775528           0           0        0        0       1
## JF775529           0           0        0        0       1
## JF775530           0           0        0        0       1
## JF792616           1           1        1        0       1
## JF792617           1           1        1        0       1
## JF828980           1           1        1        0       1
## JF828981           1           1        1        0       1
## JF893452           1           1        1        0       1
## JN129834           1           1        1        0       1
## JN129835           1           1        1        0       1
## JN183882           1           1        1        0       1
## JN183883           1           1        1        0       1
## JN547228           1           1        1        0       1
## JN624754           0           0        0        0       1
## JN624755           0           0        0        0       1
## JN624756           0           0        0        0       1
## JN634064           1           1        1        0       1
## JN825706           0           0        0        0       1
## JN825707           0           0        0        0       1
## JN825708           0           0        0        0       1
## JN825709           0           0        0        0       1
## JN825710           0           0        0        0       1
## JN825711           0           0        0        0       1
## JN825712           1           1        1        0       1
## JN854286           1           1        1        1       1
## JN856008           1           1        1        0       1
## JN874559           1           1        1        0       1
## JN874560           1           1        1        0       1
## JN874561           1           1        1        0       1
## JN874562           1           1        1        0       1
## JQ023161           1           1        1        0       1
## JQ023162           1           1        1        0       1
## JQ065042           1           1        1        0       1
## JQ065043           1           1        1        0       1
## JQ065044           1           1        1        1       1
## JQ065045           1           1        1        0       1
## JQ065046           1           1        1        0       1
## JQ065047           1           1        1        0       1
## JQ065048           1           1        1        0       1
## JQ065049           1           1        1        0       1
## JQ088078           1           1        1        0       1
## JQ173883           1           1        1        0       1
## JQ282909           1           1        1        0       1
## JQ404409           1           1        1        0       1
## JQ404410           1           1        1        0       1
## JQ408980           1           1        1        0       1
## JQ408981           1           1        1        0       1
## JQ410000           1           1        1        0       1
## JQ765563           1           1        1        0       1
## JQ765564           1           1        1        0       1
## JQ765565           1           1        1        0       1
## JQ765566           1           1        1        0       1
## JQ765567           1           1        1        0       1
## JQ765568           1           1        1        0       1
## JQ765569           1           1        1        0       1
## JQ765570           1           1        1        0       1
## JQ765571           1           1        1        0       1
## JQ765572           1           1        1        0       1
## JQ765573           1           1        1        0       1
## JQ765574           1           1        1        0       1
## JQ765575           1           1        1        0       1
## JQ860350           0           0        0        0       1
## JQ957872           0           0        0        0       1
## JQ957873           0           0        0        0       1
## JQ957874           0           0        0        0       1
## JQ977697           1           1        1        0       1
## JQ977698           1           1        1        0       1
## JQ989266           1           1        1        0       1
## JQ989267           1           1        1        0       1
## JQ989268           1           1        1        0       1
## JQ989269           1           1        1        0       1
## JQ989270           1           1        1        0       1
## JQ989271           1           1        1        0       1
## JQ989272           1           1        1        0       1
## JQ989273           1           1        1        0       1
## JX088695           1           1        1        0       1
## JX104161           1           1        1        0       1
## JX112709           1           1        1        0       1
## JX145339           0           0        0        0       1
## JX163923           1           1        1        1       1
## JX163924           1           1        1        1       1
## JX163925           1           1        1        1       1
## JX163926           1           1        1        1       1
## JX163927           1           1        1        1       1
## JX163928           1           1        1        1       1
## JX169866           1           1        1        0       1
## JX169867           1           1        1        0       1
## JX188454           1           1        1        0       1
## JX195175           1           1        1        0       1
## JX195176           1           1        1        0       1
## JX195177           1           1        1        0       1
## JX195178           1           1        1        0       1
## JX261936           1           1        1        0       1
## JX435298           0           0        0        0       1
## JX435299           0           0        0        0       1
## JX435300           0           0        0        0       1
## JX435301           0           0        0        0       1
## JX435302           0           0        0        0       1
## JX435303           0           0        0        0       1
## JX435304           0           0        0        0       1
## JX435305           0           0        0        0       1
## JX435306           0           0        0        0       1
## JX435307           0           0        0        0       1
## JX435308           0           0        0        0       1
## JX435309           0           0        0        0       1
## JX435310           0           0        0        0       1
## JX435311           0           0        0        0       1
## JX435312           0           0        0        0       1
## JX435313           0           0        0        0       1
## JX435314           0           0        0        0       1
## JX435315           0           0        0        0       1
## JX435316           0           0        0        0       1
## JX435317           0           0        0        0       1
## JX435318           0           0        0        0       1
## JX435319           0           0        0        0       1
## JX435320           0           0        0        0       1
## JX489155           1           1        1        0       1
## JX503060           1           1        1        0       1
## JX503061           1           1        1        0       1
## JX504050           1           1        1        0       1
## JX524137           1           1        1        0       1
## JX524171           1           1        1        0       1
## JX560761           1           1        1        0       1
## JX647847           1           1        1        0       1
## JX840411           1           1        1        0       1
## JX860640           1           1        1        0       1
## JX869043           0           0        0        0       1
## JX869044           0           0        0        0       1
## JX869045           0           0        0        0       1
## JX869046           0           0        0        0       1
## JX869059           1           1        1        0       1
## JX897900           1           1        1        0       1
## JX993987           1           1        1        1       1
## JX993988           1           1        1        1       1
## KC008600           1           1        1        0       1
## KC013541           1           1        1        0       1
## KC109141           1           1        1        0       1
## KC119407           1           1        1        0       1
## KC136209           1           1        1        0       1
## KC140102           1           1        1        0       1
## KC164505           1           1        1        0       1
## KC175339           1           1        1        0       1
## KC175340           1           1        1        0       1
## KC175341           1           1        1        0       1
## KC189944           1           1        1        0       1
## KC196276           1           1        1        0       1
## KC210145           1           1        1        0       1
## KC210146           1           1        1        0       1
## KC210147           1           1        1        0       1
## KC461235           1           1        1        0       1
## KC461236           1           1        1        0       1
## KC461237           1           1        1        0       1
## KC506155           1           1        1        0       1
## KC545383           1           1        1        0       1
## KC545386           1           1        1        0       1
## KC560801           1           0        1        0       0
## KC667074           1           1        1        0       1
## KC776174           1           1        1        0       1
## KC807166           0           0        0        0       1
## KC807167           0           0        0        0       1
## KC807168           0           0        0        0       1
## KC807169           0           0        0        0       1
## KC807170           0           0        0        0       1
## KC807171           0           0        0        0       1
## KC807172           0           0        0        0       1
## KC807173           0           0        0        0       1
## KC807174           0           0        0        0       1
## KC807175           0           0        0        0       1
## KC807176           0           0        0        0       1
## KC807177           0           0        0        0       1
## KC807178           0           0        0        0       1
## KC869678           1           1        1        1       1
## KC881005           1           1        1        1       1
## KC881006           1           1        1        1       1
## KC962433           1           1        1        0       1
## KF186564           1           1        1        0       1
## KF186565           1           1        1        0       1
## KF186566           1           1        1        0       1
## KF186567           1           1        1        0       1
## KF192507           1           1        1        0       1
## KF267450           1           1        1        0       1
## KF272920           1           1        1        0       1
## KF273109           0           0        0        0       1
## KF294380           1           1        1        0       1
## KF367457           1           1        1        1       1
## KF377577           1           1        1        0       1
## KF384500           1           1        1        0       1
## KF411040           1           1        1        0       1
## KF411041           1           1        1        0       1
## KF430201           1           1        1        1       1
## KF430219           1           1        1        0       1
## KF452322           1           1        1        0       1
## KF452323           1           1        1        0       1
## KF460437           1           1        1        0       1
## KF468752           1           1        1        0       1
## KF468753           1           1        1        0       1
## KF468754           1           1        1        0       1
## KF514430           1           1        1        0       1
## KF514432           1           1        1        0       1
## KF514433           1           1        1        0       1
## KF522691           0           0        0        0       1
## KF530060           1           1        1        0       1
## KF530061           1           1        1        0       1
## KF530063           1           1        1        0       1
## KF530064           1           1        1        0       1
## KF530065           1           1        1        0       1
## KF530066           1           1        1        0       1
## KF530067           1           1        1        0       1
## KF530068           1           1        1        0       1
## KF530069           1           1        1        0       1
## KF530070           1           1        1        0       1
## KF530071           1           1        1        0       1
## KF530072           1           1        1        0       1
## KF530073           1           1        1        0       1
## KF530074           1           1        1        0       1
## KF530075           1           1        1        0       1
## KF530076           1           1        1        0       1
## KF530077           1           1        1        0       1
## KF530078           1           1        1        0       1
## KF530079           1           1        1        0       1
## KF530080           1           1        1        0       1
## KF530081           1           1        1        0       1
## KF530082           1           1        1        0       1
## KF530083           1           1        1        0       1
## KF530084           1           1        1        0       1
## KF530085           1           1        1        0       1
## KF530086           1           1        1        0       1
## KF530087           1           1        1        0       1
## KF530088           1           1        1        0       1
## KF530089           1           1        1        0       1
## KF530090           1           1        1        0       1
## KF530091           1           1        1        0       1
## KF530092           1           1        1        0       1
## KF530094           1           1        1        0       1
## KF530095           1           1        1        0       1
## KF530096           1           1        1        0       1
## KF530097           1           1        1        0       1
## KF530098           1           1        1        0       1
## KF530099           1           1        1        0       1
## KF530104           1           1        1        0       1
## KF530105           1           1        1        1       1
## KF530106           1           1        1        0       1
## KF530107           1           1        1        0       1
## KF530108           1           1        1        0       1
## KF530109           1           1        1        0       1
## KF530110           1           1        1        0       1
## KF530111           1           1        1        0       1
## KF530112           1           1        1        0       1
## KF530113           1           1        1        0       1
## KF530114           1           1        1        0       1
## KF530123           1           1        1        0       1
## KF569996           1           1        1        1       1
## KF574761           1           1        1        0       1
## KF600612           1           1        1        0       1
## KF600613           1           1        1        0       1
## KF600620           1           1        1        0       1
## KF600627           1           1        1        0       1
## KF600628           1           1        1        0       1
## KF600630           1           1        1        0       1
## KF600632           1           1        1        0       1
## KF600634           1           1        1        0       1
## KF600644           1           1        1        0       1
## KF600645           1           1        1        0       1
## KF600647           1           1        1        0       1
## KF600651           1           1        1        0       1
## KF600652           1           1        1        0       1
## KF636752           1           1        1        1       1
## KF650370           1           1        1        0       1
## KF650371           1           1        1        0       1
## KF650372           1           1        1        0       1
## KF650373           1           1        1        0       1
## KF650374           1           1        1        0       1
## KF650375           1           1        1        0       1
## KF668605           1           1        1        0       1
## KF686340           1           1        1        1       1
## KF686341           1           1        1        1       1
## KF686342           1           1        1        1       1
## KF686343           1           1        1        1       1
## KF686344           1           1        1        1       1
## KF686346           1           1        1        1       1
## KF696629           1           1        1        0       1
## KF745068           1           1        1        0       1
## KF760557           1           1        1        0       1
## KF761675           1           1        1        0       1
## KF771866           0           0        0        0       1
## KF793824           1           1        1        0       1
## KF793825           1           1        1        0       1
## KF793826           1           1        1        0       1
## KF804028           1           1        1        0       1
## KF840537           1           1        1        0       1
## KF853202           1           1        1        0       1
## KF906249           1           1        1        0       1
## KF906250           1           1        1        0       1
## KF906251           1           1        1        0       1
## KF917527           1           1        1        0       1
## KF923886           1           1        1        0       1
## KF923887           1           1        1        0       1
## KF923888           1           1        1        0       1
## KF923889           1           1        1        0       1
## KF923890           1           1        1        0       1
## KF923891           1           1        1        0       1
## KF923892           1           1        1        0       1
## KF923893           1           1        1        0       1
## KF923894           1           1        1        0       1
## KF923895           1           1        1        0       1
## KF923896           1           1        1        0       1
## KF923897           1           1        1        0       1
## KF923898           1           1        1        0       1
## KF923899           1           1        1        0       1
## KF923900           1           1        1        0       1
## KF923901           1           1        1        0       1
## KF923902           1           1        1        0       1
## KF923903           1           1        1        0       1
## KF923904           1           1        1        0       1
## KF923905           1           1        1        0       1
## KF923906           1           1        1        0       1
## KF923907           1           1        1        0       1
## KF923908           1           1        1        0       1
## KF923909           1           1        1        0       1
## KF923910           1           1        1        0       1
## KF923911           1           1        1        0       1
## KF923912           1           1        1        0       1
## KF923913           1           1        1        0       1
## KF923914           1           1        1        0       1
## KF923915           1           1        1        0       1
## KF923916           1           1        1        0       1
## KF923917           1           1        1        0       1
## KF923918           1           1        1        0       1
## KF923919           1           1        1        0       1
## KF923920           1           1        1        0       1
## KF923921           1           1        1        0       1
## KF923922           1           1        1        0       1
## KF923923           1           1        1        0       1
## KF923924           1           1        1        0       1
## KF923925           1           1        1        0       1
## KF931628           1           1        1        0       1
## KF958702           1           1        1        0       1
## KF961221           1           1        1        0       1
## KF961222           1           1        1        0       1
## KJ020932           1           1        1        0       1
## KJ125489           0           0        0        0       1
## KJ128295           1           1        1        0       1
## KJ135013           1           1        1        0       1
## KJ156866           1           1        1        0       1
## KJ156869           1           1        1        0       1
## KJ156874           1           1        1        0       1
## KJ156881           1           1        1        0       1
## KJ156910           1           1        1        0       1
## KJ156934           1           1        1        0       1
## KJ156944           1           1        1        0       1
## KJ156949           1           1        1        0       1
## KJ156952           1           1        1        0       1
## KJ158152           1           1        1        0       1
## KJ184549           1           1        1        0       1
## KJ196348           1           1        1        0       1
## KJ361500           1           1        1        0       1
## KJ361501           1           1        1        0       1
## KJ361502           1           1        1        0       1
## KJ361503           1           1        1        0       1
## KJ399978           1           1        1        0       1
## KJ408801           1           1        1        0       1
## KJ425485           1           1        1        0       1
## KJ425486           1           1        1        0       1
## KJ425487           1           1        1        0       1
## KJ425488           1           1        1        0       1
## KJ425489           1           1        1        0       1
## KJ425490           1           1        1        0       1
## KJ425491           1           1        1        0       1
## KJ425492           1           1        1        0       1
## KJ425493           1           1        1        0       1
## KJ425494           1           1        1        0       1
## KJ425495           1           1        1        0       1
## KJ425496           1           1        1        0       1
## KJ425497           1           1        1        0       1
## KJ425498           1           1        1        0       1
## KJ425499           1           1        1        0       1
## KJ425500           1           1        1        0       1
## KJ425501           1           1        1        0       1
## KJ425502           1           1        1        0       1
## KJ425503           1           1        1        0       1
## KJ425504           1           1        1        0       1
## KJ425505           1           1        1        0       1
## KJ425506           1           1        1        0       1
## KJ425507           1           1        1        0       1
## KJ425508           1           1        1        0       1
## KJ425509           1           1        1        0       1
## KJ425510           1           1        1        0       1
## KJ425511           1           1        1        0       1
## KJ425512           1           1        1        0       1
## KJ435283           1           1        1        0       1
## KJ435284           1           1        1        0       1
## KJ435285           1           1        1        0       1
## KJ435286           1           1        1        0       1
## KJ462462           1           1        1        0       1
## KJ473795           1           1        1        0       1
## KJ473796           1           1        1        0       1
## KJ473797           1           1        1        0       1
## KJ473798           1           1        1        0       1
## KJ473799           1           1        1        0       1
## KJ473800           1           1        1        0       1
## KJ473806           1           1        1        0       1
## KJ473807           1           1        1        0       1
## KJ473808           1           1        1        0       1
## KJ473809           1           1        1        0       1
## KJ473810           1           1        1        0       1
## KJ473811           1           1        1        1       1
## KJ473812           1           1        1        1       1
## KJ473813           1           1        1        1       1
## KJ473814           1           1        1        1       1
## KJ473815           1           1        1        1       1
## KJ473816           1           1        1        1       1
## KJ473820           1           1        1        0       1
## KJ473821           1           1        1        1       1
## KJ473822           1           1        1        0       1
## KJ477102           1           1        1        0       1
## KJ477103           1           1        1        0       1
## KJ481931           1           1        1        0       1
## KJ526096           1           1        1        0       1
## KJ541759           0           0        0        0       1
## KJ556336           1           1        1        0       1
## KJ567050           1           1        1        0       1
## KJ569769           1           1        1        0       1
## KJ584355           1           1        1        0       1
## KJ584356           1           1        1        0       1
## KJ584357           1           1        1        0       1
## KJ584358           1           1        1        0       1
## KJ584359           1           1        1        0       1
## KJ584361           1           1        1        0       1
## KJ588062           1           1        1        0       1
## KJ588063           1           1        1        0       1
## KJ588064           1           1        1        0       1
## KJ601777           1           1        1        0       1
## KJ601778           1           1        1        0       1
## KJ601779           1           1        1        0       1
## KJ601780           1           1        1        0       1
## KJ614529           1           1        1        0       1
## KJ620016           1           1        1        0       1
## KJ623926           1           1        1        0       1
## KJ645635           1           1        1        0       1
## KJ645636           1           1        1        0       1
## KJ645637           1           1        1        0       1
## KJ645638           1           1        1        0       1
## KJ645639           1           1        1        0       1
## KJ645640           1           1        1        0       1
## KJ645641           1           1        1        0       1
## KJ645642           1           1        1        0       1
## KJ645643           1           1        1        0       1
## KJ645644           1           1        1        0       1
## KJ645645           1           1        1        0       1
## KJ645646           1           1        1        0       1
## KJ645647           1           1        1        0       1
## KJ645648           1           1        1        0       1
## KJ645649           1           1        1        0       1
## KJ645650           1           1        1        0       1
## KJ645651           1           1        1        0       1
## KJ645652           1           1        1        0       1
## KJ645653           1           1        1        0       1
## KJ645654           1           1        1        0       1
## KJ645655           1           1        1        0       1
## KJ645656           1           1        1        0       1
## KJ645657           1           1        1        0       1
## KJ645658           1           1        1        0       1
## KJ645659           1           1        1        0       1
## KJ645660           1           1        1        0       1
## KJ645661           1           1        1        0       1
## KJ645662           1           1        1        0       1
## KJ645663           1           1        1        0       1
## KJ645664           1           1        1        0       1
## KJ645665           1           1        1        0       1
## KJ645666           1           1        1        0       1
## KJ645667           1           1        1        0       1
## KJ645668           1           1        1        0       1
## KJ645669           1           1        1        0       1
## KJ645670           1           1        1        0       1
## KJ645671           1           1        1        0       1
## KJ645672           1           1        1        0       1
## KJ645673           1           1        1        0       1
## KJ645674           1           1        1        0       1
## KJ645675           1           1        1        0       1
## KJ645676           1           1        1        0       1
## KJ645677           1           1        1        0       1
## KJ645678           1           1        1        0       1
## KJ645679           1           1        1        0       1
## KJ645680           1           1        1        0       1
## KJ645681           1           1        1        0       1
## KJ645682           1           1        1        0       1
## KJ645683           1           1        1        0       1
## KJ645684           1           1        1        0       1
## KJ645685           1           1        1        0       1
## KJ645686           1           1        1        0       1
## KJ645687           1           1        1        0       1
## KJ645688           1           1        1        0       1
## KJ645689           1           1        1        0       1
## KJ645690           1           1        1        0       1
## KJ645691           1           1        1        0       1
## KJ645692           1           1        1        0       1
## KJ645693           1           1        1        0       1
## KJ645694           1           1        1        0       1
## KJ645695           1           1        1        0       1
## KJ645696           1           1        1        0       1
## KJ645697           1           1        1        0       1
## KJ645698           1           1        1        0       1
## KJ645699           1           1        1        0       1
## KJ645700           1           1        1        0       1
## KJ645701           1           1        1        0       1
## KJ645702           1           1        1        0       1
## KJ645703           1           1        1        0       1
## KJ645704           1           1        1        0       1
## KJ645705           1           1        1        0       1
## KJ645706           1           1        1        0       1
## KJ645707           1           1        1        0       1
## KJ645708           1           1        1        0       1
## KJ650098           1           1        1        0       1
## KJ650295           1           1        1        0       1
## KJ650296           1           1        1        0       1
## KJ650297           1           1        1        0       1
## KJ662670           1           1        1        0       1
## KJ713295           1           1        1        0       1
## KJ713296           1           1        1        0       1
## KJ713297           1           1        1        0       1
## KJ713298           1           1        1        0       1
## KJ713299           1           1        1        0       1
## KJ769231           1           1        1        0       1
## KJ777677           1           1        1        0       1
## KJ777678           1           1        1        0       1
## KJ778615           1           1        1        0       1
## KJ778616           1           1        1        0       1
## KJ813439           1           1        1        0       1
## KJ829365           1           1        1        0       1
## KJ958218           1           1        1        0       1
## KJ958219           1           1        1        0       1
## KJ960178           1           1        1        0       1
## KJ960179           1           1        1        0       1
## KJ960180           1           1        1        0       1
## KM012168           1           1        1        0       1
## KM015348           1           1        1        0       1
## KM027255           1           1        1        0       1
## KM027256           1           1        1        0       1
## KM027257           1           1        1        0       1
## KM027258           1           1        1        0       1
## KM027259           1           1        1        0       1
## KM027260           1           1        1        0       1
## KM027261           1           1        1        0       1
## KM027262           1           1        1        0       1
## KM052365           1           1        1        0       1
## KM077139           1           1        1        0       1
## KM089829           1           1        1        0       1
## KM189367           1           1        1        0       1
## KM210277           1           1        1        0       1
## KM210278           1           1        1        0       1
## KM213963           1           1        1        0       1
## KM242131           1           1        1        0       1
## KM347965           1           1        1        0       1
## KM349742           1           1        1        0       1
## KM349743           1           1        1        0       1
## KM349744           1           1        1        0       1
## KM392224           1           1        1        0       1
## KM392225           1           1        1        0       1
## KM392226           1           1        1        0       1
## KM392227           1           1        1        0       1
## KM392228           1           1        1        0       1
## KM392229           1           1        1        0       1
## KM392230           1           1        1        0       1
## KM392231           1           1        1        0       1
## KM392232           1           1        1        0       1
## KM403155           1           1        1        0       1
## KM403390           0           0        0        0       1
## KM454473           1           1        1        1       1
## KM586818           1           1        1        0       1
## KM589359           0           0        0        0       1
## KM609203           1           1        1        0       1
## KM609204           1           1        1        0       1
## KM609205           1           1        1        0       1
## KM609206           1           1        1        0       1
## KM609207           1           1        1        0       1
## KM609208           1           1        1        0       1
## KM609209           1           1        1        0       1
## KM609210           1           1        1        0       1
## KM609211           1           1        1        0       1
## KM609212           1           1        1        0       1
## KM609213           1           1        1        0       1
## KM820765           1           1        1        0       1
## KM887144           1           1        1        0       1
## KM975735           1           1        1        0       1
## KM975736           1           1        1        0       1
## KM975737           1           1        1        0       1
## KM975738           1           1        1        0       1
## KM975739           1           1        1        0       1
## KM975740           1           1        1        0       1
## KM975741           1           1        1        0       1
## KP036502           1           1        1        0       1
## KP036503           1           1        1        0       1
## KP036504           1           1        1        0       1
## KP036505           1           1        1        0       1
## KP118880           1           1        1        0       1
## KP118881           1           1        1        0       1
## KP118882           1           1        1        0       1
## KP118883           1           1        1        0       1
## KP118884           1           1        1        0       1
## KP118885           1           1        1        0       1
## KP118886           1           1        1        0       1
## KP118887           1           1        1        0       1
## KP118888           1           1        1        0       1
## KP118889           1           1        1        0       1
## KP118890           1           1        1        0       1
## KP118891           1           1        1        0       1
## KP118892           1           1        1        0       1
## KP118893           1           1        1        0       1
## KP118894           1           1        1        0       1
## KP143507           1           1        1        1       1
## KP143508           1           1        1        1       1
## KP143509           1           1        1        1       1
## KP143510           1           1        1        1       1
## KP143511           1           1        1        1       1
## KP143512           1           1        1        1       1
## KP162057           1           1        1        0       1
## KP198610           1           1        1        0       1
## KP198611           1           1        1        0       1
## KP202848           1           1        1        0       1
## KP209306           1           1        1        0       1
## KP209307           1           1        1        0       1
## KP209308           1           1        1        0       1
## KP209309           1           1        1        0       1
## KP209310           1           1        1        0       1
## KP209311           1           1        1        0       1
## KP209312           1           1        1        0       1
## KP209313           1           1        1        0       1
## KP223131           1           1        1        0       1
## KP343691           1           1        1        0       1
## KP403802           1           1        1        0       1
## KP403954           1           1        1        0       1
## KP641661           1           1        1        0       1
## KP641662           1           1        1        0       1
## KP641663           1           1        1        0       1
## KP662631           1           1        1        0       1
## KP688354           1           1        1        0       1
## KP719927           1           1        1        0       1
## KP719928           1           1        1        0       1
## KP719929           1           1        1        0       1
## KP719930           1           1        1        0       1
## KP719931           1           1        1        0       1
## KP719932           1           1        1        0       1
## KP719933           1           1        1        0       1
## KP728470           1           1        1        0       1
## KP757890           1           1        1        0       1
## KP757891           1           1        1        0       1
## KP757892           1           1        1        0       1
## KP765609           1           1        1        0       1
## KP780179           1           1        1        0       1
## KP790143           1           1        1        0       1
## KP790144           1           1        1        0       1
## KP790145           1           1        1        0       1
## KP790146           1           1        1        0       1
## KP849472           1           1        1        0       1
## KP861982           0           0        0        0       1
## KP868572           1           1        1        0       1
## KP868573           1           1        1        0       1
## KP886808           1           1        1        1       1
## KP886809           1           1        1        1       1
## KP887098           1           1        1        0       1
## KP890336           1           1        1        0       1
## KP981395           1           1        1        0       1
## KP981644           1           1        1        1       1
## KR003452           1           1        1        0       1
## KR011263           1           1        1        0       1
## KR011264           1           1        1        0       1
## KR011265           1           1        1        0       1
## KR011266           1           1        1        0       1
## KR011756           1           1        1        0       1
## KR061458           1           1        1        0       1
## KR061459           1           1        1        0       1
## KR078299           1           1        1        0       1
## KR078300           1           1        1        0       1
## KR095279           1           1        1        0       1
## KR131621           1           1        1        0       1
## KR150443           1           1        1        0       1
## KR153325           1           1        1        0       1
## KR153326           1           1        1        0       1
## KR231009           1           1        1        0       1
## KR265759           1           1        1        0       1
## KR265760           1           1        1        0       1
## KR265761           1           1        1        0       1
## KR265762           1           1        1        0       1
## KR265763           1           1        1        0       1
## KR265764           1           1        1        0       1
## KR265765           1           1        1        0       1
## KR265766           1           1        1        0       1
## KR265767           1           1        1        0       1
## KR265768           1           1        1        0       1
## KR265769           1           1        1        0       1
## KR265770           1           1        1        0       1
## KR265771           1           1        1        0       1
## KR265772           1           1        1        0       1
## KR265773           1           1        1        0       1
## KR265774           1           1        1        0       1
## KR265775           1           1        1        0       1
## KR265776           1           1        1        0       1
## KR265777           1           1        1        0       1
## KR265778           1           1        1        0       1
## KR265779           1           1        1        0       1
## KR265780           1           1        1        0       1
## KR265781           1           1        1        0       1
## KR265782           1           1        1        0       1
## KR265783           1           1        1        0       1
## KR265784           1           1        1        0       1
## KR265785           1           1        1        0       1
## KR265786           1           1        1        0       1
## KR265787           1           1        1        0       1
## KR265788           1           1        1        0       1
## KR265789           1           1        1        0       1
## KR265790           1           1        1        0       1
## KR265791           1           1        1        0       1
## KR265792           1           1        1        0       1
## KR265793           1           1        1        0       1
## KR265794           1           1        1        0       1
## KR265795           1           1        1        0       1
## KR265796           1           1        1        0       1
## KR265797           1           1        1        0       1
## KR265798           1           1        1        0       1
## KR265799           1           1        1        0       1
## KR265800           1           1        1        0       1
## KR265801           1           1        1        0       1
## KR265802           1           1        1        0       1
## KR265803           1           1        1        0       1
## KR265804           1           1        1        0       1
## KR265805           1           1        1        0       1
## KR265806           1           1        1        0       1
## KR265807           1           1        1        0       1
## KR265808           1           1        1        0       1
## KR265809           1           1        1        0       1
## KR265810           1           1        1        0       1
## KR265811           1           1        1        0       1
## KR265812           1           1        1        0       1
## KR265813           1           1        1        0       1
## KR265814           1           1        1        0       1
## KR265815           1           1        1        0       1
## KR265816           1           1        1        0       1
## KR265817           1           1        1        0       1
## KR265818           1           1        1        0       1
## KR265819           1           1        1        0       1
## KR265820           1           1        1        0       1
## KR265821           1           1        1        0       1
## KR265822           1           1        1        0       1
## KR265823           1           1        1        0       1
## KR265824           1           1        1        0       1
## KR265825           1           1        1        0       1
## KR265826           1           1        1        0       1
## KR265827           1           1        1        0       1
## KR265828           1           1        1        0       1
## KR265829           1           1        1        0       1
## KR265830           1           1        1        0       1
## KR265831           1           1        1        0       1
## KR265832           1           1        1        0       1
## KR265833           1           1        1        0       1
## KR265834           1           1        1        0       1
## KR265840           1           1        1        0       1
## KR265841           1           1        1        0       1
## KR265842           1           1        1        0       1
## KR265843           1           1        1        0       1
## KR265844           1           1        1        0       1
## KR265845           1           1        1        0       1
## KR265846           1           1        1        0       1
## KR265847           1           1        1        0       1
## KR265848           1           1        1        0       1
## KR265849           1           1        1        0       1
## KR265850           1           1        1        0       1
## KR265851           1           1        1        0       1
## KR265852           1           1        1        0       1
## KR265853           1           1        1        0       1
## KR265854           1           1        1        0       1
## KR265855           1           1        1        0       1
## KR265856           1           1        1        0       1
## KR265857           1           1        1        0       1
## KR265858           1           1        1        0       1
## KR265859           1           1        1        0       1
## KR265860           1           1        1        0       1
## KR265861           1           1        1        0       1
## KR265862           1           1        1        0       1
## KR265863           1           1        1        0       1
## KR265864           1           1        1        0       1
## KR265865           1           1        1        0       1
## KR270796           1           1        1        0       1
## KR527150           0           0        0        0       1
## KR608272           1           1        1        0       1
## KR610991           1           1        1        0       1
## KR610992           1           1        1        0       1
## KR610993           1           1        1        0       1
## KR610994           1           1        1        0       1
## KR809885           1           1        1        0       1
## KR818832           1           1        1        0       1
## KR818833           1           1        1        0       1
## KR822424           1           1        1        0       1
## KR873431           1           1        1        0       1
## KR873434           1           1        1        0       1
## KR873435           1           1        1        0       1
## KR902510           1           1        1        0       1
## KT006149           1           1        1        0       1
## KT021227           1           1        1        0       1
## KT021228           1           1        1        0       1
## KT021229           1           1        1        0       1
## KT021230           1           1        1        0       1
## KT021231           1           1        1        0       1
## KT021232           1           1        1        0       1
## KT021233           1           1        1        0       1
## KT021234           1           1        1        0       1
## KT021235           0           0        0        0       1
## KT021236           0           0        0        0       1
## KT021237           0           0        0        0       1
## KT021238           0           0        0        0       1
## KT021239           0           0        0        0       1
## KT021240           0           0        0        0       1
## KT021241           0           0        0        0       1
## KT021242           0           0        0        0       1
## KT026453           1           1        1        0       1
## KT026454           1           1        1        0       1
## KT026455           1           1        1        0       1
## KT026456           1           1        1        0       1
## KT029139           1           1        1        0       1
## KT121572           1           1        1        0       1
## KT121573           1           1        1        0       1
## KT121574           1           1        1        0       1
## KT121575           1           1        1        0       1
## KT121576           1           1        1        0       1
## KT121577           1           1        1        0       1
## KT121578           1           1        1        0       1
## KT121579           1           1        1        0       1
## KT121580           1           1        1        0       1
## KT121581           1           1        1        0       1
## KT156560           1           1        1        0       1
## KT156561           1           1        1        0       1
## KT203557           1           1        1        0       1
## KT225476           1           1        1        0       1
## KT253324           1           1        1        0       1
## KT253325           1           1        1        0       1
## KT253326           1           1        1        0       1
## KT253327           1           1        1        0       1
## KT253328           1           1        1        0       1
## KT266822           1           1        1        0       1
## KT266906           1           1        1        0       1
## KT326819           1           1        1        0       1
## KT336560           1           1        1        0       1
## KT368824           1           1        1        0       1
## KT368825           1           1        1        0       1
## KT368826           1           1        1        0       1
## KT368827           1           1        1        0       1
## KT368828           1           1        1        0       1
## KT368829           1           1        1        0       1
## KT368830           1           1        1        0       1
## KT368831           1           1        1        0       1
## KT368832           1           1        1        0       1
## KT368833           1           1        1        0       1
## KT368834           1           1        1        0       1
## KT368835           1           1        1        0       1
## KT368836           1           1        1        0       1
## KT368837           1           1        1        0       1
## KT368838           1           1        1        0       1
## KT368839           1           1        1        0       1
## KT368840           1           1        1        0       1
## KT368841           1           1        1        0       1
## KT368842           1           1        1        0       1
## KT368843           1           1        1        0       1
## KT368844           1           1        1        0       1
## KT368845           1           1        1        0       1
## KT368846           1           1        1        0       1
## KT368847           1           1        1        0       1
## KT368848           1           1        1        0       1
## KT368849           1           1        1        0       1
## KT368850           1           1        1        0       1
## KT368851           1           1        1        0       1
## KT368852           1           1        1        0       1
## KT368853           1           1        1        0       1
## KT368854           1           1        1        0       1
## KT368855           1           1        1        0       1
## KT368856           1           1        1        0       1
## KT368857           1           1        1        0       1
## KT368858           1           1        1        0       1
## KT368859           1           1        1        0       1
## KT368860           1           1        1        0       1
## KT368861           1           1        1        0       1
## KT368862           1           1        1        0       1
## KT368863           1           1        1        0       1
## KT368864           1           1        1        0       1
## KT368865           1           1        1        0       1
## KT368866           1           1        1        0       1
## KT368867           1           1        1        0       1
## KT368868           1           1        1        0       1
## KT368869           1           1        1        0       1
## KT368870           1           1        1        0       1
## KT368871           1           1        1        0       1
## KT368872           1           1        1        0       1
## KT368873           1           1        1        0       1
## KT368874           1           1        1        0       1
## KT368875           1           1        1        0       1
## KT368876           1           1        1        0       1
## KT368877           1           1        1        0       1
## KT368878           1           1        1        0       1
## KT368879           1           1        1        0       1
## KT368880           1           1        1        0       1
## KT368881           1           1        1        0       1
## KT368882           1           1        1        0       1
## KT368883           1           1        1        0       1
## KT368884           1           1        1        0       1
## KT368885           1           1        1        0       1
## KT368886           1           1        1        0       1
## KT368887           1           1        1        0       1
## KT368888           1           1        1        0       1
## KT368889           1           1        1        0       1
## KT368890           1           1        1        0       1
## KT368891           1           1        1        0       1
## KT368892           1           1        1        0       1
## KT368893           1           1        1        0       1
## KT368894           1           1        1        0       1
## KT368895           1           1        1        0       1
## KT368896           1           1        1        0       1
## KT368897           1           1        1        0       1
## KT368898           1           1        1        0       1
## KT368899           1           1        1        0       1
## KT368900           1           1        1        0       1
## KT368901           1           1        1        0       1
## KT368902           1           1        1        0       1
## KT368903           1           1        1        0       1
## KT368904           1           1        1        0       1
## KT368905           1           1        1        0       1
## KT368906           1           1        1        0       1
## KT368907           1           1        1        0       1
## KT368908           1           1        1        0       1
## KT368909           1           1        1        0       1
## KT368910           1           1        1        0       1
## KT368911           1           1        1        0       1
## KT368912           1           1        1        0       1
## KT368913           1           1        1        0       1
## KT368914           1           1        1        0       1
## KT368915           1           1        1        0       1
## KT368916           1           1        1        0       1
## KT371500           0           0        0        0       1
## KT371501           0           0        0        0       1
## KT371502           0           0        0        0       1
## KT371503           0           0        0        0       1
## KT371504           0           0        0        0       1
## KT371505           0           0        0        0       1
## KT371506           0           0        0        0       1
## KT371507           0           0        0        0       1
## KT374050           1           1        1        0       1
## KT374051           1           1        1        0       1
## KT374052           1           1        1        0       1
## KT374053           1           1        1        0       1
## KT374054           1           1        1        0       1
## KT374055           1           1        1        0       1
## KT374056           1           1        1        0       1
## KT374057           1           1        1        0       1
## KT381613           1           1        1        0       1
## KT381875           1           1        1        0       1
## KT444582           1           1        1        1       1
## KT591944           1           1        1        0       1
## KT696544           1           1        1        0       1
## KT736031           1           1        1        0       1
## KT736032           1           1        1        0       1
## KT751244           1           1        1        0       1
## KT779555           1           1        1        1       1
## KT779556           1           1        1        1       1
## KT806044           1           1        1        0       1
## KT806045           1           1        1        0       1
## KT806046           1           1        1        0       1
## KT806047           1           1        1        0       1
## KT806048           1           1        1        0       1
## KT806049           1           1        1        0       1
## KT806051           1           1        1        0       1
## KT806052           1           1        1        0       1
## KT806053           1           1        1        1       1
## KT806054           1           1        1        0       1
## KT806055           1           1        1        0       1
## KT852992           1           1        1        0       1
## KT860508           1           1        1        0       1
## KT861627           1           1        1        0       1
## KT861628           1           1        1        0       1
## KT877350           1           1        1        0       1
## KT877351           1           1        1        0       1
## KT886454           1           1        1        0       1
## KT941120           1           1        1        0       1
## KT946798           1           1        1        0       1
## KU051641           1           1        1        0       1
## KU051649           1           1        1        0       1
## KU095838           0           0        0        0       1
## KU131570           1           1        1        0       1
## KU182964           1           1        1        1       1
## KU182965           1           1        1        1       1
## KU215419           1           1        1        0       1
## KU215420           1           1        1        0       1
## KU215421           1           1        1        0       1
## KU215422           1           1        1        0       1
## KU215423           1           1        1        0       1
## KU215424           1           1        1        0       1
## KU215425           1           1        1        0       1
## KU215426           1           1        1        0       1
## KU215427           1           1        1        0       1
## KU215428           1           1        1        0       1
## KU237213           0           0        0        0       1
## KU237214           0           0        0        0       1
## KU237217           0           0        0        0       1
## KU237218           0           0        0        0       1
## KU237219           0           0        0        0       1
## KU237220           0           0        0        0       1
## KU237221           0           0        0        0       1
## KU237222           0           0        0        0       1
## KU237223           0           0        0        0       1
## KU237224           0           0        0        0       1
## KU237225           0           0        0        0       1
## KU237226           0           0        0        0       1
## KU237227           0           0        0        0       1
## KU237228           0           0        0        0       1
## KU237229           0           0        0        0       1
## KU237230           0           0        0        0       1
## KU237231           0           0        0        0       1
## KU237232           0           0        0        0       1
## KU237233           0           0        0        0       1
## KU237234           0           0        0        0       1
## KU242423           1           1        1        0       1
## KU242424           1           1        1        0       1
## KU252649           1           1        1        0       1
## KU291448           1           1        1        0       1
## KU291449           1           1        1        0       1
## KU297956           1           1        1        0       1
## KU308549           1           1        1        0       1
## KU317090           1           1        1        0       1
## KU356856           1           1        1        0       1
## KU361187           1           1        1        0       1
## KU361188           1           1        1        0       1
## KU380331           1           1        1        0       1
## KU558701           1           1        1        0       1
## KU558922           1           1        1        0       1
## KU558923           1           1        1        0       1
## KU569509           1           1        1        0       1
## KU646831           1           1        1        0       1
## KU664503           1           1        1        0       1
## KU710264           1           1        1        0       1
## KU710265           1           1        1        0       1
## KU729220           1           1        1        0       1
## KU762338           1           1        1        0       1
## KU847996           1           1        1        0       1
## KU851859           1           1        1        0       1
## KU851860           1           1        1        0       1
## KU851861           1           1        1        0       1
## KU851862           1           1        1        0       1
## KU851863           1           1        1        0       1
## KU851864           1           1        1        0       1
## KU886219           1           1        1        0       1
## KU900738           1           1        1        0       1
## KU900739           1           1        1        0       1
## KU900740           1           1        1        0       1
## KU900741           1           1        1        0       1
## KU900742           1           1        1        0       1
## KU900743           1           1        1        0       1
## KU900744           1           1        1        0       1
## KU973692           1           1        1        1       1
## KU975389           1           1        1        0       1
## KU981059           1           1        1        0       1
## KU981060           1           1        1        0       1
## KU981061           1           1        1        0       1
## KU981062           1           1        1        0       1
## KU982966           1           1        1        0       1
## KU982967           1           1        1        0       1
## KU982968           1           1        1        0       1
## KU982969           1           1        1        0       1
## KU982970           1           1        1        0       1
## KU982971           1           1        1        0       1
## KU982972           1           1        1        0       1
## KU982973           1           1        1        0       1
## KU982974           1           1        1        0       1
## KU982975           1           1        1        0       1
## KU982976           1           1        1        0       1
## KU982977           1           1        1        0       1
## KU982978           1           1        1        0       1
## KU982979           1           1        1        0       1
## KU982980           1           1        1        0       1
## KU982981           1           1        1        0       1
## KU984334           1           1        1        0       1
## KX016034           1           1        1        0       1
## KX022602           1           1        1        0       1
## KX022603           1           1        1        0       1
## KX022604           1           1        1        0       1
## KX022605           1           1        1        0       1
## KX034094           1           1        1        0       1
## KX034095           1           1        1        0       1
## KX034096           1           1        1        0       1
## KX034097           1           1        1        0       1
## KX034098           1           1        1        0       1
## KX034099           1           1        1        0       1
## KX034100           1           1        1        0       1
## KX058031           1           1        1        0       1
## KX058032           1           1        1        0       1
## KX058033           1           1        1        0       1
## KX064280           1           1        1        0       1
## KX066126           1           1        1        0       1
## KX077987           1           1        1        0       1
## KX108937           1           1        1        0       1
## KX108938           1           1        1        0       1
## KX108939           1           1        1        0       1
## KX108940           1           1        1        0       1
## KX108941           1           1        1        0       1
## KX108942           1           1        1        1       1
## KX108943           1           1        1        0       1
## KX108944           1           1        1        0       1
## KX108945           1           1        1        0       1
## KX108946           1           1        1        0       1
## KX118627           1           1        1        0       1
## KX154684           1           1        1        0       1
## KX154685           1           1        1        0       1
## KX154686           1           1        1        0       1
## KX154687           1           1        1        0       1
## KX154688           1           1        1        0       1
## KX154689           1           1        1        0       1
## KX154690           1           1        1        0       1
## KX154691           1           1        1        0       1
## KX154692           1           1        1        0       1
## KX154693           1           1        1        0       1
## KX154694           1           1        1        0       1
## KX179494           0           0        0        0       1
## KX179495           0           0        0        0       1
## KX179496           0           0        0        0       1
## KX179497           0           0        0        0       1
## KX179498           0           0        0        0       1
## KX179499           0           0        0        0       1
## KX179500           1           1        1        0       1
## KX185056           1           1        1        0       1
## KX185057           1           1        1        0       1
## KX185058           1           1        1        0       1
## KX185059           1           1        1        0       1
## KX219791           1           1        1        0       1
## KX219792           1           1        1        0       1
## KX219793           1           1        1        0       1
## KX219794           1           1        1        0       1
## KX219795           1           1        1        0       1
## KX219796           1           1        1        0       1
## KX219797           1           1        1        0       1
## KX219798           1           1        1        0       1
## KX219799           1           1        1        0       1
## KX219800           1           1        1        0       1
## KX219801           1           1        1        0       1
## KX236000           1           1        1        0       1
## KX236001           1           1        1        0       1
## KX236002           1           1        1        0       1
## KX236003           1           1        1        0       1
## KX236004           1           1        1        0       1
## KX236005           1           1        1        0       1
## KX236006           1           1        1        0       1
## KX236007           1           1        1        0       1
## KX236008           1           1        1        0       1
## KX236009           1           1        1        0       1
## KX236010           1           1        1        0       1
## KX236011           1           1        1        0       1
## KX236012           1           1        1        0       1
## KX236013           1           1        1        0       1
## KX236014           1           1        1        0       1
## KX236015           1           1        1        0       1
## KX236016           1           1        1        0       1
## KX247127           1           1        1        0       1
## KX247128           1           1        1        0       1
## KX247129           1           1        1        0       1
## KX247130           1           1        1        0       1
## KX252772           1           1        1        0       1
## KX252773           1           1        1        0       1
## KX252774           1           1        1        0       1
## KX252775           1           1        1        0       1
## KX252776           1           1        1        0       1
## KX252777           1           1        1        0       1
## KX252778           1           1        1        0       1
## KX252779           1           1        1        0       1
## KX252780           1           1        1        0       1
## KX252781           1           1        1        0       1
## KX252782           1           1        1        0       1
## KX252783           1           1        1        0       1
## KX252784           1           1        1        0       1
## KX252785           1           1        1        0       1
## KX252786           1           1        1        0       1
## KX252787           1           1        1        0       1
## KX252788           1           1        1        0       1
## KX252789           1           1        1        0       1
## KX252790           1           1        1        0       1
## KX252791           1           1        1        0       1
## KX259248           1           1        1        0       1
## KX259249           1           1        1        0       1
## KX259250           1           1        1        0       1
## KX259251           1           1        1        0       1
## KX259252           1           1        1        0       1
## KX259253           1           1        1        0       1
## KX259254           1           1        1        0       1
## KX259255           1           1        1        0       1
## KX259256           1           1        1        0       1
## KX259257           1           1        1        0       1
## KX266757           1           1        1        0       1
## KX272465           1           1        1        0       1
## KX275390           1           1        1        0       1
## KX275391           1           1        1        0       1
## KX275392           1           1        1        0       1
## KX275393           1           1        1        0       1
## KX275394           1           1        1        0       1
## KX289955           1           1        1        0       1
## KX302860           1           1        1        0       1
## KX302861           1           1        1        0       1
## KX302862           1           1        1        0       1
## KX302863           1           1        1        0       1
## KX302864           1           1        1        0       1
## KX302865           1           1        1        0       1
## KX302866           1           1        1        0       1
## KX302867           1           1        1        0       1
## KX302868           1           1        1        0       1
## KX302869           1           1        1        0       1
## KX302870           1           1        1        0       1
## KX302871           1           1        1        0       1
## KX302872           1           1        1        0       1
## KX302873           1           1        1        0       1
## KX302874           1           1        1        0       1
## KX302875           1           1        1        0       1
## KX344031           1           1        1        0       1
## KX348114           1           1        1        0       1
## KX348115           1           1        1        0       1
## KX348116           1           1        1        0       1
## KX348117           1           1        1        0       1
## KX364290           1           1        1        0       1
## KX364291           1           1        1        0       1
## KX364292           1           1        1        0       1
## KX364293           1           1        1        0       1
## KX364294           1           1        1        0       1
## KX364295           1           1        1        0       1
## KX364296           1           1        1        0       1
## KX364297           1           1        1        0       1
## KX364298           1           1        1        0       1
## KX364299           1           1        1        0       1
## KX364300           1           1        1        0       1
## KX372249           1           1        1        0       1
## KX372250           1           1        1        0       1
## KX375805           1           1        1        0       1
## KX375806           1           1        1        0       1
## KX375807           1           1        1        0       1
## KX375808           1           1        1        0       1
## KX389094           1           1        1        0       1
## KX400753           1           1        1        0       1
## KX425847           1           1        1        0       1
## KX432213           1           1        1        0       1
## KX434788           1           1        1        0       1
## KX434789           1           1        1        0       1
## KX434790           1           1        1        0       1
## KX442564           1           1        1        1       1
## KX442565           1           1        1        0       1
## KX443143           1           1        1        0       1
## KX499468           1           1        1        0       1
## KX512809           1           1        1        0       1
## KX512810           1           1        1        0       1
## KX534205           1           1        1        0       1
## KX534206           1           1        1        0       1
## KX538964           1           1        1        0       1
## KX538965           1           1        1        0       1
## KX538966           1           1        1        0       1
## KX538967           1           1        1        0       1
## KX538968           1           1        1        0       1
## KX538969           1           1        1        0       1
## KX538970           1           1        1        0       1
## KX538971           1           1        1        0       1
## KX538972           1           1        1        0       1
## KX538973           1           1        1        0       1
## KX538974           1           1        1        0       1
## KX538975           1           1        1        0       1
## KX538976           1           1        1        0       1
## KX538977           1           1        1        0       1
## KX538978           1           1        1        0       1
## KX538979           1           1        1        0       1
## KX550281           1           1        1        0       1
## KX574227           1           1        1        1       1
## KX580953           1           1        1        0       1
## KX580958           1           1        1        0       1
## KX640829           1           1        1        0       1
## KX683006           1           1        1        0       1
## KX722529           1           1        1        0       1
## KX722530           1           1        1        0       1
## KX791060           1           1        1        0       1
## KX812523           1           1        1        0       1
## KX812524           1           1        1        0       1
## KX834130           0           0        0        0       1
## KX834131           0           0        0        0       1
## KX834351           1           1        1        0       1
## KX834352           1           1        1        0       1
## KX839246           1           1        1        0       1
## KX839247           1           1        1        0       1
## KX839248           1           1        1        0       1
## KX839249           1           1        1        0       1
## KX839250           1           1        1        0       1
## KX839251           1           1        1        0       1
## KX900393           1           1        1        0       1
## KX900394           1           1        1        0       1
## KX900395           1           1        1        0       1
## KX900396           1           1        1        0       1
## KX900397           1           1        1        0       1
## KX900398           1           1        1        0       1
## KX900399           1           1        1        0       1
## KX900400           1           1        1        0       1
## KX900401           1           1        1        0       1
## KX900402           1           1        1        0       1
## KX900403           1           1        1        0       1
## KX900404           1           1        1        0       1
## KX900405           1           1        1        0       1
## KX900406           1           1        1        0       1
## KX900407           1           1        1        0       1
## KX900408           1           1        1        1       1
## KX900409           1           1        1        1       1
## KX900410           1           1        1        1       1
## KX900411           1           1        1        0       1
## KX964649           1           1        1        0       1
## KX981440           1           1        1        0       1
## KX982264           1           1        1        0       1
## KY007139           1           1        1        0       1
## KY007140           1           1        1        0       1
## KY014281           1           1        1        0       1
## KY014282           1           1        1        0       1
## KY019623           1           1        1        0       1
## KY019624           1           1        1        0       1
## KY047602           1           1        1        0       1
## KY056254           0           0        0        0       1
## KY056255           0           0        0        0       1
## KY063616           1           1        1        0       1
## KY063617           1           1        1        0       1
## KY063618           1           1        1        0       1
## KY065120           1           1        1        0       1
## KY070587           1           1        1        0       1
## KY073744           1           1        1        0       1
## KY073745           1           1        1        0       1
## KY073746           1           1        1        0       1
## KY073747           1           1        1        0       1
## KY073748           1           1        1        0       1
## KY111278           1           1        1        0       1
## KY130432           0           0        0        0       1
## KY292377           1           1        1        0       1
## KY293677           1           1        1        0       1
## KY293678           1           1        1        0       1
## KY352407           1           1        1        1       1
## KY354363           1           1        1        0       1
## KY354364           1           1        1        0       1
## KY363867           1           1        1        0       1
## KY363868           1           1        1        0       1
## KY364365           1           1        1        0       1
## KY369905           1           1        1        0       1
## KY369906           1           1        1        0       1
## KY369907           1           1        1        0       1
## KY369908           1           1        1        0       1
## KY369909           1           1        1        0       1
## KY369910           1           1        1        0       1
## KY369911           1           1        1        0       1
## KY369912           1           1        1        0       1
## KY369913           1           1        1        0       1
## KY369914           1           1        1        0       1
## KY369959           0           0        0        0       1
## KY398010           0           0        0        0       1
## KY398011           0           0        0        0       1
## KY398014           0           0        0        0       1
## KY406735           1           1        1        0       1
## KY407556           1           1        1        0       1
## KY407557           1           1        1        0       1
## KY407558           1           1        1        0       1
## KY417142           1           1        1        1       1
## KY417143           1           1        1        1       1
## KY417144           1           1        1        1       1
## KY417145           1           1        1        1       1
## KY417146           1           1        1        1       1
## KY417147           1           1        1        1       1
## KY417148           1           1        1        1       1
## KY417149           1           1        1        1       1
## KY417150           1           1        1        1       1
## KY417151           1           1        1        1       1
## KY417152           1           1        1        1       1
## KY419103           1           1        1        0       1
## KY419104           1           1        1        0       1
## KY419105           1           1        1        0       1
## KY419106           1           1        1        0       1
## KY419107           1           1        1        0       1
## KY419109           1           1        1        0       1
## KY419110           1           1        1        0       1
## KY419111           1           1        1        0       1
## KY419112           1           1        1        0       1
## KY419113           1           1        1        0       1
## KY421672           1           1        1        0       1
## KY421673           1           1        1        0       1
## KY486713           1           1        1        0       1
## KY486714           1           1        1        0       1
## KY499261           1           1        1        0       1
## KY499262           1           1        1        0       1
## KY513724           1           1        1        0       1
## KY513725           1           1        1        0       1
## KY554967           1           1        1        0       1
## KY554968           1           1        1        0       1
## KY554969           1           1        1        0       1
## KY554970           1           1        1        0       1
## KY554971           1           1        1        0       1
## KY554972           1           1        1        0       1
## KY554973           1           1        1        0       1
## KY554974           1           1        1        0       1
## KY554975           1           1        1        0       1
## KY566209           1           1        1        0       1
## KY566210           1           1        1        0       1
## KY566211           1           1        1        0       1
## KY581684           1           1        1        0       1
## KY581685           1           1        1        0       1
## KY581686           1           1        1        0       1
## KY581687           1           1        1        0       1
## KY581688           1           1        1        0       1
## KY581689           1           1        1        0       1
## KY581690           1           1        1        0       1
## KY581691           1           1        1        0       1
## KY581692           1           1        1        0       1
## KY581693           1           1        1        0       1
## KY581694           1           1        1        0       1
## KY581695           1           1        1        0       1
## KY581696           1           1        1        0       1
## KY581697           1           1        1        0       1
## KY581698           1           1        1        0       1
## KY581699           1           1        1        0       1
## KY581700           1           1        1        0       1
## KY620116           1           1        1        0       1
## KY621348           1           1        1        0       1
## KY626044           1           1        1        0       1
## KY626045           1           1        1        0       1
## KY649107           1           1        1        0       1
## KY673148           1           1        1        0       1
## KY673149           1           1        1        0       1
## KY674914           1           1        1        0       1
## KY674915           1           1        1        0       1
## KY674916           1           1        1        0       1
## KY674917           1           1        1        0       1
## KY674918           1           1        1        0       1
## KY674919           1           1        1        0       1
## KY674920           1           1        1        0       1
## KY674921           1           1        1        1       1
## KY674941           1           1        1        1       1
## KY674942           1           1        1        1       1
## KY674943           1           1        1        1       1
## KY684759           1           1        1        0       1
## KY684760           1           1        1        0       1
## KY688118           1           1        1        0       1
## KY688119           1           1        1        0       1
## KY688120           1           1        1        0       1
## KY688121           1           1        1        0       1
## KY688122           1           1        1        0       1
## KY688123           1           1        1        0       1
## KY688124           1           1        1        0       1
## KY770850           1           1        1        0       1
## KY770851           1           1        1        0       1
## KY770858           1           1        1        1       1
## KY770859           1           1        1        1       1
## KY770860           1           1        1        1       1
## KY776700           1           1        1        0       1
## KY776701           1           1        1        0       1
## KY793536           1           1        1        0       1
## KY799179           1           1        1        0       1
## KY799582           1           1        1        0       1
## KY805845           1           1        1        0       1
## KY805846           1           1        1        0       1
## KY825240           1           1        1        0       1
## KY825241           1           1        1        0       1
## KY825242           1           1        1        0       1
## KY825243           1           1        1        0       1
## KY829118           1           1        1        0       1
## KY926512           1           1        1        0       1
## KY928065           1           1        1        0       1
## KY933089           1           1        1        0       1
## KY933090           1           1        1        0       1
## KY938558           1           1        1        1       1
## KY963963           1           1        1        0       1
## KY967356           1           1        1        0       1
## KY967357           1           1        1        0       1
## KY967358           1           1        1        0       1
## KY967359           1           1        1        0       1
## KY967360           1           1        1        0       1
## KY967361           1           1        1        0       1
## KY983583           1           1        1        0       1
## KY983585           1           1        1        0       1
## KY983586           1           1        1        0       1
## KY983587           1           1        1        0       1
## KY983588           1           1        1        0       1
## KY994645           1           1        1        0       1
## MF000457           1           1        1        0       1
## MF000458           1           1        1        0       1
## MF000459           1           1        1        0       1
## MF000460           1           1        1        0       1
## MF041982           1           1        1        0       1
## MF083115           1           1        1        0       1
## MF094681           1           1        1        0       1
## MF094682           1           1        1        0       1
## MF094683           1           1        1        0       1
## MF094684           1           1        1        0       1
## MF094685           1           1        1        0       1
## MF094686           1           1        1        0       1
## MF094687           1           1        1        0       1
## MF094688           1           1        1        0       1
## MF095123           1           1        1        0       1
## MF113046           1           1        1        0       1
## MF158348           0           0        0        0       1
## MF167434           1           1        1        0       1
## MF176279           0           0        0        0       1
## MF280390           1           1        1        0       1
## MF281416           1           1        1        0       1
## MF314143           1           1        1        0       1
## MF346935           1           1        1        0       1
## MF370205           1           1        1        0       1
## MF373643           1           1        1        0       1
## MF374983           1           1        1        0       1
## MF374984           1           1        1        0       1
## MF374985           1           1        1        0       1
## MF375374           1           1        1        0       1
## MF421319           1           1        1        0       1
## MF421320           1           1        1        0       1
## MF431742           1           1        1        0       1
## MF431743           1           1        1        0       1
## MF462814           1           1        1        0       1
## MF508703           1           1        1        0       1
## MF577027           1           1        1        0       1
## MF593268           1           1        1        1       1
## MF593473           1           1        1        0       1
## MF598594           1           1        1        0       1
## MF598595           1           1        1        0       1
## MF598596           1           1        1        0       1
## MF598597           1           1        1        0       1
## MF598598           1           1        1        0       1
## MF598599           1           1        1        0       1
## MF598600           1           1        1        0       1
## MF598601           1           1        1        0       1
## MF598602           1           1        1        0       1
## MF598603           1           1        1        0       1
## MF598604           1           1        1        0       1
## MF598605           1           1        1        0       1
## MF598606           1           1        1        0       1
## MF598607           1           1        1        0       1
## MF598608           1           1        1        0       1
## MF598609           1           1        1        0       1
## MF598610           1           1        1        0       1
## MF598611           1           1        1        0       1
## MF598612           1           1        1        0       1
## MF598613           1           1        1        0       1
## MF598614           1           1        1        0       1
## MF598615           1           1        1        0       1
## MF598616           1           1        1        0       1
## MF598617           1           1        1        0       1
## MF598618           1           1        1        0       1
## MF598619           1           1        1        0       1
## MF598620           1           1        1        0       1
## MF598621           1           1        1        0       1
## MF598622           1           1        1        0       1
## MF598623           1           1        1        0       1
## MF598624           1           1        1        0       1
## MF598625           1           1        1        0       1
## MF598626           1           1        1        0       1
## MF598627           1           1        1        0       1
## MF598629           1           1        1        0       1
## MF598630           1           1        1        0       1
## MF598631           1           1        1        0       1
## MF598632           1           1        1        0       1
## MF598633           1           1        1        0       1
## MF598634           1           1        1        0       1
## MF598635           1           1        1        0       1
## MF598636           1           1        1        0       1
## MF598637           1           1        1        0       1
## MF598638           1           1        1        0       1
## MF598639           1           1        1        0       1
## MF598640           1           1        1        0       1
## MF598641           1           1        1        0       1
## MF598643           1           1        1        0       1
## MF598644           1           1        1        0       1
## MF598645           1           1        1        0       1
## MF598646           1           1        1        0       1
## MF598647           1           1        1        0       1
## MF598648           1           1        1        0       1
## MF598649           1           1        1        0       1
## MF598650           1           1        1        0       1
## MF598651           1           1        1        0       1
## MF598652           1           1        1        0       1
## MF598653           1           1        1        0       1
## MF598654           1           1        1        0       1
## MF598655           1           1        1        0       1
## MF598656           1           1        1        0       1
## MF598657           1           1        1        0       1
## MF598658           1           1        1        0       1
## MF598659           1           1        1        0       1
## MF598660           1           1        1        0       1
## MF598661           1           1        1        0       1
## MF598662           1           1        1        0       1
## MF598663           1           1        1        0       1
## MF598664           1           1        1        0       1
## MF598665           1           1        1        0       1
## MF598666           1           1        1        0       1
## MF598667           1           1        1        0       1
## MF598668           1           1        1        0       1
## MF598669           1           1        1        0       1
## MF598670           1           1        1        0       1
## MF598671           1           1        1        0       1
## MF598672           1           1        1        0       1
## MF598673           1           1        1        0       1
## MF598674           1           1        1        0       1
## MF598675           1           1        1        0       1
## MF598676           1           1        1        0       1
## MF598677           1           1        1        0       1
## MF598678           1           1        1        0       1
## MF598679           1           1        1        0       1
## MF598680           1           1        1        0       1
## MF598681           1           1        1        0       1
## MF598682           1           1        1        0       1
## MF598683           1           1        1        0       1
## MF598684           1           1        1        0       1
## MF598685           1           1        1        0       1
## MF598686           1           1        1        0       1
## MF598687           1           1        1        0       1
## MF598688           1           1        1        0       1
## MF598689           1           1        1        0       1
## MF598690           1           1        1        0       1
## MF598691           1           1        1        0       1
## MF598692           1           1        1        0       1
## MF598693           1           1        1        0       1
## MF598694           1           1        1        0       1
## MF598695           1           1        1        0       1
## MF598696           1           1        1        0       1
## MF598697           1           1        1        0       1
## MF598698           1           1        1        0       1
## MF598699           1           1        1        0       1
## MF598700           1           1        1        0       1
## MF598701           1           1        1        0       1
## MF598702           1           1        1        0       1
## MF598703           1           1        1        0       1
## MF598704           1           1        1        0       1
## MF598705           1           1        1        0       1
## MF598706           1           1        1        0       1
## MF598707           1           1        1        0       1
## MF598708           1           1        1        0       1
## MF598709           1           1        1        0       1
## MF598710           1           1        1        0       1
## MF598711           1           1        1        0       1
## MF598712           1           1        1        0       1
## MF598713           1           1        1        0       1
## MF598714           1           1        1        0       1
## MF598715           1           1        1        0       1
## MF598716           1           1        1        0       1
## MF598717           1           1        1        0       1
## MF598719           1           1        1        0       1
## MF598720           1           1        1        0       1
## MF598721           1           1        1        0       1
## MF598722           1           1        1        0       1
## MF618252           1           1        1        0       1
## MF618253           1           1        1        0       1
## MF642322           1           1        1        0       1
## MF642323           1           1        1        0       1
## MF642324           1           1        1        0       1
## MF642325           1           1        1        0       1
## MF685025           0           0        0        0       1
## MF737355           1           1        1        0       1
## MF769416           1           1        1        0       1
## MF769417           1           1        1        0       1
## MF769418           1           1        1        0       1
## MF769419           1           1        1        0       1
## MF769420           1           1        1        0       1
## MF769421           1           1        1        0       1
## MF769422           1           1        1        0       1
## MF769423           1           1        1        0       1
## MF769424           1           1        1        0       1
## MF769425           1           1        1        0       1
## MF769426           1           1        1        0       1
## MF769427           1           1        1        0       1
## MF769428           1           1        1        0       1
## MF769429           1           1        1        0       1
## MF769430           1           1        1        0       1
## MF769431           1           1        1        0       1
## MF769432           1           1        1        0       1
## MF769433           1           1        1        0       1
## MF769434           1           1        1        0       1
## MF769435           1           1        1        0       1
## MF769436           1           1        1        0       1
## MF769437           1           1        1        0       1
## MF769438           1           1        1        0       1
## MF769439           1           1        1        0       1
## MF769440           1           1        1        0       1
## MF769441           1           1        1        0       1
## MF769442           1           1        1        0       1
## MF769443           1           1        1        0       1
## MF769444           1           1        1        0       1
## MF782686           1           1        1        0       1
## MF782687           1           1        1        0       1
## MF807951           1           1        1        0       1
## MF807952           1           1        1        0       1
## MF882923           1           1        1        0       1
## MF924724           1           1        1        0       1
## MF924725           1           1        1        0       1
## MF948005           1           1        1        0       1
## MG011340           1           1        1        0       1
## MG011341           1           1        1        0       1
## MG011342           1           1        1        0       1
## MG011343           1           1        1        0       1
## MG011344           1           1        1        0       1
## MG011345           1           1        1        0       1
## MG011346           1           1        1        0       1
## MG011347           1           1        1        0       1
## MG011348           1           1        1        0       1
## MG011349           1           1        1        0       1
## MG011350           1           1        1        0       1
## MG011351           1           1        1        0       1
## MG011352           1           1        1        0       1
## MG011353           1           1        1        0       1
## MG011354           1           1        1        0       1
## MG011355           1           1        1        0       1
## MG011356           1           1        1        0       1
## MG011357           1           1        1        0       1
## MG011358           1           1        1        0       1
## MG011359           1           1        1        0       1
## MG011360           1           1        1        0       1
## MG011361           1           1        1        0       1
## MG011362           1           1        1        0       1
## MG021194           1           1        1        0       1
## MG021451           1           1        1        1       1
## MG021452           1           1        1        1       1
## MG197709           1           1        1        0       1
## MG197710           1           1        1        0       1
## MG197711           1           1        1        0       1
## MG197712           1           1        1        0       1
## MG197713           1           1        1        0       1
## MG197714           1           1        1        0       1
## MG197715           1           1        1        0       1
## MG197716           1           1        1        0       1
## MG197717           1           1        1        0       1
## MG197718           1           1        1        0       1
## MG197719           1           1        1        0       1
## MG197720           1           1        1        0       1
## MG197721           1           1        1        0       1
## MG197722           1           1        1        0       1
## MG197723           1           1        1        0       1
## MG197727           1           1        1        0       1
## MG233398           1           1        1        0       1
## MG242062           1           1        1        0       1
## MG334554           1           1        1        0       1
## MG334555           1           1        1        0       1
## MG366483           1           1        1        0       1
## MG366880           1           1        1        0       1
## MG366881           1           1        1        0       1
## MG366882           1           1        1        0       1
## MG366883           1           1        1        0       1
## MG428699           1           1        1        0       1
## MG428701           1           1        1        0       1
## MG428702           1           1        1        0       1
## MG428703           1           1        1        0       1
## MG428704           1           1        1        0       1
## MG428705           1           1        1        0       1
## MG428706           1           1        1        0       1
## MG448607           1           1        1        1       1
## MG517474           1           1        1        0       1
## MG518518           1           1        1        0       1
## MG520075           1           1        1        0       1
## MG520076           1           1        1        0       1
## MG546330           1           1        1        0       1
## MG546331           1           1        1        0       1
## MG546687           1           1        1        0       1
## MG546690           1           1        1        0       1
## MG557844           1           1        1        0       1
## MG596802           1           1        1        1       1
## MG596803           1           1        1        1       1
## MG605090           1           1        1        0       1
## MG605091           1           1        1        0       1
## MG738154           1           1        1        0       1
## MG738155           1           1        1        0       1
## MG738720           0           0        0        0       1
## MG742313           1           1        1        0       1
## MG752895           0           0        0        0       1
## MG757138           1           1        1        0       1
## MG757139           1           1        1        0       1
## MG757140           1           1        1        0       1
## MG757141           1           1        1        0       1
## MG757142           1           1        1        0       1
## MG757593           1           1        1        0       1
## MG757594           1           1        1        0       1
## MG757595           1           1        1        0       1
## MG757596           1           1        1        0       1
## MG757597           1           1        1        0       1
## MG757598           1           1        1        0       1
## MG757599           1           1        1        0       1
## MG757600           1           1        1        0       1
## MG757601           1           1        1        0       1
## MG757602           1           1        1        0       1
## MG757603           1           1        1        0       1
## MG757604           1           1        1        0       1
## MG757605           1           1        1        0       1
## MG762674           1           1        1        1       1
## MG763935           1           1        1        0       1
## MG772808           1           1        1        0       1
## MG772933           1           1        1        1       1
## MG772934           1           1        1        1       1
## MG781192           1           1        1        0       1
## MG812375           1           1        1        0       1
## MG812376           1           1        1        0       1
## MG812377           1           1        1        0       1
## MG812378           1           1        1        0       1
## MG837011           1           1        1        0       1
## MG837012           1           1        1        0       1
## MG837058           1           1        1        0       1
## MG837130           1           1        1        0       1
## MG837131           1           1        1        0       1
## MG837132           1           0        1        0       1
## MG837133           1           0        1        0       1
## MG878985           0           0        0        0       1
## MG893511           1           1        1        0       1
## MG912595           1           1        1        0       1
## MG912596           1           1        1        0       1
## MG912597           1           1        1        0       1
## MG912598           1           1        1        0       1
## MG912599           1           1        1        0       1
## MG912600           1           1        1        0       1
## MG912601           1           1        1        0       1
## MG912602           1           1        1        0       1
## MG912603           1           1        1        0       1
## MG912604           1           1        1        0       1
## MG912605           1           1        1        0       1
## MG912606           1           1        1        0       1
## MG912607           1           1        1        0       1
## MG912608           1           1        1        0       1
## MG913342           1           1        1        0       1
## MG913343           1           1        1        0       1
## MG916901           1           1        1        0       1
## MG916902           1           1        1        0       1
## MG916903           1           1        1        0       1
## MG916904           1           1        1        0       1
## MG923466           1           1        1        0       1
## MG923467           1           1        1        0       1
## MG923468           1           1        1        0       1
## MG923469           1           1        1        0       1
## MG923470           1           1        1        0       1
## MG923471           1           1        1        0       1
## MG923472           1           1        1        0       1
## MG923473           1           1        1        0       1
## MG923474           1           1        1        0       1
## MG923475           1           1        1        0       1
## MG923476           1           1        1        0       1
## MG923477           1           1        1        0       1
## MG923478           1           1        1        0       1
## MG923479           1           1        1        0       1
## MG923480           1           1        1        0       1
## MG923481           1           1        1        0       1
## MG977444           1           1        1        0       1
## MG977445           1           1        1        0       1
## MG977447           1           1        1        0       1
## MG977449           1           1        1        0       1
## MG977451           1           1        1        0       1
## MG977452           1           1        1        0       1
## MG983755           1           1        1        0       1
## MG996765           0           0        0        0       1
## MH004416           1           1        1        0       1
## MH004417           1           1        1        0       1
## MH004418           1           1        1        0       1
## MH004419           1           1        1        0       1
## MH004420           1           1        1        0       1
## MH004421           1           1        1        0       1
## MH013216           1           1        1        0       1
## MH013462           1           1        1        0       1
## MH013463           1           1        1        0       1
## MH013464           1           1        1        0       1
## MH013465           1           1        1        0       1
## MH013466           1           1        1        0       1
## MH020185           1           1        1        0       1
## MH021175           1           1        1        0       1
## MH043952           1           1        1        0       1
## MH043953           1           1        1        0       1
## MH043954           1           1        1        0       1
## MH043955           1           1        1        0       1
## MH052681           1           1        1        0       1
## MH052682           1           1        1        0       1
## MH052683           1           1        1        0       1
## MH052684           1           1        1        0       1
## MH052685           1           1        1        0       1
## MH052687           1           1        1        0       1
## MH052688           1           1        1        0       1
## MH052689           1           1        1        0       1
## MH056657           1           1        1        0       1
## MH056658           1           1        1        0       1
## MH061336           1           1        1        0       1
## MH061337           1           1        1        0       1
## MH061338           1           1        1        0       1
## MH061339           1           1        1        0       1
## MH061340           1           1        1        0       1
## MH061341           1           1        1        0       1
## MH061342           1           1        1        0       1
## MH061343           1           1        1        0       1
## MH107321           1           1        1        0       1
## MH107322           1           1        1        0       1
## MH117940           1           1        1        0       1
## MH121121           1           1        1        0       1
## MH171482           0           0        0        0       1
## MH181793           1           1        1        0       1
## MH188022           0           0        0        0       1
## MH188023           0           0        0        0       1
## MH243316           1           1        1        0       1
## MH243318           1           1        1        0       1
## MH243319           1           1        1        0       1
## MH259485           1           1        1        0       1
## MH259486           1           1        1        0       1
## MH306207           1           1        1        0       1
## MH310909           1           1        1        0       1
## MH310910           1           1        1        0       1
## MH310911           1           1        1        0       1
## MH310912           1           1        1        0       1
## MH371127           1           1        1        0       1
## MH395139           1           1        1        0       1
## MH432120           1           1        1        0       1
## MH443059           0           0        0        0       1
## MH454272           1           1        1        0       1
## MH520100           0           0        0        0       1
## MH520101           0           0        0        0       1
## MH520102           0           0        0        0       1
## MH520103           0           0        0        0       1
## MH520104           0           0        0        0       1
## MH520105           0           0        0        0       1
## MH520106           0           0        0        0       1
## MH532440           1           1        1        0       1
## MH539766           1           1        1        0       1
## MH539771           1           1        1        0       1
## MH539772           1           1        1        0       1
## MH581489           1           1        1        0       1
## MH593900           1           1        1        0       1
## MH603532           0           0        0        0       1
## MH687934           1           1        1        0       1
## MH687935           1           1        1        0       1
## MH687936           1           1        1        0       1
## MH687937           1           1        1        0       1
## MH687938           1           1        1        0       1
## MH687939           1           1        1        0       1
## MH687940           1           1        1        0       1
## MH687941           1           1        1        0       1
## MH687942           1           1        1        0       1
## MH687943           1           1        1        0       1
## MH687944           1           1        1        0       1
## MH687945           1           1        1        0       1
## MH687946           1           1        1        0       1
## MH687947           1           1        1        0       1
## MH687948           1           1        1        0       1
## MH687949           1           1        1        0       1
## MH687950           1           1        1        0       1
## MH687951           1           1        1        0       1
## MH687952           1           1        1        0       1
## MH687953           1           1        1        0       1
## MH687954           1           1        1        0       1
## MH687955           1           1        1        0       1
## MH687956           1           1        1        0       1
## MH687957           1           1        1        0       1
## MH687958           1           1        1        0       1
## MH687959           1           1        1        0       1
## MH687960           1           1        1        0       1
## MH687961           1           1        1        0       1
## MH687962           1           1        1        0       1
## MH687963           1           1        1        0       1
## MH687964           1           1        1        0       1
## MH687965           1           1        1        0       1
## MH687966           1           1        1        0       1
## MH687967           1           1        1        0       1
## MH687968           1           1        1        1       1
## MH687969           1           1        1        0       1
## MH687970           1           1        1        0       1
## MH687971           1           1        1        0       1
## MH687972           1           1        1        0       1
## MH687973           1           1        1        0       1
## MH687974           1           1        1        0       1
## MH687976           1           1        1        0       1
## MH687977           1           1        1        0       1
## MH687978           1           1        1        0       1
## MH697599           1           1        1        0       1
## MH708123           1           1        1        0       1
## MH708124           1           1        1        0       1
## MH708125           1           1        1        0       1
## MH708243           1           1        1        0       1
## MH708895           1           1        1        0       1
## MH719099           0           0        0        0       1
## MH726362           1           1        1        0       1
## MH726363           1           1        1        0       1
## MH726364           1           1        1        0       1
## MH726365           1           1        1        0       1
## MH726366           1           1        1        0       1
## MH726367           1           1        1        0       1
## MH726368           1           1        1        0       1
## MH726369           1           1        1        0       1
## MH726370           1           1        1        0       1
## MH726371           1           1        1        0       1
## MH726372           1           1        1        0       1
## MH726373           1           1        1        0       1
## MH726374           1           1        1        0       1
## MH726375           1           1        1        0       1
## MH726376           1           1        1        0       1
## MH726377           1           1        1        0       1
## MH726378           1           1        1        0       1
## MH726379           1           1        1        0       1
## MH726380           1           1        1        0       1
## MH726381           1           1        1        0       1
## MH726382           1           1        1        0       1
## MH726383           1           1        1        0       1
## MH726384           1           1        1        0       1
## MH726385           1           1        1        0       1
## MH726386           1           1        1        0       1
## MH726387           1           1        1        0       1
## MH726388           1           1        1        0       1
## MH726389           1           1        1        0       1
## MH726390           1           1        1        0       1
## MH726391           1           1        1        0       1
## MH726392           1           1        1        0       1
## MH726393           1           1        1        0       1
## MH726394           1           1        1        0       1
## MH726395           1           1        1        0       1
## MH726396           1           1        1        0       1
## MH726397           1           1        1        0       1
## MH726398           1           1        1        0       1
## MH726399           1           1        1        0       1
## MH726400           1           1        1        0       1
## MH726401           1           1        1        0       1
## MH726402           1           1        1        0       1
## MH726403           1           1        1        0       1
## MH726404           1           1        1        0       1
## MH726405           1           1        1        0       1
## MH726406           1           1        1        0       1
## MH726407           1           1        1        0       1
## MH726408           1           1        1        0       1
## MH734114           1           1        1        0       1
## MH734115           1           1        1        0       1
## MH748550           1           1        1        0       1
## MH810163           1           1        1        0       1
## MH817484           1           1        1        0       1
## MH822886           1           1        1        0       1
## MH878976           1           1        1        0       1
## MH891584           1           1        1        0       1
## MH891585           1           1        1        0       1
## MH891586           1           1        1        0       1
## MH891587           1           1        1        0       1
## MH891588           1           1        1        0       1
## MH891589           1           1        1        0       1
## MH891590           1           1        1        0       1
## MH910099           1           1        1        0       1
## MH924835           1           1        1        0       1
## MH938448           1           1        1        0       1
## MH938449           1           1        1        0       1
## MH938450           1           1        1        0       1
## MH940245           1           1        1        1       1
## MK005882           1           1        1        0       1
## MK032177           1           1        1        0       1
## MK032178           1           1        1        0       1
## MK032179           1           1        1        0       1
## MK032180           1           1        1        0       1
## MK032181           1           1        1        0       1
## MK032689           1           1        1        0       1
## MK032690           1           1        1        0       1
## MK032691           1           1        1        0       1
## MK032692           1           1        1        0       1
## MK039552           1           1        1        0       1
## MK039553           1           1        1        0       1
## MK052676           1           1        1        0       1
## MK062179           1           1        1        1       1
## MK062180           1           1        1        1       1
## MK062181           1           1        1        1       1
## MK062182           1           1        1        1       1
## MK062183           1           1        1        1       1
## MK062184           1           1        1        1       1
## MK071267           1           1        1        0       1
## MK138353           1           1        1        0       1
## MK138516           1           1        1        0       1
## MK140811           1           1        1        0       1
## MK140812           1           1        1        0       1
## MK140813           1           1        1        0       1
## MK140814           1           1        1        0       1
## MK142676           1           1        1        0       1
## MK167038           1           1        1        1       1
## MK211169           1           1        1        0       1
## MK211369           1           1        1        0       1
## MK211370           1           1        1        0       1
## MK211371           1           1        1        0       1
## MK211372           1           1        1        0       1
## MK211373           1           1        1        0       1
## MK211374           1           1        1        1       1
## MK211375           1           1        1        1       1
## MK211376           1           1        1        1       1
## MK211377           1           1        1        1       1
## MK211378           1           1        1        1       1
## MK211379           1           1        1        1       1
## MK217372           1           1        1        0       1
## MK217373           1           1        1        0       1
## MK217374           1           1        1        0       1
## MK217375           1           1        1        0       1
## MK280984           1           1        1        0       1
## MK288006           1           1        1        0       1
## MK303619           1           1        1        0       1
## MK303620           1           1        1        0       1
## MK303621           1           1        1        0       1
## MK303622           1           1        1        0       1
## MK303623           1           1        1        0       1
## MK303624           1           1        1        0       1
## MK303625           1           1        1        0       1
## MK309398           1           1        1        0       1
## MK329221           1           1        1        0       1
## MK330604           1           1        1        0       1
## MK330605           1           1        1        0       1
## MK334043           1           1        1        0       1
## MK334044           1           1        1        0       1
## MK334045           1           1        1        0       1
## MK334046           1           1        1        0       1
## MK334047           1           1        1        0       1
## MK355396           1           1        1        0       1
## MK357908           1           1        1        0       1
## MK357909           1           1        1        0       1
## MK359255           1           1        1        0       1
## MK392335           1           1        1        0       1
## MK409657           1           1        1        0       1
## MK409658           1           1        1        0       1
## MK409659           1           1        1        0       1
## MK423876           1           1        1        0       1
## MK423877           1           1        1        0       1
## MK462243           1           1        1        0       1
## MK462244           1           1        1        0       1
## MK462245           1           1        1        0       1
## MK462246           1           1        1        0       1
## MK462247           1           1        1        0       1
## MK462248           1           1        1        0       1
## MK462249           1           1        1        0       1
## MK462250           1           1        1        0       1
## MK462251           1           1        1        0       1
## MK462252           1           1        1        0       1
## MK462253           1           1        1        0       1
## MK462254           1           1        1        0       1
## MK462255           1           1        1        0       1
## MK462256           1           1        1        0       1
## MK482396           1           1        1        0       1
## MK482397           1           1        1        0       1
## MK483839           1           1        1        0       1
## MK492263           1           1        1        0       1
## MK521912           1           0        1        0       0
## MK521914           0           0        0        0       1
## MK558089           1           1        1        0       1
## MK559454           1           1        1        0       1
## MK559455           1           1        1        0       1
## MK559456           1           1        1        0       1
## MK564474           1           1        1        1       1
## MK564475           1           1        1        1       1
## MK572803           1           1        1        0       1
## MK574042           1           1        1        0       1
## MK574043           1           1        1        0       1
## MK577661           0           0        0        0       1
## MK577662           0           0        0        0       1
## MK581200           1           1        1        0       1
## MK581201           1           1        1        0       1
## MK581202           1           1        1        0       1
## MK581203           1           1        1        0       1
## MK581204           1           1        1        0       1
## MK581205           1           1        1        0       1
## MK581206           1           1        1        0       1
## MK581207           1           1        1        0       1
## MK581208           1           1        1        0       1
## MK606368           1           1        1        0       1
## MK606369           1           1        1        0       1
## MK636864           0           0        0        0       1
## MK636865           0           0        0        0       1
## MK644086           1           1        1        0       1
## MK644601           1           1        1        0       1
## MK644602           1           1        1        0       1
## MK644603           1           1        1        0       1
## MK644604           1           1        1        0       1
## MK644605           1           1        1        0       1
## MK651076           1           1        1        0       1
## MK673545           1           1        1        0       1
## MK679660           1           1        1        0       1
## MK690502           1           1        1        0       1
## MK720944           1           1        1        0       1
## MK720945           1           1        1        0       1
## MK720946           1           1        1        0       1
## MK728875           1           1        1        0       1
## MK796238           1           1        1        0       1
## MK796425           1           1        1        0       1
## MK841494           1           1        1        0       1
## MK841495           1           1        1        0       1
## MK878536           1           1        1        0       1
## MK937828           1           1        1        0       1
## MK937829           1           1        1        0       1
## MK937830           1           1        1        0       1
## MK937831           1           1        1        0       1
## MK937832           1           1        1        0       1
## MK937833           1           1        1        0       1
## MK977618           1           1        1        0       1
## MN026164           1           1        1        0       1
## MN037494           1           1        1        0       1
## MN065811           1           1        1        0       1
## MN096598           1           1        1        0       1
## MN120513           1           1        1        0       1
## MN120514           1           1        1        0       1
## MN165107           1           1        1        0       1
## MN306018           1           1        1        0       1
## MN306036           1           1        1        0       1
## MN306040           1           1        1        0       1
## MN306041           1           1        1        0       1
## MN306042           1           1        1        0       1
## MN306043           1           1        1        0       1
## MN306046           1           1        1        0       1
## MN306053           1           1        1        0       1
## MN310476           1           1        1        0       1
## MN310478           1           1        1        0       1
## MN365232           1           1        1        0       1
## MN365233           1           1        1        0       1
## MN369046           1           1        1        0       1
## MN507638           1           1        1        0       1
## MN514962           1           1        1        0       1
## MN514963           1           1        1        0       1
## MN514964           1           1        1        0       1
## MN514965           1           1        1        0       1
## MN514966           1           1        1        0       1
## MN514967           1           1        1        0       1
## NC_001846          1           1        1        0       1
## NC_002306          1           1        1        0       1
## NC_002645          1           1        1        0       1
## NC_003045          1           1        1        0       1
## NC_003436          1           1        1        0       1
## NC_004718          1           1        1        1       1
## NC_005831          1           1        1        0       1
## NC_006213          1           1        1        0       1
## NC_006577          1           1        1        1       1
## NC_007447          0           0        0        0       1
## NC_008516          0           0        0        0       1
## NC_009019          1           1        1        0       1
## NC_009020          1           1        1        0       1
## NC_009021          1           1        1        0       1
## NC_009657          1           1        1        0       1
## NC_009988          1           1        1        0       1
## NC_010437          1           1        1        0       1
## NC_010438          1           1        1        0       1
## NC_010646          1           1        1        0       1
## NC_010800          1           1        1        0       1
## NC_011547          1           1        1        0       1
## NC_011549          1           1        1        0       1
## NC_011550          1           1        1        0       1
## NC_012936          1           1        1        0       1
## NC_014470          1           1        1        1       1
## NC_015626          1           0        1        0       0
## NC_015668          0           0        0        0       1
## NC_015874          0           0        0        0       1
## NC_015934          1           0        0        0       0
## NC_016991          1           1        1        1       1
## NC_016992          1           1        1        0       1
## NC_016993          1           1        1        0       1
## NC_016994          1           1        1        0       1
## NC_016995          1           1        1        0       1
## NC_016996          1           1        1        0       1
## NC_017083          1           1        1        0       1
## NC_018871          1           1        1        0       1
## NC_019843          1           1        1        0       1
## NC_020899          0           0        0        0       1
## NC_020900          0           0        0        0       1
## NC_020901          0           0        0        0       1
## NC_022103          1           1        1        0       1
## NC_022787          0           0        0        0       1
## NC_023760          1           1        1        0       1
## NC_023986          0           0        0        0       1
## NC_024709          0           0        0        0       1
## NC_025217          1           1        1        1       1
## NC_026011          1           1        1        0       1
## NC_027199          0           0        0        0       1
## NC_028752          1           1        1        0       1
## NC_028806          1           1        1        0       1
## NC_028811          1           1        1        0       1
## NC_028814          1           1        1        0       1
## NC_028824          1           1        1        0       1
## NC_028833          1           1        1        0       1
## NC_030292          1           1        1        0       1
## NC_030886          1           1        1        0       1
## NC_032107          1           1        1        0       1
## NC_032730          1           1        1        0       1
## NC_032869          0           0        0        0       1
## NC_033700          0           0        0        0       1
## NC_034440          1           1        1        1       1
## NC_034972          1           1        1        0       1
## NC_034976          0           0        0        0       1
## NC_035191          1           1        1        1       1
## NC_036586          0           0        0        0       1
## NC_038294          1           1        1        0       1
## NC_038295          0           0        0        0       1
## NC_038296          0           0        0        0       1
## NC_038297          0           0        0        0       1
## NC_038857          0           0        0        0       1
## NC_038861          1           1        1        0       1
## NC_039207          1           1        1        0       1
## NC_039208          1           1        1        0       1
## NC_040534          0           0        0        0       1
## NC_040711          0           0        0        0       1
## NC_043474          0           0        0        0       1
## NC_043488          0           0        0        0       1
## NC_043489          0           0        0        0       1
## NC_043490          0           0        0        0       1
## U00735             1           1        1        0       1
```

```r
upset(upset.table)
```

![](Assignment_3_template_2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
**Exercise 15:**_  Interpret the plot: overall do these strategies generally find the same sequences?  What strategies are outliers?  How does that relate to what you know about the different search strategies.

```r
#Overal for the 4 strategies below, they found almost the same sequences, but megaW28 is the outlier, maybe because 28 is too big a number for too coarse search of megablast, its result is inaccurate.
```
**Exercise 16:** Let's investigate those errors.  Use the [ ] to view the offending rows of `uniq.blastn`.  what went wrong?

```r
uniq.blastn <- uniq.blast.results %>%
    ungroup() %>%
    filter(strategy=="blastnWS11",
           str_detect(subject.title, "complete genome"))
head(uniq.blastn)
```

```
## # A tibble: 6 x 14
##   strategy query.acc.ver subject.acc.ver pct.identity alignment.length
##   <chr>    <chr>         <chr>                  <dbl>            <dbl>
## 1 blastnW… Seq_H         KC881006                80.7            26651
## 2 blastnW… Seq_H         KY417146                80.7            26649
## 3 blastnW… Seq_H         KC881005                80.6            26647
## 4 blastnW… Seq_H         KY417152                80.7            26646
## 5 blastnW… Seq_H         KF569996                80.6            26642
## 6 blastnW… Seq_H         AY351680                80.0            24681
## # … with 9 more variables: mismatches <dbl>, gap.opens <dbl>, q.start <dbl>,
## #   q.end <dbl>, s.start <dbl>, s.end <dbl>, evalue <dbl>, bit.score <dbl>,
## #   subject.title <chr>
```

```r
uniq.blastn %>% pull(subject.title) %>% head()
```

```
## [1] "KC881006 |Bat SARS-like coronavirus Rs3367| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"              
## [2] "KY417146 |Bat SARS-like coronavirus isolate Rs4231| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"      
## [3] "KC881005 |Bat SARS-like coronavirus RsSHC014| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"            
## [4] "KY417152 |Bat SARS-like coronavirus isolate Rs9401| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus sinicus"      
## [5] "KF569996 |Rhinolophus affinis coronavirus isolate LYRa11| complete genome|Severe acute respiratory syndrome-related coronavirus|China|Rhinolophus affinis"
## [6] "AY351680 |SARS coronavirus ZMY 1| complete genome|Severe acute respiratory syndrome-related coronavirus||"
```

```r
uniq.blastn <- uniq.blastn%>%
    separate(subject.title,
             into=c("acc", "isolate", "complete", "name", "country", "host"),
             remove = FALSE, 
             sep="\\|")
```

```
## Warning: Expected 6 pieces. Additional pieces discarded in 1 rows [1678].
```

```
## Warning: Expected 6 pieces. Missing pieces filled with `NA` in 2 rows [1653,
## 1714].
```

```r
#Expected 6 titles from the database, but for some rows the titles are not completed, not following this format, so there are errors.
```
**Exercise 17:** Let's delete those rows  Use the [ ] to remove the offending rows of `uniq.blastn`.  Put the result in a new object called `filtered.blastn`

```r
filtered.blastn <- uniq.blastn[-c(1678,1653,1714),]

filtered.blastn <- filtered.blastn %>%
    mutate_all(function(x) ifelse(x=="", NA, x))

filtered.blastn <- na.omit(filtered.blastn)
```

**Exercise 18:** Look back to the code where we created `uniq.blast.results` Use a similar strategy to retain the entry with longest alignment length for each combination of name, country, and host


```r
uniq.blast.results2_temp <- filtered.blastn %>% 
    group_by(name,country,host) %>% 
    arrange(desc(alignment.length))%>%
    filter(alignment.length==max(alignment.length))%>%
    filter(!duplicated(name))
uniq.blast.results2_temp
```

```
## # A tibble: 248 x 20
## # Groups:   name, country, host [248]
##    strategy query.acc.ver subject.acc.ver pct.identity alignment.length
##    <chr>    <chr>         <chr>                  <dbl>            <dbl>
##  1 blastnW… Seq_H         KC881006                80.7            26651
##  2 blastnW… Seq_H         KF569996                80.6            26642
##  3 blastnW… Seq_H         FJ959407                80.2            24676
##  4 blastnW… Seq_H         AY274119                80.3            24666
##  5 blastnW… Seq_H         GU553364                80.3            24666
##  6 blastnW… Seq_H         MK062179                80.3            24666
##  7 blastnW… Seq_H         GU553365                80.2            24666
##  8 blastnW… Seq_H         JF292914                80.2            24666
##  9 blastnW… Seq_H         AY515512                80.2            24664
## 10 blastnW… Seq_H         AY572034                80.2            24664
## # … with 238 more rows, and 15 more variables: mismatches <dbl>,
## #   gap.opens <dbl>, q.start <dbl>, q.end <dbl>, s.start <dbl>, s.end <dbl>,
## #   evalue <dbl>, bit.score <dbl>, subject.title <chr>, acc <chr>,
## #   isolate <chr>, complete <chr>, name <chr>, country <chr>, host <chr>
```
**Exercise 19:** Finally, let's retain those with an alignment length >= 5000

```r
uniq.blast.result2 <- uniq.blast.results2_temp %>%
  filter(alignment.length>=5000)
uniq.blast.result2
```

```
## # A tibble: 102 x 20
## # Groups:   name, country, host [102]
##    strategy query.acc.ver subject.acc.ver pct.identity alignment.length
##    <chr>    <chr>         <chr>                  <dbl>            <dbl>
##  1 blastnW… Seq_H         KC881006                80.7            26651
##  2 blastnW… Seq_H         KF569996                80.6            26642
##  3 blastnW… Seq_H         FJ959407                80.2            24676
##  4 blastnW… Seq_H         AY274119                80.3            24666
##  5 blastnW… Seq_H         GU553364                80.3            24666
##  6 blastnW… Seq_H         MK062179                80.3            24666
##  7 blastnW… Seq_H         GU553365                80.2            24666
##  8 blastnW… Seq_H         JF292914                80.2            24666
##  9 blastnW… Seq_H         AY515512                80.2            24664
## 10 blastnW… Seq_H         AY572034                80.2            24664
## # … with 92 more rows, and 15 more variables: mismatches <dbl>,
## #   gap.opens <dbl>, q.start <dbl>, q.end <dbl>, s.start <dbl>, s.end <dbl>,
## #   evalue <dbl>, bit.score <dbl>, subject.title <chr>, acc <chr>,
## #   isolate <chr>, complete <chr>, name <chr>, country <chr>, host <chr>
```

**Exercise 20:** Use [ %in% ] to subset the ncbi seqs to retain only those present in `filtered.blastn` __Hint:__ you will want to use the `subject.title` column from `filtered.blastn` and you can get the sequence names of the fasta file with `names(ncbi.seqs)`.  Put the resulting sequences in an object `selected.seqs`.  You should have 102 sequences.

```r
library(Biostrings)
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
## 
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
## 
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:dplyr':
## 
##     combine, intersect, setdiff, union
```

```
## The following objects are masked from 'package:stats':
## 
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
## 
##     anyDuplicated, append, as.data.frame, basename, cbind, colnames,
##     dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
##     grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
##     order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
##     rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
##     union, unique, unsplit, which, which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
## Loading required package: stats4
```

```
## 
## Attaching package: 'S4Vectors'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     first, rename
```

```
## The following object is masked from 'package:tidyr':
## 
##     expand
```

```
## The following object is masked from 'package:base':
## 
##     expand.grid
```

```
## Loading required package: IRanges
```

```
## 
## Attaching package: 'IRanges'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     collapse, desc, slice
```

```
## The following object is masked from 'package:purrr':
## 
##     reduce
```

```
## Loading required package: XVector
```

```
## 
## Attaching package: 'XVector'
```

```
## The following object is masked from 'package:purrr':
## 
##     compact
```

```
## 
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
## 
##     strsplit
```

```r
ncbi.seqs <- readDNAStringSet("../input/ncbi_virus_110119_2.txt")
ncbi.seqs
```

```
##   A DNAStringSet instance of length 122200
##            width seq                                        names               
##      [1]   10705 GTCTACGTGGACCGACAAAG...TGGAATGGTGCTGTTGAAT MH781015 |Dengue ...
##      [2]  198157 ATGGACAGCATAACTAACGG...AGTACACTACAAAGTTAAC NC_044938 |Heliot...
##      [3]  193886 ACAATTTTATATTATAGTGC...CACTATAATATAAAATTGT NC_044944 |Africa...
##      [4]  190773 TCTTATTACTACTGCTGTAG...TACAGCAGTAGTAATAAGA NC_044950 |Africa...
##      [5]   34080 AATAAATAACGAAACATGCA...GCATGTTTCGTTATTTATT NC_044960 |Bottle...
##      ...     ... ...
## [122196]    2585 CGGTGGCGTTTTTGTAATAA...AGAGAATCTATTTGTTAAA X15984 |Abutilon ...
## [122197]    2632 CGGTGGCATTTATGTAATAA...GTACTCTAAATTTCTTTGG X15983 |Abutilon ...
## [122198]    1291 CGCCAAAAACCTCTGCTAAG...GACGGCTGAGTTGATCTGG M29963 |Coconut f...
## [122199]    6355 GATGTTTTAATAGTTTTCGA...AACCGCCGGTAGCGGCCCA M34077 |Tobacco m...
## [122200]   12297 GTATACGAGGTTAGCTCTTT...TAATTTCCTAACGGCCCCC J04358 |Classical...
```

```r
selected.seq <- ncbi.seqs[names(ncbi.seqs) %in% uniq.blast.result2$subject.title]
selected.seq
```

```
##   A DNAStringSet instance of length 102
##       width seq                                             names               
##   [1] 30033 ACTTCCCCTCGTTCTCTTGCAG...CTCTACAGTGTGAAATGTAAAT MN507638 |Middle ...
##   [2] 31075 GATTTGCGTGCGTGCATCCCGC...TTATGGCCAATTGGAAGAATCA MN514966 |Dromeda...
##   [3] 29585 GATAAAAGGTAATAGCACCGCG...ATTTGCAAAAAAAAAAAAAAAA MK492263 |Bat cor...
##   [4] 30777 ATATGGACTTGCATTCATAACA...ATTATGGCCAATTGGAAGAATC MN026164 |Human c...
##   [5] 30213 TATTAGGTTTTCTACCTACCCA...TTAATTTTAGTAGTGCTATCCC MK211378 |Coronav...
##   ...   ... ...
##  [98] 31076 GATTGCGAGCGATTTGCGTGCG...AAAAAAAAAAAAAAAAAAAAAA DQ915164 |Bovine ...
##  [99] 27550 AAAGTGAGTGTAGCGTGGCTAT...CTTTTGATAGTGATACAACCCC DQ811787 |PRCV IS...
## [100] 29540 AAGCCAACCAACCTCGATCTCT...CTTTAATCTCACATAGCAATCT AY572034 |SARS co...
## [101] 29731 GAAAAGCCAACCAACCTCGATC...TTAATAGCTTCTTAGGAGAATC AY515512 |SARS co...
## [102] 29751 ATATTAGGTTTTTACCTACCCA...AAAAAAAAAAAAAAAAAAAAAA AY274119 |Severe ...
```

**Exercise 21:** Read in the patient seq file, extract the Seq_H sequence, and then add it to the `selected.seqs` object using `c()`.  The new sequence object should have 103 sequences. Write it out to a fasta file using the function `writeXStringSet()`, naming the resulting file "selected_viral_seqs.fa".


```r
patient.seqs <- readDNAStringSet("../input/patient_viral.txt")
patient.seqs
```

```
##   A DNAStringSet instance of length 8
##      width seq                                              names               
## [1]   3215 CTCCACCAATTTCCATCAAACTC...ATCCTCAGGCCATGCAGTGGAA Seq_A
## [2]   1684 ATGGGCCAATTCCGAACGAAGAG...GACCCGCCGCCCAAGTTCGAGC Seq_B
## [3] 233833 CGCGACACACCCGGCACACACCC...GCGCCAGCGCGCCCAGCACGCC Seq_C
## [4] 236375 CCATTCCGGGCCGTGTGTTGGGT...GGCGCCGGTGCGGGACCGGGCT Seq_D
## [5]   7564 GTGAATGAAGATGGCGTCTAACG...TTTCTTTTCTTTAGTGTCTTTT Seq_E
## [6]  37631 ATCAACTTTGCCCTCGCTTTAAA...CCTCTGTAAAACGATGTAAAAA Seq_F
## [7]  18028 TTTATGATTTGAAATTAAAATCT...ACTTTTTCCCTATTATATTATA Seq_G
## [8]  29838 CAACCAACTTTCGATCTCTTGTA...AATAGCTTCTTAGGAGAATGAC Seq_H
```

```r
selected.seq <- c(selected.seq,patient.seqs[8])
selected.seq
```

```
##   A DNAStringSet instance of length 103
##       width seq                                             names               
##   [1] 30033 ACTTCCCCTCGTTCTCTTGCAG...CTCTACAGTGTGAAATGTAAAT MN507638 |Middle ...
##   [2] 31075 GATTTGCGTGCGTGCATCCCGC...TTATGGCCAATTGGAAGAATCA MN514966 |Dromeda...
##   [3] 29585 GATAAAAGGTAATAGCACCGCG...ATTTGCAAAAAAAAAAAAAAAA MK492263 |Bat cor...
##   [4] 30777 ATATGGACTTGCATTCATAACA...ATTATGGCCAATTGGAAGAATC MN026164 |Human c...
##   [5] 30213 TATTAGGTTTTCTACCTACCCA...TTAATTTTAGTAGTGCTATCCC MK211378 |Coronav...
##   ...   ... ...
##  [99] 27550 AAAGTGAGTGTAGCGTGGCTAT...CTTTTGATAGTGATACAACCCC DQ811787 |PRCV IS...
## [100] 29540 AAGCCAACCAACCTCGATCTCT...CTTTAATCTCACATAGCAATCT AY572034 |SARS co...
## [101] 29731 GAAAAGCCAACCAACCTCGATC...TTAATAGCTTCTTAGGAGAATC AY515512 |SARS co...
## [102] 29751 ATATTAGGTTTTTACCTACCCA...AAAAAAAAAAAAAAAAAAAAAA AY274119 |Severe ...
## [103] 29838 CAACCAACTTTCGATCTCTTGT...AATAGCTTCTTAGGAGAATGAC Seq_H
```
**Turning in the assignment**

* Click the knit button at the top of the screen to create an html.  Check it to make sure you are happy with its content.
* add your .Rmd, .md and .html files and your figures.../ folder to the repository and commit the changes.
* push the changes
