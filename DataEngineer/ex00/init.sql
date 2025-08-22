-- create the event table without primary key
CREATE TABLE data_2022_dec (
    event_time TIMESTAMPTZ,
    event_type VARCHAR(50),
    product_id INT,
    price REAL,
    user_id INT,
    user_session VARCHAR(50)
);

-- Copy data from the CSV file into the table
COPY data_2022_dec
FROM '/data/data_2022_dec.csv'
DELIMITER ','
CSV HEADER;