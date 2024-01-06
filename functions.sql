CREATE FUNCTION dbo.TopRated
(
    @type varchar(200)
   
)
RETURNS table
AS
RETURN(
    select top 250 title.primaryTitle,rating.averageRating,rating.numVotes
	from title inner join rating on title.tconst=rating.tconst 
	where title.titleType=@type and rating.numVotes>=50000 
	order by rating.averageRating desc
)


------------------------------------------------------------------------------------------------------------

CREATE FUNCTION dbo.titlesByActor
(
    @name varchar(200),
    @type varchar(200)
)
RETURNS @t table(titleName varchar(MAX),titleType varchar(200),character varchar(MAX))

BEGIN
	IF(@type='all')
		insert into @t
		SELECT title.primaryTitle, title.titleType, crew.characters
		FROM person
		JOIN crew ON person.nconst = crew.nconst
		JOIN title ON title.tconst = crew.tconst
		WHERE person.primaryName = @name and (title.titleType='movie' or title.titleType='tvseries')
	Else
	-- type=
		insert into @t
		SELECT title.primaryTitle, title.titleType, crew.characters
		FROM person
		JOIN crew ON person.nconst = crew.nconst
		JOIN title ON title.tconst = crew.tconst
		WHERE person.primaryName = @name AND title.titleType = @type
	RETURN
END

-----------------------------------------------------------------------------------------------------------------

create function dbo.commonTitles(
@name1 varchar(200),
@name2 varchar(200)
)
RETURNS TABLE
as
RETURN (
	select title.primaryTitle,titleType,c1.characters as 'played by actor1' , c2.characters as 'played by actor2'
	from person p1 join crew c1 on p1.nconst = c1.nconst 
	join title on title.tconst = c1.tconst
	join crew c2 on c2.tconst = title.tconst
	join person p2 on p2.nconst = c2.nconst
	where p1.primaryName=@name1 and p2.primaryName=@name2 and (title.titleType in ('movie','tvseries'))
)


CREATE FUNCTION dbo.colleagues (
    @name VARCHAR(150)
)
RETURNS table
AS
RETURN(
    SELECT
        p2.primaryName AS ColleagueName,
        t.primaryTitle AS Title,
        c2.category AS Category
    FROM
        person p1
        JOIN crew c1 ON p1.nconst = c1.nconst
        JOIN title t ON t.tconst = c1.tconst
        JOIN crew c2 ON t.tconst = c2.tconst
        JOIN person p2 ON c2.nconst = p2.nconst
    WHERE
        p1.primaryName = @name
        AND p1.nconst != p2.nconst
)






