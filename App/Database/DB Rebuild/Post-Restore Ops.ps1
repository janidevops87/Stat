# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

If ((Get-InstalledModule -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Install-Module SqlServer -Scope CurrentUser -AllowClobber -ErrorAction Stop -Force
}

If ((Get-Module -ListAvailable -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Import-Module SqlServer -ErrorAction Stop
}

# Post-restore operations
# Note - This may need another set of creds to run AT ops if AT isn't on the same server as txnl at some point
Function PostRestore {
    [CmdletBinding()]
    param($Server, $Database, $AuditTrailServer, $AuditTrailDatabase, $DbLogins, $AuditTrailUser, $QueryUsername, $QueryPassword)

    Write-Host "Beginning post-restore ops on $Server\$Database...`n"

    if ($Database -eq "_ReferralTraining" -and $Server -like "*sqlrpt*") {
        # From Give StatTracAdmin Access.sql
        Write-Host "Creating/updating DB users..."
        CreateUpdateDbUsers -DbLogins $DbLogins -Server $Server -Database $Database -QueryUsername $QueryUsername -QueryPassword $QueryPassword -ErrorAction Stop
        Write-Host "Created/updated DB users`n"

        # From PostMountScript.sql
        Write-Host "Removing replication..."
        $query = "
	    EXEC sp_removedbreplication @dbname = '$Database';

	    INSERT INTO GeneralAlert(GeneralAlertExpires, GeneralAlertOrg, GeneralAlertMessage, PersonID, LastModified, OrganizationID)
		    VALUES ('12/31/2029', 'Statline', 'This is the $Database on $Server! Created: ' + CONVERT(VARCHAR(20), GETDATE(), 100), 3505, GETDATE(), 194);

	    UPDATE CALL
		    SET CallOpenByID = -1
		    WHERE CallOpenById <> -1;

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Removed replication`n"

        # From StatTracNotForProduction.sql
        Write-Host "Performing misc other tasks..."
        $query = "
        UPDATE [dbo].PersonPhone
	        SET [PhoneAlphaPagerEmail] = 'StTraining@Statline.org';

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Performed misc other tasks`n"
    }
    elseif (($Database -eq "_ReferralTest" -or $Database -eq "_ReferralTest2") -and $Server -like "*testsql*") {
        # From Give Streportadmin Access.sql
        Write-Host "Creating/updating DB users..."
        CreateUpdateDbUsers -DbLogins $DbLogins -Server $Server -Database $Database -QueryUsername $QueryUsername -QueryPassword $QueryPassword -ErrorAction Stop
        Write-Host "Created/updated DB users`n"

        Write-Host "Adding audit trail user..."
        $query = "
        CREATE USER [$AuditTrailUser] FOR LOGIN [$AuditTrailUser] WITH DEFAULT_SCHEMA=[dbo]
        GO
        ALTER ROLE [db_owner] ADD MEMBER [$AuditTrailUser]

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $AuditTrailDatabase -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Added audit trail user"

        # From Remove Prod Replication.sql
        Write-Host "Removing replication..."
        $query = "
        exec sp_removedbreplication $Database
        exec sp_removedbreplication $AuditTrailDatabase

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database "master" -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Removed replication`n"

        # From UpdateForReporting.sql
        Write-Host "Updating reporting URLs..."
        $query = "
        update 
	        report
        set 
	        ReportVirtualURl = Replace(ReportVirtualURl, 'StatTrac', 'StatTrac Test')	
        where 
	        ReportVirtualURl like '%stattrac%'
        and ReportVirtualURl not like '%stattrac test%'	

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Updated reporting URLs`n"

        # From UPDATEDRDSN.sql
        Write-Host "Updating DRDSN server names..."
        $query = "
        UPDATE DRDSN
            SET DRDSNServerName = 'registry-test-mi.097db93d9c7e.database.windows.net';

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Updated DRDSN server names`n"

        # From UpdatevwDataWarehouseOrganizationDeaths.sql
        Write-Host "Creating DataWarehouseOrganizationDeaths view..."
        $query = "
        /****** Object:  View [dbo].[vwDataWarehouseOrganizationDeaths]    Script Date: 04/14/2009 09:45:28 ******/
        IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[vwDataWarehouseOrganizationDeaths]') AND OBJECTPROPERTY(id, N'IsView') = 1)
        DROP VIEW [dbo].[vwDataWarehouseOrganizationDeaths]
        /****** Object:  View [dbo].[vwDataWarehouseOrganizationDeaths]    Script Date: 04/14/2009 09:45:14 ******/
        SET ANSI_NULLS ON
        GO
        SET QUOTED_IDENTIFIER ON
        GO
        CREATE View [dbo].[vwDataWarehouseOrganizationDeaths]

	        /******************************************************************************
	        **		File: vwDataWarehouseOrganizationDeaths.sql
	        **		Name: vwDataWarehouseOrganizationDeaths
	        **		Desc: 
	        **
	        ** 
	        **		Called by:   
	        **              
	        **
	        **		Auth: Bret Knoll
	        **		Date: 12/8/2008
	        *******************************************************************************
	        **		Change History
	        *******************************************************************************
	        **		Date:		Author:				Description:
	        **		--------	--------				-------------------------------------------
	        **		12/8/2008			Bret Knoll			View of Organization Deahs in the Datawarehouse DB
	        *******************************************************************************/
	        AS
		        SELECT * FROM _ReferralProd_DataWarehouse.dbo.OrganizationDeaths

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Created DataWarehouseOrganizationDeaths view`n"

        Write-Host "Creating vwDataWarehouseWebReportGroupSourceCode view..."
        $query = "
        /****** Object:  View [dbo].[vwDataWarehouseWebReportGroupSourceCode]    Script Date: 8/10/2020 12:41:40 PM ******/
        IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[vwDataWarehouseWebReportGroupSourceCode]') AND OBJECTPROPERTY(id, N'IsView') = 1)
        DROP VIEW [dbo].[vwDataWarehouseWebReportGroupSourceCode]
        GO

        /****** Object:  View [dbo].[vwDataWarehouseWebReportGroupSourceCode]    Script Date: 8/10/2020 12:41:40 PM ******/
        SET ANSI_NULLS ON
        GO

        SET QUOTED_IDENTIFIER ON
        GO



        CREATE VIEW [dbo].[vwDataWarehouseWebReportGroupSourceCode]
      
        AS
              /******************************************************************************
              **          File: 
              **          Name: vwDataWarehouseWebReportGroupSourceCode
              **          Desc: view used to query data from Replicated Reporting DB
              **
              **              
              **          Return values: Table WebReportGroupSourceCode
              ** 
              **          Called by:   AuditTrail Reports
              **              
              **
              **          Auth: Bret Knoll
              **          Date: Aug  4 2011 11:56AM
              *******************************************************************************
              **          Change History
              *******************************************************************************
              **          Date:       Author:                       Description:
              **          --------    --------                -------------------------------------------
              **          10/15/2008  Bret Knoll              Create View
              **          10/28/2010  bret j knoll            fix to use new server/db names
              *******************************************************************************/    
              select * from dbo.[WebReportGroupSourceCode]
      
        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Created vwDataWarehouseWebReportGroupSourceCode view`n"

        Write-Host "Creating vwOrganizationSourceCode view..."
        $query = "
        /****** Object:  View [dbo].[vwOrganizationSourceCode]    Script Date: 8/10/2020 12:44:53 PM ******/
        IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[vwOrganizationSourceCode]') AND OBJECTPROPERTY(id, N'IsView') = 1)
        DROP VIEW [dbo].[vwOrganizationSourceCode]
        GO

        /****** Object:  View [dbo].[vwOrganizationSourceCode]    Script Date: 8/10/2020 12:44:53 PM ******/
        SET ANSI_NULLS ON
        GO

        SET QUOTED_IDENTIFIER ON
        GO


        CREATE VIEW [dbo].[vwOrganizationSourceCode]
 
        AS
        /******************************************************************************
        **	File: vwOrganizationSourceCode.sql
        **	Name: vwOrganizationSourceCode
        **	Desc: Selects multiple rows of OrganizationSourceCode Based on Id  fields 
        **	Auth: Bret Knoll
        **	Date: 11/12/2010
        **	Called By: 
        *******************************************************************************
        **	Change History
        *******************************************************************************
        **	Date:			Author:					Description:
        **	--------		--------				----------------------------------
        **	11/12/2010		Bret Knoll			Initial Sproc Creation
        *******************************************************************************/
	        SELECT 
		        dbo.Organization.OrganizationID,
		        dbo.fn_SourceCodeListByOrganizationID(Organization.OrganizationID) AS SourceCodeList
	        FROM 
		        dbo.Organization
	        JOIN 
	        (SELECT DISTINCT OrganizationID FROM  dbo.SourceCodeOrganization) SourceCodeOrganization  ON Organization.OrganizationID = SourceCodeOrganization.OrganizationID


        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Created vwOrganizationSourceCode view`n"

        # From StatTracNotForProduction.sql
        Write-Host "Performing misc other tasks..."
        $query = "
        -- StatTrac
        if(@@Servername like '%test%')
        begin
	        select * from Api.Configuration
	        delete api.Configuration


	        UPDATE 
		        [dbo].[WebPerson]
	        SET 
		        [SaltValue] = 'Rkt0RGNFAO/v7+/v7+/v7w==',
		        [HashedPassword] = CONVERT(VARCHAR(100),HASHBYTES('SHA1','miketrac'+'Rkt0RGNFAO/v7+/v7+/v7w=='), 2)
	        where webperson.WebPersonUserName like 'statline%'


	        --- turn off all statfile records

	        update ExportFile 
	        set ExportFileOn = 0
        end

        GO
        
        UPDATE [dbo].PersonPhone
	        SET [PhoneAlphaPagerEmail] = 'STTraining@Statline.org';

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Performed misc other tasks`n"

        # From ST_Add_AuditTrail_Publications.sql (in source control)
        Write-Host "Adding audit trail publications..."
        $query = "
        print @@servername
        print db_name()
        set nocount on 

        DECLARE @DBNAME VARCHAR(100),
		        @INSTANCENAME VARCHAR(100),
		        @PRODUCTIONSERVER VARCHAR(100),
		        @distributionServer VARCHAR(100),
		        @publication VARCHAR(100),
		        @logreader_job_name VARCHAR(200),
		        @snapshot_job_name VARCHAR(200),
		        @description VARCHAR(200),
		        @login varchar(50),
		        @loopCount int, 
		        @loopMax int,
		        @publicationName varchar(200),
		        @articleName varchar(200),
		        @NoColumn varchar(100),
		        @dbOwner varchar(200),
		        @filter nvarchar(4000),
		        @spi nvarchar(4000),
		        @spu nvarchar(4000),
		        @spd nvarchar(4000)

        DECLARE	@publicationList TABLE
        (
	        ID INT IDENTITY(1,1),
	        publicationName varchar(200)	
		
        )
        if (select object_id('tempdb..#articleList')) is not null
        begin
	        drop table #articleList 
        end
        create table #articleList
	        (
		        ID INT IDENTITY(1,1),
		        publicationName varchar(200),
		        dbOwner varchar(200)	,
		        articleName varchar(200)	
	        )
	
        SET @DBNAME = '$Database'
        SET @INSTANCENAME = @DBNAME
        SET @PRODUCTIONSERVER = '$Server'
        SET @distributionServer = '$Server'

        print 'Passed in Variables'
        print @DBNAME
        print @INSTANCENAME 
        print @PRODUCTIONSERVER
        print @distributionServer


        -- todo check if db is not configured to publish
        if not exists(select is_published, * from master.sys.databases where name like @DBNAME and is_published = 1)
        begin 
	        exec master..sp_replicationdboption @dbname = @DBNAME, @optname = N'publish', @value = N'true'
        end

        INSERT #articleList 
        select distinct REPLACE('<INSTANCE>_AuditTrail', '<INSTANCE>', @INSTANCENAME),  sch.name, tab.name
        from sys.tables tab
        join sys.schemas sch on tab.schema_id = sch.schema_id
        join sys.columns col on tab.object_id = col.object_id
        where tab.object_id in ( select OBJECT_ID from sys.columns col where col.name = 'LastModified' 	)
        and tab.object_id in ( select OBJECT_ID from sys.columns col where col.name like 'LastStatEmployeeID'	)
        and tab.name not like 'Audit%'
        and tab.name not like 'Archive%'
        and tab.name not in (
	        'AgeInterval',
	        'AspSettingType',
	        'AspSourceCodeMap',
	        'BulletinBoard',
	        'CaseType',
	        'ContactCallInstruction',
	        'ContactRoleMergeLog',
	        'CountryCode',
	        'Credential',
	        'Criteria',
	        'CriteriaAgeUnit',
	        'CriteriaIndication',
	        'CriteriaOrganization',
	        'CriteriaProcessor',
	        'CriteriaSourceCode',
	        'CriteriaWeightUnit',
	        'DashBoardDisplaySetting',
	        'DashBoardTimerDefault',
	        'DashBoardTimerType',
	        'DashBoardWindow',
	        'DisplayScreen',
	        'DonorCategory',
	        'DonorTracIdentifier',
	        'DonorTracURL',
	        'DuplicateSearchRule',
	        'DuplicateSearchRuleDefault',
	        'EmailType',
	        'ExportFile',
	        'Field',
	        'FSBCase',
	        'FsbCaseStatus',
	        'Gender',
	        'Idd',
	        'Indication',
	        'IndicationQuestionAssociated',
	        'IndicationResponse',
	        'ListFsbStatus',
	        'ListFsbStatusColor',
	        'PagerType',
	        'PersonPhone',
	        'PersonType',
	        'Phone',
	        'Race',
	        'SecurityRule',
	        'SourceCodeASP',
	        'SourceCodeTransplantCenter',
	        'SourceCodeType',
	        'StatEmployee',
	        'TimeZone',
	        'TrainedRequestor',
	        'TransplantCenter'
        )
        or tab.name in (
	        'Call',
	        'QALogos',
	        'WebReportGroupSourceCode',
	        'OrganizationType'
        )

        delete #articleList where publicationName is null
        -- select * from #articleList  

        -- check for duplicates select count(1), articleName	 from #articleList  group by articleName having count(1) > 1

        -- Remove articles currently published
        delete #articleList 
        ---select * 
        from #articleList 
        join (select pub.name,  article.dest_table, article.dest_owner, article.objid
		         from syspublications pub 
		        join sysarticles article on pub.pubid = article.pubid
		        where pub.name = 'AuditTrail'
		        ) existingPubs  on #articleList.publicationName = existingPubs.name and #articleList.dbOwner = existingPubs.dest_owner and #articleList.articleName = existingPubs.dest_table 

        -- select * from #articleList 

        INSERT @publicationList
        SELECT DISTINCT publicationname 
        FROM #articleList

        SELECT @loopCount = 1, 
	        @loopMax = MAX(ID) FROM @publicationList

        WHILE (@loopcount <= @loopMax)
        BEGIN 
	        SELECT 
		        @publication =  publicationName ,
		        @logreader_job_name = @PRODUCTIONSERVER + '-' + @DBNAME + '-1',
		        @snapshot_job_name = @PRODUCTIONSERVER + '-' + @DBNAME + '-' + @publicationName,
		        @description = N'Transactional publication of ' + @publication + ' on ' + @DBNAME + ' database.'
	        FROM @publicationList
		        WHERE ID = @loopCount

	        PRINT 'CREATING ' + @publication
	        if not exists(select * from syspublications where name = @publication)
	        begin		
		        exec sp_addpublication 
		        @publication = @publication, 
		        @sync_method = N'concurrent', 
		        @repl_freq = N'continuous', 
		        @description = @description, 
		        @status = N'active', 
		        @allow_push = N'true', 
		        @allow_pull = N'true', 
		        @allow_anonymous = N'false', 
		        @enabled_for_internet = N'false', 
		        @independent_agent = N'true', 
		        @immediate_sync = N'false', 
		        @allow_sync_tran = N'false', 
		        @autogen_sync_procs = N'false', 
		        @retention = 0, 
		        @allow_queued_tran = N'false', 
		        @snapshot_in_defaultfolder = N'true', 
		        @compress_snapshot = N'false', 
		        @ftp_port = 21, 
		        @ftp_login = N'anonymous', 
		        @allow_dts = N'false', 
		        @allow_subscription_copy = N'false'

		        exec sp_addpublication_snapshot 
		        @publication = @publication ,
		        @frequency_type = 1, 
		        @frequency_interval = 1, 
		        @frequency_relative_interval = 1, 
		        @frequency_recurrence_factor = 0, 
		        @frequency_subday = 8, 
		        @frequency_subday_interval = 1, 
		        @active_start_date = 19900101, --- this causes the snapshot to not be scheduled
		        @active_end_date = 19900101,   --- Snapshots need to be ran manully
		        @active_start_time_of_day = 0, 
		        @active_end_time_of_day = 235959 

		        -- do not think I need this 9/3/2019 EXEC sp_grant_publication_access @publication = @publication, @login = N'distributor_admin'
		        if exists(SELECT 1 FROM syslogins WHERE name = N'DOGGY\svc_testsql$')
		        BEGIN
			        print 'Adding access for DOGGY\svc_testsql$'
			        exec sp_grant_publication_access @publication = @publication, @login = N'DOGGY\svc_testsql$'
		        END
		        if exists(SELECT 1 FROM syslogins WHERE name = N'BUILTIN\Administrators')
		        BEGIN
			        print 'Adding access for BUILTIN\Administrators'
			        EXEC sp_grant_publication_access @publication = @publication, @login = N'BUILTIN\Administrators'
		        END
		        if exists(SELECT 1 FROM syslogins WHERE name = N'distributor_admin')
		        BEGIN
			        print 'Adding access for distributor_admin'
			        EXEC sp_grant_publication_access @publication = @publication, @login = N'distributor_admin'
		        END
	        end
	        SELECT @loopCount = @loopCount + 1
	
	
        END

        -- Adding the transactional articles

        SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM #articleList

        -- SELECT * FROM SYSCOLUMNS WHERE name = 'caseid'

        --select * from funeralhome 
        WHILE (@loopCount <= @loopMax)
        BEGIN

	        SELECT 
		        @articleName = articleName,
		        @publication = publicationName,
		        @dbOwner = dbOwner,
		        @filter = '1 = 2',
		        @spi = N'CALL spi_Audit_' + articleName,
		        @spu = N'CALL spd_Audit_' + articleName,
		        @spd = N'MCALL spu_Audit_' + articleName
	        FROM 
		        #articleList
	        WHERE
		        ID = @loopCount
	        if not exists (
		        select * from sysarticles articles
		        join syspublications pub on articles.pubid = pub.pubid
		        join sys.objects o on articles.objid = o.object_id
		        join sys.schemas sch on o.schema_id = sch.schema_id
		        where o.name = @articleName
		        and pub.name = @publication
		        and sch.name = @dbOwner)
	        begin
		        -- Adding the transactional articles
		        exec sp_addarticle 
			        @publication = @publication, 
			        @article = @articleName, 
			        @source_owner = @dbOwner, 
			        @source_object = @articleName, 
			        @destination_table = @articleName, 
			        @type = N'logbased', 
			        @creation_script = null, 
			        @description = null, 
			        @pre_creation_cmd = N'none', 
			        @schema_option = 0x0000000030030000,
			        -- 110000000011110001, 
			        -- select 241 + 65536 + 131072
			        -- 0x00000000000000F1 = 11110001 = 241
			        -- + 0x10000 = 10000000000000000 = 65536
			        -- 0x20000 = 100000000000000000 = 131072
			        --0x00000000000300F3, -- 0x00000000000000F3,  --  0x00000000000300F3, --
			        @identityrangemanagementoption = N'manual', 
			        @status = 8, 
			        @vertical_partition = N'false', 
			        @ins_cmd = @spi, 
			        @del_cmd = @spu, 
			        @upd_cmd = @spd, 
			        @filter = null, 
			        @sync_object = null,
			        @filter_clause = @filter
	        end 
	        SET @loopCount = @loopCount + 1
        END

        select *  from  #articleList
        where articleName not in (select name from sys.tables)

        if (select object_id('tempdb..#articleList')) is not null
        begin
	        drop table #articleList 
        end

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Added audit trail publications`n"

        # From ST_Add_AuditTrail_PushSubscriptions.sql (in source control)
        Write-Host "Adding audit trail push subscriptions..."
        $query = "
        print @@servername
        print db_name()

        DECLARE 
	        @DBNAME VARCHAR(100),
	        @PRODUCTIONSERVER VARCHAR(100),
	        @REPORTSERVER VARCHAR(100),
	        @publication VARCHAR(100),
	        @logreader_job_name VARCHAR(200),
	        @snapshot_job_name VARCHAR(200),
	        @description VARCHAR(200),
	        @login varchar(50),
	        @qreader_job_name VARCHAR(200),
	        @DESTINATIONDB VARCHAR(100)
	
        SET @DBNAME = '$Database'
        SET @DESTINATIONDB = '$AuditTrailDatabase'
        SET @PRODUCTIONSERVER = '$Server'
        SET @REPORTSERVER = '$Server'

        Print @DBNAME 
        Print @DESTINATIONDB 
        Print @PRODUCTIONSERVER 
        Print @REPORTSERVER 

        -- Adding the transactional pull subscription: ST-PRODSQL-5:' + @DBNAME + ':CAOL_Common
        DECLARE @PublicationList Table
        (
	        ID INT IDENTITY(1,1),
	        PublicationName NVARCHAR(max)
        )

        insert @PublicationList
        select name from syspublications where name like '%AuditTrail'
 
        DECLARE @PublicationName nvarchar(max) 

        WHILE (SELECT COUNT(*) FROM @PublicationList) > 0
        BEGIN
	        SELECT TOP(1) @PublicationName = PublicationName FROM @PublicationList
	
	        SELECT 	@publication =  @PublicationName,
	        @logreader_job_name = @REPORTSERVER + '-' + @DBNAME + '-' + @publication,
	        @snapshot_job_name = @REPORTSERVER + '-' + @DBNAME + '-' + @publication,
	        @description = N'Transactional publication of ' + @DBNAME + ' database.',
	        @qreader_job_name = @REPORTSERVER + '-QUEUEReader'
		
	        --debug
	        --select 'exec sp_addsubscription @publication = ' + @publication + ', @subscriber = ' + @REPORTSERVER +', @destination_db = ' + @DESTINATIONDB + ', 
	        --@sync_type = N''automatic'', @subscription_type = N''Push'', @update_mode = N''read only'', @subscriber_type = 0'
	
	        --select 'exec sp_addpushsubscription_agent @publication = ' + @publication + ', @subscriber = ' + @REPORTSERVER +', @subscriber_db = '+ @DESTINATIONDB +', 
	        --@job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 0, 
	        --@frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, 
	        --@active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 99991231, 
	        --@enabled_for_syncmgr = N''False'', @dts_package_location = N''Distributor'''

	        exec sp_addsubscription @publication = @publication, @subscriber = @REPORTSERVER, @destination_db = @DESTINATIONDB, 
	        @sync_type = N'automatic', @subscription_type = N'Push', @update_mode = N'read only', @subscriber_type = 0
	
	        exec sp_addpushsubscription_agent @publication = @publication, @subscriber = @REPORTSERVER, @subscriber_db = @DESTINATIONDB, 
	        @job_login = null, @job_password = null, @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 0, 
	        @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, 
	        @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 99991231, 
	        @enabled_for_syncmgr = N'False', @dts_package_location = N'Distributor'
		
	        DELETE @PublicationList WHERE PublicationName = @PublicationName	
        END

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Added audit trail push subscriptions`n"

        # From CreateAuditTailViews.sql
        Write-Host "Creating audit trail views..."
        $query = "
        /*
	        Creates views for the AuditTrail DB
	        1. Update the string @dbNameStringToReplace
	        2. Update the string @dbNameNewText 
	        3. Set the where statement for select sysobjects
        */
        DECLARE 
	        @loopCount int, 
	        @loopMax int,
	        @tableName nvarchar(100),
	        @blank nvarchar(100),
            @tableSchema nvarchar(100),
	        @dropSql nvarchar(4000),
	        @sql nvarchar(4000),
	        @testSQL nvarchar(4000),
	        @testResult int, 
	        @dbNameStringToReplace nvarchar(100),
	        @dbNameNewText nvarchar(100),
	        @vwname nvarchar(25),
	        @publicationDB nvarchar(25)
	
        SET @publicationDB ='$Database'

        DECLARE @tables TABLE
	        (
		        ID INT IDENTITY(1,1),
		        tableName nvarchar(100),
		        blank nvarchar(100),
                tableSchema nvarchar(100)
		
	
	        )

        --select * from sysobjects where name like 'vwAuditTrail%'

        --- test string 
        set @vwName = 'vwAuditTrail'
        set  @dbNameStringToReplace = '$AuditTrailDatabase'
        --set @dbNameNewText = @publicationDB + '.dbo.'
        --select replace(db_name(), @dbNameStringToReplace, @dbNameNewText)
	
        INSERT @tables 
            SELECT TABLE_NAME, '', TABLE_SCHEMA FROM $Database.INFORMATION_SCHEMA.TABLES
	            WHERE 1=1
		            AND TABLE_TYPE LIKE '%TABLE%'
		            AND TABLE_NAME NOT LIKE 'ms%'
		            AND TABLE_NAME NOT LIKE 'dt%'
		            AND TABLE_NAME NOT LIKE 'conflict%'
        order by 1

        SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM @tables

        WHILE (@loopCount <= @loopMax)
        BEGIN
	        SELECT 
		        @tableName = tableName,
		        @blank = blank,
                @tableSchema = tableSchema
	        FROM 
		        @tables
	        WHERE
		        ID = @loopCount
            print @vwName + @tableName
            set @dbNameNewText = @publicationDB + '.' + @tableSchema + '.'
	        select @dropSql = ' if exists(select * from sysobjects where name = ''' + @vwName + @tableName + ''')
	        BEGIN
		        DROP VIEW [' + @vwName + @tableName + ']
	        END
	        '
	        SELECT @testSQL = '
	        if exists(select * from sysobjects where name = ''' + @tableName +''' )
	        BEGIN
		        SET @testResult = 1
	        END
	        ELSE
	        BEGIN
		        SET @testResult = 0
	        END'
	
	        SET @sql = '
	        CREATE VIEW [' + @vwName + @tableName + ']
	
	        AS
	        /******************************************************************************
	        **		File: 
	        **		Name: ' + @vwName +  @tableName + '
	        **		Desc: view used to query data from Replicated Reporting DB
	        **
	        **              
	        **		Return values: Table ' + @tableName + '
	        ** 
	        **		Called by:   AuditTrail Reports
	        **              
	        **
	        **		Auth: Bret Knoll
	        **		Date: ' + convert(varchar, getDate()) + '
	        *******************************************************************************
	        **		Change History
	        *******************************************************************************
	        **		Date:		Author:				Description:
	        **		--------	--------			-------------------------------------------
	        **		10/15/2008	Bret Knoll			Create View
	        *******************************************************************************/	
	        select * from ' + replace(db_name(), @dbNameStringToReplace, @dbNameNewText) + '[' + @tableName + ']
	        '
            
            PRINT @sql
	        SET @testResult = 0
	        EXEC sp_executesql @dropSql
	        EXEC sp_executesql @sql --, N'@testResult INT OUTPUT', @testResult= @testResult OUTPUT
	        PRINT @DROPSQL
		        PRINT @testSQL
		        PRINT @sql

        ----print @testResult 
        --	if (@testResult = 1)
        --	BEGIN
		
        --		EXEC sp_executesql @sql
        --	END 
        --	if(@@error > 0)
        --	begin
        --		PRINT @DROPSQL
        --		PRINT @testSQL
        --		PRINT @sql
        --	end

	        SET @loopCount = @loopCount + 1
        END

        -- select 'select * from ' + name,  * from sysobjects where name like @vwName + '%' order by name
        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $AuditTrailDatabase -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000  -ErrorAction Stop
        Write-Host "Created audit trail views`n"

        Write-Host "Fixing audit trail functions..."
        $query = "
        /****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_TimeZoneDifference]    Script Date: 3/2/2020 10:51:17 AM ******/
        SET ANSI_NULLS ON
        GO
        SET QUOTED_IDENTIFIER ON
        GO

        ALTER FUNCTION [dbo].[AuditTrailfn_TimeZoneDifference]
	        (
	        @timeZone VARCHAR(2),
	        @activityDate DATETIME
	        )
        RETURNS INT
        AS
        /******************************************************************************
        **		File: AuditTrailfn_TimeZoneDifference.sql
        **		Name: AuditTrailfn_TimeZoneDifference
        **		Desc: 
        **			Call fn_TimeZoneDifference from Report DB			
        **
        **              
        **		Return values:
        ** 
        **		Called by:   
        **		AuditTrail Sprocs
        **              
        **		Parameters:
        **		Input							Output
        **     ----------							-----------
        **
        **		Auth: Bret Knoll
        **		Date: 11/19/08
        *******************************************************************************
        **		Change History
        *******************************************************************************
        **		Date:		Author:				Description:
        **		--------	--------			-------------------------------------------
        **		11/19/08	Bret Knoll			buil during release
        *******************************************************************************/

        BEGIN
	        DECLARE  @RETURNVALUE INT
	        SELECT @RETURNVALUE = $Database.dbo.fn_TimeZoneDifference(@timeZone,@activityDate)
	        RETURN @RETURNVALUE 
        END
        GO

        /****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_SourceCodeList]    Script Date: 3/2/2020 11:04:34 AM ******/
        SET ANSI_NULLS ON
        GO
        SET QUOTED_IDENTIFIER ON
        GO

        ALTER FUNCTION [dbo].[AuditTrailfn_SourceCodeList]
	        (
	        @ReportGroupID int = 0,
	        @SourceCodeName varchar(10)
	
	        )
        RETURNS 
	        @SourceCodeList TABLE 
	        (
		        SourceCodeID int 
	        )
        AS
        /******************************************************************************
        **		File: AuditTrailfn_SourceCodeList
        **		Name: AuditTrailfn_SourceCodeList
        **		Desc: Calls fn_SourceCodeList in the production database 
        **
        **		
        **		Return values:
        **		Returns a table variable of sourcecodeid
        **		Called by:   
        **              
        **		Parameters:
        **		Input							Output
        **     ----------							-----------
        **		ReportGroupID
        **		SourceCodeName
        **
        **		Auth: Bret Knoll
        **		Date: 11/24/08
        *******************************************************************************
        **		Change History
        *******************************************************************************
        **		Date:		Author:				Description:
        **		--------	--------			-------------------------------------------
        **      11/24/08	Bret Knoll			Create Function
        *******************************************************************************/
	
	        BEGIN
		        INSERT INTO @SourceCodeList 
				        SELECT * FROM $Database.dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName)
		        /* alternative sql statement or statements */ 
	        RETURN
	        END
        GO

        /****** Object:  UserDefinedFunction [dbo].[AuditTrailfn_rpt_ConvertDateTime]    Script Date: 3/2/2020 11:31:54 AM ******/
        SET ANSI_NULLS ON
        GO
        SET QUOTED_IDENTIFIER ON
        GO
        ALTER Function [dbo].[AuditTrailfn_rpt_ConvertDateTime] (
		        @vOrgID int,						/* Referral Facility OrganizationID/UserOrgId */
		        @vDateTime datetime,				/* DateTime to convert */
		        @vDisplayMountainTime int = Null	/* Option
												        0 = Display Referral Facility/UserOrg Time
												        1 = Display Mountain Time - Statline Employee */
        )

        RETURNS datetime AS 

        /******************************************************************************
        **		File: AuditTrailfn_rpt_ConvertDateTime.sql
        **		Name: AuditTrailfn_rpt_ConvertDateTime
        **		Desc: Calls the produciton database function
        **
        **		Return values:
        ** 
        **		Called by:   
        **              
        **		Parameters:
        **		Input							Output
        **     ----------							-----------
        **		See Above
        **
        **		Auth: 
        **		Date: 
        *******************************************************************************
        **		Change History
        *******************************************************************************
        **		Date:		Author:				Description:
        **		--------		--------				-------------------------------------------
        **      11/13/2007		ccarroll				initial
        *******************************************************************************/

        BEGIN 
	        DECLARE @RETURNDATETIME DATETIME
	        SELECT @RETURNDATETIME = $Database.dbo.fn_rpt_ConvertDateTime(@vOrgID, @vDateTime, @vDisplayMountainTime)
	        RETURN @RETURNDATETIME
        END

        GO"
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $AuditTrailDatabase -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Fixed audit trail functions"

        Write-Host "Creating Andrey's ST user..."
        $query = "
            IF (NOT EXISTS(SELECT TOP 1 StatEmployeeUserId FROM StatEmployee WHERE StatEmployeeUserID = 'asavin')) BEGIN
	            DECLARE @PersonID INT = (SELECT TOP 1 PersonID FROM WebPerson WHERE WebPersonUserName = 'asavin')
	
	            INSERT INTO StatEmployee
		            VALUES ('Andrey', 'Savin', 'asavin', '', GETDATE(), -1, -1, -1, 0, @PersonID, 'asavin@statline.org', -1, -1, -1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 3);
            END

            GO
        "
        Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
        Write-Host "Created Andrey's ST user`n"
    }
    else {
        Write-Error "Invalid value for Database param ('$Database') and/or Server param ('$Server')"
    }

    Write-Host "Finished post-restore ops on $Server\$Database"
}

# Common function to create/update a list of DB users
Function CreateUpdateDbUsers {
    [CmdletBinding()]
    param($DbLogins, $Server, $Database, $QueryUsername, $QueryPassword)

    $query = ""

    foreach ($dbLogin in $DbLogins) {
        $query += "
        IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'$dbLogin') BEGIN
	        PRINT '$dbLogin login does not exist. Creating now with password ''''';
	        CREATE LOGIN [$dbLogin] WITH PASSWORD = N'', DEFAULT_DATABASE = [$Database], CHECK_POLICY = OFF;
        END

        IF NOT EXISTS (SELECT * FROM dbo.sysusers WHERE name = N'$dbLogin') BEGIN
	        CREATE USER [$dbLogin] FOR LOGIN [$dbLogin];
        END

        ALTER ROLE db_owner ADD MEMBER [$dbLogin];
        ALTER USER [$dbLogin] WITH Login = [$dbLogin]

        GO
        
        "
    }

    Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $Server -Database $Database -Username $QueryUsername -Password $QueryPassword -Query $query -QueryTimeout 10000 -ErrorAction Stop
}

$dbLogins = ($env:DestLogins).Split(",")

PostRestore -Server $env:DestServer -Database $env:DestDatabase -AuditTrailServer $env:DestAtServer -AuditTrailDatabase $env:DestAtDatabase -DbLogins $dbLogins -AuditTrailUser $env:DestAtUser -QueryUsername $env:DestPlnUser -QueryPassword $env:DestPlnUserPassword -Verbose -ErrorAction Stop