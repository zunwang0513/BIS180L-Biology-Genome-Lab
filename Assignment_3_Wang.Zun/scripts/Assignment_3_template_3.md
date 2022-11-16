---
title: "Assignment 3, part 3"
output: 
  html_document: 
    keep_md: yes
    df_print: paged
---

__Name:__ Zun Wang

__Student ID:__ 915019847





**Exercise 22:**
Scroll through the alignment.  Are there any additional regions where you are suspicious of the alignment?  If so, list when and state the potential problem.

```r
#Around 1700bp, there is a gap rich region, where the alignment does not work well.
```

**Exercise 23:** 

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
inpath <- "../output/mafft_maxiter100_195_op.5.fa"
outpath <- "../output/mafft_maxiter100_195_op.5_trimmed_75pct.fa"
alignment <- readDNAMultipleAlignment(inpath)
alignment
```

```
## DNAMultipleAlignment with 196 rows and 49633 columns
##        aln                                                  names               
##   [1] -------------------------...------------------------ Seq_H
##   [2] ------------ATAT----TAG--...------------------------ MG772933 |Bat SAR...
##   [3] -------------TAT----TAG--...------------------------ MK211378 |Coronav...
##   [4] ------------TTTT----TAG--...------------------------ MK211375 |Coronav...
##   [5] -------------T-T----TAG--...------------------------ MK211377 |Coronav...
##   [6] ------------ATAT----TAG--...------------------------ KY417142 |Bat SAR...
##   [7] -------------TTT----TAG--...------------------------ MK211376 |Coronav...
##   [8] ------------ATAT----TAG--...------------------------ KY417146 |Bat SAR...
##   [9] ------------ATAT----TAG--...------------------------ KT444582 |SARS-li...
##   ... ...
## [188] -------------------------...------------------------ KY674921 |Human c...
## [189] ----------AGCT-----------...------------------------ KT779556 |Human c...
## [190] ----------AGCT-----------...------------------------ KT779555 |Human c...
## [191] -------------------------...------------------------ HM034837 |Human c...
## [192] ----G-----AGATCTAACAAGAGG...------------------------ MH687968 |Betacor...
## [193] -------------------------...------------------------ MF618252 |Murine ...
## [194] -------------------------...------------------------ FJ884686 |Murine ...
## [195] ------------GT---ATAAGA--...------------------------ GU593319 |Murine ...
## [196] --CT--------ATC-----TAC--...------------------------ MH938449 |Alphaco...
```

```r
alignment <- DNAMultipleAlignment(alignment,start=1000,end=48250)
```

```r
alignment <- maskGaps(alignment, min.fraction=0.25, min.block.width=1)
maskedratio(alignment) 
```

```
## [1] 0.0000000 0.5204758
```

```r
alignment <- alignment %>% as("DNAStringSet")
newnames <- names(alignment) %>% 
  tibble(name=.) %>%
  mutate(name=str_replace_all(name," ","_")) %>% #replace " " with "_" because some programs truncate name at " "
  separate(name, 
           into=c("acc", "isolate", "complete", "name", "country", "host"),
           sep="_?\\|_?") %>%
  mutate(name=str_replace(name, "Middle_East_respiratory_syndrome-related","MERS"),   # abbreviate
         name=str_replace(name, "Severe_acute_respiratory_syndrome-related", "SARS"), # abbreviate
         newname=paste(acc,name,country,host,sep="|")) %>% # select columns for newname
  pull(newname) #return newname
```

```
## Warning: Expected 6 pieces. Missing pieces filled with `NA` in 1 rows [1].
```

```r
head(newnames)
```

```
## [1] "Seq_H|NA|NA|NA"                                                     
## [2] "MG772933|SARS_coronavirus|China|Rhinolophus_sinicus"                
## [3] "MK211378|Coronavirus_BtRs-BetaCoV/YN2018D|China|Rhinolophus_affinis"
## [4] "MK211375|Coronavirus_BtRs-BetaCoV/YN2018A|China|Rhinolophus_affinis"
## [5] "MK211377|Coronavirus_BtRs-BetaCoV/YN2018C|China|Rhinolophus_affinis"
## [6] "KY417142|SARS_coronavirus|China|Aselliscus_stoliczkanus"
```

```r
names(alignment) <- newnames
alignment %>% writeXStringSet(outpath)
```
__A:__ What is the sister taxon to Seq_H? What is the host for the virus in this group (provide the Latin and common names)
_hint: if you are having trouble finding Seq H in the tree, search for it using the (Aa) magnifying glass_

```r
#It is the MG772933 sequence. Its host is Rhinolophus Sinicus, which is the Chinese rufous horseshoe bat.
```
__B:__ Consider Seq_H plus its sister taxon as defining one taxonomic group of two species.  Look at the sister taxa to this group.  What is a general description for the viruses in this group?  List at least 3 hosts found in this group.

```r
#They are either SARS coronavirus or bat coronavirus. The hosts include Rhinolophus ferrumequinum, Rhinolophus affinis, and Chiroptera.
```

__C:__ Examine the sister group to the taxa described in parts A and B.  What are its host(s)?

```r
#Rhinolophus blasii.
```
__D:__ What do you think the host of the most recent common ancestor to the viruses in parts A and B was?

```r
#It is the Rhinolophus sinicus.
```
__E:__ Do you think that Seq_H evolved from a virus with a human host?  Why or why not?  If not, what did it evolve from?

```r
#It is most likely that this virus arise from bat instead of human host, since its related sequences are all from bats.
```

**JD:** -0
