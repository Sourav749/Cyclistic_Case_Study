-- Creat table

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

-- Imort data to the table

BULK INSERT alldata
FROM 'D:\Project\SQL_Project\Cyclistic_Project\Raw_Data\AllData.csv'
WITH (
	FORMAT = 'CSV',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- CSV file has a header row so want to skip that
   
);