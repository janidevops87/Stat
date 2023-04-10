/******************************************************************************
**		File: CreateAuditTrailPublication.sql
**		Name: CreateAuditTrailPublication
**		Desc: This Script will create the AuditTrail Publications
**		
		
	
	
	@schema_option = 0x00000000000000F1 -- Does not Include Procedures
**		
		
	
	
	@schema_option = 0x00000000000000F3 -- includes Stored Procedures
**              
**		Auth: Bret Knoll
**		Date: 6/4/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/04/07	Bret Knoll			initial	
**    
*******************************************************************************/
-- Enabling the replication database

declare 
	@publisherDbName VARCHAR(100)
	,@description NVARCHAR(500)

SET @publisherDbName  = db_name()
SET @description = 'Transactional publication of StatTrac ' + @publisherDbName

exec master..sp_replicationdboption 
	@dbname = @publisherDbName, 
	@optname = N'publish', 
	@value = N'true'

exec sys.sp_addlogreader_agent 
	@job_login = null 
	,@job_password = null 
	,@publisher_security_mode = 1

exec sys.sp_addqreader_agent 
	@job_login = null 
	,@job_password = null
	,@frompublisher = 1



-- Adding the transactional publication
exec sp_addpublication 
	@publication = N'AuditTrail', 
	@description = @description, 
	@sync_method = N'concurrent', 
	@retention = 0, 
	@allow_push = N'true', 
	@allow_pull = N'true', 
	@allow_anonymous = N'false', 
	@enabled_for_internet = N'false', 
	@snapshot_in_defaultfolder = N'true', 
	@compress_snapshot = N'false', 
	@ftp_port = 21, 
	@ftp_login = N'anonymous', 
	@allow_subscription_copy = N'false', 
	@add_to_active_directory = N'false', 
	@repl_freq = N'continuous', 
	@status = N'active', 
	@independent_agent = N'true', 
	@immediate_sync = N'false', 
	@allow_sync_tran = N'false', 
	@autogen_sync_procs = N'false', 
	@allow_queued_tran = N'false', 
	@allow_dts = N'false', 
	@replicate_ddl = 1, 
	@allow_initialize_from_backup = N'false', 
	@enabled_for_p2p = N'false', 
	@enabled_for_het_sub = N'false'

exec sp_addpublication_snapshot 
	@publication = N'AuditTrail', 
	@frequency_type = 1, 
	@frequency_interval = 0, 
	@frequency_relative_interval = 0, 
	@frequency_recurrence_factor = 0, 
	@frequency_subday = 0, 
	@frequency_subday_interval = 0, 
	@active_start_time_of_day = 0, 
	@active_end_time_of_day = 235959, 
	@active_start_date = 0, 
	@active_end_date = 0, 
	@job_login = null, 
	@job_password = null, 
	@publisher_security_mode = 1

exec sp_grant_publication_access 
	@publication = N'AuditTrail', 
	@login = N'sa'

-- tableName
-- spi
-- spu
-- spd
-- filter
DECLARE 
	@loopCount int, 
	@loopMax int,
	@tableName nvarchar(200),
	@filter nvarchar(4000)
	, @spi nvarchar(4000)
	, @spu nvarchar(4000)
	, @spd nvarchar(4000)
	
DECLARE @ArticleList TABLE
	(
		ID INT IDENTITY(1,1),
		tableName nvarchar(200),
		filter nvarchar(4000)
		
	
	)
	
INSERT @ArticleList 
	values
	('BillTo',  '1 = 2'),
	('Call',  '1 = 2'),
	('CallCustomField',  '1 = 2'),
	('DonorData',  '1 = 2'),
	('FSCase',  '1 = 2'),
	('LogEvent',  '1 = 2'),
	('Message',  '1 = 2'),
	('NOK',  '1 = 2'),
	('Organization',  '1 = 2'),
	('OrganizationAlias',  '1 = 2'),
	('OrganizationASPSetting',  '1 = 2'),
	('OrganizationCaseReview',  '1 = 2'),	
	('OrganizationDashBoardTimer',  '1 = 2'),
	('OrganizationDisplaySetting',  '1 = 2'),
	('OrganizationDuplicateSearchRule',  '1 = 2'),
	('OrganizationFsSourceCode',  '1 = 2'),
	('OrganizationPhone',  '1 = 2'),
	('OrganizationSourceCode',  '1 = 2'),
	('OrganizationStatus',  '1 = 2'),
	('OrganizationType',  '1 = 2'),	
	('Person',  '1 = 2'),
	('QAErrorLocation',  '1 = 2'),
	('QAErrorLog',  '1 = 2'),
	('QAErrorLogHowIdentified',  '1 = 2'),
	('QAErrorStatus',  '1 = 2'),
	('QAErrorType',  '1 = 2'),
	('QALogos',  '1 = 2'),
	('QAMonitoringForm',  '1 = 2'),
	('QAMonitoringFormTemplate',  '1 = 2'),
	('QAProcessStep',  '1 = 2'),
	('QATracking',  '1 = 2'),
	('QATrackingForm',  '1 = 2'),
	('QATrackingFormErrors',  '1 = 2'),
	('QATrackingStatus',  '1 = 2'),
	('QATrackingType',  '1 = 2'),
	('Referral',  '1 = 2'),
	('ReferralSecondaryData',  '1 = 2'),
	('RegistryStatus',  '1 = 2'),
	('ReportRule',  '1 = 2'),
	('Roles',  '1 = 2'),
	('Secondary',  '1 = 2'),
	('Secondary2',  '1 = 2'),
	('SecondaryApproach',  '1 = 2'),
	('SecondaryDisposition',  '1 = 2'),
	('SecondaryMedication',  '1 = 2'),
	('SecondaryMedicationOther',  '1 = 2'),
	('SecondaryTBI',  '1 = 2'),	 
	-- ('SourceCodeASP',  '1 = 2'),	 
	-- ('SourceCodeTransplantCenter',  '1 = 2'),
	-- ('SourceCodeType',  '1 = 2'),
	('SourceCode',  '1 = 2'), 
	('SourceCodeOrganization',  '1 = 2'),
	('WebReportGroup',  '1 = 2'),
	('WebReportGroupOrg',  '1 = 2'),
	('WebReportGroupSourceCode',  '1 = 2'),
	('UserRoles',  '1 = 2'),
	('WebPerson',  '1 = 2')
	



SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM @ArticleList

-- SELECT * FROM SYSCOLUMNS WHERE name = 'caseid'

--select * from funeralhome 
WHILE (@loopCount <= @loopMax)
BEGIN

	SELECT 
		@tableName = tableName,
		@filter = filter
		, @spi = N'CALL spi_Audit_' + tableName
		, @spu = N'CALL spd_Audit_' + tableName
		, @spd = N'MCALL spu_Audit_' + tableName
	FROM 
		@ArticleList
	WHERE
		ID = @loopCount


-- Adding the transactional articles
exec sp_addarticle 
	@publication = N'AuditTrail', 
	@article = @tableName, 
	@source_owner = N'dbo', 
	@source_object = @tableName, 
	@destination_table = @tableName, 
	@type = N'logbased', 
	@creation_script = null, 
	@description = null, 
	@pre_creation_cmd = N'none', 
	@schema_option = 0x00000000000000F1, -- 0x00000000080110CB, -- 0x00000000080110CB, -- 0x00000000000000A1, -- 0x00000000000000E1, 
	@identityrangemanagementoption = N'none', 
	@status = 8, 
	@vertical_partition = N'false', 
	@ins_cmd = @spi, 
	@del_cmd = @spu, 
	@upd_cmd = @spd, 
	@filter = null, 
	@sync_object = null, 	
	@filter_clause = @filter

	
	SET @loopCount = @loopCount + 1
END

GO

