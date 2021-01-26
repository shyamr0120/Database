-- Assignment #2

-- Create "assigment2" database and use
create database assignment2;
use assignment2;

-- Create landmass table with "name" as primary key
CREATE TABLE landmass (
  name VARCHAR(20) NOT NULL,
  area FLOAT NULL,
  PRIMARY KEY (name),
  UNIQUE INDEX name_UNIQUE (name)
);

-- Create bodyofwater table with "name" as primary key
CREATE TABLE bodyofwater (
  name VARCHAR(20) NOT NULL,
  area FLOAT ZEROFILL NULL,
  UNIQUE INDEX name_UNIQUE (name),
  PRIMARY KEY (name)
);

-- Create strait table with "name" as foriegn key and constraint to bodyofwater table
CREATE TABLE strait (
  name VARCHAR(20) NOT NULL,
  PRIMARY KEY (name),
  INDEX fk_strait_bodyofwater_index (name),
  UNIQUE INDEX name_UNIQUE (name),
  CONSTRAINT fk_strait_bodyofwater
    FOREIGN KEY (name)
    REFERENCES bodyofwater (name)
);

-- Create ocean table with "name" as foriegn key and constraint to bodyofwater table
CREATE TABLE ocean (
  name VARCHAR(20) NOT NULL,
  PRIMARY KEY (name),
  INDEX fk_ocean_bodyofwater_index (name),
  UNIQUE INDEX name_UNIQUE (name),
  CONSTRAINT fk_ocean_bodyofwater
    FOREIGN KEY (name)
    REFERENCES bodyofwater (name)
);

-- Create continent table with "name" as foriegn key and constraints to landmass table
-- as well as constraint to bodyofwater table
CREATE TABLE continent (
  name VARCHAR(20) NOT NULL,
  sepearted_by VARCHAR(20) NULL,
  connected_to VARCHAR(20) NULL,
  PRIMARY KEY (name),
  INDEX fk_continent_landmass_index (name),
  INDEX fk_continent_strait_index (sepearted_by),
  INDEX fk_continent_continent_index (connected_to),
  UNIQUE INDEX name_UNIQUE (name),
  CONSTRAINT fk_continent_landmass_1
    FOREIGN KEY (name)
    REFERENCES landmass (name),
  CONSTRAINT fk_continent_strait
    FOREIGN KEY (sepearted_by)
    REFERENCES strait (name),
  CONSTRAINT fk_continent_landmass_2
    FOREIGN KEY (connected_to)
    REFERENCES landmass (name)
);

-- Create island table with "name" as foriegn key and constraint to landmass table
-- as well as constraints to bodyofwater table
CREATE TABLE island (
  name VARCHAR(20) NOT NULL,
  seperated_by VARCHAR(20) NULL,
  located_in VARCHAR(20) NULL,
  PRIMARY KEY (name),
  INDEX fk_island_landmass_index (name),
  INDEX fk_island_strait_index (seperated_by),
  UNIQUE INDEX `name_UNIQUE` (name),
  INDEX fk_island_ocean_index (located_in),
  CONSTRAINT fk_island_landmass
    FOREIGN KEY (name)
    REFERENCES landmass (name),
  CONSTRAINT fk_island_strait
    FOREIGN KEY (seperated_by)
    REFERENCES strait (name),
  CONSTRAINT fk_island_ocean
    FOREIGN KEY (located_in)
    REFERENCES ocean (name)
);


-- First insert data into primary tables, landmass and bodyofwater. Then insert the data into other tables in the order so as to satisfy foriegn key and
-- relationship constraints with primary tables

-- Insert data into landmass table
INSERT INTO   landmass (name, area) VALUES ("Asia", 44579000);
INSERT INTO   landmass (name, area) VALUES ("Africa", 30370000);
INSERT INTO   landmass (name, area) VALUES ("North America", 24709000);
INSERT INTO   landmass (name, area) VALUES ("South America", 17840000);
INSERT INTO   landmass (name, area) VALUES ("Antarctica", 14000000);
INSERT INTO   landmass (name, area) VALUES ("Europe", 10180000);
INSERT INTO   landmass (name, area) VALUES ("Australia", 8600000);
INSERT INTO   landmass (name, area) VALUES ("Hainan", 0);
INSERT INTO   landmass (name, area) VALUES ("Hebao", 0);
INSERT INTO   landmass (name, area) VALUES ("Ping", 0);
INSERT INTO   landmass (name, area) VALUES ("Pingtan", 0);
INSERT INTO   landmass (name, area) VALUES ("Shamian", 0);
INSERT INTO   landmass (name, area) VALUES ("Asparagus", 0);
INSERT INTO   landmass (name, area) VALUES ("Barrow", 0);
INSERT INTO   landmass (name, area) VALUES ("Burgh", 0);
INSERT INTO   landmass (name, area) VALUES ("Chapel", 0);
INSERT INTO   landmass (name, area) VALUES ("Denny", 0);
INSERT INTO   landmass (name, area) VALUES ("Adams", 0);
INSERT INTO   landmass (name, area) VALUES ("Cameron", 0);
INSERT INTO   landmass (name, area) VALUES ("Graham", 0);
INSERT INTO   landmass (name, area) VALUES ("Alexander", 0);
INSERT INTO   landmass (name, area) VALUES ("Coburg", 0);
INSERT INTO   landmass (name, area) VALUES ("Tasmania", 0);
INSERT INTO   landmass (name, area) VALUES ("Melville", 0);
INSERT INTO   landmass (name, area) VALUES ("Kangaroo", 0);
INSERT INTO   landmass (name, area) VALUES ("Groote", 0);
INSERT INTO   landmass (name, area) VALUES ("King", 0);
INSERT INTO   landmass (name, area) VALUES ("Arce", 0);
INSERT INTO   landmass (name, area) VALUES ("Blancas", 0);
INSERT INTO   landmass (name, area) VALUES ("Del Palo", 0);
INSERT INTO   landmass (name, area) VALUES ("Gable", 0);
INSERT INTO   landmass (name, area) VALUES ("Tova", 0);
INSERT INTO   landmass (name, area) VALUES ("Grande Comore", 0);
INSERT INTO   landmass (name, area) VALUES ("Anjouan", 0);
INSERT INTO   landmass (name, area) VALUES ("Mauritius", 0);
INSERT INTO   landmass (name, area) VALUES ("Rodrigues", 0);
INSERT INTO   landmass (name, area) VALUES ("Saint Brandon", 0);
INSERT INTO   landmass (name, area) VALUES ("Antipodes", 0);
INSERT INTO   landmass (name, area) VALUES ("Auckland", 0);
INSERT INTO   landmass (name, area) VALUES ("Bounty", 0);
INSERT INTO   landmass (name, area) VALUES ("Campbell", 0);
INSERT INTO   landmass (name, area) VALUES ("Crozet", 0);
INSERT INTO   landmass (name, area) VALUES ("Kyushu", 0);
INSERT INTO   landmass (name, area) VALUES ("Shikoku", 0);
INSERT INTO   landmass (name, area) VALUES ("Banks", 0);

-- Insert data into bodyoawater table
INSERT INTO   bodyofwater (name, area) VALUES ("Atlantic", 76762000);
INSERT INTO   bodyofwater (name, area) VALUES ("Arctic", 14056000);
INSERT INTO   bodyofwater (name, area) VALUES ("Indian", 68566000);
INSERT INTO   bodyofwater (name, area) VALUES ("Pacific", 155557000);
INSERT INTO   bodyofwater (name, area) VALUES ("Southern", 20327000);
INSERT INTO   bodyofwater (name, area) VALUES ("Bungo Channel", 0);
INSERT INTO   bodyofwater (name, area) VALUES ("Bass Strait", 0);
INSERT INTO   bodyofwater (name, area) VALUES ("McClure Strait", 0);
INSERT INTO   bodyofwater (name, area) VALUES ("Bering Strait", 0);
INSERT INTO   bodyofwater (name, area) VALUES ("Strait of Gibraltar", 0);
INSERT INTO   bodyofwater (name, area) VALUES ("Drake Passage", 0);

-- Insert data into strait table
INSERT INTO   strait (name) VALUES ("Bass Strait");
INSERT INTO   strait (name) VALUES ("Bering Strait");
INSERT INTO   strait (name) VALUES ("Bungo Channel");
INSERT INTO   strait (name) VALUES ("Drake Passage");
INSERT INTO   strait (name) VALUES ("McClure Strait");
INSERT INTO   strait (name) VALUES ("Strait of Gibraltar");

-- Insert data into ocean table
INSERT INTO   ocean (name) VALUES ("Atlantic");
INSERT INTO   ocean (name) VALUES ("Arctic");
INSERT INTO   ocean (name) VALUES ("Indian");
INSERT INTO   ocean (name) VALUES ("Pacific");
INSERT INTO   ocean (name) VALUES ("Southern");

-- Insert data into continent table
INSERT INTO   continent (name, sepearted_by, connected_to) VALUES ("Asia", "Bering Strait", "Europe");
INSERT INTO   continent (name, sepearted_by, connected_to) VALUES ("Africa", "Strait of Gibraltar", "Asia");
INSERT INTO   continent (name, sepearted_by, connected_to) VALUES ("North America", "Bering Strait", "South America");
INSERT INTO   continent (name, sepearted_by, connected_to) VALUES ("South America", "Drake Passage", "North America");
INSERT INTO   continent (name, sepearted_by, connected_to) VALUES ("Antarctica", "Drake Passage",NULL);
INSERT INTO   continent (name, sepearted_by, connected_to) VALUES ("Europe", "Strait of Gibraltar", "Asia");
INSERT INTO   continent (name, sepearted_by, connected_to) VALUES ("Australia",NULL,NULL);

-- Insert data into island table
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Hainan", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Hebao", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Ping", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Pingtan", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Shamian", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Asparagus", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Barrow", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Burgh", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Chapel", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Denny", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Adams", NULL, "Arctic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Cameron", NULL, "Arctic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Graham", NULL, "Arctic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Alexander", NULL, "Arctic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Coburg", NULL, "Arctic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Tasmania", "Bass Strait", "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Melville", "McClure Strait", "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Kangaroo", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Groote", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("King", NULL, "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Arce", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Blancas", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Del Palo", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Gable", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Tova", NULL, "Atlantic");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Grande Comore", NULL, "Indian");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Anjouan", NULL, "Indian");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Mauritius", NULL, "Indian");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Rodrigues", NULL, "Indian");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Saint Brandon", NULL, "Indian");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Auckland", NULL, "Southern");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Antipodes", NULL, "Southern");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Bounty", NULL, "Southern");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Campbell", NULL, "Southern");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Crozet", NULL, "Southern");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Kyushu", "Bungo Channel", "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Shikoku", "Bungo Channel", "Pacific");
INSERT INTO   island (name, seperated_by, located_in) VALUES ("Banks", "McClure Strait", "Pacific");

-- Export the data into excel 
SELECT * FROM landmass INTO outfile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\landmass.csv" fields terminated by ',' lines terminated by '\n';
SELECT * FROM bodyofwater INTO outfile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bodyofwater.csv" fields terminated by ',' lines terminated by '\n';
SELECT * FROM strait INTO outfile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\strait.csv" fields terminated by ',' lines terminated by '\n';
SELECT * FROM ocean INTO outfile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ocean.csv" fields terminated by ',' lines terminated by '\n';
SELECT * FROM continent INTO outfile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\continent.csv" fields terminated by ',' lines terminated by '\n';
SELECT * FROM island INTO outfile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\island.csv" fields terminated by ',' lines terminated by '\n';

-- Drop tables
DROP TABLE continent;
DROP TABLE island;
DROP TABLE landmass;
DROP TABLE strait;
DROP TABLE ocean;
DROP TABLE bodyofwater;

-- Drop the database
DROP database assignment2;
