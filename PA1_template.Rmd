---
title: 'Peer-graded Assignment: Course Project 1'
output: html_document
---

#### Loading and preprocessing the data

```{r}
Activity  <- read.csv("activity.csv")
```

#### What is mean total number of steps taken per day?

##### Calculate the total number of steps taken per day.

```{r}
SumperDay <- with(Activity, tapply(steps, date, sum, na.rm = TRUE))
```

___________________________________________________________________

##### Make a histogram of the total number of steps taken each day.

```{r}
hist(SumperDay, xlab = "Total Number of Steps per Day", main = "Histogram of total number of steps per day")
```

______________________________________________________________________________________________

##### Calculate and report the mean and median of the total number of steps taken per day

```{r}
mean(SumperDay)
```

The mean of the total number of steps taken per day is "`r mean(SumperDay)`"

```{r}
median(SumperDay)
```
The median of the total number of steps taken per day is "`r median(SumperDay)`"

_____________________________________________________________________________

#### What is the average daily activity pattern?

```{r}
AveperInterval <- with(Activity, tapply(steps, interval, mean, na.rm = TRUE))
plot(AveperInterval, type = "l", xlab = "Interval", ylab = "Average Number of Steps")
```
```{r}
df <- as.data.frame(AveperInterval)
rownames(df)[df$AveperInterval == max(df[,1])]
```

5-minute interval, on average across all the days in the dataset, that contains the maximum number of steps is "`r rownames(df)[df$AveperInterval == max(df[,1])]`"

_____________________________________________________________________________________________________

#### What is the total number of missing values in the dataset?

```{r}
sum(is.na(Activity$steps))
```

The total number of missing values in the dataset is "`r sum(is.na(Activity$steps))`"

_____________________________________________________________________________________________________

#### Devise a strategy for filling in all of the missing values in the dataset.

```{r}
ActivityFilled  <- read.csv("activity.csv")
MedperInterval <- with(ActivityFilled, tapply(steps, interval, median, na.rm = TRUE))
for (i in 1:nrow(ActivityFilled)) {
        if(is.na(ActivityFilled$steps)[i]) { 
                num <- ActivityFilled$interval[i]  
                ActivityFilled$steps[i] <- as.data.frame(MedperInterval)[rownames(MedperInterval) == num, ]
        }
}
```


```{r}
SumperDayFilled <- with(ActivityFilled, tapply(steps, date, sum, na.rm = TRUE))
```

___________________________________________________________________

##### Making a histogram of the total number of steps taken each day for filled NA's

```{r}
hist(SumperDayFilled, xlab = "Total Number of Steps per Day", main = "Histogram of total number of steps per day")
```

______________________________________________________________________________________________

##### Calculating and reporting the mean and median of the total number of steps taken per day

```{r}
mean(SumperDayFilled)
```

The mean of the total number of steps taken per day is "`r mean(SumperDayFilled)`"

```{r}
median(SumperDayFilled)
```
The median of the total number of steps taken per day is "`r median(SumperDayFilled)`"

_____________________________________________________________________________

What is the impact of imputing missing data on the estimates of the total daily number of steps?

The average value for total daily number of steps before filling missed value (`r mean(SumperDay)`) and after  filling missed value (`r mean(SumperDayFilled)`) is "`r mean(SumperDayFilled) - mean(SumperDay)`". But the median value has not been changed.

_____________________________________________________________________________

#### Are there differences in activity patterns between weekdays and weekends?

```{r}
ActivityFilled$date <- as.Date(ActivityFilled$date)
ActivityFilled$weekdays <- weekdays(ActivityFilled$date)
```

```{r}
for(i in 1: nrow(ActivityFilled)) {
        if(ActivityFilled$weekdays[i] %in% c("Saturday", "Sunday")){
                ActivityFilled$weekday[i] <- "weekend"  
        }
        else{
                ActivityFilled$weekday[i] <- "weekday"
        }
}
```

```{r}
ActivityFilled$weekday <- as.factor(ActivityFilled$weekday)
```

```{r}
AveActivityDataImp <- aggregate(steps ~ interval + weekday, data = ActivityFilled, mean)

library(ggplot2)

ggplot(AveActivityDataImp, aes(interval, steps)) + 
        geom_line() + 
        facet_grid(weekday ~ .) +
        xlab("5-minute interval") + 
        ylab("Avarage Number of Steps")
```





