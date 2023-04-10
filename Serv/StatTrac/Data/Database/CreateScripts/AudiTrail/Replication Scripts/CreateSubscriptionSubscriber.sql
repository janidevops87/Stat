--:setvar Distributor 'st-devsql-2'
--:setvar Publisher 'st-devsql-2'
--:setvar Subscriber 'st-devsql-2'
--:setvar TransactionDb 'ReferralTest'
--:setvar AuditTrailDb '_ReferralAuditTrail'
--:setvar DistribtorLogin NULL
--:setvar DistributorPassword	NULL

PRINT '----------------------------------- AuditTrail Create Subscription: ' + $(TransactionDb) + ' -----------------------------------'
DECLARE 
	@publication NVARCHAR(100)		= N'AuditTrail',	
	@subscriber NVARCHAR(100)		= $(Subscriber),
	@destination_db NVARCHAR(100)	= $(AuditTrailDb),
	@publisher_db NVARCHAR(100)		= $(TransactionDb),
	@sync_type NVARCHAR(100)		= 'automatic',
	@subscription_type NVARCHAR(100)= N'pull',
	@update_mode  NVARCHAR(100)		= N'read only',
	@publisher NVARCHAR(100)		= $(Publisher),			
	@independent_agent NVARCHAR(100)= N'True'		 ,	
	@description NVARCHAR(100)		= N'', 	
	@immediate_sync NVARCHAR(100)	= N'0',
	@distributor NVARCHAR(100)		= $(Distributor),
	@distributor_security_mode int,	
	@distributor_login NVARCHAR(100)= $(DistribtorLogin),		
	@distributor_password NVARCHAR(100)	= $(DistributorPassword)

	--DECLARE 
	--	@publication NVARCHAR(100)		,	
	--	@subscriber NVARCHAR(100)		,
	--	@destination_db NVARCHAR(100)	,
	--	@publisher_db NVARCHAR(100)	,
	--	@sync_type NVARCHAR(100)		,
	--	@subscription_type NVARCHAR(100),
	--	@update_mode  NVARCHAR(100)		,
	--	@publisher NVARCHAR(100)		,			
	--	@independent_agent NVARCHAR(100),	
	--	@description NVARCHAR(100)		, 	
	--	@immediate_sync NVARCHAR(100)	,
	--	@distributor NVARCHAR(100)		,
	--	@distributor_security_mode int,	
	--	@distributor_login NVARCHAR(100),		
	--	@distributor_password NVARCHAR(100)	
	

IF @distributor_password IS NULL 
BEGIN
	SET @distributor_security_mode= 1
END
ELSE
BEGIN
	SET @distributor_security_mode = 0
END

EXEC sp_addpullsubscription 
	@publisher =			@publisher,
	@publication =			@publication, 
	@publisher_db =			@publisher_db , 
	@independent_agent =	@independent_agent, 
	@subscription_type =	@subscription_type, 
	@description =			@description , 
	@update_mode =			@update_mode , 
	@immediate_sync =		@immediate_sync 

-- Create Pull Subscription Agent
EXEC sp_addpullsubscription_agent 
	@publisher					= @publisher,
	@publisher_db				= @publisher_db, 
	@publication				= @publication ,
	@distributor				= @distributor, 
	@distributor_security_mode	= @distributor_security_mode, 
	@distributor_login			= @distributor_login, 
	@distributor_password		= @distributor_password, 
	@enabled_for_syncmgr		= N'False', 
	@frequency_type				= 64, 
	@frequency_interval			= 0, 
	@frequency_relative_interval = 0, 
	@frequency_recurrence_factor = 0, 
	@frequency_subday			= 0, 
	@frequency_subday_interval	= 0, 
	@active_start_time_of_day	= 0, 
	@active_end_time_of_day		= 235959, 
	@active_start_date			= 20080819, 
	@active_end_date			= 99991231, 
	@alt_snapshot_folder		= N'', 
	@working_directory			= N'', 
	@use_ftp					= N'False', 
	@job_login					= null, 
	@job_password				= null, 
	@publication_type			= 0
