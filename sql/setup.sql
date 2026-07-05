--Creating database
CREATE DATABASE crm-analysis;

--Membuat table berdasarkan setiap sheet
CREATE TABLE accounts (
	account VARCHAR(100),
	sector VARCHAR(50),
	year_established INT,
	revenue NUMERIC,
	employees INT,
	office_location VARCHAR(100),
	subsidiary_of VARCHAR(100)
);

CREATE TABLE products (
	products VARCHAR(50),
	series VARCHAR(20),
	sales_price NUMERIC
);

CREATE TABLE sales_teams (
	sales_agent VARCHAR(100),
	manager VARCHAR(100),
	regional VARCHAR (50)
);

CREATE TABLE sales_pipeline (
	opportunity_id VARCHAR(100),
	sales_agent VARCHAR(100),
	product VARCHAR(50),
	account VARCHAR(100),
	deal_stage VARCHAR(30),
	engage_date DATE,
	close_date DATE,
	close_value NUMERIC
);

-- Data loaded via pgAdmin Import/Export feature
-- Source: CSV files in /data/raw/ folder
