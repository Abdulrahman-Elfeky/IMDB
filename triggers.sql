CREATE TRIGGER delete_title
on title
after delete 
as 
BEGIN
	declare @tconst2 varchar(100);
	select @tconst2=d.tconst
	from deleted d;
	delete from rating where rating.tconst=@tconst2
	delete from aka WHERE  aka.tconst =@tconst2
    delete from crew WHERE  crew.tconst =@tconst2
END