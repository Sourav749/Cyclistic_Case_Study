# Cyclistic Case Study

Welcome to my Cyclistic bike-share case study, my capstone for the Google Data Analytics Professional Certificate. Your feedback, whether positive or constructive, is highly appreciated as I strive for continuous improvement. Thank you for joining me on this learning journey!

## Problem Statement

Understand how annual members and casual riders use Cyclistic bikes differently.

What motivates casual riders to invest in Cyclistic annual memberships?

How can Cyclistic use digital media to influence casual riders to become members?

## The Data

The data has been made available by Motivate International Inc. under this [license](https://divvybikes.com/data-license-agreement).

The data source used was downloaded from [here](https://divvy-tripdata.s3.amazonaws.com/index.html) which contains data from year 2013 to year 2023. However, in this case study I will be analysing 12 months of data between Jan 2022 to Dec 2022.

This is public data that can be used to explore how different customer types are using Cyclistic bikes. But note that data privacy issues prohibit you from using riders’ personally identifiable information.

## Process

I collected data for 12 months, each in a separate CSV file. Initially, I merged these files using Windows PowerShell. Following that, I established a table in SQL Server Management Studio [SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16) and proceeded to import the data through the bulk insert.

Here is the query - [Click here](https://github.com/Sourav749/Cyclistic_Case_Study/blob/main/Creat_Table.sql)

## Data Cleaning and Transformation

Establish a new table and insert the necessary columns for analysis. Remove irrelevant columns and extract information such as "startDate," "startDay," and "startMonth" from the "started_at" column. Additionally, include a new "duration" column in the dataset.

Here is the query - [Click here](https://github.com/Sourav749/Cyclistic_Case_Study/blob/main/Transformation.sql)

## Analysis

Execute various queries for analysis; you can find all queries [here](https://github.com/Sourav749/Cyclistic_Case_Study/blob/main/Analysis.sql).

## Insight

- Members contribute the highest number of rides.
- Casual riders exhibit the highest average ride duration on a monthly and daily basis.
- Member users favor both Classic bikes and electric bikes, while casual users predominantly opt for electric bikes.
- The top three busiest months are June, July, and August.
- Weekends are peak days for casual riders, while weekdays are the busiest for members.


## The Finale

Thank you for your engagement with this ReadMe. Your feedback is crucial to my growth as an analyst. 
You can find presentation slides [here](https://www.canva.com/design/DAF201SGoaM/YiuNEmUDpGCK8ItPZiSsTw/view?utm_content=DAF201SGoaM&utm_campaign=designshare&utm_medium=link&utm_source=editor). Your support is greatly appreciated!




