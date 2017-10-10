

use leeds
go

set nocount on
go
 
 --Delete HAI custom tables
 if object_id('tempdb..#name_table') is not null drop table #name_table
 if object_id('hai.dt_stormwater_sample_plan') is not null drop table hai.dt_stormwater_sample_plan
 if object_id('hai.dt_sdg_tracking') is not null drop table hai.dt_sdg_tracking
 if object_id('dbo.dt_location_parameter flow_rate 20160908') is not null drop table [dt_location_parameter flow_rate 20160908]
 if object_id('hai.dt_equis_improvement_requests') is not null drop table [hai].[dt_equis_improvement_requests]
  if object_id('dbo.dt_hai_location_details') is not null drop table dbo.dt_hai_location_details
  if object_id('dbo.dt_hai_task_permissions') is not null drop table dbo.dt_hai_task_permissions
  if object_id('dbo.dt_hai_vertical_elevation') is not null drop table dbo.dt_hai_vertical_elevation
  if object_id('dbo.dt_hai_webmap_etl_log') is not null drop table dbo.dt_hai_webmap_etl_log
  if object_id('dbo.rt_hai_apn') is not null drop table dbo.rt_hai_apn
  if object_id('dbo.rt_hai_tef') is not null drop table dbo.rt_hai_tef
  if object_id('dt_hai_lab_file_share_tracking') is not null drop table dt_hai_lab_file_share_tracking
  if object_id('hai_error_msg') is not null drop table hai_error_msg

 create table #name_table  (t_name varchar (100),rec_count int, fac_check varchar (20))


insert into #name_table
select
name, 9999999 ,0 from sys.tables
where left(name,2) = 'dt' or left(name,2) = 'at' or left(name, 2) = 'st'

declare @name varchar (100)

declare @SQL varchar (max)
declare @SQL2 varchar (max)

while (select count(*) from #name_table where rec_count = 9999999) > 0
begin
	 set @name = (select top 1 t_name from #name_table where rec_count = 9999999)
	set @SQL = 'update #name_table ' + char(10)
	 + 'set rec_count = (select count(*) from ' + @name +  ') where t_name = ' + '''' + @name + '''' 

	 --update #name_table set rec_count = 0 where t_name = @name
	 raiserror(@name,0,1) with nowait
	exec( @sql)

end



delete #name_table where t_name = 'at_geo_unit'
delete #name_table where t_name like '%action%'
delete #name_table where t_name like '%person%'
delete #name_table where t_name like '%note%'
While (select count(*) from #name_table where rec_count <> 0 and fac_check = '0') >0
Begin
	set @name = (select top 1 t_name from #name_table where rec_count <> 0 and fac_check = '0')
	set @SQL = 'update #name_table' + char(10) +
	'set fac_check = (select cast(max(facility_id) as varchar )' +  ' + ' + '''' + '/' + '''' + '+' + ' cast(min(facility_id) as varchar) from ' + @name + ' ) where t_name = ' + '''' + @name + '''' 

	print 'sql1 = ' + char(10) + @SQL
	begin try
		exec (@SQL)
		
	end try
	begin catch
		set @SQL2 = 'update #name_table set fac_check = 9999999 where t_name =' + '''' +  @name + ''''
		set @name = 'No facility for: ' + @name
		raiserror( @name,1,0)
		print 'Error sql = ' + char(10) + @sql2
		exec(@SQL2)
	end catch

End

select * from #name_table where rec_count <> 0 order by t_name


