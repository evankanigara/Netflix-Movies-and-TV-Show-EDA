# Netflix-Movies-and-TV-Show-EDA
![Cover](gambar/cover.jpg)
## Background
The “TV Shows and Movies listed on Netflix” dataset consists of television series and films that were on Netflix until 2009. The data from the dataset is obtained via Flixable, which is a third party search engine. While the dataset can be accessed from the [Kaggle](https://www.kaggle.com/shivamb/netflix-shows) website by uploading a dataset from a user named Shivam Bansal.
According to Bansal, the dataset from Netflix is interesting because the number of television series and films has tripled since 2010. The large number of datasets allows for a lot of insight that can be obtained through EDA.

## About the Datasets
The data dimensions used are 6234 rows and 12 columns. In detail, the columns of the dataset used consist of:
```
> str(df0)
'data.frame':	6234 obs. of  12 variables:
 $ show_id     : int  81145628 80117401 70234439 80058654...
 $ type        : chr  "Movie" "Movie" "TV Show" "TV Show" ...
 $ title       : chr  "Norm of the North: King Sized Adventure"...
 $ director    : chr  "Richard Finn, Tim Maltby" "" "" "" ...
 $ cast        : chr  "Alan Marriott, Andrew Toth, Brian Dobson, Cole Howard, Jennifer Cameron, Jonathan Holmes, Lee Tockar, Lisa Duru"...
 $ country     : chr  "United States, India, South Korea, China"...
 $ date_added  : chr  "September 9, 2019" "September 9, 2016"...
 $ release_year: int  2019 2016 2013 2016 2017 2016 2014 ...
 $ rating      : chr  "TV-PG" "TV-MA" "TV-Y7-FV" "TV-Y7" ...
 $ duration    : chr  "90 min" "94 min" "1 Season" "1 Season" ...
 $ listed_in   : chr  “Stand-Up Comedy" "Kids' TV" "Kids' TV" ...
 $ description : chr  "Before planning an awesome wedding for his grandfather, a polar bear king must take back a stolen artifact from"| __truncated__ "Jandino Asporaat riffs on the challenges of raising kids and serenades the audience with a rousing rendition of"| __truncated__ "With the help of thr
```
## Objective 
The basic exploratory data analysis will be done, including:
- Variation: Categorical Variable
- Variable: Continous Variable
- CovariationL Categorical vs Categorical Variable
- Covariation: Categorical vs COntinous Variable
The analysis analysis will be carried out using R progamming language.

# Analysis
## Data Cleaning and Pre-Processing
The data is not perfect, so it needs to be cleaned. They are:
- Incomplete dataset. There is blank space in the dataset.
- There are some data that must be converted from char to num such as date_added.
- Lack of continuous data so that data analysis is limited.<br>
<br>The libraries used are:
```
library(dplyr)
library(ggplot2)
library(tidyverse)
```
The dataset has blank data which is blankspace. To make the search easier, the blankspace will be changed to NA:
`df0[df0==""] <- NA`
In the duration data column consists of two, namely minutes (minutes) to indicate film and season to indicate TV Show. For easier reading, this column's data type must be changed from chr to int.
```
#Changing minute
df0b<-df0
df0b$duration=as.numeric(gsub(" min", "", df0$duration))
#Changing season
df0s<-df0
df0s$duration=as.numeric(gsub(" Season","",df0s$duration))
```
The same is done for the date_added column. In order to be used (as year information), this column is also modified using the following code:
```
#Changing year added
dfyear<-df0
dfyear1<-str_sub(dfyear$date_added, start= -4)
dfyear3<-as.numeric(dfyear1)
dfyear$date_added<-dfyear3
```

