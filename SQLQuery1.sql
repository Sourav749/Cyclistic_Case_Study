

drop table alldata

CREATE TABLE alldata (
    ride_id VARCHAR(50),
    rideable_type VARCHAR(20),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(50),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(50),
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual VARCHAR(10)
);

BULK INSERT alldata
FROM 'D:\Project\SQL_Project\Cyclistic_Project\Raw_Data\AllData.csv'
WITH (
	FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- If your CSV file has a header row and you want to skip it
   
);

SELECT * FROM alldata

SELECT COUNT(*) FROM alldata

drop table overalldata

CREATE TABLE overalldata (
Rider_Id varchar(50),
Membership_Type varchar(50),
Bike_Type varchar(50),
StartTimeStamp datetime,
StartTime time,
StartDate date,
StartDay varchar(50),
StartMonth varchar(50),
EndTimeStamp datetime,
EndTime time,
EndDate date,
EndDay varchar(50),
EndMonth varchar(50),
Duration int
);

INSERT INTO overalldata(
Rider_Id,
Membership_Type,
Bike_Type,
StartTimeStamp,
StartTime,
StartDate,
StartDay,
StartMonth,
EndTimeStamp,
EndTime,
EndDate,
EndDay,
EndMonth,
Duration
)
SELECT
ride_id AS Rider_Id,
member_casual AS Membership_Type,
rideable_type AS Bike_Type,
CAST(started_at AS datetime) AS StartTimeStamp,
CAST(started_at AS time) AS StartTime,
CAST(started_at AS date) AS StartDate,
FORMAT(started_at, 'dddd') AS StartDay,
FORMAT(started_at, 'MMMM') AS StartMonth,
CAST(ended_at AS datetime) AS EndTimeStamp,
CAST(ended_at AS time) AS EndTime,
CAST(ended_at AS date) AS EndDate,
FORMAT(ended_at, 'dddd') AS EndDay,
FORMAT(ended_at, 'MMMM') AS EndMonth,
DATEDIFF(minute, started_at, ended_at) AS Duration
FROM alldata
ORDER BY StartDate;

SELECT count(Duration) FROM overalldata WHERE Duration < 0 

DELETE FROM overalldata
WHERE Duration < 0;

----------------Analysis-------------

SELECT * FROM overalldata;

SELECT count(*) FROM overalldata;


--Overall rides by membership type

SELECT
	Membership_Type,
	COUNT(*) AS TypeCount,
	FORMAT(COUNT(*) * 100.0 /(SELECT COUNT(*) FROM OverallData) , '0.00') AS Percentage
FROM overalldata
GROUP BY Membership_Type;

--OR

SELECT
	Membership_Type,
	COUNT(*) AS TypeCount,
	CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM OverallData) AS DECIMAL(5, 2)) AS Percentage
FROM overalldata
GROUP BY Membership_Type;

--Number of riders by bike type

	WITH MembershipTypeCounts AS (
		SELECT
			Membership_Type,
			Bike_Type,
			COUNT(*) AS TypeCount
		FROM
			OverallData
		GROUP BY
			Membership_Type, Bike_Type
	)
		SELECT
			Membership_Type,
			MAX(CASE WHEN Bike_Type = 'classic_bike' THEN TypeCount END) AS classic_bike,
			MAX(CASE WHEN Bike_Type = 'docked_bike' THEN TypeCount END) AS docked_bike,
			MAX(CASE WHEN Bike_Type = 'electric_bike' THEN TypeCount END) AS electric_bike
		FROM
			MembershipTypeCounts
		GROUP BY
		Membership_Type;

--Count of Membership type by each month

SELECT
	StartMonth,
	COUNT(CASE WHEN Membership_Type = 'member' THEN 1 END) AS Member_Count,
	COUNT(CASE WHEN Membership_Type = 'casual' THEN 1 END) AS Casual_Count
FROM
	overalldata
GROUP BY
	StartMonth
ORDER BY
	MONTH(MIN(StartDate));


--Count of Membership type by each day

SELECT
	StartDay,
	Membership_Type,
	COUNT(*) AS TypeCount
FROM
	overalldata
GROUP BY
	StartDay, Membership_Type
ORDER BY
	StartDay, Membership_Type;

-- Average duration by month

SELECT
    DATENAME(month, StartDate) AS Month,
    Membership_Type,
    AVG(Duration) AS AverageDuration
FROM
    overalldata
GROUP BY
    DATENAME(month, StartDate),
    Membership_Type
ORDER BY
    Month, Membership_Type;


--Average duration by day

SELECT
    StartDay,
    Membership_Type,
    AVG(Duration) AS AverageDuration
FROM
    overalldata
GROUP BY
    StartDay,
    Membership_Type
ORDER BY
    StartDay, Membership_Type;


SELECT
    StartDay,
    AVG(CASE WHEN Membership_Type = 'Casual' THEN Duration END) AS CasualAverageDuration,
    AVG(CASE WHEN Membership_Type = 'Member' THEN Duration END) AS MemberAverageDuration
FROM
    overalldata
GROUP BY
    StartDay
ORDER BY
    CASE StartDay
		WHEN 'Sunday' THEN 1
        WHEN 'Monday' THEN 2
        WHEN 'Tuesday' THEN 3
        WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5
        WHEN 'Friday' THEN 6
        WHEN 'Saturday' THEN 7
    END;









SELECT
    DATEPART(hour, StartTimeStamp) AS HourOfDay,
    COUNT(*) AS RiderCount,
	Membership_Type
FROM
    overalldata
GROUP BY
    DATEPART(hour, StartTimeStamp),Membership_Type
ORDER BY
    HourOfDay;


SELECT
    FORMAT(StartTimeStamp, 'HH') AS HourOfDay,
    COUNT(*) AS RiderCount,
    Membership_Type
FROM
    overalldata
GROUP BY
    FORMAT(StartTimeStamp, 'HH'), Membership_Type
ORDER BY
    HourOfDay;

