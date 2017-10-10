use equis
go

set nocount on
go


/*Inserts data from one facility table to another*/

declare @new_fac int =3400513
declare @facility_id varchar(10) = '29'
declare @table_name varchar (100) = 'dt_water_level'


/*get the column names of the target/source table*/
declare @t table (name varchar (100))
insert into @t
select name from sys.columns
where object_id = 
(select object_id from sys.tables where name = @table_name)
delete @t where name = 'euid'



/*create a concatenated comma-separated list of column names for use in a query*/
declare @list varchar (max)

	SELECT @list =  ISNULL(@list,'') + name + char(10) + ',' 
	FROM @t

	set @list = (select left(@list,len(@list)-1))



declare @sql1 varchar (max)
declare @name varchar (100)

/*build the insert query */
set @sql1 = 
	'INSERT into ' + @table_name + '(' + char(10) +  @list + ')' + char(10) +
	'SELECT ' + char(10) + replace(@list,'facility_id',cast(@new_fac as varchar(20)) )  --<<replace the facility_id in the insert 'from' list
	+ char(10) + 
	'FROM ' + @table_name + char(10) +
	'WHERE  facility_id = ' +  @facility_id +   char(10)

	print @sql1


/***ATTENTIION!! *****uncomment this when ready to insert data*****************************/
	--exec(@sql1)


	/*see the target table after insert*/
	exec('Select * from ' + @table_name + ' where  facility_id = ' + @new_fac)




