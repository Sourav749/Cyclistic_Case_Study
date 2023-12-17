
----------------Analysis------------------

SELECT * FROM overalldata;

SELECT count(*) FROM overalldata;


--Overall rides by membership type

SELECT
	Membership_Type,
	COUNT(*) AS TypeCount,
	FORMAT(COUNT(*) * 100.0 /(SELECT COUNT(*) FROM OverallData) , '0.00') AS Percentage
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






