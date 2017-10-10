use leeds
go

set nocount on
go

declare @facility_id int = 84

IF OBJECT_ID('hai.dt_sdg_tracking') IS NOT NULL drop table hai.dt_sdg_tracking
if object_id('dt_hai_stormwater_sample_plan') is not null drop table dt_hai_stormwater_sample_plan
if object_id('hai.report_logging') is not null drop table hai.report_logging
if object_id('rpt.rt_tef') is not null drop table rpt.rt_tef
if object_id('hai_dt_sample_codes') is not null drop table hai_dt_sample_codes
if object_id('hai_rt_sample_status_codes') is not null drop table hai_rt_sample_status_codes
if object_id('hai_temp_users') is not null drop table hai_temp_users
if object_id('hai_wqx_project_identifier') is not null drop table hai_wqx_project_identifier
if object_id('dt_hai_sample_tracking') is not null drop table dt_hai_sample_tracking
if object_id('dbo.dt_hai_location_details') is not null drop table dbo.dt_hai_location_details
if object_id('dbo.dt_hai_task_permissions') is not null drop table dbo.dt_hai_task_permissions
if object_id('dbo.dt_hai_vertical_elevation') is not null drop table dbo.dt_hai_vertical_elevation
if object_id('dbo.dt_hai_webmap_etl_log') is not null drop table dbo.dt_hai_webmap_etl_log
if object_id('dbo.rt_hai_apn') is not null drop table dbo.rt_hai_apn
if object_id('dbo.rt_hai_tef') is not null drop table dbo.rt_hai_tef
if object_id('dbo.dt_sample_parameter_backup') is not null drop table dbo.dt_sample_parameter_backup
if object_id('dbo.dt_sample_parameter_backup2') is not null drop table dbo.dt_sample_parameter_backup2
if object_id ('rt_hai_elev_reference') is not null drop table rt_hai_elev_reference
if object_id ('rt_hai_permissions') is not null drop table rt_hai_permissions

--used try-catch because object_id for HAI-Potr.2016.01Sed.SDSEDD because its not recognized by object_id method
	begin try
		drop table [dbo].[HAI-Potr.2016.01Sed.SDSEDD]
	end try
	begin catch
		print 'HAI-Potr.2016.01Sed.SDSEDD not present or ERROR occured'
	end catch



delete dbo.st_user_facility_EQ5
delete dbo.st_file_registration

delete dt_result_qc where facility_id not in (select @facility_id)
	raiserror ('dt_result_qc',0,1) with nowait

delete dt_result_parameter where facility_id not in (select @facility_id)
	raiserror ('dt_result_parameter',0,1) with nowait
	
delete dt_result where facility_id not in (select @facility_id)
	raiserror ('dt_result',0,1) with nowait
		
		
delete dt_action_level_parameter 
from dt_action_level_parameter alp inner join dt_action_level al on alp.action_level_code = al.action_level_code
where facility_id not in (select @facility_id) or facility_id is null
	raiserror ('dt_action_level_parameter',0,1) with nowait
		
delete dt_action_level where facility_id not in (select @facility_id) or facility_id is null
	raiserror ('dt_action_level',0,1) with nowait

delete at_test_batch_assign where facility_id not in (select @facility_id)
	raiserror ('at_test_batch_assign',0,1) with nowait
		
delete dt_test_batch where facility_id not in (select @facility_id)
	raiserror ('dt_test_batch',0,1) with nowait


delete dt_test  where facility_id not in (select @facility_id)
	raiserror ('dt_test',0,1) with nowait
		
delete dt_coordinate where facility_id not in (select @facility_id)
	raiserror ('dt_coordinate',0,1) with nowait

delete dt_water_level where facility_id not in (select @facility_id)
	raiserror ('dt_water_level',0,1) with nowait

delete dt_well_segment where facility_id not in (select @facility_id)
	raiserror ('dt_well_segment',0,1) with nowait

delete dt_product_thickness where facility_id not in (select @facility_id)
	raiserror ('dt_product_thickness',0,1) with nowait

delete dt_purge where facility_id not in (select @facility_id)
	raiserror ('dt_purge',0,1) with nowait
	
delete dt_well where facility_id not in (select @facility_id)
	raiserror ('dt_well',0,1) with nowait

delete dt_lithology where facility_id not in (select @facility_id)
	raiserror ('dt_lithology',0,1) with nowait

delete dt_precipitation where facility_id not in (select @facility_id)
	raiserror ('dt_precipitation',0,1) with nowait

delete dt_measure_datum where facility_id not in (select @facility_id)
	raiserror ('dt_measure_datum',0,1) with nowait

delete dt_purge  where facility_id not in (select @facility_id)
	raiserror ('dt_purge',0,1) with nowait	

delete dt_permit  where facility_id not in (select @facility_id)
	raiserror ('dt_permit',0,1) with nowait	

delete dt_collect_proc  
	raiserror ('dt_collect_proc',0,1) with nowait	
		
delete dt_person 
	raiserror ('dt_person',0,1) with nowait

delete dt_note
	raiserror ('dt_note',0,1) with nowait

delete dt_precipitation where facility_id not in (select @facility_id)
	raiserror ('dt_precipitation',0,1) with nowait

delete dbo.dt_fieldqc_batch_partner
	raiserror('dbo.dt_fieldqc_batch_partner',0,1) with nowait

delete dt_field_sample where facility_id not in (select @facility_id)
	raiserror ('dt_field_sample',0,1) with nowait

delete dt_sdg  where facility_id not in (select @facility_id)
	raiserror ('dt_sdg',0,1) with nowait

delete dt_file
	raiserror ('dt_file',0,1) with nowait

delete dt_fieldqc_batch_partner
	raiserror ('dt_fieldqc_batch_partner',0,1) with nowait

delete dt_sample_parameter where facility_id not in (select @facility_id)
	raiserror ('dt_sample_parameter',0,1) with nowait


delete dt_sample  where facility_id not in (select @facility_id)
	raiserror ('dt_sample',0,1) with nowait

delete dt_location_parameter where facility_id not in (select @facility_id)
	raiserror ('dt_location_parameter',0,1) with nowait

delete dbo.at_subfacility_location where facility_id not in (select @facility_id)
	raiserror ('dbo.at_subfacility_location', 0,1) with nowait

delete dt_location where facility_id not in (select @facility_id)
	raiserror ('dt_location',0,1) with nowait


delete dt_subfacility where facility_id not in (select @facility_id)
	raiserror ('dt_subfacility',0,1) with nowait


delete dt_phase where facility_id not in (select @facility_id)
	raiserror ('dt_phase',0,1) with nowait

delete dt_chain_of_custody  where facility_id not in (select @facility_id)
	raiserror ('dt_chain_of_custody',0,1) with nowait

delete dt_task where facility_id not in (select @facility_id)
	raiserror('dt_task',0,1) with nowait

delete dt_sample_plan where facility_id not in (select @facility_id)
	raiserror('dt_sample_plan',0,1) with nowait

delete dt_equipment where facility_id not in (select @facility_id)
	raiserror('dt_equipment',0,1) with nowait

delete dt_facility where facility_id not in (select @facility_id)
	raiserror ('dt_facility',0,1) with nowait

/**Delete System Tables**/
delete st_report_event_recipient
delete st_report_task
delete st_report_event
delete st_user_report_parameter
delete st_user_report
delete st_report_use
delete st_notice
delete  st_notice_template where template_code like 'Widget%'
delete st_config  where config_key not like '%version'
delete st_edd_batch 
where ebatch not  in (
select ebatch from dt_sample where facility_id = @facility_id union select ebatch from dt_result where facility_id = @facility_id)

/**Delete report records**/
Delete st_report where report_type = 'xtab'
Delete st_report where report_type = 'xtabgrid'
Delete st_report where report_type = 'class'
delete st_report where report_type = 'proc' and report_name not in (select name from sys.procedures)
Delete st_report where report_Type = 'func' and report_name not in (SELECT name FROM sys.objects WHERE type IN ('FN', 'IF', 'TF') )

Print 'Table Deletes Done'



		
