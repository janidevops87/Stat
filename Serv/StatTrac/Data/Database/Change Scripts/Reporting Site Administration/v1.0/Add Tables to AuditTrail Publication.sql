/******************************************************************************
**		File: Add Tables to AuditTrail Publication.sql
**		Desc: Add new tables to the AuditTrail Publication. These tables will track changes to Users (Person, WebPerson) and Roles
**
	@schema_option = 0x00000000000000F1 -- Does not Include Procedures
**		
	@schema_option = 0x00000000000000F3 -- includes Stored Procedures
**
**		Auth: Bret Knoll
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------	
**		11/12/07	Bret Knoll			initial
**    
*******************************************************************************/ 
use master
GO

exec sp_replicationdboption 
	@dbname = N'_ReferralProd', 
	@optname = N'publish', 
	@value = N'true'
GO

use [_ReferralProd]
GO

-- Adding the transactional publication
exec sp_addpublication 
	@publication = N'AuditTrail2', 
	@restricted = N'false', 
	@sync_method = N'native', 
	@repl_freq = N'continuous', 
	@description = N'Transactional publication of _ReferralProd database from Publisher ST-DTDEVSVR.', 
	@status = N'active', 
	@allow_push = N'true', 
	@allow_pull = N'true', 
	@allow_anonymous = N'false', 
	@enabled_for_internet = N'false', 
	@independent_agent = N'false', 
	@immediate_sync = N'false', 
	@allow_sync_tran = N'false', 
	@autogen_sync_procs = N'false', 
	@retention = 336, 
	@allow_queued_tran = N'false', 
	@snapshot_in_defaultfolder = N'true', 
	@compress_snapshot = N'false', 
	@ftp_port = 21, 
	@ftp_login = N'anonymous', 
	@allow_dts = N'false', 
	@allow_subscription_copy = N'false', 
	@add_to_active_directory = N'false', 
	@logreader_job_name = N'ST-DTDEVSVR-_ReferralProd-11'
exec sp_addpublication_snapshot 
	@publication = N'AuditTrail2',
	@frequency_type = 4, 
	@frequency_interval = 1, 
	@frequency_relative_interval = 1, 
	@frequency_recurrence_factor = 0, 
	@frequency_subday = 8, 
	@frequency_subday_interval = 1, 
	@active_start_date = 0, 
	@active_end_date = 0, 
	@active_start_time_of_day = 0, 
	@active_end_time_of_day = 235959, 
	@snapshot_job_name = N'ST-DTDEVSVR-_ReferralProd-AuditTrail2-12'
GO

exec sp_grant_publication_access 
	@publication = N'AuditTrail2', 
	@login = N'BUILTIN\Administrators'
GO
exec sp_grant_publication_access 
	@publication = N'AuditTrail2', 
	@login = N'distributor_admin'
GO
exec sp_grant_publication_access 
	@publication = N'AuditTrail2', 
	@login = N'DOGGY\Administrator'
GO

exec sp_grant_publication_access 
	@publication = N'AuditTrail2', 
	@login = N'sa'
GO

exec sp_addarticle 
	@publication = N'AuditTrail2', 
	@article = N'Roles', 
	@source_owner = N'dbo', 
	@source_object = N'Roles', 
	@destination_table = N'Roles', 
	@type = N'logbased', 
	@creation_script = null, 
	@description = null, 
	@pre_creation_cmd = N'none', 
	@schema_option = 0x00000000000000F1, 
	@status = 0, 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL spi_Audit_Roles', 
	@del_cmd = N'CALL spd_Audit_Roles', 
	@upd_cmd = N'MCALL spu_Audit_Roles', 
	@filter = null, 
	@sync_object = null, 
	@auto_identity_range = N'false', 
	@filter_clause = N'RoleID > (select Max(MaxID) from AuditTrailStatus ats
join AuditTrailTable att on att.AuditTrailTableID = ats.AuditTrailTableID
where att.AuditTrailTableName = ''Roles''
)'
GO

exec sp_addarticle 
	@publication = N'AuditTrail2', 
	@article = N'UserRoles', 
	@source_owner = N'dbo', 
	@source_object = N'UserRoles', 
	@destination_table = N'UserRoles', 
	@type = N'logbased', 
	@creation_script = null, 
	@description = null, 
	@pre_creation_cmd = N'none', 
	@schema_option = 0x00000000000000F1, 
	@status = 0, 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL spi_Audit_UserRoles', 
	@del_cmd = N'CALL spd_Audit_UserRoles', 
	@upd_cmd = N'MCALL spu_Audit_UserRoles', 
	@filter = null, 
	@sync_object = null, 
	@auto_identity_range = N'false', 
	@filter_clause = N'WebPersonID = WebPersonID'
GO

exec sp_addarticle 
	@publication = N'AuditTrail2', 
	@article = N'WebPerson', 
	@source_owner = N'dbo', 
	@source_object = N'WebPerson', 
	@destination_table = N'WebPerson', 
	@type = N'logbased', 
	@creation_script = null, 
	@description = null, 
	@pre_creation_cmd = N'none', 
	@schema_option = 0x00000000000000F1, 
	@status = 0, 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL spi_Audit_WebPerson', 
	@del_cmd = N'CALL spd_Audit_WebPerson', 
	@upd_cmd = N'MCALL spu_Audit_WebPerson', 
	@filter = null, 
	@sync_object = null, 
	@auto_identity_range = N'false', 
	@filter_clause = N'WebPersonID > (select Max(MaxID) from AuditTrailStatus ats
join AuditTrailTable att on att.AuditTrailTableID = ats.AuditTrailTableID
where att.AuditTrailTableName = ''WebPerson''
)'
GO

exec sp_addarticle 
	@publication = N'AuditTrail2', 
	@article = N'ReportRule', 
	@source_owner = N'dbo', 
	@source_object = N'ReportRule', 
	@destination_table = N'ReportRule', 
	@type = N'logbased', 
	@creation_script = null, 
	@description = null, 
	@pre_creation_cmd = N'none', 
	@schema_option = 0x00000000000000F1, 
	@status = 0, 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL spi_Audit_ReportRule', 
	@del_cmd = N'CALL spd_Audit_ReportRule', 
	@upd_cmd = N'MCALL spu_Audit_ReportRule', 
	@filter = null, 
	@sync_object = null, 
	@auto_identity_range = N'false', 
	@filter_clause = N'ReportRuleID > (select Max(MaxID) from AuditTrailStatus ats
join AuditTrailTable att on att.AuditTrailTableID = ats.AuditTrailTableID
where att.AuditTrailTableName = ''ReportRule''
)'
GO
