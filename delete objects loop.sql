
use leeds
go

set nocount on
go

Declare @ErrorMsg varchar (1000)
--*********************************************************************************
/*Delete Custom Functions*/
if object_id('v533.analytical_results_HaleyAldrich')  is not null
	drop function v533.analytical_results_HaleyAldrich
if object_id('rpt.fn_thousands_separator')  is not null
	drop function rpt.fn_thousands_separator
if object_id('hai.fn_thousands_separator')  is not null
	drop function hai.fn_thousands_separator
if object_id('rpt.fn_List')  is not null
	drop function rpt.fn_List
if object_id('rpt.GIS_Pad_Columns')  is not null
	drop function rpt.GIS_Pad_Columns
if object_id('rpt.trim_zeros')  is not null
	drop function rpt.trim_zeros
if object_id('hai.fn_ADD_WORKING_DAYS')  is not null
	drop function hai.fn_ADD_WORKING_DAYS


if object_id('tempdb..#t') is not null drop table #t
create table #t (name varchar (200))

insert into #t

select '[' +s.name + ']' +'.[' + o.name + ']'
 FROM sys.objects o
 inner join sys.schemas s on o.schema_id = s.schema_id
WHERE RIGHT(type_desc, 8) = 'function'
and (o.name like '%hai%' )


declare @name varchar (200)
declare @name2 varchar (200)
declare @SQL  varchar (max)

while (select count(*) from #t where name like '%rpt%') > 0
begin
	set @name = (select top 1 name from #t where name like '%rpt%')
	print @name

		set @SQL = 'if object_id (' + ''''+  @name  + '''' + ') is not null 
		drop function '  +   @name  

	exec (@SQL)
	--print(@sql)
	delete #t where name = @name

end

while (select count(*) from #t where name like '%hai%') > 0
begin
	set @name = (select top 1 name from #t where name like '%hai%')
	print 'Function ' +  @name

	
		set @SQL = 'if object_id (' + ''''+  @name  + '''' + ') is not null 
		drop function '  +   @name  

	exec (@SQL)
	--print(@sql)
	delete #t where replace(replace(name,']',''),'[','') like replace(replace(@name,']',''),'[','')

end

while (select count(*) from #t where name like '%dbo%') > 0
begin
	set @name = (select top 1 name from #t where name like '%dbo%')
	print 'Function ' +  @name

	
		set @SQL = 'if object_id (' + ''''+   @name  + '''' + ') is not null 
		drop function '  +   @name  

	exec (@SQL)
	--print(@sql)
	delete #t where replace(replace(name,']',''),'[','') like replace(replace(@name,']',''),'[','')

end


--****************************************************************************
/*Delete Custom Procedures*/

if object_id('v54.Analytical_Results_Summary_HAI_OLD') is not null drop procedure v54.Analytical_Results_Summary_HAI_OLD
if object_id ('v54.Analytical_Results_Summary_HAI') is not null drop procedure v54.Analytical_Results_Summary_HAI
if object_id ('Analytical_Results_Action_Level_Dots') is not null drop procedure Analytical_Results_Action_Level_Dots
if object_id ('Analytical_Results_Action_Level_Screen') is not null drop procedure Analytical_Results_Action_Level_Screen
if object_id ('Analytical_Results_w_Parameters') is not null drop procedure Analytical_Results_w_Parameters
if object_id ('Analytical_Results_w_Parameters_1_1_5') is not null drop procedure Analytical_Results_w_Parameters_1_1_5
if object_id ('Analytical_Results_w_Parameters_1_1_6') is not null drop procedure Analytical_Results_w_Parameters_1_1_6
if object_id ('Analytical_Results_w_Parameters20130107') is not null drop procedure Analytical_Results_w_Parameters20130107
if object_id ('sp_GEI_Get_FKs') is not null drop procedure sp_GEI_Get_FKs
if object_id ('Update_GM_Defiance_Data') is not null drop procedure Update_GM_Defiance_Data

if object_id ('hai.sp_project_tracking') is not null DROP PROCEDURE [HAI].[sp_project_tracking]
if object_id ('hai.sp_Sample_Received_Status') is not null DROP PROCEDURE [HAI].[sp_Sample_Received_Status]
if object_id ('hai.sp_review_method_group_members') is not null DROP PROCEDURE [HAI].[sp_review_method_group_members]
if object_id ('hai.sp_update_sample_tracking') is not null DROP PROCEDURE [HAI].[sp_update_sample_tracking]
if object_id ('hai.sp_samples_wNo_sys_loc_code') is not null DROP PROCEDURE [HAI].[sp_samples_wNo_sys_loc_code]

if object_id ('rpt.sp_database_QC') is not null drop procedure rpt.sp_database_QC
if object_id ('rpt.sp_Get_EQuIS_Results_w_ALs') is not null drop procedure rpt.sp_Get_EQuIS_Results_w_ALs
if object_id ('rpt.sp_samples_wNo_sys_loc_code') is not null drop procedure rpt.sp_samples_wNo_sys_loc_code
if object_id ('rpt.sp_Get_EQuIS_Results_w_ALs_test') is not null drop procedure rpt.sp_Get_EQuIS_Results_w_ALs_test
if object_id ('rpt.sp_Get_EQuIS_Results_w_ALs_location_params_test') is not null drop procedure rpt.sp_Get_EQuIS_Results_w_ALs_location_params_test



if object_id ('v54.Analytical_Results_HaleyAldrich') is not null drop procedure v54.Analytical_Results_HaleyAldrich
if object_id ('v54.Analytical_Results_HaleyAldrich_FiltPrototype') is not null drop procedure v54.Analytical_Results_HaleyAldrich_FiltPrototype
if object_id ('v54.GoogleEarth_Analytical_Results_HaleyAldrich') is not null drop procedure v54.GoogleEarth_Analytical_Results_HaleyAldrich

if object_id ('hai.sp_Get_EQuIS_Results_w_ALs_test_DHC') is not null drop procedure hai.sp_Get_EQuIS_Results_w_ALs_test_DHC
if object_id ('hai.sp_Get_EQuIS_Results_w_ALs_test') is not null drop procedure hai.sp_Get_EQuIS_Results_w_ALs_test
if object_id ('hai.sp_Get_EQuIS_Results_w_ALs_test2') is not null drop procedure hai.sp_Get_EQuIS_Results_w_ALs_test2
if object_id ('hai.sp_gis_labels') is not null drop procedure hai.sp_gis_labels

delete #t
insert into #t

select '[' +s.name + ']' +'.[' + o.name + ']'
 FROM sys.objects o
 inner join sys.schemas s on o.schema_id = s.schema_id
WHERE RIGHT(type_desc, 9) = 'procedure'
and (o.name like '%hai%' )



while (select count(*) from #t name where name like '%rpt%') > 0
begin
	set @name = (select top 1 name from #t where name like '%rpt%')
	
	print 'Procedure ' + @name

		set @SQL = 'if object_id (' + ''''+  @name  + '''' + ') is not null ' + char(10) +
		'begin ' + char(10) +
		'drop procedure ' +    @name  +  char(10) +
		 'end'

	exec (@SQL)
	--select * from #t where replace(replace(name,']',''),'[','') like replace(replace(@name,']',''),'[','') 
	delete #t where replace(replace(name,']',''),'[','') like replace(replace(@name,']',''),'[','')
	--print(@sql)
	
end

while (select count(*) from #t where name like '%hai%') > 0
begin
	set @name = (select top 1 name from #t where name like '%hai%')
	--print @name

	
		set @SQL = 'if object_id (' + ''''+  @name  + '''' + ') is not null'  + char(10) +
		'begin ' + char(10) +
		'drop procedure '  +  @name  + char(10) +
		 'end'

	exec (@SQL)
	delete #t where replace(replace(name,']',''),'[','') like replace(replace(@name,']',''),'[','')
    --print(@sql)
	

end
while (select count(*) from #t where name like '%dbo%') > 0
begin
	set @name = (select top 1 name from #t where name like '%dbo%')
	print @name

	
		set @SQL = 'if object_id (' + '''' +   @name  + '''' + ') is not null '+ char(10) +
		'begin ' + char(10) +
		'drop procedure '  +   @name  +  char(10) +
		 'end'

	exec (@SQL)
	delete #t where replace(replace(name,']',''),'[','') like replace(replace(@name,']',''),'[','')
	--print(@sql)
	

end

select * from #t

--*************************************************
/*Drop Views*/

if object_id ('vw_HAI_Coordinate') is not null drop view vw_HAI_Coordinate
if object_id ('vw_HAI_Phillips_Lighting') is not null drop view vw_HAI_Phillips_Lighting
if object_id ('rpt.vw_HAI_GIS_PGE_GW_Naph_DRO_MO') is not null drop view rpt.vw_HAI_GIS_PGE_GW_Naph_DRO_MO
if object_id ('rpt.vw_HAI_GIS_test_fillmore') is not null drop view rpt.vw_HAI_GIS_test_fillmore
if object_id ('vw_PSEG-MTB_samples') is not null drop view [vw_PSEG-MTB_samples]

--**************************************************

	begin try
		if object_id ('[rpt]') is not null
		DROP SCHEMA [rpt]
		raiserror ('Schema [rpt] dropped',0,1) with nowait
	end try
	begin catch
		raiserror ('Schema [rpt] not found',0,1) with nowait
	end catch

	begin try
		if object_id('[hai]') is  not null
		DROP SCHEMA [HAI]
		raiserror ('Schema [hai] dropped',0,1) with nowait
	end try
	begin catch
		raiserror ('Schema [hai] not found',0,1) with nowait
	end catch

/*Drop Custom Roles*/
		DECLARE @RoleName sysname


		Declare @t table (role_name varchar(100))
		insert into @t
		select 'eq_rt_lock'
		union
		select 'eq_st_lock'
		union
		select 'eq_tierra'
		union
		select 'eq_reports'

		While (select count(*) from @t) > 0
		begin
			set @RoleName = (select top 1 role_name from @t)

			IF @RoleName <> N'public' and (select is_fixed_role from sys.database_principals where name = @RoleName) = 0
			BEGIN
				DECLARE @RoleMemberName sysname
				DECLARE Member_Cursor CURSOR FOR
				select [name]
				from sys.database_principals 
				where principal_id in ( 
					select member_principal_id
					from sys.database_role_members
					where role_principal_id in (
						select principal_id
						FROM sys.database_principals where [name] = @RoleName AND type = 'R'))

				OPEN Member_Cursor;

				FETCH NEXT FROM Member_Cursor
				into @RoleMemberName
	
				DECLARE @SQLROLE NVARCHAR(4000)

				WHILE @@FETCH_STATUS = 0
				BEGIN
		
					SET @SQLROLE = 'ALTER ROLE '+ QUOTENAME(@RoleName,'[') +' DROP MEMBER '+ QUOTENAME(@RoleMemberName,'[')
					EXEC(@SQLROLE)
		
					FETCH NEXT FROM Member_Cursor
					into @RoleMemberName
				END;

				CLOSE Member_Cursor;
				DEALLOCATE Member_Cursor;
			END
			/****** drop role ******/
		if (select count(*) From sys.database_principals where name = @rolename) > 0  
			begin 
				exec('DROP ROLE ' + @rolename)
				set @ErrorMsg = @rolename + ' Dropped...'
				raiserror (@errormsg,0,1) with nowait
			end

			delete @t where role_name = @rolename
		end
		

/*Drop Users*/
 --DROP USER [HALEYALDRICH\Adm_ctd]
 --DROP USER [HALEYALDRICH\DMAP Read Only]
 --DROP USER [HALEYALDRICH\sppsapp]
 --DROP USER [HALEYALDRICH\SQLAdministrators]
 --DROP USER [HA_User]
 --DROP USER HA_Tierra
 --DROP USER HA_Database_MGR
 --DROP USER HA_Database_Admin
 --DROP USER HA_Client
 --DROP USER eq5service
 --DROP USER eqservice






