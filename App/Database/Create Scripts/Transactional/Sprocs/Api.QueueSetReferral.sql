IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE   schema_name = 'Api' ) 
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Api'
END
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'QueueSetReferral')
	BEGIN
		PRINT 'Dropping Procedure QueueSetReferral'
		DROP Procedure [Api].QueueSetReferral
	END
GO

PRINT 'Creating Procedure QueueSetReferral'
GO

CREATE PROCEDURE [Api].[QueueSetReferral]
AS
		/*******************************************************************************
		**	File: Api.QueueSetReferral.sql 
		**	Name: QueueSetReferral
		**	Desc: Set Referral Json value into Api.Queue table
		**	Auth: Ilya Osipov
		**	Date: 8/16/2017
		**	Called By: 
		*******************************************************************************/	


DECLARE @currDate DATETIME,
		@DocumentTypeId int

SET  @currDate = getdate();

SELECT @DocumentTypeId = DocumentTypeId FROM Api.DocumentType WHERE Name = 'Referral';

WHILE EXISTS (SELECT * FROM [Api].[Configuration] WHERE [Api].[Configuration].LastRun < @currDate AND [Api].[Configuration].DocumentTypeId = @DocumentTypeId) 
BEGIN

	IF OBJECT_ID('tempdb.dbo.#refferalTable') IS NOT NULL
			DROP TABLE #refferalTable

	DECLARE @LastRun DATETIME,
	@WebReportGroupID INT,
	@OrganizationID INT,
	@ConfigurationID INT,
	@JSON VARCHAR(MAX)

	SELECT TOP(1) @ConfigurationID = ConfigurationID, @LastRun = LastRun, @WebReportGroupID = WebReportGroupID , @OrganizationID = OrganizationID
	FROM [Api].[Configuration] 
	WHERE [Api].[Configuration].LastRun < @currDate AND [Api].[Configuration].DocumentTypeId = @DocumentTypeId;

	--get CallId

	SELECT *
	INTO #refferalTable
	FROM 
	(
	-- "Normal" referrals
	SELECT [dbo].[Referral].ReferralID ,[dbo].[call].CallID
	FROM [dbo].[call] JOIN [dbo].[Referral] ON  [dbo].[call].CallID = [dbo].[Referral].CallID
	WHERE		
				([dbo].[call].LastModified > @LastRun OR
				[dbo].[Referral].LastModified > @LastRun)
			AND
				[dbo].[Referral].ReferralCallerOrganizationID  IN (SELECT WebReportGroupOrg.OrganizationID FROM WebReportGroupOrg WHERE WebReportGroupOrg.WebReportGroupID = @WebReportGroupID  )
			AND	
				[dbo].[call].SourceCodeID IN (SELECT SourceCodeID FROM dbo.fn_SourceCodeList(@WebReportGroupID, NULL))
	
	UNION
	-- Referrals with recycled cases (calls)
	SELECT [dbo].[Referral].ReferralID ,[dbo].[callrecycle].CallID
	FROM [dbo].[callrecycle] JOIN [dbo].[Referral] ON  [dbo].[callrecycle].CallID = [dbo].[Referral].CallID
	WHERE		
				([dbo].[callrecycle].RecycleDateTime > @LastRun OR
				[dbo].[Referral].LastModified > @LastRun)
			AND
				[dbo].[Referral].ReferralCallerOrganizationID  IN (SELECT WebReportGroupOrg.OrganizationID FROM WebReportGroupOrg WHERE WebReportGroupOrg.WebReportGroupID = @WebReportGroupID  )
			AND	
				[dbo].[callrecycle].SourceCodeID IN (SELECT SourceCodeID FROM dbo.fn_SourceCodeList(@WebReportGroupID, NULL))
	) AS Referrals;

	--get Referral
	if EXISTS(SELECT * FROM #refferalTable)
	BEGIN
		WHILE EXISTS (SELECT * FROM #refferalTable) 
		BEGIN 
			DECLARE @ReferralID INT,
					@CallID INT;

			SELECT TOP(1) @ReferralID = ReferralID, @CallID = CallID from #refferalTable;

			EXEC Api.AddMessageToSqlQueue 	
				@ReferralID,
				@WebReportGroupId,
				@DocumentTypeId,
				@OrganizationId;

			DELETE FROM #refferalTable 
			WHERE ReferralID = @ReferralID and @CallID = CallID;
		END;

		-- drop temp table
		DROP TABLE #refferalTable;
	END

	-- update [Api].[Configuration]

	UPDATE [Api].[Configuration]
	SET [Api].[Configuration].LastRun = @currDate
	WHERE ConfigurationID = @ConfigurationID;

END;

GO