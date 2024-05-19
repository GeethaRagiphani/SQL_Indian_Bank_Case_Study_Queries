	Use Master
	go
-- Schema of the db
	Sp_helpdb IndianBank

	Use IndianBank
	go
-- Schema of the table
Sp_help AccountMaster
-- To retrieve all columns and all rows
	Select * from AccountMaster
	Select * from BranchMaster
	Select * from ProductMaster
	Select * from RegionMaster
	Select * from TxnMaster
	Select * from UserMaster
-- Some columns and All rows
	Select Name, Address, BRID from AccountMaster
-- All columns and some rows/ WHERE clause
	Select * from AccountMaster Where BRID = 'BR8'
--Inserting more records
insert into AccountMaster values(112,'ABCD','Pakistan','BR9','LB','2000/03/03',5822,850,'C')
-- Additional unique records with modified values for all columns including date in YYYY/MM/DD format
	INSERT INTO AccountMaster VALUES (145, 'AAA', 'India', 'BR8', 'SB', '2023/01/01', 1655, 78, 'I')
	INSERT INTO AccountMaster VALUES (130, 'BBB', 'USA', 'BR1', 'SB', '2020/01/01', 2000, 1000, 'C')
	INSERT INTO AccountMaster VALUES (131, 'CCC', 'Canada', 'BR2', 'SB', '2020/01/02', 2000, 0, 'O')
	INSERT INTO AccountMaster VALUES (133, 'EEE', 'India', 'BR5', 'LB', '2018/09/02', 1789, 0, 'C')
	INSERT INTO AccountMaster VALUES (134, 'FFF', 'London', 'BR4', 'FD', '2020/01/14', 1789, 789, 'I')
	INSERT INTO AccountMaster VALUES (135, 'GGG', 'Pakistan', 'BR6', 'LB', '2018/09/02', 1678, 876, 'O')
	INSERT INTO AccountMaster VALUES (136, 'HHH', 'Australia', 'BR9', 'FD', '2023/03/22', 1675, 87, 'C')
	INSERT INTO AccountMaster VALUES (137, 'HHH', 'Australia', 'BR1', 'RD', '2024/03/22', 1675, 87, 'O')
	INSERT INTO AccountMaster VALUES (138, 'HHH', 'Australia', 'BR1', 'LB', '2023/03/22', 1675, 87, 'O')
-- All columns and some rows/ WHERE clause
	
--Some columns and some rows
	Select ACID, Name from AccountMaster where PID = 'FD'
	go
-- Sort the data/ Default is ASC
	Select * from AccountMaster
	order by name	Desc

	Select ACID, Name 
	from AccountMaster
	Where PID = 'SB'
	Order by Name Desc
-- Order is Select, From,Where, Order by
--Concatenation
	Select ACID, Name  + ' is Studying 'as Status
	from AccountMaster
-- Update Records
	update AccountMaster
	set Name = ' Sacnhita'
	Where ACID = 131
-- Concatenation doesn't work for Numbers and strings. You need to use convert() or cast() functions
	Select Acid, Name, cast(CBalance as varchar) +  '  USD' as Balance 
	from AccountMaster

--Select Acid, Name, CONVERT(varchar, CBalance +  '  USD' As NewBalance 
--from AccountMaster (Didn't work)
-- Print columns and constants
	Select Acid, Name, cast (CBalance as varchar) +  '  USD' Balance 
	from AccountMaster
--Convert() Didn't work.  Convert is useful for converting dates style
	Select Acid, Name, '  USD' + cast ( varchar, CBalance) as Balance 
	from AccountMaster
-- Number of rows
	Select count (*) as [Number of Customers] from AccountMaster
-- Number of customers in branch BR1
	Select count (*) as [Number of Customers] 
	from AccountMaster
	where BRID = 'BP6'
-- AND will not work beacause custoner can be either in BR1 or Br2, need to use or
	Select count (*) as [Number of Customers] 
	from AccountMaster
	where BRID = 'BR1' AND BRID = 'BR2'
-- Using OR
	Select count (*) as [Number of Customers] 
	from AccountMaster
	where BRID = 'BR1' or BRID = 'BR2'
-- using in
	Select count (*) as [Number of Customers] 
	from AccountMaster
	where BRID in ('BR1','BR2')
/**  execution order: FROM, Where, Aggrgate function, Select**/
-- Total balance
	Select sum(CBalance) 
	from AccountMaster
-- Total balance in BR1
	Select sum(CBalance) 
	from AccountMaster
	where BRID in ('BR1','BR2')
-- Min balance in BR1
	Select Min(CBalance) 
	from AccountMaster
	where BRID in ('BR1','BR2')
-- Max balance in BR1
	Select Max(CBalance) 
	from AccountMaster
	where BRID in ('BR1','BR2')
-- Avg balance in BR1
	Select Avg(CBalance) 
	from AccountMaster
	where BRID in ('BR1','BR2')
-- Star within brackets is just a chunk value whereas Select * means all columns
-- Count (*) counts the number of rows inclding nulls whereas Count(colname) counts no of rows but nulls
-- Branchwise no of customers: Group by
	Select BRID, count(*) as CNT
	from AccountMaster
	Group by BRID
-- Wherre and Group by
		Select BRID, count(*) as CNT
		from AccountMaster
		where PID = 'SB'
		Group by BRID
--Column 'AccountMaster.PID' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
-- Productwise. SFGO
	Select PID, count(*) as CNT
	from AccountMaster
	Where BRID = 'BR1'
	Group by PID
	order by CNT Desc
-- Always select the columns you use in the Group by line in the last
--Branchiwse , productwise number of customers
	Select  PID, BRID , count (*) as CNT
	from AccountMaster
	Group by PID, BRID
	ORDER BY BRID ASC
--Branchiwse , productwise total Cbalance
	Select  PID, BRID , sum(Cbalance) as [Branchwise total Cbalance]
	from AccountMaster
	Group by PID, BRID
	ORDER BY BRID ASC
--Branchiwse , productwise total Cbalance in 2011
	Select  PID, BRID , sum(Cbalance) as [Branchwise total Cbalance]
	from AccountMaster
	where year(DOO) = 2020
	Group by PID, BRID
	ORDER BY BRID ASC
--Column 'AccountMaster.Name' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
-- Any field present in the Select clause other than aggregate should be present in the Group by clause
-- Get all branches. Distinct is right
	Select distinct BRID from AccountMaster
	Select BRID from AccountMaster Group by BRID
-- Use the group by clause only when there are aggregations
--Number of branches. We can use distinct with both aggregates and non aggregates
	Select count(distinct BRID) as [number of branches]
	from AccountMaster
-- Date Functions
	Select getdate() as today
	Select getdate()-1 as Yesterday
-- As on Balance
	Select ACID, Name, CBalance, Getdate() as [CBalance_As_of_today]
	from AccountMaster
-- convert
	Select Convert(varchar, getdate())
-- Datediff: takes 3 parameters, Difference between two dates
Select DATEDIFF(WW, 2019/02/03, getdate())
	Select DATEDIFF(DD, 2019/03, getdate())
	Select DATEDIFF(QQ, 2019/03, getdate())
	Select DATEDIFF(MM, 2019/03, getdate())
	Select DATEDIFF(YY, 2019/03, getdate())
-- Age of the accounts
	Select ACID, Name,CBalance, DOO, datediff(YY, DOO, getdate()) as [Age of the account]
	from AccountMaster
-- Update S
	Update AccountMaster 
	Set DOO = getdate()
	where ACID = 110
-- List of accounts opened in the current year, age will be zero 
	Select ACID, Name,CBalance, DOO, datediff(YY, DOO, getdate()) as [Age of the account]
	from AccountMaster
	where datediff(YY, DOO, getdate()) = 0

-- Accounts opened in current month
	Select ACID, Name,CBalance, DOO, datediff(YY, DOO, getdate()) as [Age of the account]
	from AccountMaster
	where datediff(MM, DOO, getdate()) = 0
-- Accounts opened in the last month
	Select ACID, Name,CBalance, DOO, datediff(YY, DOO, getdate()) as [Age of the account]
	from AccountMaster
	where datediff(MM, DOO, getdate()) = 1
--  how many people opened accounts in the last 3 years?
	Select count(*)
	from AccountMaster
	where DATEDIFF(YY,DOO, getdate()) <= 3
-- Datepart
	Select DATEPART(MM, getdate())
-- Year wise number of customers
	Select datepart(yy, doo) as YearName, count(*) as [Number of customers]
	from AccountMaster
	Group by datepart(YY, DOO)
	order by [Number of Customers] Desc
--Year CBAlance
	Select datepart(yy, doo) as YearName, Sum(Cbalance) as [Year wise CBalance]
	from AccountMaster
	Group by datepart(YY, DOO)
	order by [Year wise CBalance] Desc
-- List of Customers who opened accounts in 2011
	Select Name, ACID, CBalance, datepart(YY,DOO) as YearNo
	from AccountMaster
	where datepart(YY,DOO) = 2023
-- List of Customers who opened accounts in May 2024
	Select Name, ACID, CBalance, datepart(YY,DOO) as YearNo
	from AccountMaster
	where datepart(YY,DOO) = 2024 and datepart(MM,DOO) = 5 and datepart(DD,DOO) = 12
-- This is not recommended beacuse it doesn't work as time also gets captured. Taking the above date
	Select Name, ACID, CBalance
	from AccountMaster
	where DOO = 12/05/2024
-- DAtename 
	Select DATENAME(MM, getdate()) as MonthName
	Select DATENAME(DW, getdate()) as DayName
-- Different ways of writing
	Select Name, Acid , DOO,
	datepart(YY, DOO) as YNo,
	Year(DOO) as Yno,
	datepart(QQ, DOO) as QNo,
	datepart(MM,DOO) as MonthNumber,
	Month(DOO) as MOnthNo,
	datename(MM,DOO) as Monthname,
	datepart(WW,DOO) as Wkno
	from AccountMaster
--Year wise , Quarter wise Cbalance
-- Apart from the aggregate funnctiob whatever the columns are in group by clause, they should be select clause
	Select	datepart(YY, DOO) as YNO,
			'Q'+ cast(datepart(QQ,DOO) as varchar) as QuarterNumber,
			datepart(MM,DOO) as MonthNumber,
			sum(Cbalance)
	from AccountMaster
	where BRID = 'BR4'and datepart(YY, DOO) >= 2020
	Group by datepart(YY, DOO) , datepart(QQ,DOO), datepart(MM,DOO)
-- Adding or Subtracting
	Select DATEADD (DD, -20, GETDATE())
	Select DATEADD (MM, -20, GETDATE())
	Select DATEADD (YY, -20, 2024/01/01)
-- Setting up a due date
	Select ACID, name, CBalance, DOO as [paid on ], DATEADD(dd,20, DOO) as [Due Date]
	from AccountMaster
-- Last date is not same for every month. In case we need last month last day sales
	Select ACID, name, CBalance, DOO as [paid on ], EOMONTH(DOO) as [Due Date]
	from AccountMaster

	insert into AccountMaster values ( 154, 'Kial','USA','BR6', 'SB', '2024/04/04',2220, 562, 'C')
	insert into AccountMaster values ( 155, 'Kialol','USA','BR7', 'SB', '2024/04/05',2270, 572, 'C')
-- Month wise number of accounts opened in the 2020
	Select count(*) as [Number of Customers], datename(MM, DOO) as [Monthno]
	from AccountMaster
	where Datepart(YY,DOO) = 2020
	group by datename(MM, DOO)
--top n
	Select top(10) * from AccountMaster
-- top n percent
	select top 10 percent * from AccountMaster
-- Latest data
	Select top 10 * from AccountMaster order by DOO Desc
-- How sort months from Jan to Dec
	Select datepart(mm,doo) as monthno, count(*) as [Number of Customers], datename(MM, DOO) as [Monthname]
	from AccountMaster
	where Datepart(YY,DOO) = 2023
	group by datepart(mm,doo), datename(MM, DOO)
	order by monthno ASC
-- Product wise number of customers in BR1
	Select PID, count(*) as [ number of customers product wise], SUM(cbalance) as [Total CBalance]
	from AccountMaster
	where BRID = 'BR1'
	group by PID
-- Product wise number of customers in BR1. Show if the cnt is greater than  1
	Select PID, count(*) as [ number of customers product wise], SUM(cbalance) as [Total CBalance]
	from AccountMaster
	where BRID = 'BR1'
	group by PID
	having count(*) >1
-- NOTE: Aggregates functions don't work for WHERE clause 
-- Order by column we can use Alias but not in Having
	Select PID, Sum(CBalance) as [ Total CBalance]
	from AccountMaster
	where BRID = 'BR1'
	group by PID
	having Sum(CBalance) >1
--Filter, Aggregate and Filter
	Select * from TXNMaster
	
	Select BRID, Sum(TXN_Amount)
	from TXNMaster
	where BRID in ('BR1', 'BR2','BR3', 'BR4')
	Group by BRID
	Having Sum(TXN_Amount)> 20000

--SFWGHO
-- Month wise number of accounts opened in the year 2011
	Select ACID, Name, count(*) as [ Number of Accounts] ,  datename(MM, DOO) as MonthNumber
	from AccountMaster
	where datepart(YY, DOO) = 2023
	group by ACID, Name,DATENAME(MM, DOO),  datepart(MM, DOO)
	order by datepart(MM, DOO) ASC
-- Product wise number of customers in BR1
	 select PID, count(*) as [Number of Customers], SUM(CBalance)  as [Sum of CBalance]
	 from AccountMaster
	 where BRID = 'BR1'
	 group by PID 
	 having SUM(CBalance) > 2000
-- WHERE clause filters the data before aggregation
-- HAving takes only aggregated functions
-- Alias doesn't work in having clause but for order by
-- Branchwise Total Amount in the month of October in BR1
-- The below is not recommended because having should have aggrgegate functuns only
	Select  BRID, SUM(CBAlance) as [Total Amount]
	from AccountMaster
	group BY BRID
	Having BRID = 'BR1'
---  Creation of permanent table
	Select BRID, SUM(CBAlance) as Total into Branchwisetotalbalance
	from AccountMaster
	where DATEPART(MM,DOO) = 4
	Group by BRID

	Select * from Branchwisetotalbalance
-- LAST YEAR
	Select BRID, SUM(CBAlance) as Total into LastYearlo
	from AccountMaster
	where DATEPART(MM,DOO) in (10,12) and datediff(YY, DOO, GETDATE()) =1 
	Group by BRID

	Select * from LastYearlo
-- LAST YEAR temperoty table
	Select BRID, SUM(CBAlance) as Total into LastYear2023
	from AccountMaster
	where DATEPART(MM,DOO) in (10,12) and datediff(YY, DOO, GETDATE()) =1 
	Group by BRID

	Select * from LastYearlo
--into keyword creates a new table and it will not constraints like old table
-- This creates a table with just the structure
Select * into AM_New from AccountMaster where 1=2
Select * from AM_New
-- Joins: used to retrieve data from more than one table.we can join 255 tables
-- to join tables, we need to have common columns
-- 1. Inner JOin, Outer Join: Left, Right, Full 3. Cross join ( Cartesian product) 4. Self Join
-- Nulls are not comparable
-- Inner joins will give matched data
-- Outer joins gets  matching + umatched data
-- Left outer join: Matched data from left table + unmatached data from left table
-- Right outer join: Matched data from left table + unmatached data from Right table
-- Set A(1,2,3,4,5,Null) B (1,2,3,3,6,7) 
-- Inner join: 1,1  2,2, 3,3, 3,3, 
--Left outer join:  1,1  2,2, 3,3, 3,3, 4, Null, 5, Null, Null, Null
--Right outer join: 1,1  2,2, 3,3, 3,3, Null,6, Null,7, Null, Null
-- Full outer Join : matched data + umatached data from both the tables.
--1,1  2,2, 3,3, 3,3, Null,6, Null,7, Null, Null, 4, Null, 5, Null, Null, Null
-- Syntax: Inner Join
/* two tables
Select *
from T1, T2
where T1.PK = T2. Fk
*/
/* three tables
Select *
from T1, T2, T3
where T1.PK = T2. Fk
AND T3.PK =  T1. FK
Note: When joining n tables, there should be n-1 conditions
in Inner join, you'll see the same number of rows as in foreign key table
*/
	Select * 
	from AccountMaster, TXNMaster
	where AccountMaster. ACID = TXNMaster.ACID

	Select * 
	from AccountMaster inner join TXNMaster
	on AccountMaster. ACID = TXNMaster.ACID
-- Three tables join
	Select * 
	from AccountMaster join TXNMaster
	on AccountMaster. ACID = TXNMaster.ACID
	join ProductMaster
	on ProductMaster. PID = AccountMaster.PID
--Account holders and their product names
	select * from ProductMaster

	Select Name, ProductName
	from AccountMaster join ProductMaster
	on AccountMaster.PID  = ProductMaster. PID
-- Customer Name wise, Txntype wise number of TXNs
	select * from  TXNMaster
	Select name, TXN_TYPE, count(*) as NumberofTXns
	from AccountMaster join TXNMaster
	on AccountMaster.ACID = TXNMaster.ACID
	group by name, TXN_TYPE
-- Customer Name wise, Txntype wise number of TXNs in last year
	Select name, TXN_TYPE, count(*) as NumberofTXns
	from AccountMaster join TXNMaster
	on AccountMaster.ACID = TXNMaster.ACID
	where DATEDIFF(YY,DOT, GETDATE()) = 1
	group by name, TXN_TYPE
-- List names of customers who deposited cash and their product names
	select * from AccountMaster
	Select * from ProductMaster
	Select * from TXNMaster
	Select distinct name, ProductName, TXN_TYPE
	from AccountMaster join TXNMaster
	on AccountMaster.acid = TXNMaster. ACID
	join ProductMaster
	on AccountMaster.PID= ProductMaster.PID
	where TXN_TYPE = 'CD'
--Cutsomers who didn't do any transactions
--  Left outer join: Matched data+ umatched data from AccountMaster
	Select * from
	AccountMaster left join TXNMaster on AccountMaster. ACID = TXNMaster.ACID
--To get only unmatched data, take any column from the second table and say is null. Null is not used with =
	where TXNNo is null
-- If the same column is available in multiple tables, prefix the column name to let it know where to
--pick the column from
-- The below query tells people who opened accounts but haven't done any transactions.
	Select Name, AccountMaster.Acid
	from AccountMaster left join TXNMaster on AccountMaster. ACID = TXNMaster.ACID
	where TXNNo is null
--cross join 
	Select *
	from AccountMaster, TXNMaster
-- Name wise, Txn type wise, number of txns in the last year
	select * from AccountMaster
	Select * from ProductMaster
	Select * from TXNMaster

	Select Name, TXN_TYPE, COUNT(*) AS [Number of Txns Last year]
	from TXNMaster JOIN AccountMaster
	on AccountMaster.ACID = TXNMaster. ACID
	WHERE DATEDIFF(YY, DOT, GETDATE()) = 1
	GROUP BY Name, TXN_TYPE
-- Specific Date/MM/YY use Datepart
-- Last YY/MM?DD use datediff

-- LIst  names of the account holders who deposited cash  and their product names
	Select distinct Name, TXN_TYPE
	from AccountMaster JOIN TXNMaster
	ON AccountMaster.ACID = TXNMaster.ACID
	join ProductMaster
	 on ProductMaster.PID = AccountMaster.PID	
	WHERE TXN_TYPE = 'CD'
	group by Name, TXN_TYPE

-- Self Join
-- List Employee Name and their manager name
	create table EMP
	(
	 EID	Int				Primary key,
	 Name	 varchar(10) 	not null,
	 MID	Int				Null	Foreign key references Emp(EID)
	 )
	 go

	 
		 INSERT INTO EMP (EID, Name, MID) VALUES (1, 'Bill', NULL);
		INSERT INTO EMP (EID, Name, MID) VALUES (2, 'Jane', 1);
		INSERT INTO EMP (EID, Name, MID) VALUES (3, 'John', 1);
		INSERT INTO EMP (EID, Name, MID) VALUES (4, 'Alice', 2);
		INSERT INTO EMP (EID, Name, MID) VALUES (5, 'Bob', 2);
		INSERT INTO EMP (EID, Name, MID) VALUES (6, 'Charlie', 3);
		INSERT INTO EMP (EID, Name, MID) VALUES (7, 'David', 3);
		INSERT INTO EMP (EID, Name, MID) VALUES (8, 'Eve', 4);
		INSERT INTO EMP (EID, Name, MID) VALUES (9, 'Frank', 4);
		INSERT INTO EMP (EID, Name, MID) VALUES (10, 'Grace', 5);
		INSERT INTO EMP (EID, Name, MID) VALUES (11, 'Hank', 5);
		INSERT INTO EMP (EID, Name, MID) VALUES (12, 'Ivy', 6);
		INSERT INTO EMP (EID, Name, MID) VALUES (13, 'Jack', 6);
		INSERT INTO EMP (EID, Name, MID) VALUES (14, 'Ken', 7);
		INSERT INTO EMP (EID, Name, MID) VALUES (15, 'Lily', 7);
		INSERT INTO EMP (EID, Name, MID) VALUES (16, 'Mia', 8);
		INSERT INTO EMP (EID, Name, MID) VALUES (17, 'Nina', 8);
		INSERT INTO EMP (EID, Name, MID) VALUES (18, 'Oscar', 9);
		INSERT INTO EMP (EID, Name, MID) VALUES (19, 'Paul', 9);
		INSERT INTO EMP (EID, Name, MID) VALUES (20, 'Quinn', 10);

	Select * from EMP
	
	Select e1.name as EmpName, E2.Name as BossName
	from emp as e1 left join emp as e2 on e2.eid= e1.mid

-- Self joing: Joining the table with itself
-- It can have inner or outer join
-- You cannot join tables just because they have same column name Instead they should 've primary foreign
-- Key relationship, We need to use union
--Union union combines results of two most select statements it should have same number of column in
--each query, the corresponding columns to be of the same data type duplicates eliminated
--by default unions all the data union all to keep the duplicates

-- LIKE operator
--List the names of the customers whose name starts with 'K'
--'K%' means : First letter has to be K

	Select * from
	AccountMaster
	where name like 'A%'

-- --'_K%' means : Second letter has to be A

	Select * from
	AccountMaster
	where name like '_A%'

-- first letter not A
	Select * from
	AccountMaster
	where name not like 'A%'

-- Last letter is A
	Select * from
	AccountMaster
	where name like '%A'
---- Somewhere it is A
	Select * from
	AccountMaster
	where name like '%A%'
-- Name starts with A and ends with

	Select * from
	AccountMaster
	where name like 'A%A'

-- Is null() function: It returns constant value when the column contains NULL value

	update AccountMaster
	set CBalance = Null
	where ACID =  106

Select Name, ACID, ISNULL(CBalance,0) as CBalance from AccountMaster
Select Name, CBalance from
AccountMaster where CBalance is null 

-- Give Bonus: Increase the CBAlance 0 peopl's account with 1000 
	update AccountMaster
	Set CBalance = ISNULL(Cbalance, 0) +1000

-- Coalesce function : Returns first non null value. If everything is null, you get Nulls
	Select coalesce (Name, PID ) as BalanceNow
	from AccountMaster
-- Any values + Null is NULL
	Select ISNULL(Name,'')+ ISNULL(PID,'') as NamePID
	from AccountMaster

--Substring
	Select substring(Name,2,2) from AccountMaster

--Reverse
	Select Reverse(Name) as Reverssed from AccountMaster
	Select Reverse(substring(Reverse(Name),1,3)) as Reverssed from AccountMaster
--List the names who's balance is between 1000 to 2000
	Select Name, CBALance 
	from AccountMaster
	where CBalance between 1000 and 2000
--List the names who opened accounts between 2020 to 2023
	Select Name, CBALance , DOO
	from AccountMaster
	where DATEPART(YY,DOO) between 2020 And 2023

--Customer Type
	Select ACID,
		   Name,
		   CBalance,
		   Case
				when CBalance <5000						then 'Silver'
				When CBalance between 5000 And 10000	then 'Gold'
				else									'platinum'
			end as CustomerType
	from
		AccountMaster

	Select ACID,
		   Name,
		   CBalance,
		   CUSTYPE=
		   Case
				when CBalance <5000						then 'Silver'
				When CBalance between 5000 And 10000	then 'Gold'
				else									'platinum'
			end
	from
		AccountMaster





  


