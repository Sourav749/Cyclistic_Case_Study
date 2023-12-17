-- Look at the table and data

SELECT * FROM alldata

-- Count of the row

SELECT COUNT(*) FROM alldata

-- Creat another table to store reqied data (Because of large dataset) 

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

-- Import necessary columns, extract requerd columns and add duration colum

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

-- Check for negative value

SELECT Duration FROM overalldata WHERE Duration < 0 

-- Duration can not be negative so remove those

DELETE FROM overalldata
WHERE Duration < 0;