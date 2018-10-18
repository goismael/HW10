--Create a database called HW10.
IF (db_id('HW10') is not null)
DROP DATABASE HW10;

create database HW10;
go

use HW10;
go  

set nocount on;

--Create a table called Employees 
create table Employees
(ID int identity(1,1) PRIMARY KEY CLUSTERED 
,BadgeNum int not null unique
,Title varchar(20) null
,DateHired datetime2 not null) 
;

--database.
IF (db_id('HW10') is not null)
DROP DATABASE HW10;

create database HW10;
go

use HW10;
go  

set NOCOUNT on;

-- table 
create table Employees
(ID int identity(1,1) PRIMARY KEY CLUSTERED 
,BadgeNum int not null unique
,Title varchar(20) null
,DateHired datetime2 not null) 
;


--creating trigger
CREATE TRIGGER MessageDisplayed on dbo.Employees  
after INSERT, update 
AS  
declare @BadgeNum int;
select  @BadgeNum = BadgeNum 
from inserted

--if statement
IF (@BadgeNum between 0 and 300)
begin
update dbo.Employees set Title = 'Clerk' where  BadgeNum = @BadgeNum
end
else 
IF (@BadgeNum between 301 and 600)
begin
update dbo.Employees set Title = 'Office Employee' where  BadgeNum = @BadgeNum
end
else IF (@BadgeNum between 700 and 800)
begin
update dbo.Employees set Title = 'Manager' where  BadgeNum = @BadgeNum
end
else if (@BadgeNum between 900 and 1000)
begin
update dbo.Employees set Title = 'Director' where  BadgeNum = @BadgeNum
end
go


--inserting into the table
declare @count int =1;
declare @HoldRand int;
while @count < 26 begin
--random number betw 0 and 1000 for badge num
	SET @HoldRand = CAST(RAND() *1000 as int);

	if not exists (select badgenum from dbo.Employees where BadgeNum= @HoldRand)
	Begin 
		insert into Employees( BadgeNum, Title, DateHired)
		values (@HoldRand, 'to be', getdate());
		set @count +=1;
	end;
	else begin 
		continue;
	end;
end;
go

--declaring the cursor
declare @BadgeNum int ;
Declare @Title varchar(20);
Declare @DateHired datetime2;

Declare EmplTitles CURSOR FAST_FORWARD FOR
SELECT BadgeNum, Title, DateHired FROM dbo.Employees;

Open EmplTitles;

FETCH NEXT FROM EmplTitles INTO @BadgeNum, @Title, @DateHired;

WHILE @@FETCH_STATUS = 0 
BEGIN
PRINT 'BadgeNum = ' + CONVERT(Nvarchar(4), @BadgeNum) +  ' Title= ' + @Title + ' DateHired = ' + Convert(NVARCHAR(40), @DateHired) 
FETCH NEXT FROM EmplTitles INTO @BadgeNum, @Title, @DateHired;
END

CLOSE EmplTitles;
DEALLOCATE EmplTitles;

	











