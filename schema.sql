CREATE DATABASE IMDB



create table person(
nconst varchar(150) primary key,
primaryName varchar(200),
birthYear varchar(10),
deathYear varchar(10),
primaryProfession varchar(200),
knownForTitles varchar(200));

create table title(
tconst varchar(100) primary key,
titleType varchar(200),
primaryTitle varchar(MAX),
originalTitle varchar(MAX),
isAdult bit,
startYear varchar(10),
endYear varchar(10),
runtimeMinutes varchar(20),
genres varchar(200));

create table crew(tconst varchar(150),
ordering int ,
nconst varchar(150),
category varchar(200),
job varchar(MAX),
characters varchar(MAX));


create table rating(tconst varchar(150) primary key,
averageRating float,
numVotes int);

create table aka(
tconst varchar(150),
ordering int ,
title varchar(MAX),
region varchar(MAX),
language varchar(MAX),
types varchar(MAX),
attributes varchar(MAX),
isOriginalTitle varchar(5),
primary key(tconst,ordering));

CREATE INDEX ix_person_name ON person(primaryName);
CREATE INDEX ix_title_type ON title(titleType);
CREATE INDEX ix_crew_nconst ON crew(nconst);
CREATE INDEX ix_crew_tconst ON crew(tconst);

BULK INSERT person
FROM 'C:\Users\pc\Downloads\Compressed\name.basics.tsv\data.tsv'
WITH (
    FIELDTERMINATOR = '\t',  -- Specify the tab as the field terminator
    ROWTERMINATOR = '0x0a',    -- Specify the newline as the row terminator
    FIRSTROW = 2             -- Specify if the first row contains column headers
);

BULK INSERT title
FROM 'C:\Users\pc\Downloads\Compressed\title.basics.tsv\data.tsv'
WITH (
    FIELDTERMINATOR = '\t',  -- Specify the tab as the field terminator
    ROWTERMINATOR = '0x0a',    -- Specify the newline as the row terminator
    FIRSTROW = 2             -- Specify if the first row contains column headers
);

BULK INSERT crew
FROM 'C:\Users\pc\Downloads\Compressed\title.principals.tsv\data.tsv'
WITH (
    FIELDTERMINATOR = '\t',  -- Specify the tab as the field terminator
    ROWTERMINATOR = '0x0a',    -- Specify the newline as the row terminator
    FIRSTROW = 2             -- Specify if the first row contains column headers
);

BULK INSERT rating
FROM 'C:\Users\pc\Downloads\Compressed\title.ratings.tsv\data.tsv'
WITH (
    FIELDTERMINATOR = '\t',  -- Specify the tab as the field terminator
    ROWTERMINATOR = '0x0a',    -- Specify the newline as the row terminator
    FIRSTROW = 2             -- Specify if the first row contains column headers
);

BULK INSERT aka
FROM 'C:\Users\pc\Downloads\Compressed\title.akas.tsv\data.tsv'
WITH (
    FIELDTERMINATOR = '\t',  -- Specify the tab as the field terminator
    ROWTERMINATOR = '0x0a',    -- Specify the newline as the row terminator
    FIRSTROW = 2             -- Specify if the first row contains column headers
);


