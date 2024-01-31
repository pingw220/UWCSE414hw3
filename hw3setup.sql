CREATE EXTERNAL DATA SOURCE flightdata_blob
WITH (TYPE = BLOB_STORAGE, 
LOCATION = 'https://introdatamanagement.blob.core.windows.net/flightdata'
);

CREATE TABLE CARRIERS (
	cid VARCHAR(7) PRIMARY KEY,
	name VARCHAR(83));

CREATE TABLE MONTHS (
	mid INT PRIMARY KEY,
	month VARCHAR(9));

CREATE TABLE WEEKDAYS (
	did INT PRIMARY KEY,
	day_of_week VARCHAR(9));

CREATE TABLE FLIGHTS (
	fid INT PRIMARY KEY, 
	month_id INT REFERENCES MONTHS(mid),
	day_of_month INT,
	day_of_week_id INT REFERENCES WEEKDAYS(did),
	carrier_id VARCHAR(7) REFERENCES CARRIERS(cid), 
	flight_num INT,
	origin_city VARCHAR(34), 
	origin_state VARCHAR(47), 
	dest_city VARCHAR(34), 
	dest_state VARCHAR(46), 
	departure_delay INT,
	taxi_out INT,
	arrival_delay INT,
	canceled INT,
	actual_time INT,
	distance INT,
	capacity INT, 
	price INT);

bulk insert Carriers from 'carriers.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

bulk insert Months from 'months.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

bulk insert Weekdays from 'weekdays.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

-- Import for the large Flights table.
-- This last import might take a little under 10 minutes on the
-- provided server settings
bulk insert Flights from 'flights-small.csv'
with (ROWTERMINATOR = '0x0a',
DATA_SOURCE = 'flightdata_blob', FORMAT='CSV', CODEPAGE = 65001, --UTF-8 encoding
FIRSTROW=1,TABLOCK);

-- After you run the code above successfully, you can move on to creating the indexes.

-- Indexes, which we’ll discuss later this quarter, will make your
-- homework queries run much faster (optional, but STRONGLY recommended).
-- In aggregate, these three statements will take about 10 minutes
create index Flights_idx1 on Flights(origin_city,dest_city,actual_time);
create index Flights_idx2 on Flights(actual_time);
create index Flights_idx3 on Flights(dest_city,origin_city,actual_time);
