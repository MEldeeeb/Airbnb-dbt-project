-- Set up the defaults
USE WAREHOUSE COMPUTE_WH;
USE DATABASE airbnb;
USE SCHEMA RAW;
------------------------------------------------------------------------------------------------------------------------
-- Create our three tables and import the data from S3
CREATE OR REPLACE TABLE raw_listings(id integer,
                     listing_url string,
                     name string,
                     room_type string,
                     minimum_nights integer,
                     host_id integer,
                     price string,
                     created_at datetime,
                     updated_at datetime);
                    
COPY INTO raw_listings (id,
                        listing_url,
                        name,
                        room_type,
                        minimum_nights,
                        host_id,
                        price,
                        created_at,
                        updated_at)
                   from 's3://dbtlearn/listings.csv'
                    FILE_FORMAT = (type = 'CSV' skip_header = 1
                    FIELD_OPTIONALLY_ENCLOSED_BY = '"');
                    
------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE raw_reviews
                    (listing_id integer,
                     date datetime,
                     reviewer_name string,
                     comments string,
                     sentiment string);
                    
COPY INTO raw_reviews (listing_id, date, reviewer_name, comments, sentiment)
                    from 's3://dbtlearn/reviews.csv'
                    FILE_FORMAT = (type = 'CSV' skip_header = 1
                    FIELD_OPTIONALLY_ENCLOSED_BY = '"');

------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE raw_hosts
                    (id integer,
                     name string,
                     is_superhost string,
                     created_at datetime,
                     updated_at datetime);
                    
COPY INTO raw_hosts (id, name, is_superhost, created_at, updated_at)
                    from 's3://dbtlearn/hosts.csv'
                    FILE_FORMAT = (type = 'CSV' skip_header = 1
                    FIELD_OPTIONALLY_ENCLOSED_BY = '"');
------------------------------------------------------------------------------------------------------------------------
drop view AIRBNB.RAW.SRC_HOSTS;
drop view AIRBNB.RAW.SRC_LISTINGS;
drop view AIRBNB.RAW.SRC_REVIEWS;

drop view AIRBNB.RAW.DIM_HOSTS_CLEANSED;
drop view AIRBNB.RAW.DIM_LISTINGS_CLEANSED;

drop TABLE AIRBNB.RAW.SEED_FULL_MOON_DATES;
drop TABLE AIRBNB.RAW.DIM_LISTINGS_W_HOSTS;
drop TABLE AIRBNB.RAW.FCT_REVIEWS;
drop TABLE AIRBNB.RAW.SEED_FULL_MOON_DATES;

drop schema RAW_PUBLIC ;
drop schema RAW ;
drop schema DEV ;
drop schema RAW_DEV ;

 UPDATE AIRBNB.RAW.RAW_LISTINGS SET MINIMUM_NIGHTS=30, 
    updated_at=CURRENT_TIMESTAMP() WHERE ID=3176; 

SELECT * FROM AIRBNB.RAW_DEV.SCD_RAW_LISTINGS WHERE ID=3176;