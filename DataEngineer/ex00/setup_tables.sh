#!/bin/sh

cd /data

chmod 775 /docker-entrypoint-initdb.d/

for f in *.csv
do
    << EOF >> /docker-entrypoint-initdb.d/init_tables.sql
CREATE TABLE ${f%.csv} (
    event_time TIMESTAMPTZ,
    event_type VARCHAR(50),
    product_id INT,
    price REAL,
    user_id INT,
    user_session VARCHAR(50)
);

-- Copy data from the CSV file into the table
COPY ${f%.csv}
FROM '/data/$f'
DELIMITER ','
CSV HEADER;

EOF
    echo "Adding ${f%.csv}..."
done

exec docker-entrypoint.sh "$@"
