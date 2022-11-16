---
title: "Assignment 3, part1"
output: 
  html_document: 
    keep_md: yes
---

__Name:__ Zun Wang

__Student ID:__ 915109847

For each of the exercises below, take advantage of R markdown features.  That is include the code and have Rstudio embed your answers.  See Exercise 0 for an example


## Exercise 0 (example)
_Provide the name of your current working directory and list the files therein_

```r
getwd()
```

```
## [1] "/home/ubuntu/LAB3/Assignment_3_Wang.Zun/scripts"
```

```r
dir()
```

```
## [1] "Assignment_3_template_1.html" "Assignment_3_template_1.md"  
## [3] "Assignment_3_template_1.Rmd"
```

(You would then click on the > arrow in your answer code block to run it before continuing)

## Exercise 1
_Use sum() to determine the sum of numbers from 2000 to 20000.  Provide your code and have Rmarkdown produce the actual sum in your answer._

```r
sum(2000:20000)
```

```
## [1] 198011000
```


## Exercise 2
_In one or two sentences, describe what the above code snippet it did._


```r
#It means a is assigned a value of 5, and b is assigned to be a list containing integers from 2 to 20.
```

## Exercise 3
_Add the contents of a and b together and place the results in a new object.  Examine the result.  Include your code.  Try using both `sum()` and `+`; do you get different results?  If so, why?_


```r
a <- 5
b <- 2:20
sum(a + b)
```

```
## [1] 304
```

```r
x <- sum(b) + a
x
```

```
## [1] 214
```

```r
# For sum(a + b), I am adding 5 to every element on b, so sum(b) + a is the actual sum of every element in it.
```
## Exercise 4
_What is the sum of the 5th through 10th element of object b?  Provide your code and the sum._

```r
sum(b[5:10])
```

```
## [1] 51
```

## Exercise 5
_What is the sum of the 3rd, 8th, and 10th element of b?  For both of these exercises should only need to have "b" in your code once._

```r
sum(b[c(3,8,10)])
```

```
## [1] 24
```

## Exercise 6
_When extracting from a 2-dimensional object, which number specifies rows and which specifies columns?_

_What does `m[3,]` do?_

_How can you extract the 3rd, 4th and 5th columns of m together as one object?_

```r
m <- matrix(data=1:25,ncol=5,byrow=T)
m
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    2    3    4    5
## [2,]    6    7    8    9   10
## [3,]   11   12   13   14   15
## [4,]   16   17   18   19   20
## [5,]   21   22   23   24   25
```

```r
m[5,5]
```

```
## [1] 25
```

```r
m[3,]
```

```
## [1] 11 12 13 14 15
```

```r
#The first number in the index is row, the second number is column. m[3,] generates the whole third row.
#To extract the 3rd, 4th, and 5th column.
my_matrix <- m[,3:5]
my_matrix
```

```
##      [,1] [,2] [,3]
## [1,]    3    4    5
## [2,]    8    9   10
## [3,]   13   14   15
## [4,]   18   19   20
## [5,]   23   24   25
```

## Exercise 7
_What does the cbind command do?  How about rbind?_

_Create a new object "n" where the first row is a new row of numbers (your choice) and the following rows are the rows from matrix m._

_Want more? (OPTIONAL) do the same but reverse the order of the rows from matrix m._


```r
cbind(m,101:105)
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    2    3    4    5  101
## [2,]    6    7    8    9   10  102
## [3,]   11   12   13   14   15  103
## [4,]   16   17   18   19   20  104
## [5,]   21   22   23   24   25  105
```

```r
#cbind add a column of chosen number on the left or right, and rbind add a row of chosen number at the top or bottom.
n <- rbind(1000:996,m)
n
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,] 1000  999  998  997  996
## [2,]    1    2    3    4    5
## [3,]    6    7    8    9   10
## [4,]   11   12   13   14   15
## [5,]   16   17   18   19   20
## [6,]   21   22   23   24   25
```

```r
#Optional:
rbind(1000:996,m[5:1,])
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,] 1000  999  998  997  996
## [2,]   21   22   23   24   25
## [3,]   16   17   18   19   20
## [4,]   11   12   13   14   15
## [5,]    6    7    8    9   10
## [6,]    1    2    3    4    5
```

**JD:** -0

** Turning in the assignment**

* Click the arrow next to the "Preview" Button and choose the "knit-to-html" option to generate an up-to-date html version of your notebook.  Check it to make sure you are happy with its content.
* add your .Rmd and .html files to the repository and commit the changes.
* push the changes
