-- -- -- File Manifest -- -- --  
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ImportOfferActivity/sps_rpt_ImportOfferActivity.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ImportOfferActivity/sps_rpt_ImportOfferActivity_count_select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ImportOfferActivity/sps_rpt_ImportOfferActivity_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ImportOfferDetail/sps_rpt_ImportOfferDetail_count_select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ImportOfferDetail/sps_rpt_ImportOfferDetail_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/MessageActivity/sps_rpt_MessageActivity.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/MessageActivity/sps_rpt_MessageActivity_count_select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/MessageActivity/sps_rpt_MessageActivity_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/MessageDetail/sps_rpt_MessageDetail_count_select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/MessageDetail/sps_rpt_MessageDetail_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/OutcomeByCategory/sps_rpt_OutcomeByCategory.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/PendingReferrals/sps_rpt_PendingReferrals_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralActivity/sps_rpt_ReferralActivity.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralActivity/sps_rpt_ReferralActivity_count_select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralActivity/sps_rpt_ReferralActivity_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralDetail/sps_rpt_DynamicDonorCategoryByOrg.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralDetail/sps_rpt_ReferralDetail_Triage_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralDetail/sps_rpt_SecondaryDisposition.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralDetail/sps_rpt_SecondaryDisposition_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralDetail/sps_rpt_SecondaryDisposition_Select1.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralDetail/sps_SecondaryDispositionTriageDisposition1.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralFacilityCompliance/sps_rpt_ReferralFacilityCompliance.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/ReferralOutcome/sps_rpt_ReferralOutcome_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/QA.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/sps_rpt_QAErrorLog_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/sps_rpt_QATrackingForm_Select.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAApproved/QAApproved.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyCAPA/sps_rpt_QAbyCAPA.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyError/sps_rpt_QAbyError.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyTrackingNumber/sps_rpt_QAbyTrackingNumber.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAFormsCompletedBy/sps_rpt_QAFormsCompletedBy.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAScorebyEmployee/GetPersonTitleListByOrganizationIDTitleID.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAScorebyEmployee/ParseVarcharValueString.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAScorebyEmployee/sps_rpt_QAScorebyEmployee.sql
-- C:/2005Projects/Statline/StatTrac/Data/Database/Queries/web/ScriptToFixReportURLs.sql --added 10/28/2009 ccarroll

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_ImportOfferActivity]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	  PRINT 'Dropping Procedure sps_rpt_ImportOfferActivity'
	  DROP PROCEDURE [DBO].[sps_rpt_ImportOfferActivity]
  END
GO
PRINT 'Creating Procedure sps_rpt_ImportOfferActivity'
SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_ImportOfferActivity
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @ImportOfferStartDateTime  DATETIME  = NULL,
                @ImportOfferEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferActivity
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data
**      10/21/08    jth                 added  MessageForOrganizationID
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
DECLARE @Source_DB int  
SET @Source_DB = 1 /* SET database to production (default) */  

  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
  
  IF @MessageCallerOrganization IS NOT Null
	BEGIN
		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
	END
  /*Null out dates if call id is populated */
  IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @ImportOfferStartDateTime = NULL
      SET @ImportOfferEndDateTime = NULL
      SET @MessageCallerOrganization = NULL
      SET @MessageFor = NULL

		/* determine if CallID is in Production db */
		IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
			BEGIN /* production database */
				SET @Source_DB = 1
			END
		ELSE
			BEGIN /* Archive database */
				SET @Source_DB = 2
			END
	END
ELSE
	BEGIN
	/* determine if date range is in Archive db */
	DECLARE @maxTableDate DATETIME
	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

		IF (ISNULL(@ImportOfferStartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 1
			END 

		IF (    ISNULL(@ImportOfferStartDateTime, GetDate()) < @maxTableDate 
			AND ISNULL(@ImportOfferEndDateTime, GetDate()) < @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 2
			END 

		IF (    ISNULL(@ImportOfferStartDateTime, GetDate()) < @maxTableDate 
			AND ISNULL(@ImportOfferEndDateTime, GetDate()) > @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 3
			END 
	END


CREATE TABLE #sps_rpt_ImportOfferActivityResults
   (
	[CallID][int] NULL, 
	[MessageTypeName][varchar] (50) NULL,
	[CallNumber][varchar] (15) NULL,
	[OrganizationName] [varchar] (80) NULL,
	[MessageCallerName][varchar] (80) NULL,
	[MessageCallerOrganization] [varchar] (80) NULL,
	[MessageCallerPhone][varchar] (20) NULL,
	[BasedOnDT1] [smalldatetime] NULL,
	[MessageForLastName] [varchar] (50) NULL,
	[PersonTypeName] [varchar] (50) NULL,
	[PersonName] [varchar] (150) NULL,
	[ReportCustomCode] [int] NULL,
	[MessageImportUNOSID][varchar] (20) NULL,
	[MessageImportCenter][varchar] (5) NULL,
	[MessageImportPatient][varchar] (50) NULL,
	[AlertGroupName][varchar] (80) NULL,
    [alertid] [int] NULL
   )

	IF @Source_DB = 3
				BEGIN /* Need to run in both archive and production databases */
					  /* run in Archive database */	
					INSERT #sps_rpt_ImportOfferActivityResults 
						EXEC _ReferralProdArchive..sps_rpt_ImportOfferActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT


					/* run in production database */
					INSERT #sps_rpt_ImportOfferActivityResults 
						EXEC sps_rpt_ImportOfferActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
				END

	IF @Source_DB = 2
				BEGIN
					/* run in Archive database only */	
					INSERT #sps_rpt_ImportOfferActivityResults 
						EXEC _ReferralProdArchive..sps_rpt_ImportOfferActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
				END

	IF @Source_DB = 1
			BEGIN	/* run in production database only */
			INSERT #sps_rpt_ImportOfferActivityResults 
				EXEC sps_rpt_ImportOfferActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
			END

 
/* Display Finial Selection */ 
SELECT * FROM #sps_rpt_ImportOfferActivityResults

DROP TABLE #sps_rpt_ImportOfferActivityResults       


GO              

 GO 

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_ImportOfferActivity_count_select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	DROP PROCEDURE [DBO].[sps_rpt_ImportOfferActivity_count_select]
	PRINT 'Dropping procedure: sps_rpt_ImportOfferActivity_count_select'
  END
	PRINT 'Creating procedure: sps_rpt_ImportOfferActivity_count_select' 
GO

SET QUOTED_IDENTIFIER ON  
GO

SET ANSI_NULLS ON  
GO

CREATE PROCEDURE sps_rpt_ImportOfferActivity_count_select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS
/******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferActivity_count_select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data   
**      10/21/08    jth                 added  MessageForOrganizationID
**      02/09       JTH                 limit message org id to user org id
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
 Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID
end
   IF @MessageCallerOrganization IS NOT Null
	BEGIN
		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
	END
	 
  /*Null out dates if call id is populated */
  IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @StartDateTime = NULL
      SET @EndDateTime = NULL
      SET @MessageCallerOrganization = NULL
      SET @MessageFor = NULL
    END
    
   
  SELECT COUNT(DISTINCT Call.CallID) 'RecordCount'
	FROM      CALL
	Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
		@DisplayMT		 ) )LT ON 
					  LT.CallID = Call.CallID 
	INNER JOIN Message ON Message.CallID = Call.CallID 
	LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID 
	JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
	LEFT JOIN Person ON Person.PersonID = Message.PersonID 
	LEFT JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID                   
	LEFT JOIN (
				SELECT     
					Alert.AlertID, 
					Alert.AlertGroupName, 
					AlertOrganization.OrganizationID, 
					AlertSourceCode.SourceCodeID
				FROM         
					Alert 
				INNER JOIN
					AlertSourceCode ON Alert.AlertID = AlertSourceCode.AlertID 
				INNER JOIN
					AlertOrganization ON Alert.AlertID = AlertOrganization.AlertID
				WHERE AlertTypeID = 4
			 ) ALERTS ON ALERTS.OrganizationID = Message.OrganizationID 
	AND ALERTS.SourcecodeID = Call.SourceCodeID	                      
	INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID

	WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
		AND ISNULL(PATINDEX(@MessageCallerOrganization, ISNULL(MessageCallerOrganization, 0)), -1) <> 0
		/* Search - Organization message for*/
		AND IsNull(Message.OrganizationID, 0) = IsNull(ISNull(@MessageForOrganizationID, Message.OrganizationID), 0)
        AND ISNULL(@MessageFor, ISNUll(Person.PersonID, 0)) = ISNUll(Person.PersonID, 0)                      
		AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
          --LIMIT MESSAGE.OrganizationID
		 AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)                         
         AND (MESSAGE.MESSAGETYPEID = 2)
         
GROUP BY
Call.CALLID,
Alerts.AlertID
GO

 GO 

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_ImportOfferActivity_Select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	  PRINT 'Dropping Procedure sps_rpt_ImportOfferActivity_Select'
	  DROP PROCEDURE [DBO].[sps_rpt_ImportOfferActivity_Select]
  END
  
GO
PRINT 'Creating Procedure sps_rpt_ImportOfferActivity_Select'
SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_ImportOfferActivity_Select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @ImportOfferStartDateTime  DATETIME  = NULL,
                @ImportOfferEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferActivity_Select
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added Select sproc for Archive data
**		10/14/2008	Bret				removed distinct and change how alerts are queried
**      10/21/08    jth                 added  MessageForOrganizationID
**      02/09       JTH                 limit message org id to user org id
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
           Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID
end
  
  IF @MessageCallerOrganization IS NOT Null
	BEGIN
		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
	END
  /*Null out dates if call id is populated */
  IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @ImportOfferStartDateTime = NULL
      SET @ImportOfferEndDateTime = NULL
      SET @MessageCallerOrganization = NULL
      SET @MessageFor = NULL
    END
    
  /* Set CustomCode */
  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
    @UserOrgID ,
    @Results OUTPUT
    
  SELECT 
		CALL.CallID,
		MESSAGETYPE.MessageTypeName,
		CALL.CallNumber,
		ORGANIZATION.OrganizationName,
		MESSAGE.MessageCallerName,
		MessageCallerOrganization,
		MESSAGE.MessageCallerPhone,
		LT.CallDateTime AS BasedOnDT1,
		PERSON.PERSONLAST                            AS MessageForLastName,
		PERSONTYPE.PERSONTYPENAME,
		PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST AS PersonName,
		@CustomCode                                  AS 'ReportCustomCode',
		Message.MessageImportUNOSID, 
		Message.MessageImportCenter, 
		Message.MessageImportPatient,
		Alerts.AlertGroupName,
		Alerts.alertid
  FROM      CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@ImportOfferStartDateTime		 ,
		@ImportOfferEndDateTime		 ,
		@DisplayMT		 ) )LT ON 
		LT.CallID = Call.CallID 
INNER JOIN Message ON Message.CallID = Call.CallID 
LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID 
JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
LEFT JOIN Person ON Person.PersonID = Message.PersonID 
LEFT JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID                   
LEFT JOIN (
				SELECT     
					Alert.AlertID, 
					Alert.AlertGroupName, 
					AlertOrganization.OrganizationID, 
					AlertSourceCode.SourceCodeID
				FROM         
					Alert 
				INNER JOIN
					AlertSourceCode ON Alert.AlertID = AlertSourceCode.AlertID 
				INNER JOIN
					AlertOrganization ON Alert.AlertID = AlertOrganization.AlertID
				WHERE AlertTypeID = 4	
		 ) ALERTS ON ALERTS.OrganizationID = Message.OrganizationID 
AND ALERTS.SourcecodeID = Call.SourceCodeID	                      
INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID

  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
		/* Search - Organization message for*/
		AND IsNull(Message.OrganizationID, 0) = IsNull(ISNull(@MessageForOrganizationID, Message.OrganizationID), 0)

		AND ISNULL(PATINDEX(@MessageCallerOrganization, ISNULL(MessageCallerOrganization, 0)), -1) <> 0
        AND ISNULL(@MessageFor, ISNUll(Person.PersonID, 0)) = ISNUll(Person.PersonID, 0)                      
		AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
         
         --LIMIT MESSAGE.OrganizationID
		 AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)                         
         AND (MESSAGE.MESSAGETYPEID = 2)
GO

 GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ImportOfferDetail_count_select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_rpt_ImportOfferDetail_count_select]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_ImportOfferDetail_count_select
	@UserOrgID		int = Null,
	@ReportGroupID	int = Null,
	@CallID			int = Null,
	@StartDateTime	DATETIME = NULL ,
	@EndDateTime	DATETIME = NULL,
	@SourceCodeName varchar(50) ,
	@OrganizationID int = Null,
	@DisplayMT		int = Null
	
AS

/******************************************************************************
**		File: sps_rpt_ImportOfferDetail_count_select.sql
**		Name: sps_rpt_ImportOfferDetail_count_select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data   
**      02/09       JTH                 limit message org id to user org id 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID
end
SELECT  COUNT(DISTINCT Call.CallID) 'RecordCount'
 FROM   CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
		@DisplayMT		 ) ) LT ON LT.CallID = Call.CallID
         INNER JOIN MESSAGE
           ON MESSAGE.CALLID = CALL.CALLID
         INNER JOIN ORGANIZATION
           ON ORGANIZATION.ORGANIZATIONID = MESSAGE.ORGANIZATIONID
         INNER JOIN MESSAGETYPE
           ON MESSAGETYPE.MESSAGETYPEID = MESSAGE.MESSAGETYPEID
         INNER JOIN PERSON
           ON PERSON.PERSONID = MESSAGE.PERSONID
         INNER JOIN PERSONTYPE
           ON PERSON.PERSONTYPEID = PERSONTYPE.PERSONTYPEID
         INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Message.OrganizationID   
  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
         AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
          --LIMIT MESSAGE.OrganizationID
         AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)                                      
         AND (MESSAGE.MESSAGETYPEID = 2)


  GO

 GO 

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_ImportOfferDetail_Select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure: sps_rpt_ImportOfferDetail_Select'
	DROP PROCEDURE [DBO].[sps_rpt_ImportOfferDetail_Select]
END
	PRINT 'Creating Procedure: sps_rpt_ImportOfferDetail_Select'
GO

SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_ImportOfferDetail_Select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: sps_rpt_ImportOfferDetail_Select.sql
**		Name: sps_rpt_ImportOfferDetail_Select
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		10/01/2008	ccarroll			Created for Archive and Production databases
**      02/09       JTH                 limit message org id to user org id 	
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
  
Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID
end

  /* Set CustomCode */
  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
    @UserOrgID ,
    @Results OUTPUT
    
  SELECT DISTINCT CALL.CallID,
                  MESSAGETYPE.MessageTypeName,
                  CALL.CallNumber,
                  ORGANIZATION.OrganizationName,
                  MESSAGE.MessageCallerName,
                  MessageCallerOrganization,
                  MESSAGE.MessageCallerPhone,
                  LT.CallDateTime AS CallDateTime,
				  --CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
				  --CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,
                  MESSAGE.MessageUrgent,
                  MESSAGE.MessageDescription,
                  PERSON.PERSONLAST                            AS MessageForLastName,
                  PERSONTYPE.PERSONTYPENAME,
                  PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST AS PersonName,
                  @CustomCode                                  AS 'ReportCustomCode',
                  (SELECT TOP 1 SC.SourceCodeName
                   FROM   SOURCECODE AS SC
                   WHERE  SC.SOURCECODEID = CALL.SOURCECODEID) AS SOURCECODENAME,
                  (SELECT TOP 1 PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST
                   FROM   LOGEVENT
                          LEFT OUTER JOIN STATEMPLOYEE
                            ON STATEMPLOYEE.STATEMPLOYEEID = LOGEVENT.STATEMPLOYEEID
                          LEFT OUTER JOIN PERSON
                            ON PERSON.PERSONID = STATEMPLOYEE.PERSONID
                   WHERE  (LOGEVENT.CALLID = CALL.CALLID)) AS TrigageCoord,Message.MessageImportUNOSID, Message.MessageImportCenter, 
                      Message.MessageImportPatient
  FROM   CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
		@DisplayMT		 ) ) LT ON LT.CallID = Call.CallID
         INNER JOIN MESSAGE
           ON MESSAGE.CALLID = CALL.CALLID
         INNER JOIN ORGANIZATION
           ON ORGANIZATION.ORGANIZATIONID = MESSAGE.ORGANIZATIONID
         INNER JOIN MESSAGETYPE
           ON MESSAGETYPE.MESSAGETYPEID = MESSAGE.MESSAGETYPEID
         INNER JOIN PERSON
           ON PERSON.PERSONID = MESSAGE.PERSONID
         INNER JOIN PERSONTYPE
           ON PERSON.PERSONTYPEID = PERSONTYPE.PERSONTYPEID
         INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Message.OrganizationID   
         --JOIN WEBREPORTGROUP ON WEBREPORTGROUP.ORGHIERARCHYPARENTID = MESSAGE.ORGANIZATIONID
  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
         AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
         --AND WEBREPORTGROUP.WEBREPORTGROUPID = ISNULL(@ReportGroupID,0)
         
         --LIMIT MESSAGE.OrganizationID
		 AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
         AND (MESSAGE.MESSAGETYPEID = 2)


GO

 GO 

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageActivity]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
BEGIN
  PRINT 'Dropping Procedure SPS_RPT_MessageActivity'
  DROP PROCEDURE [DBO].[SPS_RPT_MessageActivity]
END
GO
PRINT 'Creating Procedure sps_rpt_MessageActivity'
SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO


CREATE PROCEDURE sps_rpt_MessageActivity
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @MessageStartDateTime  DATETIME  = NULL,
                @MessageEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_MessageActivity
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data
**      10/21/08    jth                 added  MessageForOrganizationID
**      04/2009     jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  

DECLARE @Source_DB int  
SET @Source_DB = 1 /* SET database to production (default) */

  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
           
  IF @MessageCallerOrganization IS NOT Null
	BEGIN
		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
	END

  /* Set CustomCode */
--  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
--    @UserOrgID ,
--    @Results OUTPUT

/*Null out dates if call id is populated */
IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @MessageStartDateTime = NULL
      SET @MessageEndDateTime = NULL
      SET @MessageCallerOrganization = NULL
      SET @MessageFor = NULL

		/* determine if CallID is in Production db */
		IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
			BEGIN /* production database */
				SET @Source_DB = 1
			END
		ELSE
			BEGIN /* Archive database */
				SET @Source_DB = 2
			END
	END
ELSE
	BEGIN
	/* determine if date range is in Archive db */
	DECLARE @maxTableDate DATETIME
	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

		IF (ISNULL(@MessageStartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 1
			END 

		IF (    ISNULL(@MessageStartDateTime, GetDate()) < @maxTableDate 
			AND ISNULL(@MessageEndDateTime, GetDate()) < @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 2
			END 

		IF (    ISNULL(@MessageStartDateTime, GetDate()) < @maxTableDate 
			AND ISNULL(@MessageEndDateTime, GetDate()) > @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 3
			END 
	END


CREATE TABLE #sps_rpt_MessageActivityResults
   (
	[CallID][int] NULL, 
	[MessageTypeName][varchar] (50) NULL,
	[CallNumber][varchar] (15) NULL,
	[OrganizationName] [varchar] (80) NULL,
	[MessageCallerName][varchar] (80) NULL,
	[MessageCallerOrganization] [varchar] (80) NULL,
	[MessageCallerPhone][varchar] (20) NULL,
	[BasedOnDT1] [smalldatetime] NULL,
	[MessageForLastName] [varchar] (50) NULL,
	[PersonTypeName] [varchar] (50) NULL,
	[PersonName] [varchar] (150) NULL,
	[ReportCustomCode] [int] NULL,
	[AlertGroupName][varchar] (80) NULL,
    [alertid] [int] NULL
   )

	IF @Source_DB = 3
				BEGIN /* Need to run in both archive and production databases */
					  /* run in Archive database */	
					INSERT #sps_rpt_MessageActivityResults 
						EXEC _ReferralProdArchive..sps_rpt_MessageActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @MessageStartDateTime, @MessageEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT


					/* run in production database */
					INSERT #sps_rpt_MessageActivityResults 
						EXEC sps_rpt_MessageActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @MessageStartDateTime, @MessageEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
				END

	IF @Source_DB = 2
				BEGIN
					/* run in Archive database only */	
					INSERT #sps_rpt_MessageActivityResults 
						EXEC _ReferralProdArchive..sps_rpt_MessageActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @MessageStartDateTime, @MessageEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
				END

	IF @Source_DB = 1
			BEGIN	/* run in production database only */
			INSERT #sps_rpt_MessageActivityResults 
				EXEC sps_rpt_MessageActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @MessageStartDateTime, @MessageEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
			END

 
/* Display Finial Selection */ 
SELECT * FROM #sps_rpt_MessageActivityResults

DROP TABLE #sps_rpt_MessageActivityResults       
       
       
GO
 

 GO 

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageActivity_count_select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	DROP PROCEDURE [DBO].[SPS_RPT_MessageActivity_count_select]
	PRINT 'Dropping procedure: sps_rpt_MessageActivity_count_select'
  END
	PRINT 'Creating procedure: sps_rpt_MessageActivity_count_select'
GO

SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO


CREATE PROCEDURE sps_rpt_MessageActivity_count_select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_MessageActivity_count
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Placed into select sproc for Archive data  
**      10/21/08    jth                 added  MessageForOrganizationID
**      02/09       JTH                 limit message org id to user org id  
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
  Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID
end
  /*Null out dates if call id is populated */
  IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @StartDateTime = NULL
      
      SET @EndDateTime = NULL
    END
    
  /* Set CustomCode */
--  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
--    @UserOrgID ,
--    @Results OUTPUT
  
  SELECT COUNT(DISTINCT Call.CallID) 'RecordCount'
  FROM      CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
		@DisplayMT		 ) )LT ON 
                      LT.CallID = Call.CallID
	INNER JOIN Message ON Message.CallID = Call.CallID 
	LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID 
	INNER JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
	LEFT JOIN Person ON Person.PersonID = Message.PersonID 
	LEFT JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID 
	LEFT JOIN (
				SELECT     
					Alert.AlertID, 
					Alert.AlertGroupName, 
					AlertOrganization.OrganizationID, 
					AlertSourceCode.SourceCodeID
				FROM         
					Alert 
				INNER JOIN
					AlertSourceCode ON Alert.AlertID = AlertSourceCode.AlertID 
				INNER JOIN
					AlertOrganization ON Alert.AlertID = AlertOrganization.AlertID
				WHERE AlertTypeID = 2									  
			 ) ALERTS ON ALERTS.OrganizationID = Message.OrganizationID 
	AND ALERTS.SourcecodeID = Call.SourceCodeID	                      
	INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID 

	WHERE  
		ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
	AND 
		ISNULL(PATINDEX(@MessageCallerOrganization, ISNULL(MessageCallerOrganization, 0)), -1) <> 0
	AND 
		IsNull(Message.OrganizationID, 0) = IsNull(ISNull(@MessageForOrganizationID, Message.OrganizationID), 0)
	AND
		ISNULL(@MessageFor,ISNULL(Person.PersonID, 0)) = ISNULL(Person.PersonID, 0)
	AND 
		CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
                                   --LIMIT MESSAGE.OrganizationID
	AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
	AND (MESSAGE.MESSAGETYPEID <> 2)      
       
GROUP BY
Call.CALLID,
Alerts.AlertID
GO
  

 GO 

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageActivity_Select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
BEGIN
  PRINT 'Dropping Procedure sps_rpt_MessageActivity_Select'
  DROP PROCEDURE [DBO].[sps_rpt_MessageActivity_Select]
END
GO
PRINT 'Creating Procedure sps_rpt_MessageActivity_Select'
SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO


CREATE PROCEDURE sps_rpt_MessageActivity_Select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @MessageStartDateTime  DATETIME  = NULL,
                @MessageEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_MessageActivity_Select
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added Select sproc for Archive data
**		10/14/2008	Bret				removed distinct and change how alerts are queried
**      10/21/08    jth                 added  MessageForOrganizationID
**      02/09       JTH                 limit message org id to user org id 	
**      04/2009     jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
  DECLARE  @CustomCode  AS INT,
           @Results     AS INT
  Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID
end
           
  /* Set CustomCode */
  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
    @UserOrgID ,
    @Results OUTPUT

  SELECT			
		CALL.CallID,
		MESSAGETYPE.MessageTypeName,
		CALL.CallNumber,
		ORGANIZATION.OrganizationName,
		MESSAGE.MessageCallerName,
		MessageCallerOrganization,
		MESSAGE.MessageCallerPhone,
		LT.CallDateTime AS 'BasedOnDT1',
		PERSON.PERSONLAST                            AS MessageForLastName,
		PERSONTYPE.PERSONTYPENAME,
		PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST AS PersonName,
		@CustomCode                                  AS 'ReportCustomCode',
		Alerts.AlertGroupName,
		Alerts.Alertid
  FROM      CALL
	  JOIN (SELECT 		
				CallID, 
				CallDateTime
			FROM dbo.fn_rpt_MessageDateTimeConversion 
			(
			@CallID						 ,
			@MessageStartDateTime		 ,
			@MessageEndDateTime		 ,
			@DisplayMT		 ) )LT ON 
						  LT.CallID = Call.CallID 
	INNER JOIN Message ON Message.CallID = Call.CallID 
	LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID 
	INNER JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID 
	LEFT JOIN Person ON Person.PersonID = Message.PersonID 
	LEFT JOIN PersonType ON Person.PersonTypeID = PersonType.PersonTypeID 
	LEFT JOIN (
				SELECT     
					Alert.AlertID, 
					Alert.AlertGroupName, 
					AlertOrganization.OrganizationID, 
					AlertSourceCode.SourceCodeID
				FROM         
					Alert 
				INNER JOIN
					AlertSourceCode ON Alert.AlertID = AlertSourceCode.AlertID 
				INNER JOIN
					AlertOrganization ON Alert.AlertID = AlertOrganization.AlertID
				WHERE AlertTypeID = 2									  
			 ) ALERTS ON ALERTS.OrganizationID = Message.OrganizationID 
	AND ALERTS.SourcecodeID = Call.SourceCodeID	                      
	INNER JOIN SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID 

	WHERE  
		ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
	AND 
		ISNULL(PATINDEX(@MessageCallerOrganization, ISNULL(MessageCallerOrganization, 0)), -1) <> 0
	AND 
		IsNull(Message.OrganizationID, 0) = IsNull(ISNull(@MessageForOrganizationID, Message.OrganizationID), 0)
	AND
		ISNULL(@MessageFor,ISNULL(Person.PersonID, 0)) = ISNULL(Person.PersonID, 0)
	AND 
		CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
    
    --LIMIT MESSAGE.OrganizationID
	AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
	AND (MESSAGE.MESSAGETYPEID <> 2)      
       
GO
 

 GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_MessageDetail_count_select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
	drop procedure [dbo].[sps_rpt_MessageDetail_count_select]
	PRINT 'Dropping Procedure: sps_rpt_MessageDetail_count_select'
	END
PRINT 'Creating Procedure: sps_rpt_MessageDetail_count_select'
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_MessageDetail_count_select
	@UserOrgID		int = Null,
	@ReportGroupID	int = Null,
	@CallID			int = Null,
	@StartDateTime	DATETIME = NULL ,
	@EndDateTime	DATETIME = NULL,
	@SourceCodeName varchar(50) ,
	@OrganizationID int = Null,
	@DisplayMT		int = Null
	
AS

/******************************************************************************
**		File: sps_rpt_MessageDetail_count_select.sql
**		Name: sps_rpt_MessageDetail_count_select
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		10/01/2008	ccarroll			Added for Archive and Production databases
**      02/09       JTH                 limit message org id to user org id 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
Declare @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID

end

SELECT  COUNT(DISTINCT Call.CallID) 'RecordCount'
 FROM   CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
		@DisplayMT		 ) ) LT ON LT.CallID = Call.CallID
         INNER JOIN MESSAGE
           ON MESSAGE.CALLID = CALL.CALLID
         INNER JOIN ORGANIZATION
           ON ORGANIZATION.ORGANIZATIONID = MESSAGE.ORGANIZATIONID
         INNER JOIN MESSAGETYPE
           ON MESSAGETYPE.MESSAGETYPEID = MESSAGE.MESSAGETYPEID
         INNER JOIN PERSON
           ON PERSON.PERSONID = MESSAGE.PERSONID
         INNER JOIN PERSONTYPE
           ON PERSON.PERSONTYPEID = PERSONTYPE.PERSONTYPEID
           
         INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Message.OrganizationID   
  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
         AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
         --LIMIT MESSAGE.OrganizationID
		 AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
         AND (MESSAGE.MESSAGETYPEID <> 2)

GO
 

 GO 

IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageDetail_Select]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MessageDetail_Select'
		DROP PROCEDURE [dbo].[sps_rpt_MessageDetail_Select]
	END
		PRINT 'Creating Procedure: sps_rpt_MessageDetail_Select'
GO

SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_MessageDetail_Select
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @DisplayMT      INT  = NULL
AS

 /******************************************************************************
**		File: sps_rpt_MessageDetail_Select.sql
**		Name: sps_rpt_MessageDetail_Select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 2/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		10/01/2008	ccarroll			Added for Archive and Production databases
**      02/09       JTH                 limit message org id to user org id 	
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
  DECLARE  @CustomCode  AS INT,
           @Results     AS INT,
		   @MessageOrganizationID int

-- CHECK FOR STATLINE AND SET PARAM
if (@UserOrgID = 194)
begin
	set @MessageOrganizationID = null
end
else
begin
	set @MessageOrganizationID = @UserOrgID

end
  
  /* Set CustomCode */
  EXEC @CustomCode = SPS_RPT_CHECKCUSTOMREPORTUSERORG
    @UserOrgID ,
    @Results OUTPUT
    
  SELECT DISTINCT CALL.CALLID,
                  MESSAGETYPE.MESSAGETYPENAME,
                  CALL.CALLNUMBER,
                  ORGANIZATION.ORGANIZATIONNAME,
                  MESSAGE.MESSAGECALLERNAME,
                  MESSAGECALLERORGANIZATION,
                  MESSAGE.MESSAGECALLERPHONE,
                  LT.CallDateTime AS CallDateTime,
				  --CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
				  --CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,
                  MESSAGE.MESSAGEURGENT,
                  MESSAGE.MESSAGEDESCRIPTION,
                  PERSON.PERSONLAST                            AS MESSAGEFORLASTNAME,
                  PERSONTYPE.PERSONTYPENAME,
                  PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST AS PERSONNAME,
                  @CustomCode                                  AS 'ReportCustomCode',
                  (SELECT TOP 1 SC.SOURCECODENAME
                   FROM   SOURCECODE AS SC
                   WHERE  SC.SOURCECODEID = CALL.SOURCECODEID) AS SOURCECODENAME,
                  (SELECT TOP 1 PERSON.PERSONFIRST + ' ' + PERSON.PERSONLAST
                   FROM   LOGEVENT
                          LEFT OUTER JOIN STATEMPLOYEE
                            ON STATEMPLOYEE.STATEMPLOYEEID = LOGEVENT.STATEMPLOYEEID
                          LEFT OUTER JOIN PERSON
                            ON PERSON.PERSONID = STATEMPLOYEE.PERSONID
                   WHERE  (LOGEVENT.CALLID = CALL.CALLID)) AS TRIGAGECOORD
  FROM   CALL
  Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_MessageDateTimeConversion 
		(
		@CallID						 ,
		@StartDateTime		 ,
		@EndDateTime		 ,
		@DisplayMT		 ) ) LT ON LT.CallID = Call.CallID
         INNER JOIN MESSAGE
           ON MESSAGE.CALLID = CALL.CALLID
         INNER JOIN ORGANIZATION
           ON ORGANIZATION.ORGANIZATIONID = MESSAGE.ORGANIZATIONID
         INNER JOIN MESSAGETYPE
           ON MESSAGETYPE.MESSAGETYPEID = MESSAGE.MESSAGETYPEID
         INNER JOIN PERSON
           ON PERSON.PERSONID = MESSAGE.PERSONID
         INNER JOIN PERSONTYPE
           ON PERSON.PERSONTYPEID = PERSONTYPE.PERSONTYPEID
           
         INNER JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Message.OrganizationID 
  WHERE  ISNULL(@CallID,CALL.CALLID) = CALL.CALLID
         AND CALL.SOURCECODEID IN (SELECT SOURCECODEID
                                   FROM   DBO.FN_SOURCECODELIST (@ReportGroupID,@SourceCodeName ))
         
         --LIMIT MESSAGE.OrganizationID
		 AND MESSAGE.OrganizationID = ISNULL(@MessageOrganizationID, MESSAGE.OrganizationID)
         AND (MESSAGE.MESSAGETYPEID <> 2)


GO

 GO 

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_OutcomeByCategory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure: sps_rpt_OutcomeByCategory'
	drop procedure [dbo].[sps_rpt_OutcomeByCategory]
End
go

PRINT 'Creating Procedure: sps_rpt_OutcomeByCategory'
GO

CREATE     PROCEDURE sps_rpt_OutcomeByCategory
	@ReferralStartDateTime		datetime	= NULL ,
	@ReferralEndDateTime		datetime  	= NULL ,
	@ReportGroupID			int			= NULL , 
	@OrganizationID			int			= NULL ,
	@SourceCodeName			varchar (10) = NULL ,
	@DisplayMT				int	= Null
	 
AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
/******************************************************************************
**		File: sps_rpt_OutcomeByCategory.sql
**		Name: sps_rpt_OutcomeByCategory
**		Desc: 
**
**		Return values:
** 
**		Called by: OutcomeByCategory.rdl              
**		Parameters:
**		See above
**		
**		Auth: ccarroll
**		Date: 08/14/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**		08/14/2008		ccarroll		Initial Release
**		09/24/2008		ccarroll		Added selection for Archive db
**      03/2009         jth             was running the insert table sproc twice
****************************************************************************/

DECLARE @SQLString varchar(1000)
/* Create Temp table select */
	CREATE TABLE #Temp_OutcomeByCategory_Select 

	(	/* Call Details */
		[CallID] [INT] ,
		[CallDateTime] [DATETIME] , 
		[CallSourceCodeID] [INT] NULL , 
		[CallStatEmployeeID] [INT] NULL,

		[ReferralGeneralConsent] [INT] NULL,
		[ReferralTypeID] [INT] NULL,
		[ReferralCallerOrganizationID] [INT] NULL, 
		[RegistryStatus] [INT] NULL,

		[ReferralOrganAppropriateID] [INT] NULL , 
		[ReferralBoneAppropriateID] [INT] NULL , 
		[ReferralTissueAppropriateID] [INT] NULL , 
		[ReferralSkinAppropriateID] [INT] NULL , 
		[ReferralEyesTransAppropriateID] [INT] NULL , 
		[ReferralEyesRschAppropriateID] [INT] NULL , 
		[ReferralValvesAppropriateID] [INT] NULL , 

		[ReferralOrganApproachID] [INT] NULL , 
		[ReferralBoneApproachID] [INT] NULL , 
		[ReferralTissueApproachID] [INT] NULL , 
		[ReferralSkinApproachID] [INT] NULL , 
		[ReferralEyesTransApproachID] [INT] NULL , 
		[ReferralEyesRschApproachID] [INT] NULL , 
		[ReferralValvesApproachID] [INT] NULL , 

		[ReferralOrganConsentID] [INT] NULL , 
		[ReferralBoneConsentID] [INT] NULL , 
		[ReferralTissueConsentID] [INT] NULL , 
		[ReferralSkinConsentID] [INT] NULL , 
		[ReferralEyesTransConsentID] [INT] NULL , 
		[ReferralEyesRschConsentID] [INT] NULL , 
		[ReferralValvesConsentID] [INT] NULL , 

		[ReferralOrganConversionID] [INT] NULL , 
		[ReferralBoneConversionID] [INT] NULL , 
		[ReferralTissueConversionID] [INT] NULL , 
		[ReferralSkinConversionID] [INT] NULL , 
		[ReferralEyesTransConversionID] [INT] NULL , 
		[ReferralEyesRschConversionID] [INT] NULL , 
		[ReferralValvesConversionID] [INT]  NULL 
	)
	
	
	/* Create virtual table for Registry Status Type */
	DECLARE @RegistryStatusType Table
	(
		ID int,
		RegistryType varchar(50),
		DisplayOrder int
	)

INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(1, 'State Registry', 1)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(2, 'Web Registry', 2)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(3, 'Not Registered', 4)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(4, 'Manually Found', 3)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(5, 'Not Checked', 5)
	

	/*	Create virtual table used in finial display */
	DECLARE	@TempCounts TABLE
	 ( 
		ID int identity(1,1),
		FormatCode int NULL,	/* Values to format row: -1 Hidden, 0 = None, 1 = Bold, 2 = Bold & Italic */
		Disposition varchar(50) NULL,
		GroupingCode int Null,	/* This field is used to group and calculate sub-totals in report */
		Type varchar (50) Null,

		/* Counts */
		Organ int NULL,
		Bone int NULL,
		Soft_Tissue int NULL,
		Skin int NULL,
		Valves int NULL,
		Eyes int NULL,
		Other int NULL,

		/* Totals */
		Total_StateRegistry int Default(0),
		Total_WebRegistry int Default(0),
		Total_ManuallyFound int Default(0),
		Total_NotRegistered int Default(0),
		Total_Referrals int Default(0)
	 )

	 
	/* #Temp_OutcomeByCategory_Select initial selection  comment this out...why this was running twice? jth
			INSERT INTO #Temp_OutcomeByCategory_Select
				EXEC sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT*/

/* determine if date range is in Archive db */
	DECLARE @maxTableDate DATETIME
	DECLARE @OriginalEndDateTime DATETIME
	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS
	
	IF (ISNULL(@ReferralStartDateTime, GETDATE()) < @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
		/* Selection resides in archive db */
			IF (ISNULL(@ReferralEndDateTime, GETDATE()) > @maxTableDate)
					
				BEGIN /* Need to run in both archive and production databases */

					/* run in Archive database */	
					INSERT #Temp_OutcomeByCategory_Select 
						EXEC _ReferralProdArchive..sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT

					/* run in production database */
					INSERT #Temp_OutcomeByCategory_Select 
						EXEC sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT
				END
			ELSE
				BEGIN
					/* run in Archive database only */	
					INSERT #Temp_OutcomeByCategory_Select 
						EXEC _ReferralProdArchive..sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT
				END
	ELSE
			BEGIN	/* run in production database only */
			INSERT #Temp_OutcomeByCategory_Select
				EXEC sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT
			END


/*** Start Counts ***/
/*** Calculate Totals and set to local variables ***/

/* TOTAL Referrals Total */
DECLARE @TotalReferralStateRegistry int
DECLARE @TotalReferralWebRegistry int
DECLARE @TotalReferralManuallyFound int
DECLARE @TotalReferralNotRegistered int
DECLARE @TotalReferralReferrals int

	SELECT
		@TotalReferralStateRegistry = TOS.Total_StateRegistry,
		@TotalReferralWebRegistry = TOS.Total_WebRegistry,
		@TotalReferralManuallyFound = TOS.Total_ManuallyFound,
		@TotalReferralNotRegistered = TOS.Total_NotRegistered,
		@TotalReferralReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
				SUM(CASE WHEN RegistryStatus = 1 THEN 1 ELSE 0 END) AS 'Total_StateRegistry',
				SUM(CASE WHEN RegistryStatus = 2 THEN 1 ELSE 0 END) AS 'Total_WebRegistry',
				SUM(CASE WHEN RegistryStatus = 4 THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',
				SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',
				Count(CallID) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS


/* Appropriate Totals */
DECLARE @TotalAppropriateReferrals int

	SELECT
		@TotalAppropriateReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
			
			SUM(CASE WHEN 
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS


/* Approach Totals */
DECLARE @TotalApproachStateRegistry int
DECLARE @TotalApproachWebRegistry int
DECLARE @TotalApproachManuallyFound int
DECLARE @TotalApproachNotRegistered int
DECLARE @TotalApproachReferrals int

	SELECT
		@TotalApproachStateRegistry = TOS.Total_StateRegistry,
		@TotalApproachWebRegistry = TOS.Total_WebRegistry,
		@TotalApproachManuallyFound = TOS.Total_ManuallyFound,
		@TotalApproachNotRegistered = TOS.Total_NotRegistered,
		@TotalApproachReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
			SUM(CASE WHEN RegistryStatus = 1 AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

			SUM(CASE WHEN RegistryStatus = 2 AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

			SUM(CASE WHEN RegistryStatus = 4 AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

			SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',
			
			SUM(CASE WHEN 
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS

/* Consent Totals */
DECLARE @TotalConsentStateRegistry int
DECLARE @TotalConsentWebRegistry int
DECLARE @TotalConsentManuallyFound int
DECLARE @TotalConsentNotRegistered int
DECLARE @TotalConsentReferrals int

	SELECT
		@TotalConsentStateRegistry = TOS.Total_StateRegistry,
		@TotalConsentWebRegistry = TOS.Total_WebRegistry,
		@TotalConsentManuallyFound = TOS.Total_ManuallyFound,
		@TotalConsentNotRegistered = TOS.Total_NotRegistered,
		@TotalConsentReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
			SUM(CASE WHEN RegistryStatus = 1 AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

			SUM(CASE WHEN RegistryStatus = 2 AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

			SUM(CASE WHEN RegistryStatus = 4 AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

			SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',
			
			SUM(CASE WHEN 
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS

/* Recovery Totals */
DECLARE @TotalRecoveryStateRegistry int
DECLARE @TotalRecoveryWebRegistry int
DECLARE @TotalRecoveryManuallyFound int
DECLARE @TotalRecoveryNotRegistered int
DECLARE @TotalRecoveryReferrals int

	SELECT
		@TotalRecoveryStateRegistry = TOS.Total_StateRegistry,
		@TotalRecoveryWebRegistry = TOS.Total_WebRegistry,
		@TotalRecoveryManuallyFound = TOS.Total_ManuallyFound,
		@TotalRecoveryNotRegistered = TOS.Total_NotRegistered,
		@TotalRecoveryReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
					SUM(CASE WHEN RegistryStatus = 1 AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

				SUM(CASE WHEN RegistryStatus = 2 AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

				SUM(CASE WHEN RegistryStatus = 4 AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

				SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',
				
				SUM(CASE WHEN 
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS




/*** APPROPRIATE ***/
	/* Registry Appropriate */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)
	SELECT
			0 AS 'FormatCode',
			'Appropriate' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1 = Blank
				 1 = Yes
				 3 = Not on Registry
				 5 = Not Checked
			*/
			SUM(CASE WHEN ReferralOrganAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalReferralReferrals AS 'Total_Referrals'

	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Appropriate - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Appropriate' AS 'Disposition',
			2 AS 'GroupingCode', 
			Appropriate.AppropriateName AS 'Type',
			SUM(CASE WHEN ReferralOrganAppropriateID > 1 AND ReferralOrganAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN ReferralBoneAppropriateID > 1 AND ReferralBoneAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueAppropriateID > 1 AND ReferralTissueAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN ReferralSkinAppropriateID > 1 AND ReferralSkinAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesAppropriateID > 1 AND ReferralValvesAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransAppropriateID > 1 AND ReferralEyesTransAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschAppropriateID > 1 AND ReferralEyesRschAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalReferralReferrals AS 'Total_Referrals'
			
	FROM 	Appropriate, #Temp_OutcomeByCategory_Select
	WHERE	Appropriate.AppropriateID > 1 AND Appropriate.Inactive <> 1
	GROUP BY Appropriate.AppropriateName,
			 Appropriate.AppropriateReportDisplaySort1
--	ORDER BY Appropriate.AppropriateReportDisplaySort1
	ORDER BY Appropriate.AppropriateName

/*** End APPROPRIATE ***/


/*** APPROACH ***/
	/* Registry Approach */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)

	SELECT
			0 AS 'FormatCode',
			'Approach' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1 = Blank
				 1 = Yes
				 3 = Not on Registry
				 5 = Not Checked
			*/
			SUM(CASE WHEN ReferralOrganApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalAppropriateReferrals AS 'Total_Referrals'
			
	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Approach - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Approach' AS 'Disposition',
			2 AS 'GroupingCode', 
			Approach.ApproachName AS 'Type',
			SUM(CASE WHEN ReferralOrganApproachID > 1 AND ReferralOrganApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN ReferralBoneApproachID > 1 AND ReferralBoneApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueApproachID > 1 AND ReferralTissueApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN ReferralSkinApproachID > 1 AND ReferralSkinApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesApproachID > 1 AND ReferralValvesApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransApproachID > 1 AND ReferralEyesTransApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschApproachID > 1 AND ReferralEyesRschApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalAppropriateReferrals AS 'Total_Referrals'
			
	FROM 	Approach, #Temp_OutcomeByCategory_Select
	WHERE	Approach.ApproachID > 1 AND Approach.Inactive <> 1
	GROUP BY Approach.ApproachName,
			 Approach.ApproachReportDisplaySort1
	ORDER BY Approach.ApproachName

/*** End APPROACH ***/


/*** CONSENT ***/
	/* Registry Consent */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)

	SELECT
			0 AS 'FormatCode',
			'Consent' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1 = Blank
				 1 = Yes
				 3 = Not on Registry
				 5 = Not Checked
			*/
			SUM(CASE WHEN ReferralOrganConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalApproachReferrals AS 'Total_Referrals'

	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Consent - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Consent' AS 'Disposition',
			2 AS 'GroupingCode', 
			Consent.ConsentName AS 'Type',
			SUM(CASE WHEN ReferralOrganConsentID > 1 AND ReferralOrganConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN ReferralBoneConsentID > 1 AND ReferralBoneConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueConsentID > 1 AND ReferralTissueConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN ReferralSkinConsentID > 1 AND ReferralSkinConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesConsentID > 1 AND ReferralValvesConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransConsentID > 1 AND ReferralEyesTransConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschConsentID > 1 AND ReferralEyesRschConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalApproachReferrals AS 'Total_Referrals'
			
	FROM 	Consent, #Temp_OutcomeByCategory_Select
	WHERE	Consent.ConsentID > 1 AND Consent.Inactive <> 1
	GROUP BY Consent.ConsentName,
			 Consent.ConsentReportDisplaySort1
	ORDER BY Consent.ConsentName
	
/*** End CONSENT ***/


/*** RECOVERY ***/
	/* Registry Recovery (Conversion) */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)

	SELECT
			0 AS 'FormatCode',
			'Recovery' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1=Blank, 1=Yes, 3=Not on Registry, 5=Not Checked 	*/
			SUM(CASE WHEN ReferralOrganConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalConsentReferrals AS 'Total_Referrals'
			
	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Recovered - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Recovery' AS 'Disposition',
			2 AS 'GroupingCode', 
			Conversion.ConversionName AS 'Type',
			SUM(CASE WHEN ReferralOrganConversionID > 1 AND ReferralOrganConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN ReferralBoneConversionID > 1 AND ReferralBoneConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueConversionID > 1 AND ReferralTissueConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN ReferralSkinConversionID > 1 AND ReferralSkinConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesConversionID > 1 AND ReferralValvesConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransConversionID > 1 AND ReferralEyesTransConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschConversionID > 1 AND ReferralEyesRschConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			@TotalConsentReferrals AS 'Total_Referrals'
			
	FROM 	Conversion, #Temp_OutcomeByCategory_Select
	WHERE	Conversion.ConversionID > 1 AND Conversion.Inactive <> 1
	GROUP BY Conversion.ConversionName,
			 Conversion.ConversionReportDisplaySort1
	ORDER BY Conversion.ConversionName

/*** End RECOVERY ***/



/*** Start Totals ***/
	/*** TOTAL Referrals */
	INSERT INTO @TempCounts
	SELECT
			1 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Total Referrals' AS'Type',
			0 AS 'Organs',
			0 AS 'Bone',
			0 AS 'Soft_Tissue',
			0 AS 'Skin',
			0 AS 'Valves',
			0 AS 'Eyes',
			0 AS 'Other',
			@TotalReferralStateRegistry,
			@TotalReferralWebRegistry,
			@TotalReferralManuallyFound,
			@TotalReferralNotRegistered,
			@TotalReferralReferrals

	/*** TOTAL Appropriate */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Appropriate' AS'Type',
			0 AS 'Organs',
			0 AS 'Bone',
			0 AS 'Soft_Tissue',
			0 AS 'Skin',
			0 AS 'Valves',
			0 AS 'Eyes',
			0 AS 'Other',
			SUM(CASE WHEN RegistryStatus = 1 AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

			SUM(CASE WHEN RegistryStatus = 2 AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

			SUM(CASE WHEN RegistryStatus = 4 AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

			SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',
			
			SUM(CASE WHEN 
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
			
	FROM	#Temp_OutcomeByCategory_Select


	/*** TOTAL Approach */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Approach' AS'Type',
			0 AS 'Organs',
			0 AS 'Bone',
			0 AS 'Soft_Tissue',
			0 AS 'Skin',
			0 AS 'Valves',
			0 AS 'Eyes',
			0 AS 'Other',
			@TotalApproachStateRegistry,
			@TotalApproachWebRegistry,
			@TotalApproachManuallyFound,
			@TotalApproachNotRegistered,
			@TotalApproachReferrals


	/*** TOTAL Consent */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Consent' AS'Type',
			0 AS 'Organs',
			0 AS 'Bone',
			0 AS 'Soft_Tissue',
			0 AS 'Skin',
			0 AS 'Valves',
			0 AS 'Eyes',
			0 AS 'Other',
			@TotalConsentStateRegistry,
			@TotalConsentWebRegistry,
			@TotalConsentManuallyFound,
			@TotalConsentNotRegistered,
			@TotalConsentReferrals


	/*** TOTAL Recovery - Conversion */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Recovery' AS'Type',
			0 AS 'Organs',
			0 AS 'Bone',
			0 AS 'Soft_Tissue',
			0 AS 'Skin',
			0 AS 'Valves',
			0 AS 'Eyes',
			0 AS 'Other',
			@TotalRecoveryStateRegistry AS 'Total_StateRegistry',
			@TotalRecoveryWebRegistry AS 'Total_WebRegistry',
			@TotalRecoveryManuallyFound AS 'Total_ManuallyFound',
			@TotalRecoveryNotRegistered AS 'Total_NotRegistered',
			@TotalRecoveryReferrals AS 'Total_Referrals'
 /*** END Totals ***/
/*** End Counts  ***/


--SELECT * FROM #Temp_OutcomeByCategory_Select
SELECT * FROM @TempCounts

DROP TABLE #Temp_OutcomeByCategory_Select

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_PendingReferrals_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_PendingReferrals_Select'
		DROP  Procedure  sps_rpt_PendingReferrals_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_PendingReferrals_Select'
GO


CREATE Procedure sps_rpt_PendingReferrals_Select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	
	@ReferralType				int = Null,		

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@DisplayMT					int = Null
AS
/******************************************************************************
**		File: sps_rpt_PendingReferrals_Select.sql
**		Name: sps_rpt_PendingReferrals_Select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 10/10/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      10/10/2008		ccarroll			Initial release
**		06/22/2009		ccarroll			HS 17764, Categories not checked in View By Option
**											(StatTrac Report Groups) are not displayed when only item pending.
*******************************************************************************/

IF @LowerAgeLimit Is Not Null AND IsNull(@UpperAgeLimit, 0) = 0
BEGIN
	/* Set default limit */
	SELECT @UpperAgeLimit = 200
END

IF IsNull(@LowerAgeLimit, 0) = 0  AND @UpperAgeLimit Is Not Null
BEGIN
	/* Set default limit */
	SELECT @LowerAgeLimit = 0
END


/*	The following parameters are used to define referral type groups.
	Categories can be turned on and off within a group to determine the 
	referrals selected in the report.
	Key:
		0 = Display (Select)
		1 = Hide (Exclude from selection) 
	
	Example values of a referral type group:
		@Organ (1, 0)
		@Bone (1, 0)
		@Tissue (1, 0)
		@Skin (1, 0)
		@EyesTrans (1, 0)
		@EyesRsch (1, 0)
		@Valves (1, 0)
*/

DECLARE @Organ Int
DECLARE @Bone Int
DECLARE @Tissue Int
DECLARE @Skin Int
DECLARE @EyesTrans Int
DECLARE @EyesRsch Int
DECLARE @Valves Int


		IF IsNull(@ReferralType, 0) = 0 /* Select all */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 0
					SET @Bone = 0 
					SET @Tissue = 0
					SET @Skin = 0
					SET @EyesTrans = 0
					SET @EyesRsch = 0
					SET @Valves = 0 -- 1 HS:17764
			END 

		IF IsNull(@ReferralType, 0) = 1 /* Organ/Tissue/Eye - Select all */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 0
					SET @Bone = 0 
					SET @Tissue = 0
					SET @Skin = 0
					SET @EyesTrans = 0
					SET @EyesRsch = 1
					SET @Valves = 1 
			END 

		IF IsNull(@ReferralType, 0) = 2 /* Tissue/Eye */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 1
					SET @Bone = 0 
					SET @Tissue = 0
					SET @Skin = 0
					SET @EyesTrans = 0
					SET @EyesRsch = 1
					SET @Valves = 1 
			END	

		IF IsNull(@ReferralType, 0) = 3 /* Eyes Only */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 1
					SET @Bone = 1 
					SET @Tissue = 1
					SET @Skin = 1
					SET @EyesTrans = 0
					SET @EyesRsch = 1
					SET @Valves = 1 
			END	

SELECT  DISTINCT
	call.CallID,
	LT.CallDateTime AS 'BasedOnDT',
	Organization.OrganizationName AS 'ReferralFacility',

	/* Patient Information */
	IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
	Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' / ' + Referral.ReferralDonorGender + ' / ' + isnull(UPPER(SUBSTRING(race.RaceName,1,2)),'') AS 'A/S/R',

	/* RS Search parameters */
	Referral.ReferralDonorLastName AS 'PatientLastName',
	Referral.ReferralDonorFirstName AS 'PatientFirstName',

	/* RS GroupBy ReferralType ID */
	Referral.ReferralTypeID

FROM Call 
Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallID						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		Null						 ,
		Null						 ,
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
	JOIN Referral ON Referral.CallID = Call.CallID 
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
		/* 06/19/2009 ccarroll - HS 17764 added table join for category access */
 	LEFT JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = ISNULL(@ReportGroupID, 0) AND (WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID)

	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
		--	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 


WHERE ISNULL(@CallID,call.CallID) = call.CallID
	/* Search - ReportGroup */
		AND Call.SourceCodeID IN 
			(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))

	/* Search - Referral Type */
		AND IsNull(ReferralTypeID, 0) <> 4 
--		AND (IsNull(ReferralTypeID, 0) = IsNull(@ReferralType, ReferralTypeID) AND IsNull(ReferralTypeID, 0) <> 4) 

	/* Pending Referrals */
		AND (/* HS 17764 - Added StatTrac Report Group Access
				If one of the View By Report Group options in StatTrac is turned off and the category item
				is shown as pending, then the referral is not permitted to display. The exception is
				when another category in the same referral has a pending condition. 			
				*/
				(	/* Approach Type: Access(1) + Unknown(2) + Display(0) = true(3) */
					(AccessOrgans + ReferralOrganApproachID + @Organ) = 3 OR
					(AccessBone + ReferralBoneApproachID + @Bone) = 3 OR
					(AccessTissue + ReferralTissueApproachID + @Tissue) = 3 OR
					(AccessSkin + ReferralSkinApproachID + @Skin) = 3 OR
					(AccessEyes + ReferralEyesTransApproachID + @EyesTrans) = 3 OR
					(AccessResearch + ReferralEyesRschApproachID + @EyesRsch) = 3 OR
					(AccessValves + ReferralValvesApproachID + @Valves) = 3
					) OR
--				(	/* Consent Type: (5)No,Unknown */
--					ReferralOrganConsentID = 5 OR
--					ReferralBoneConsentID = 5 OR
--					ReferralTissueConsentID = 5 OR
--					ReferralSkinConsentID = 5 OR
--					ReferralEyesTransConsentID = 5 OR
--					ReferralEyesRschConsentID = 5 OR
--					ReferralValvesConsentID = 5
--					) OR
				(	/* Conversion Type: Access(1) + Unknown(9) + Display(0) = true(10)*/ 
					(AccessOrgans + ReferralOrganConversionID + @Organ) = 10 OR
					(AccessBone + ReferralBoneConversionID + @Bone) = 10 OR
					(AccessTissue + ReferralTissueConversionID + @Tissue) = 10 OR
					(AccessSkin + ReferralSkinConversionID + @Skin) = 10 OR
					(AccessEyes + ReferralEyesTransConversionID + @EyesTrans) = 10 OR
					(AccessResearch + ReferralEyesRschConversionID + @EyesRsch) = 10 OR
					(AccessValves + ReferralValvesConversionID + @Valves) = 10
					) OR
				(	/* Appropriate: Access(1) + Yes(1) + Display(0) = true(2), Approach: Blank(-1) + Access(1) + display(0) = true(0) */ 
					(AccessOrgans + ReferralOrganAppropriateID + @Organ = 2 AND IsNull(ReferralOrganApproachID, -1) + AccessOrgans + @Organ = 0) OR
					(AccessBone + ReferralBoneAppropriateID + @Bone = 2 AND IsNull(ReferralBoneApproachID, -1) + AccessBone + @Bone = 0) OR
					(AccessTissue + ReferralTissueAppropriateID + @Tissue = 2 AND IsNull(ReferralTissueApproachID, -1) + AccessTissue + @Tissue = 0) OR
					(AccessSkin + ReferralSkinAppropriateID + @Skin = 2 AND IsNull(ReferralSkinApproachID, -1) + AccessSkin + @Skin = 0) OR
					(AccessEyes + ReferralEyesTransAppropriateID + @EyesTrans = 2 AND IsNull(ReferralEyesTransApproachID, -1) + AccessEyes + @EyesTrans = 0) OR
					(AccessResearch + ReferralEyesRschAppropriateID + @EyesRsch = 2 AND IsNull(ReferralEyesRschApproachID, -1) + AccessResearch + @EyesRsch = 0) OR
					(AccessValves + ReferralValvesAppropriateID + @Valves = 2 AND IsNull(ReferralValvesApproachID, -1) + AccessValves + @Valves = 0)
					) OR

				(	/* Approach: Access(1) + Yes(1) + display(0) = true(2), Consent: = Access(1) + (-1)Blank + Access(1) + display(0) = true(0) */ 
					(AccessOrgans + ReferralOrganApproachID + @Organ = 2 AND IsNull(ReferralOrganConsentID, -1) + AccessOrgans + @Organ = 0) OR
					(AccessBone + ReferralBoneApproachID + @Bone = 2 AND IsNull(ReferralBoneConsentID, -1)+ AccessBone + @Bone = 0) OR
					(AccessTissue + ReferralTissueApproachID + @Tissue = 2 AND IsNull(ReferralTissueConsentID, -1) + AccessTissue + @Tissue = 0) OR
					(AccessSkin + ReferralSkinApproachID + @Skin = 2 AND IsNull(ReferralSkinConsentID, -1) + AccessSkin + @Skin = 0) OR
					(AccessEyes + ReferralEyesTransApproachID + @EyesTrans = 2 AND IsNull(ReferralEyesTransConsentID, -1) + AccessEyes + @EyesTrans = 0) OR
					(AccessResearch + ReferralEyesRschApproachID + @EyesRsch = 2 AND IsNull(ReferralEyesRschConsentID, -1) + AccessResearch + @EyesRsch = 0) OR
					(AccessValves + ReferralValvesApproachID + @Valves = 1 AND IsNull(ReferralValvesConsentID, -1) + AccessValves + @Valves = 0)
					) OR

				(	/* Consent: Access(1) + Yes(1) display(0) = true(2), Recovery: = Blank(-1) + Access(1) + diaplay(0) = true(0) */ 
					(AccessOrgans + ReferralOrganConsentID + @Organ = 2 AND IsNull(ReferralOrganConversionID, -1) + AccessOrgans + @Organ = 0) OR
					(AccessBone + ReferralBoneConsentID + @Bone = 2 AND IsNull(ReferralBoneConversionID, -1)+ AccessBone + @Bone = 0) OR
					(AccessTissue + ReferralTissueConsentID + @Tissue = 2 AND IsNull(ReferralTissueConversionID, -1) + AccessTissue + @Tissue = 0) OR
					(AccessSkin + ReferralSkinConsentID + @Skin = 2 AND IsNull(ReferralSkinConversionID, -1) + AccessSkin + @Skin = 0) OR
					(AccessEyes + ReferralEyesTransConsentID + @EyesTrans = 2 AND IsNull(ReferralEyesTransConversionID, -1) + AccessEyes + @EyesTrans = 0) OR
					(AccessResearch + ReferralEyesRschConsentID + @EyesRsch = 2 AND IsNull(ReferralEyesRschConversionID, -1) + AccessResearch + @EyesRsch = 0) OR
					(AccessValves + ReferralValvesConsentID + @Valves = 2 AND IsNull(ReferralValvesConversionID, -1) + AccessValves + @Valves = 0)
					) 
			)

--		AND (
--				AccessOrgans + @Organ <> 0 OR
--				AccessBone + @Bone <> 0 OR
--				AccessTissue + @Tissue <> 0 OR
--				AccessSkin + @Skin <> 0 OR
--				AccessEyes + @EyesTrans <> 0 OR
--				AccessResearch + @EyesRsch <> 0 OR
--				AccessValves + @Valves <> 0
--			)

	/* Search - Organization */
		AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)

	/* Search - Lower/Upper Age Limit */
		AND (  --- either use the fn_rpt_DonorAgeYear or ignore
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate, ReferralDonorAge,ReferralDonorAgeUnit)
		BETWEEN @LowerAgeLimit AND @UpperAgeLimit)	OR 	(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)		
	/* Search - Coordinator */
		AND IsNull(Call.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(Call.StatEmployeeID, 0))

	/* Search - Gender */
		AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))

		AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


GROUP BY

	Referral.ReferralTypeID,
	Call.CallID,
	LT.CallDateTime,

	Referral.ReferralDonorLastName,
	Referral.ReferralDonorFirstName,
	Referral.ReferralDonorNameMI,
	Referral.ReferralDonorAge,
	Referral.ReferralDonorAgeUnit,
	Referral.ReferralDonorGender,

	Organization.OrganizationName,
	Race.RaceName





GO



 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity'
		DROP  Procedure  sps_rpt_ReferralActivity
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity'
GO


CREATE Procedure sps_rpt_ReferralActivity
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	
	@PatientFirstName			varchar(40) = Null,
	@PatientLastName			varchar(40) = Null,
	@MedicalRecordNumber		varchar(30) = Null,
	@ReferralType				int = Null,		

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@UserOrgID					int = Null,
	@UserID						int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralActivity.sql
**		Name: sps_rpt_ReferralActivity
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 08/27/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      08/30/2007		ccarroll			Initial release
**		11/15/2007		ccarroll			Added FN for ConvertDateTime
**		06/2008 		jth					fix cardiac/referral date selection, create groupby field, 
**											remove unneeded columns,fixed join to get alert group
**		09/30/2008		ccarroll			Added selection for Archive data
**      04/2009         jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
*******************************************************************************/

DECLARE @Source_DB int  
SET @Source_DB = 1 /* SET database to production (default) */

	/* Search parameter configuration check
	If dates are entered with CallID value then the CallID
	value will have priority and will be searched */
IF  IsNull(@CallID, 0) <> 0 
		BEGIN
			SET @ReferralStartDateTime	= Null
			SET @ReferralEndDateTime	= Null
			SET @CardiacStartDateTime	= Null
			SET @CardiacEndDateTime		= Null
			SET	@PatientFirstName		= Null
			SET @PatientLastName		= Null
			SET @MedicalRecordNumber	= Null
			SET @ReferralType			= Null		
			SET @SourceCodeName			= Null
			SET @CoordinatorID			= Null
			SET	@LowerAgeLimit			= Null
			SET	@UpperAgeLimit			= Null
			SET	@Gender					= Null

			IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
				BEGIN /* production database */
					SET @Source_DB = 1
				END
			ELSE
				BEGIN /* Archive database */
					SET @Source_DB = 2
				END

		END
ELSE
	BEGIN
	/* determine if date range is in Archive db */
	DECLARE @maxTableDate DATETIME
	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

		IF (ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 1
			END 

		IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
			AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) < @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 2
			END 

		IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
			AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) > @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 3
			END 


		/* Configure ReferralType search parameter. Default <Null> (or 0) will return all referral types  */
		IF @ReferralType = 0
			BEGIN
				SET @ReferralType = Null
			END
		/* Allow wildcard search using asteric [*]  */
		IF @PatientFirstName IS NOT Null
			BEGIN
				SET @PatientFirstName = REPLACE(@PatientFirstName,'*','%')
			END
		IF @PatientLastName IS NOT Null
			BEGIN
				SET @PatientLastName = REPLACE(@PatientLastName,'*','%')
			END
		IF @MedicalRecordNumber IS NOT Null
			BEGIN
				SET @MedicalRecordNumber = REPLACE(@MedicalRecordNumber,'*','%')
			END
END


CREATE TABLE #sps_rpt_ReferralActivityResults
   (
	[CallID][int] NULL, 
	[CallNumber] [varchar] (500) NULL,
	[ReferralType] [varchar] (500) NULL,
	[AlertGroup] [varchar] (500) NULL,
	[AlertID] [int] NULL,
	[BasedOnDT1] [varchar] (500) NULL,
	[ReferralFacility] [varchar] (500) NULL,
	[ReferralPerson] [varchar] (500) NULL,
	[HospitalUnit] [varchar] (500) NULL,
	[Floor] [varchar] (500) NULL,
	[GroupBy] [varchar] (500) NULL,
	[PatientName] [varchar] (500) NULL,
	[A/S/R] [varchar] (500) NULL,
	[MedicalRecordNumber] [varchar] (500) NULL,
	[AppropriateOrgan] [varchar] (50) NULL,
	[ApproachOrgan] [varchar] (50) NULL,
	[ConsentOrgan] [varchar] (50) NULL,
	[RecoveryOrgan] [varchar] (50) NULL,
	[AppropriateBone] [varchar] (50) NULL,
	[ApproachBone] [varchar] (50) NULL,
	[ConsentBone] [varchar] (50) NULL,
	[RecoveryBone] [varchar] (50) NULL,
	[AppropriateTissue] [varchar] (50) NULL,
	[ApproachTissue] [varchar] (50) NULL,
	[ConsentTissue] [varchar] (50) NULL,
	[RecoveryTissue] [varchar] (50) NULL,
	[AppropriateSkin] [varchar] (50) NULL,
	[ApproachSkin] [varchar] (50) NULL,
	[ConsentSkin] [varchar] (50) NULL,
	[RecoverySkin] [varchar] (50) NULL,
	[AppropriateValve] [varchar] (50) NULL,
	[ApproachValve] [varchar] (50) NULL,
	[ConsentValve] [varchar] (50) NULL,
	[RecoveryValve] [varchar] (50) NULL,
	[AppropriateEyes] [varchar] (50) NULL,
	[ApproachEyes] [varchar] (50) NULL,
	[ConsentEyes] [varchar] (50) NULL,
	[RecoveryEyes] [varchar] (50) NULL,
	[AppropriateOther] [varchar] (50) NULL,
	[ApproachOther] [varchar] (50) NULL,
	[ConsentOther] [varchar] (50) NULL,
	[RecoveryOther] [varchar] (50) NULL,
	[PatientLastName] [varchar] (150) NULL,
	[PatientFirstName] [varchar] (150) NULL,
	[ReferralTypeID] [int] NULL,
	[CountOrganTissueEye] [int] NULL,
	[CountTissueEye] [int] NULL,
	[CountEyesOnly] [int] NULL,
	[CountRuleOut] [int] NULL
	)


	IF @Source_DB = 3
				BEGIN /* Need to run in both archive and production databases */
					  /* run in Archive database */	
					INSERT #sps_rpt_ReferralActivityResults 
						EXEC _ReferralProdArchive..sps_rpt_ReferralActivity_Select
							@CallID,
							@ReferralStartDateTime,
							@ReferralEndDateTime, 
							@CardiacStartDateTime,
							@CardiacEndDateTime,

							@PatientFirstName,
							@PatientLastName,
							@MedicalRecordNumber,
							@ReferralType, 

							@ReportGroupID, 
							@OrganizationID, 
							@SourceCodeName, 
							@CoordinatorID, 
							@LowerAgeLimit, 
							@UpperAgeLimit, 
							@Gender, 

							@UserOrgID, 
							@UserID, 
							@DisplayMT 

					/* run in production database */
					INSERT #sps_rpt_ReferralActivityResults 
						EXEC sps_rpt_ReferralActivity_Select
							@CallID,
							@ReferralStartDateTime,
							@ReferralEndDateTime, 
							@CardiacStartDateTime,
							@CardiacEndDateTime,

							@PatientFirstName,
							@PatientLastName,
							@MedicalRecordNumber,
							@ReferralType, 

							@ReportGroupID, 
							@OrganizationID, 
							@SourceCodeName, 
							@CoordinatorID, 
							@LowerAgeLimit, 
							@UpperAgeLimit, 
							@Gender, 

							@UserOrgID, 
							@UserID, 
							@DisplayMT 
				END

	IF @Source_DB = 2
				BEGIN
					/* run in Archive database only */	
					INSERT #sps_rpt_ReferralActivityResults 
						EXEC _ReferralProdArchive..sps_rpt_ReferralActivity_Select
							@CallID,
							@ReferralStartDateTime,
							@ReferralEndDateTime, 
							@CardiacStartDateTime,
							@CardiacEndDateTime,

							@PatientFirstName,
							@PatientLastName,
							@MedicalRecordNumber,
							@ReferralType, 

							@ReportGroupID, 
							@OrganizationID, 
							@SourceCodeName, 
							@CoordinatorID, 
							@LowerAgeLimit, 
							@UpperAgeLimit, 
							@Gender, 

							@UserOrgID, 
							@UserID, 
							@DisplayMT 
				END

	IF @Source_DB = 1
			BEGIN	/* run in production database only */
			INSERT #sps_rpt_ReferralActivityResults 
				EXEC sps_rpt_ReferralActivity_Select
							@CallID,
							@ReferralStartDateTime,
							@ReferralEndDateTime, 
							@CardiacStartDateTime,
							@CardiacEndDateTime,

							@PatientFirstName,
							@PatientLastName,
							@MedicalRecordNumber,
							@ReferralType, 

							@ReportGroupID, 
							@OrganizationID, 
							@SourceCodeName, 
							@CoordinatorID, 
							@LowerAgeLimit, 
							@UpperAgeLimit, 
							@Gender, 

							@UserOrgID, 
							@UserID, 
							@DisplayMT 
			END


SELECT * FROM #sps_rpt_ReferralActivityResults

DROP TABLE #sps_rpt_ReferralActivityResults

GO



 GO 

 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity_count_select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity'
		DROP  Procedure  sps_rpt_ReferralActivity_count_select
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity_count_select'
GO


CREATE Procedure sps_rpt_ReferralActivity_count_select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	
	@PatientFirstName			varchar(40) = Null,
	@PatientLastName			varchar(40) = Null,
	@MedicalRecordNumber		varchar(30) = Null,
	@ReferralType				int = Null,		

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@UserOrgID					int = Null,
	@UserID						int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralActivity_count_select.sql
**		Name: sps_rpt_ReferralActivity_count_select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 05/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		09/30/2008		ccarroll			Added for Archive and Production selects
*******************************************************************************/


SELECT  COUNT(DISTINCT Referral.CallID) 'RecordCount'
FROM Call 
Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallID						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		@CardiacStartDateTime		 ,
		@CardiacEndDateTime			 , 
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
	JOIN Referral ON Referral.CallID = Call.CallID 
	LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	INNER JOIN AlertOrganization ON Referral.ReferralCallerOrganizationID = AlertOrganization.OrganizationID 
	INNER JOIN  AlertSourceCode ON Call.SourceCodeID = AlertSourceCode.SourceCodeID 
	INNER JOIN  Alert ON AlertOrganization.AlertID = Alert.AlertID  
	AND AlertSourceCode.AlertID = Alert.AlertID 
	--LEFT JOIN AlertOrganization ON AlertOrganization.OrganizationID = Organization.OrganizationID AND Organization.Inactive = 0
	--LEFT JOIN Alert ON Alert.AlertID = AlertOrganization.AlertID 
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
	LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
	LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
	LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
	LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
	LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
	LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
	LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
	LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
	LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
	LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
	LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
	LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
	LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
	LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
	LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
	LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
	LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
	LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
	LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
	LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
	LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
	LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 
	LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID 
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 

WHERE ISNULL(@CallID,call.CallID) = call.CallID


	/* Search - ReportGroup */
		AND Call.SourceCodeID IN 
			(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))

	/* Search - Organization */
		AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)

	/* Search - Referral Type */
		AND IsNull(Referral.ReferralTypeID, 0) = IsNull(@ReferralType, IsNull(Referral.ReferralTypeID, 0))

	/* Search - Lower/Upper Age Limit */
		AND (  --- either use the fn_rpt_DonorAgeYear or ignore
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
		BETWEEN ISNULL(@LowerAgeLimit, 0) AND ISNULL(@UpperAgeLimit, 0))	OR 	(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)		
	/* Search - Coordinator */
		AND IsNull(LogEvent.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(LogEvent.StatEmployeeID, 0))

	/* Search - Gender */
		AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))

		AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)

	/* Search (wildcards permitted) - PatientLastName */
	--	AND PATINDEX(IsNull(@PatientLastName, IsNull(Referral.ReferralDonorLastName, 0)), IsNull(Referral.ReferralDonorLastName, 0)) > 0
	AND ISNULL(PATINDEX(@PatientLastName, ISNULL(Referral.ReferralDonorLastName, 0)), -1) <> 0
	/* Search (wildcards permitted) - PatientFirstName */
		--AND PATINDEX(IsNull(@PatientFirstName, IsNull(Referral.ReferralDonorFirstName, 0)), IsNull(Referral.ReferralDonorFirstName, 0)) > 0
	AND ISNULL(PATINDEX(@PatientFirstName, ISNULL(Referral.ReferralDonorFirstName, 0)), -1) <> 0
	/* Search (wildcards permitted) - Medical Record# */
	--	AND PATINDEX(IsNull(@MedicalRecordNumber, IsNull(Referral.ReferralDonorRecNumber, 0)), IsNull(Referral.ReferralDonorRecNumber, 0)) > 0
	AND ISNULL(PATINDEX(@MedicalRecordNumber, ISNULL(Referral.ReferralDonorRecNumber, 0)), -1) <> 0

GO



 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity_Select'
		DROP  Procedure  sps_rpt_ReferralActivity_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity_Select'
GO


CREATE Procedure sps_rpt_ReferralActivity_Select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	
	@PatientFirstName			varchar(40) = Null,
	@PatientLastName			varchar(40) = Null,
	@MedicalRecordNumber		varchar(30) = Null,
	@ReferralType				int = Null,		

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@UserOrgID					int = Null,
	@UserID						int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralActivity_Select.sql
**		Name: sps_rpt_ReferralActivity_Select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 08/27/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      08/30/2007		ccarroll			Initial release
**		11/15/2007		ccarroll			Added FN for ConvertDateTime
**		06/2008 		jth					fix cardiac/referral date selection, create groupby field, 
**											remove unneeded columns,fixed join to get alert group
**		09/30/2008		ccarroll			Added selection for Archive data
**      04/2009         jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
**      04/2009         jth                 fixed handling of null age limits
*******************************************************************************/


SELECT  DISTINCT
	call.CallID,
	call.CallNumber,
	ReferralType.ReferralTypeName AS 'ReferralType',
	Alert.AlertGroupName AS 'AlertGroup',
	Alert.AlertID,
	CASE WHEN (@CardiacStartDateTime Is Not Null) 
		 --THEN ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + ISNULL(ReferralDonorDeathTime, ' ')
		 THEN convert(datetime,ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + substring(ISNULL(ReferralDonorDeathTime, '00:00 '),1,5))
		ELSE LT.CallDateTime
		 END AS 'BasedOnDT1',
	/* LT.CallDateTime AS CallDateTime,
	CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
	CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,
	Caller Information */
	Organization.OrganizationName AS 'ReferralFacility',
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',
	SubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	CASE WHEN (@ReportGroupID = 37) 
		 THEN Alert.AlertGroupName
		 ELSE Organization.OrganizationName
		 END AS GroupBy,
	/* Patient Information */
	IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
	Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' / ' + Referral.ReferralDonorGender + ' / ' + isnull(UPPER(SUBSTRING(race.RaceName,1,2)),'') AS 'A/S/R',
	Referral.ReferralDonorRecNumber AS 'MedicalRecordNumber',

	/* Disposition */
		/* Custom Mapping
		1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.

		Note: If client's service level is turned off, default values are set by the 
		function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
		future by changing the return value in the function. All reports using this function will 
		receive the new default value. Passing the function either a blank ('') or NULL value will cause
		the default value to be returned. If the UserOrg = 194 all data will be displaied */

		/* Organ @UserOrgId = 194 OR */
		AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOrgan,
		
		/* Bone*/
		AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryBone,

		/* Tissue*/
		AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryTissue, 

		/* Skin*/
		AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoverySkin, 

		/* Valves*/
		AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryValve, 

		/* Eyes*/
		AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryEyes, 

		/* Other*/
		AppropRsch.AppropriateReportName AS AppropriateOther,
		ApproaRsch.ApproachReportName AS ApproachOther,
		ConsentRsch.ConsentReportName AS ConsentOther,
		RecoveryRsch.ConversionReportName AS RecoveryOther,

		/* RS Search parameters */
		Referral.ReferralDonorLastName AS 'PatientLastName',
		Referral.ReferralDonorFirstName AS 'PatientFirstName',

		/* RS GroupBy ReferralType ID */
		Referral.ReferralTypeID,

		/* ReferralType Counts */
		Case WHEN Referral.ReferralTypeID = 1 THEN 1 ELSE 0 END AS 'CountOrganTissueEye',
		Case WHEN Referral.ReferralTypeID = 2 THEN 1 ELSE 0 END AS 'CountTissueEye',
		Case WHEN Referral.ReferralTypeID = 3 THEN 1 ELSE 0 END AS 'CountEyesOnly',
		Case WHEN IsNull(Referral.ReferralTypeID, 0) = 4 THEN 1 ELSE 0 END AS 'CountRuleOut'
	
FROM Call 
Join (SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallID						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		@CardiacStartDateTime		 ,
		@CardiacEndDateTime			 , 
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
	JOIN Referral ON Referral.CallID = Call.CallID 
	LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	INNER JOIN AlertOrganization ON Referral.ReferralCallerOrganizationID = AlertOrganization.OrganizationID 
	INNER JOIN  AlertSourceCode ON Call.SourceCodeID = AlertSourceCode.SourceCodeID 
	INNER JOIN  Alert ON AlertOrganization.AlertID = Alert.AlertID  
	AND AlertSourceCode.AlertID = Alert.AlertID 
	--LEFT JOIN AlertOrganization ON AlertOrganization.OrganizationID = Organization.OrganizationID AND Organization.Inactive = 0
	--LEFT JOIN Alert ON Alert.AlertID = AlertOrganization.AlertID 
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
	LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
	LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
	LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
	LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
	LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
	LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
	LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
	LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
	LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
	LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
	LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
	LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
	LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
	LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
	LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
	LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
	LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
	LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
	LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
	LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
	LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
	LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 
	LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID 
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 

WHERE ISNULL(@CallID,call.CallID) = call.CallID


	/* Search - ReportGroup */
		AND Call.SourceCodeID IN 
			(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))

	/* Search - Organization */
		AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)

	/* Search - Referral Type */
		AND IsNull(Referral.ReferralTypeID, 0) = IsNull(@ReferralType, IsNull(Referral.ReferralTypeID, 0))

	/* Search - Lower/Upper Age Limit */
		AND (  --- either use the fn_rpt_DonorAgeYear or ignore
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
		BETWEEN ISNULL(@LowerAgeLimit, 0) AND ISNULL(@UpperAgeLimit, 0))	OR 	(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)		
	/* Search - Coordinator */
		AND IsNull(LogEvent.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(LogEvent.StatEmployeeID, 0))

	/* Search - Gender */
		AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))

		AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)

	/* Search (wildcards permitted) - PatientLastName */
	--	AND PATINDEX(IsNull(@PatientLastName, IsNull(Referral.ReferralDonorLastName, 0)), IsNull(Referral.ReferralDonorLastName, 0)) > 0
	AND ISNULL(PATINDEX(@PatientLastName, ISNULL(Referral.ReferralDonorLastName, 0)), -1) <> 0
	/* Search (wildcards permitted) - PatientFirstName */
		--AND PATINDEX(IsNull(@PatientFirstName, IsNull(Referral.ReferralDonorFirstName, 0)), IsNull(Referral.ReferralDonorFirstName, 0)) > 0
	AND ISNULL(PATINDEX(@PatientFirstName, ISNULL(Referral.ReferralDonorFirstName, 0)), -1) <> 0
	/* Search (wildcards permitted) - Medical Record# */
	--	AND PATINDEX(IsNull(@MedicalRecordNumber, IsNull(Referral.ReferralDonorRecNumber, 0)), IsNull(Referral.ReferralDonorRecNumber, 0)) > 0
	AND ISNULL(PATINDEX(@MedicalRecordNumber, ISNULL(Referral.ReferralDonorRecNumber, 0)), -1) <> 0

GROUP BY

	Referral.ReferralTypeID,
	Call.CallID,
	Call.CallNumber,
	Alert.AlertID,
	LT.CallDateTime,

	Referral.ReferralCallerOrganizationID,
	ReferralType.ReferralTypeName,

	Referral.ReferralDonorDeathDate,
	Referral.ReferralDonorDeathTime,
	Referral.ReferralCallerSubLocationLevel,
	Referral.ReferralDonorLastName,
	Referral.ReferralDonorFirstName,
	Referral.ReferralDonorNameMI,
	Referral.ReferralDonorAge,
	Referral.ReferralDonorAgeUnit,
	Referral.ReferralDonorGender,
	Referral.ReferralDonorRecNumber,

	Organization.OrganizationName,
	CallerPerson.PersonFirst,
	CallerPerson.PersonLast,
	SubLocation.SubLocationName,
	Race.RaceName,

	AppropOrgan.AppropriateReportName,
	AppropTissue.AppropriateReportName,
	AppropBone.AppropriateReportName,
	AppropSkin.AppropriateReportName,
	AppropValve.AppropriateReportName,
	AppropEyes.AppropriateReportName,
	AppropRsch.AppropriateReportName,

	ApproaOrgan.ApproachReportName,
	ApproaBone.ApproachReportName,
	ApproaTissue.ApproachReportName,
	ApproaSkin.ApproachReportName,
	ApproaValve.ApproachReportName,
	ApproaEyes.ApproachReportName,
	ApproaRsch.ApproachReportName,

	ConsentOrgan.ConsentReportName,
	ConsentBone.ConsentReportName,
	ConsentTissue.ConsentReportName,
	ConsentSkin.ConsentReportName,
	ConsentValve.ConsentReportName,
	ConsentEyes.ConsentReportName,
	ConsentRsch.ConsentReportName,

	RecoveryOrgan.ConversionReportName,
	RecoveryBone.ConversionReportName,
	RecoveryTissue.ConversionReportName,
	RecoverySkin.ConversionReportName,
	RecoveryValve.ConversionReportName,
	RecoveryEyes.ConversionReportName,
	RecoveryRsch.ConversionReportName,

	ServiceLevel.ServiceLevelApproachOrgan,
	ServiceLevel.ServiceLevelApproachBone,
	ServiceLevel.ServiceLevelApproachTissue,
	ServiceLevel.ServiceLevelApproachSkin,
	ServiceLevel.ServiceLevelApproachValves,
	ServiceLevel.ServiceLevelApproachEyes,

	ServiceLevel.ServiceLevelConsentOrgan,
	ServiceLevel.ServiceLevelConsentBone,
	ServiceLevel.ServiceLevelConsentTissue,
	ServiceLevel.ServiceLevelConsentSkin,
	ServiceLevel.ServiceLevelConsentValves,
	ServiceLevel.ServiceLevelConsentEyes,

	ServiceLevel.ServiceLevelRecoveryOrgan,
	ServiceLevel.ServiceLevelRecoveryBone,
	ServiceLevel.ServiceLevelRecoveryTissue,
	ServiceLevel.ServiceLevelRecoverySkin,
	ServiceLevel.ServiceLevelRecoveryValves,
	ServiceLevel.ServiceLevelRecoveryEyes,
	Alert.AlertGroupName



GO



 GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_DynamicDonorCategoryByOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure sps_rpt_DynamicDonorCategoryByOrg'
	drop procedure [dbo].[sps_rpt_DynamicDonorCategoryByOrg]
END

PRINT 'Creating Procedure sps_rpt_DynamicDonorCategoryByOrg'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sps_rpt_DynamicDonorCategoryByOrg

     @vOrganizationID int =null,
     @vSourceCodeName varchar(20) = null

AS
/******************************************************************************
**		File: sps_rpt_DynamicDonorCategoryByOrg.sql
**		Name: sps_rpt_DynamicDonorCategoryByOrg
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: unknown
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      08/03/2009	ccarroll			initial
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Category TABLE
(
	CategoryID Int Identity (1,1),
	CategoryName Varchar(20)
)

DECLARE @DynamicCategory TABLE
(
	DynamicCategoryID Int,
	DynamicCategoryName Varchar(20)
)

/* Enter default StatTrac category values */
INSERT INTO @Category (CategoryName) VALUES('Organ')
INSERT INTO @Category (CategoryName) VALUES('Bone')
INSERT INTO @Category (CategoryName) VALUES('Tissue')
INSERT INTO @Category (CategoryName) VALUES('Skin')
INSERT INTO @Category (CategoryName) VALUES('Valves')
INSERT INTO @Category (CategoryName) VALUES('Eyes')
INSERT INTO @Category (CategoryName) VALUES('Other')

INSERT INTO @DynamicCategory
		SELECT	DISTINCT
					Criteria.DonorCategoryID,
					DynamicDonorCategory.DynamicDonorCategoryName
		FROM
					Criteria
		JOIN		CriteriaSourceCode ON CriteriaSourceCode.CriteriaID = Criteria.CriteriaID
		JOIN		SourceCode ON SourceCode.SourceCodeID = CriteriaSourceCode.SourceCodeID
		JOIN		CriteriaOrganization ON CriteriaOrganization.CriteriaID = Criteria.CriteriaID
		JOIN		DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
		WHERE		
				OrganizationID = @vOrganizationID
				AND	PATINDEX(@vSourceCodeName, SourceCode.SourceCodeName) > 0
				AND	CriteriaStatus = 1

SELECT 
		CategoryID,
		IsNull(DynamicCategoryName, CategoryName) AS 'DynamicDonorCategoryName'
FROM @Category Category
LEFT JOIN @DynamicCategory DynamicCategory ON DynamicCategory.DynamicCategoryID = Category.CategoryID
ORDER BY CategoryID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 



 GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ReferralDetail_Triage_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_Triage_Select'
		DROP  Procedure  sps_rpt_ReferralDetail_Triage_Select
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_Triage_Select'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE sps_rpt_ReferralDetail_Triage_Select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,
	@UserOrgID					int = Null,
	@DisplaySecondary			smallint = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralDetail_Triage_Select.sql
**		Name: sps_rpt_ReferralDetail_Triage_Select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: ReferralDetail.rdl   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: christopher carroll  
**		Date: 06/13/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**      6/20/2007	ccarroll		Initail release
**		8/20/2007	ccarroll		Empirix 6728, 6729, 6730, 2726
**		8/29/2007	ccarroll		Empirix 6839
**		11/14/2007	ccarroll		TimeZone requirement changes 
**		04/07/2008	jth				Added @listTable and adjusted DeathDateConversion
**		04/25/208	Bret			Replace @listTable with dbo.fn_rpt_ReferralDateTimeConversion
**		05/08/2008	ccarroll		Changed ServiceLevelAttendingMD, ServiceLevelPronounceingMD	from -1 to 1 
**		10/02/2008	ccarroll		Added select sproc for Archive and Production db
**      03/09       jth             Don't use NOKID to link to state table to get state abbreviation
**      04/2009     jth             fixed handling of null age limits
**      05/2009     jth             Changed ServiceLevelAttendingMD, ServiceLevelPronounceingMD	test from = 1 to > 0...for some reason servicelevelattendingmd is getting set with a 2
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
DECLARE @CustomCode AS Int,
		@Results AS Int
		

/* Set CustomCode */
EXEC @CustomCode = sps_rpt_CheckCustomReportUserOrg @UserOrgID, @Results OUTPUT

SELECT  DISTINCT 
	call.CallID,
	call.CallNumber,
	LT.CallDateTime AS CallDateTime,
	CONVERT(varchar, LT.CallDateTime, 1) AS CallDate,
	CONVERT(varchar, LT.CallDateTime, 8) AS CallTime,

	ReferralType.ReferralTypeName AS PreliminaryRefType,
	CurrentRefType.ReferralTypeName AS CurrentRefType,
	ISNULL(Person.PersonFirst,' ') + ' ' + ISNULL(Person.PersonLast,' ') AS TriageCoordinator,
	@CustomCode AS 'ReportCustomCode', -- Used for special Reporting features: images, notes, etc.
	--@UserOrgTZ AS 'OrganizationTimeZone', --User Organization Time Zone
	
	/* Caller Information */
	Organization.OrganizationName AS 'ReferralFacility',
	Organization.OrganizationAddress1 + ' ' + isnull(Organization.OrganizationAddress2,' ') AS 'ReferralAddress',
	Organization.OrganizationCity + ', ' + st.stateabbrv + ' ' + Organization.OrganizationZipCode AS 'ReferralCSZ',
	
	SubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'Referralphone',
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',
	CallPersonType.PersonTypeName AS 'ReferralPersonTitle',
	ReferralCallerExtension AS 'ReferralPersonExtension',
	Organization.OrganizationID,
	SourceCode.SourceCodeName,

	/* Patient Information */
	CASE WHEN ServiceLevel.ServiceLevelFirstName = -1 THEN IsNull(Referral.ReferralDonorFirstName, '')  ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralDonorFirstName', 
	ISNULL(Referral.ReferralDonorNameMI,'') AS 'ReferralDonorNameMI',
	CASE WHEN ServiceLevel.ServiceLevelLastName = -1 THEN IsNull(Referral.ReferralDonorLastName, '') ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralDonorLastName', 
	
	CASE WHEN ServiceLevel.ServiceLevelDOB = -1 THEN CASE WHEN ISNULL(ReferralDOB_ILB, 0) = -1 THEN 'Unknown' ELSE convert(varchar,ReferralDOB,101) END ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'DateOfBirth', 
	
	CASE WHEN ServiceLevel.ServiceLevelAge = -1 THEN Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) ELSE dbo.fn_ServiceLevelDefault(NULL) END + ' / ' + CASE WHEN ServiceLevel.ServiceLevelGender = -1 THEN Referral.ReferralDonorGender ELSE dbo.fn_ServiceLevelDefault(NULL) END + ' / ' + isnull(UPPER(SUBSTRING(CASE WHEN ServiceLevel.ServiceLevelRace = -1 THEN isnull(UPPER(SUBSTRING(race.RaceName,1,2)),'') ELSE dbo.fn_ServiceLevelDefault(NULL) END,1,2)),null) AS 'A/S/R',
	CASE WHEN ServiceLevel.ServiceLevelSSN = -1 THEN Referral.ReferralDonorSSN ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'DonorSSN', 
	CASE WHEN ServiceLevel.ServiceLevelRecNum = -1 THEN Referral.ReferralDonorRecNumber ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'MedicalRecordNumber', 
	CASE WHEN ServiceLevel.ServiceLevelWeight = -1 THEN Referral.ReferralDonorWeight ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'DonorWeight', 
	CASE WHEN ServiceLevel.ServiceLevelCOD = -1 THEN CauseOfDeathName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'CauseOfDeath', 
	CASE WHEN ServiceLevel.ServiceLevelDonorSpecificCOD = -1 THEN Referral.ReferralDonorSpecificCOD ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralDonorSpecificCOD', 
	CASE WHEN ServiceLevel.ServiceLevelVent = -1 THEN ReferralDonorOnVentilator ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'OnVentilation', 
	CASE ReferralDonorHeartBeat WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE '' END AS 'ReferralDonorHeartBeat',
	Referral.ReferralExtubated,
	--ISNULL(convert(varchar, ReferralDonorAdmitDate, 101),' ') + ' ' + ISNULL(ReferralDonorAdmitTime, ' ') AS 'DonorAdmitDT',
	CASE WHEN ServiceLevel.ServiceLevelAdmitDate = -1 THEN ISNULL(convert(varchar, ReferralDonorAdmitDate, 101),' ') + ' ' + ISNULL(ReferralDonorAdmitTime, ' ') ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'DonorAdmitDT',
	--CASE WHEN ServiceLevel.ServiceLevelDeathDate = -1 THEN CASE WHEN LT.DeathDateTime = '01/01/00' THEN ' ' ELSE convert(char(10),LT.DeathDateTime,101) END ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'CardiacDeathDateTime', 
	CASE WHEN ServiceLevel.ServiceLevelDeathDate = -1 THEN ISNULL(convert(varchar, ReferralDonorDeathDate, 101),' ') + ' ' + ISNULL(ReferralDonorDeathTime, ' ') ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'DonorCardiacDeathDT',
	--ISNULL(convert(varchar, ReferralDonorBrainDeathDate, 101),' ') + ' ' + ISNULL(ReferralDonorBrainDeathTime, ' ') AS 'DonorBrainDeathDT',
	CASE WHEN ServiceLevel.ServiceLevelDonorBrainDeathDate = -1 THEN ISNULL(convert(varchar, ReferralDonorBrainDeathDate, 101),' ') + ' ' + ISNULL(ReferralDonorBrainDeathTime, ' ') ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'DonorBrainDeathDT',
	--Referral.ReferralDonorBrainDeathDate,
	--Referral.ReferralDonorBrainDeathTime,
	--CASE WHEN ServiceLevel.ServiceLevelDOA = -1 THEN Referral.ReferralDOA ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralDOA', 
	Referral.ReferralDOA,
	Referral.ReferralNotesCase AS 'MedicalHistory',

	/* Disposition */
		/* Custom Mapping
		1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.

		Note: If client's service level is turned off, default values are set by the 
		function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
		future by changing the return value in the function. All reports using this function will 
		receive the new default value. Passing the function either a blank ('') or NULL value will cause
		the default value to be returned. If the UserOrg = 194 all data will be displaied */
/* Organ @UserOrgId = 194 OR */
		--AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateOrgan = -1 THEN AppropOrgan.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOrgan,
		
		/* Bone*/
		--AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateBone = -1 THEN AppropBone.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryBone,

		/* Tissue*/
		--AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateTissue = -1 THEN AppropTissue.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryTissue, 

		/* Skin*/
		--AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateSkin = -1 THEN AppropSkin.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoverySkin, 

		/* Valves*/
		--AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateValves = -1 THEN AppropValve.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryValve, 

		/* Eyes*/
		--AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateEyes = -1 THEN AppropEyes.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryEyes, 

		/* Other*/
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateRsch = -1 THEN AppropRsch.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachRsch = -1 THEN ApproaRsch.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentRsch = -1 THEN ConsentRsch.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryRsch = -1 THEN RecoveryRsch.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOther,


	/* Approach Imformation */
--	ApproachType.ApproachTypeName AS 'FinalApproachType',
	/* Final Approach - Display values only if Secondary Servicelevel is turned ON */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN InformedApproach.FSApproachTypeName
		 ELSE '' 
	END AS 'FinalApproachType',
	
	/* Initial Approach -  */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null
		 THEN isnull(HospitalApproach.ApproachTypeName,ApproachType.ApproachTypeName) -- pull from Secondary
		 ELSE ApproachType.ApproachTypeName     -- pull from Triage
	END AS 'InitialApproachType',
	
	--ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'FinalApproacher',
	
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN ISNULL(InformedApproachPerson.PersonFirst, '') + ' ' + ISNULL(InformedApproachPerson.PersonLast, '')
		 ELSE ''
	END AS 'FinalApproacher',
	
	/* Initial Approacher - */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null
		 THEN ISNULL(HospitalApproachPerson.PersonFirst, ApproachPerson.PersonFirst) + ' ' + ISNULL(HospitalApproachPerson.PersonLast, ApproachPerson.PersonLast)
		 ELSE ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast
	END AS 'InitialApproacher',
	
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN 
				(CASE SecondaryApproach.SecondaryApproachOutcome
					WHEN 1 THEN 'Yes-Verbal'
					WHEN 2 THEN 'Yes-Written'
					WHEN 3 THEN 'No'
					WHEN 4 THEN 'Undecided' 
					ELSE '' 
				 END)
		 ELSE ''
	END AS 'FinalOutcome',
	--CASE SecondaryApproach.SecondaryApproachOutcome WHEN 1 THEN 'Yes-Written'
	--								WHEN 2 THEN 'Yes-Verbal'
	--								WHEN 3 THEN 'No'
	--						END  AS 'Final Outcome',
	--CASE SecondaryApproach.SecondaryHospitalOutcome WHEN 1 THEN 'Yes-Written'
	--								WHEN 2 THEN 'Yes-Verbal'
	--								WHEN 3 THEN 'No'
	--						END  AS 'Initial Outcome',
	/* Initial Approach Outcome - */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null and SecondaryApproach.SecondaryHospitalOutcome > 0
		 THEN (CASE SecondaryApproach.SecondaryHospitalOutcome
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
		 ELSE
			  (CASE Referral.ReferralGeneralConsent
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
	END AS 'Initial Outcome',
	
	ISNULL(RegistryStatusType.RegistryType, 'Not on Registry') AS RegistryStatus,
	
	/* Next of Kin Information */
	CASE WHEN ReferralNOKID > 0 THEN LEFT(REPLACE(REPLACE(NOK.NOKFirstName + ' ' + NOK.NOKLastName,CHAR(10), CHAR(32)), CHAR(13), ''),50) ELSE ReferralApproachNOK END AS ReferralApproachNOK,
	CASE WHEN ServiceLevel.ServiceLevelRelation = -1 THEN CASE WHEN ReferralNOKID > 0 THEN NOK.NOKApproachRelation ELSE ReferralApproachRelation END ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralApproachRelation', 
	CASE WHEN ServiceLevel.ServiceLevelNOKPhone = -1 THEN CASE WHEN ReferralNOKID > 0 THEN NOK.NOKPhone ELSE ReferralNOKPhone END ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralNOKPhone', 
	CASE WHEN ServiceLevel.ServiceLevelNOKAddress = -1 THEN CASE WHEN ReferralNOKID > 0 THEN Referral.ReferralNOKAddress end ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralNOKAddress', 
	CASE WHEN ReferralNOKID > 0 THEN NOK.NOKCity + ', ' + st.StateAbbrv + ' ' + NOK.NOKZip end AS ReferralNOKCSZ,
	st.StateAbbrv,
	/* Physician Information */
	CASE WHEN ServiceLevel.ServiceLevelAttendingMD > 0 THEN Attending.PersonFirst + ' ' + Attending.PersonLast ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'Attending', 
	CASE WHEN ServiceLevel.ServiceLevelAttendingMDPhone = -1 THEN Referral.ReferralAttendingMDPhone ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralAttendingMDPhone', 
	CASE WHEN ServiceLevel.ServiceLevelPronouncingMD > 0 THEN Pronouncing.PersonFirst + ' ' + Pronouncing.PersonLast ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'Pronouncing', 
	CASE WHEN ServiceLevel.ServiceLevelPronouncingMDPhone = -1 THEN Referral.ReferralPronouncingMDPhone ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralPronouncingMDPhone', 
	
	/* Coroner/ME Information */
	CASE WHEN Referral.ReferralCoronersCase = -1 THEN 'Yes' ELSE 'No' END AS 'CoronersCase',
	Referral.ReferralCoronerName,
	Referral.ReferralCoronerOrganization,
	Referral.ReferralCoronerPhone,
	
	Referral.ReferralCoronerNote,

	/* Additional Information */
	CallCustomField.CallCustomField1 as CustomField_1, 
	CallCustomField.CallCustomField2 as CustomField_2, 
	CallCustomField.CallCustomField3 as CustomField_3, 
	CallCustomField.CallCustomField4 as CustomField_4, 
	CallCustomField.CallCustomField5 as CustomField_5, 
	CallCustomField.CallCustomField6 as CustomField_6, 
	CallCustomField.CallCustomField7 as CustomField_7, 
	CallCustomField.CallCustomField8 as CustomField_8, 
	CallCustomField.CallCustomField9 as CustomField_9, 
	CallCustomField.CallCustomField10 as CustomField_10, 
	CallCustomField.CallCustomField11 as CustomField_11, 
	CallCustomField.CallCustomField12 as CustomField_12, 
	CallCustomField.CallCustomField13 as CustomField_13, 
	CallCustomField.CallCustomField14 as CustomField_14, 
	CallCustomField.CallCustomField15 as CustomField_15, 
	CallCustomField.CallCustomField16 as CustomField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS CustomFieldLabel_1, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS CustomFieldLabel_2, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS CustomFieldLabel_3, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS CustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS CustomFieldLabel_5, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS CustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS CustomFieldLabel_7, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS CustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS CustomFieldLabel_9, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS CustomFieldLabel_10, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS CustomFieldLabel_11, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS CustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS CustomFieldLabel_13, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS CustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS CustomFieldLabel_15, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS CustomFieldLabel_16 


FROM Call 
JOIN --- NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
	 --- converting the date as appropriate
	 --- The function limits the data returned by daterange and/or CallID
	(
		SELECT 		
			CallID, 
			CallDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallID						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		@CardiacStartDateTime		 ,
		@CardiacEndDateTime			 , 
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID
JOIN Referral ON Referral.CallID = Call.CallID
LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
LEFT JOIN NOK ON NOK.NOKID = Referral.ReferralNOKID 
--LEFT JOIN State st ON st.StateID = NOK.NOKStateID 
LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
LEFT JOIN State st ON st.StateID = Organization.StateID 
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID 
LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID 
LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
/* Hospital Approach */
LEFT JOIN SecondaryApproach ON Call.CallID = SecondaryApproach.CallID 
LEFT JOIN ApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
LEFT JOIN Person HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy 
/* Informed Approach */
LEFT JOIN FSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
LEFT JOIN Person AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy


LEFT JOIN ApproachType HospitalApproachType ON HospitalApproachType.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach 
LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD 
LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD 
LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID 
LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID 
LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
LEFT JOIN ReferralType AS CurrentRefType ON CurrentRefType.ReferralTypeID = Referral.CurrentReferralTypeID 
LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID 
LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 
LEFT JOIN ReferralSecondaryData ON ReferralSecondaryData.ReferralID = Referral.ReferralID 
LEFT JOIN CallCustomField on CallCustomField.CallID = Referral.CallID 
LEFT JOIN RegistryStatus ON RegistryStatus.CallId = Call.CallId 
LEFT JOIN RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID 
LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID 
LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 
LEFT JOIN ServiceLevelSecondary ON ServiceLevelSecondary.ServiceLevelID = CC.ServiceLevelID
LEFT JOIN FSCase ON Call.CallID =FSCase.CallID 
LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID

WHERE 
Call.SourceCodeID IN 
	  (SELECT DISTINCT * 
	    FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))
AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID, Referral.ReferralCallerOrganizationID)

AND (  --- either use the fn_rpt_DonorAgeYear or ignore
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
		BETWEEN ISNULL(@LowerAgeLimit, 0) AND ISNULL(@UpperAgeLimit, 0))
	OR
		(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)
	
AND IsNull(LogEvent.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(LogEvent.StatEmployeeID, 0))
AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


/* Default Sort order */
ORDER BY CurrentRefType.ReferralTypeName,
	 LT.CallDateTime, 
	 Referral.ReferralDonorLastName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



 GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_SecondaryDisposition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_SecondaryDisposition'
		DROP  Procedure  sps_rpt_SecondaryDisposition
	END

GO

PRINT 'Creating Procedure: sps_rpt_SecondaryDisposition'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_SecondaryDisposition
     @CallID             int          = null

AS
/******************************************************************************
**		File: sps_rpt_SecondaryDisposition.sql
**		Name: sps_rpt_SecondaryDisposition
**		Desc: This stored procedure returns a list of (secondary) dispositions for
**			  given CallID and is an option for display in ReferralDetail
**
**              
**		Return values:
** 
**		Called by: ReferralDetail_Secondary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID
**
**		Auth: christopher carroll  
**		Date: 06/13/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      6/20/2007		ccarroll				Initial release
**		05/07/2008		ccarroll				Added Triage Appropriate values Per StatTrac view
**		05/08/2008		ccarroll				Added Sub_Precedence for displaying Case Order sequence
**		10/02/2008		ccarroll				Added selection for Archive data
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Source_DB int  
SET @Source_DB = 1 /* SET database to production (default) */

	/* Is CallID in production db? */
	IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
		BEGIN /* Production database */
			SET @Source_DB = 1
		END
	ELSE
		BEGIN /* Archive database */
			SET @Source_DB = 2
		END


	/* Database Selection */
	IF @Source_DB = 2
				BEGIN
					/* run in Archive database only */	
						EXEC _ReferralProdArchive..sps_rpt_SecondaryDisposition_Select @CallID
				END

	IF @Source_DB = 1
			BEGIN	/* run in production database only */
						EXEC sps_rpt_SecondaryDisposition_Select @CallID
			END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


 GO 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_SecondaryDisposition_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_SecondaryDisposition_Select'
		DROP  Procedure  sps_rpt_SecondaryDisposition_Select
	END

GO

PRINT 'Creating Procedure: sps_rpt_SecondaryDisposition_Select'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_SecondaryDisposition_Select
     @CallID             int          = null

AS
/******************************************************************************
**		File: sps_rpt_SecondaryDisposition_Select.sql
**		Name: sps_rpt_SecondaryDisposition_Select
**		Desc: This stored procedure returns a list of (secondary) dispositions for
**			  given CallID and is an option for display in ReferralDetail
**
**              
**		Return values:
** 
**		Called by: ReferralDetail_Secondary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID
**
**		Auth: christopher carroll  
**		Date: 06/13/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      6/20/2007		ccarroll				Initial release
**		05/07/2008		ccarroll				Added Triage Appropriate values Per StatTrac view
**		05/08/2008		ccarroll				Added Sub_Precedence for displaying Case Order sequence
**		10/02/2008		ccarroll				Created select sproc for Archive for and Production db
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


DECLARE @SecondaryDispositionTable TABLE
	(
		CategoryID		Int Null,
		Category		varchar(150) Null,
		Sub_Category		varchar(150) Null,
		Sub_Precedence		Int Null,
		Processor		varchar(150) Null,
		AppropriateName		varchar(50) Null,
		ApproachName		varchar(50) Null,
		ConsentName		varchar(50) Null,
		RecoveryName		varchar(50) Null
	)

-- sp_helptext sps_SecondaryDispositionTriageDisposition 

IF EXISTS(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME LIKE '%#sps_SecondaryDispositionTriageDisposition%')
BEGIN
	DROP TABLE #sps_SecondaryDispositionTriageDisposition
END

CREATE TABLE #sps_SecondaryDispositionTriageDisposition
	(
	ReferralID  INT,
	CallID  INT,      
	DonorCategoryID  INT, 
	DonorCategoryName  VARCHAR(50),                                
	AppropriateID  INT, 
	ApproachID  INT,  
	ConsentID  INT,   
	ConversionID  INT, 
	AppropriateName  VARCHAR(50),                                    
	ApproachName  VARCHAR(50),                                       
	ConsentName  VARCHAR(50),                                        
	ConversionName  VARCHAR(50)
	)

INSERT #sps_SecondaryDispositionTriageDisposition
EXEC sps_SecondaryDispositionTriageDisposition @CALLID


INSERT @SecondaryDispositionTable
	SELECT 
		DynamicDonorCategory.DynamicDonorCategoryID AS 'CategoryID',
		DynamicDonorCategory.DynamicDonorCategoryName AS 'Category',
		SubType.SubTypeName AS 'Sub_Category',
		CriteriaSubType.SubCriteriaPrecedence AS 'Sub_Precedence',
		Organization.OrganizationName AS 'Processor',
		FSAppropriate.FSAppropriateName AS 'Appropriate',
		FSApproach.FSApproachReportName AS 'Approach',
		FSConsent.FSConsentReportName AS 'Consent',
		FSConversion.FSConversionReportName AS 'Recovery'
	FROM SecondaryDisposition
	LEFT JOIN SubCriteria ON SubCriteria.SubCriteriaID = SecondaryDisposition.SubCriteriaID
	LEFT JOIN Criteria ON Criteria.CriteriaID = SubCriteria.CriteriaID
	LEFT JOIN Organization ON Organization.OrganizationID = SubCriteria.ProcessorID
	LEFT JOIN DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	LEFT JOIN SubType ON SubType.SubTypeID = SubCriteria.SubTypeID 
    LEFT JOIN CriteriaSubType ON CriteriaSubType.CriteriaID = SubCriteria.CriteriaID and SubCriteria.SubTypeID = CriteriaSubType.SubTypeID
	LEFT JOIN FSAppropriate ON FSAppropriate.FSAppropriateID = SecondaryDisposition.SecondaryDispositionAppropriate
	LEFT JOIN FSApproach ON FSApproach.FSApproachID = SecondaryDisposition.SecondaryDispositionApproach
	LEFT JOIN FSConsent ON FSConsent.FSConsentID = SecondaryDisposition.SecondaryDispositionConsent
	LEFT JOIN FSConversion ON FSConversion.FSConversionID = SecondaryDisposition.SecondaryDispositionConversion
	WHERE SecondaryDisposition.CallID = @CallID
	


INSERT @SecondaryDispositionTable
SELECT
	sp.DonorCategoryID	AS 'CategoryID',
	sp.DonorCategoryName 	AS 'Category',
	'' 			AS 'Sub_Category',
	-1			AS 'Sub_Precedence',
	''			AS 'Processor',
	sp.AppropriateName 	AS 'AppropriateName',
	sp.ApproachName		AS 'ApproachName',
	sp.ConsentName		AS 'ConsentName',
	sp.ConversionName	AS 'RecoveryName'

FROM #sps_SecondaryDispositionTriageDisposition sp
JOIN @SecondaryDispositionTable sdt ON sdt.Category = sp.DonorCategoryName

SELECT 
	CategoryID,
	Category,
	Sub_Category,
	Processor,
	AppropriateName,
	ApproachName,
	ConsentName,
	RecoveryName
FROM @SecondaryDispositionTable
GROUP BY
	CategoryID,
	Category,
	Sub_Category,
	Sub_Precedence,
	Processor,
	AppropriateName,
	ApproachName,
	ConsentName,
	RecoveryName

ORDER BY CategoryID, Sub_Precedence

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralFacilityCompliance')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralFacilityCompliance'
		DROP  Procedure  sps_rpt_ReferralFacilityCompliance
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralFacilityCompliance'
GO


CREATE Procedure sps_rpt_ReferralFacilityCompliance
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,

	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralFacilityCompliance.sql
**		Name: sps_rpt_ReferralFacilityCompliance
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 10/20/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      10/20/2008		ccarroll			Initial release
**      12/23/2008      jth                 fixed join of temp tables...s/b refdata to orgdeaths
**      12/29/08        jth                 now inserts deaths into same temp table as referrals, join to webreportgroupid to get correct report group with org
**		06/17/2009		ccarroll			Changed table joins of final select to display all Organizations even if no deaths. HS-18361
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @YearStartID Int
DECLARE @YearEndID Int

DECLARE @MonthStartID Int
DECLARE @MonthEndID Int

SET @YearStartID = CAST(DatePart(yyyy, @ReferralStartDateTime) AS Int)
SET @MonthStartID = CAST(DatePart(m, @ReferralStartDateTime) AS Int)

SET @YearEndID = CAST(DatePart(yyyy, @ReferralEndDateTime) AS Int)
SET @MonthEndID = CAST(DatePart(m, @ReferralEndDateTime) AS Int)



DECLARE @Source_DB int  
SET @Source_DB = 1 /* SET database to production (default) */

	/* determine if date range is in Archive db */
	DECLARE @maxTableDate DATETIME
	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

		IF (ISNULL(@ReferralStartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 1
			END 

		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate 
			AND ISNULL(@ReferralEndDateTime, GetDate()) < @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 2
			END 

		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate 
			AND ISNULL(@ReferralEndDateTime, GetDate()) > @maxTableDate
			AND DB_NAME() NOT LIKE '%archive%')
			BEGIN
				SET @Source_DB = 3
			END 




CREATE TABLE #sps_rpt_ReferralFacilityComplianceResults
   (
--	[CallID] [int] NULL,
	[OrganizationID] [int] NULL,
	[OrganizationName] [varchar] (100) NULL,
	[TotalReferrals] [int] NULL,
	[TotalRegistered] [int] NULL,
	[TotalCTOD] [int] NULL,
	[ClientReportedDeaths] [int] NULL
	)

--CREATE TABLE #Temp_OrganizationDeaths
  -- (
--	[OrganizationID] [int] NULL,
--	[ClientReportedDeaths] [int] NULL
--	)


--INSERT #Temp_OrganizationDeaths
INSERT #sps_rpt_ReferralFacilityComplianceResults
SELECT 
		OrganizationID,'',0,0,0,
		sum(TotalDeaths)
FROM vwDataWarehouseOrganizationDeaths OrganizationDeaths

WHERE
		IsNull(@OrganizationID, OrganizationID) = OrganizationID
		AND CONVERT(datetime, Cast(OrganizationDeaths.MonthID AS varchar(2))+ '/01/' + Cast(OrganizationDeaths.YearID AS varchar(4)) ) BETWEEN @ReferralStartDateTime AND @ReferralEndDateTime


--		AND (OrganizationDeaths.YearID >= @YearStartID
--		AND OrganizationDeaths.MonthID >= @MonthStartID)
--		AND (OrganizationDeaths.YearID <= @YearEndID
--		AND OrganizationDeaths.MonthID <= @MonthEndID)

GROUP BY
		OrganizationID

--***TEST***
-- SELECT * FROM #Temp_OrganizationDeaths

	IF @Source_DB = 3
				BEGIN /* Need to run in both archive and production databases */
					  /* run in Archive database */	
					INSERT #sps_rpt_ReferralFacilityComplianceResults 
						EXEC _ReferralProdArchive..sps_rpt_ReferralFacilityCompliance_Select
							@ReferralStartDateTIme,
							@ReferralEndDateTime,
							@ReportGroupID,
							@OrganizationID,
							@SourceCodeName,
							@DisplayMT

					/* run in production database */
					INSERT #sps_rpt_ReferralFacilityComplianceResults 
						EXEC sps_rpt_ReferralFacilityCompliance_Select
							@ReferralStartDateTIme,
							@ReferralEndDateTime,
							@ReportGroupID,
							@OrganizationID,
							@SourceCodeName,
							@DisplayMT
				END

	IF @Source_DB = 2
				BEGIN
					/* run in Archive database only */	
					INSERT #sps_rpt_ReferralFacilityComplianceResults 
						EXEC _ReferralProdArchive..sps_rpt_ReferralFacilityCompliance_Select
							@ReferralStartDateTIme,
							@ReferralEndDateTime,
							@ReportGroupID,
							@OrganizationID,
							@SourceCodeName,
							@DisplayMT
				END

	IF @Source_DB = 1
			BEGIN	/* run in production database only */
			INSERT #sps_rpt_ReferralFacilityComplianceResults 
				EXEC sps_rpt_ReferralFacilityCompliance_Select
							@ReferralStartDateTIme,
							@ReferralEndDateTime,
							@ReportGroupID,
							@OrganizationID,
							@SourceCodeName,
							@DisplayMT
			END


/* Get SourcodeList for User ReportGroupID */
DECLARE @SourceCodeList varchar(200)
if(db_name() like '%dev%')
BEGIN
	exec _ReferralDev_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList @ReportGroupID, @SourceCodeList output
END
ELSE
BEGIN
	exec _ReferralProd_DataWarehouse.dbo.sps_GetReportGroupSourceCodeList @ReportGroupID, @SourceCodeList output
END	



SELECT
		Organization.OrganizationID,
		Organization.OrganizationName,
		SUM(ISNull(TotalReferrals,0)) AS 'TotalReferrals',
		SUM(ISNull(TotalRegistered, 0)) AS 'TotalRegistered',
		SUM(ISNull(TotalCTOD, 0)) AS 'TotalCTOD',
		@SourceCodeList AS 'SourceCodeList',
		SUM(ClientReportedDeaths) AS 'ClientReportedDeaths',
		CASE WHEN IsNull(SUM(ClientReportedDeaths), 0) > 0
			 THEN IsNull(CAST(SUM(TotalCTOD) AS Decimal), 0)/CAST(SUM(ClientReportedDeaths) AS Decimal) 
		END AS 'PercentCompliance',
		CASE WHEN IsNull(SUM(ClientReportedDeaths), 0) > 0
			 THEN 
				CASE WHEN SUM(ClientReportedDeaths) <= SUM(TotalCTOD) THEN '100 %' ELSE
					CAST(CAST((IsNull(CAST(SUM(TotalCTOD) AS Decimal), 0)/CAST(SUM(ClientReportedDeaths) AS Decimal)* 100) AS numeric(4,0)) AS varchar(15)) + ' %'
				END
			 ELSE  '-'
		END AS '%_Compliance'
FROM Organization
-- left join #Temp_OrganizationDeaths OrganizationDeaths on OrganizationDeaths.OrganizationID = ReferralFacilityComplianceResults.OrganizationID 
LEFT JOIN #sps_rpt_ReferralFacilityComplianceResults ReferralFacilityComplianceResults ON Organization.OrganizationID = ReferralFacilityComplianceResults.OrganizationID
JOIN webreportgrouporg ON webreportgrouporg.OrganizationID = Organization.OrganizationID
WHERE webreportgrouporg.webreportgroupid = @ReportGroupID
GROUP BY
Organization.OrganizationID,
Organization.OrganizationName




DROP TABLE #sps_rpt_ReferralFacilityComplianceResults

--DROP TABLE #Temp_OrganizationDeaths


GO



 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralOutcome_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralOutcome_Select'
		DROP  Procedure  sps_rpt_ReferralOutcome_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralOutcome_Select'
GO


CREATE Procedure sps_rpt_ReferralOutcome_Select
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	
	@PatientFirstName			varchar(40) = Null,
	@PatientLastName			varchar(40) = Null,
	@MedicalRecordNumber		varchar(30) = Null,
	@ReferralType				int = Null,		
	@CauseOfDeath				int = Null,

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	--@SourceCodeID				int = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@UserOrgID					int = Null,
	@UserID						int = Null,
	@DisplayMT					int = Null,
	@FS_Link					int = Null,
	@Type_Outcome				varchar(50) = Null,
	@ApproachPersonID			int = Null,
	@ReferralCallerOrgID		int = Null	

AS
/******************************************************************************
**		File: sps_rpt_ReferralOutcome_Select.sql
**		Name: sps_rpt_ReferralOutcome_Select
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 11/27/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      09/25/2007	ccarroll			Initial release
**      04/2009         jth             fixed handling of null age limits
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	
SELECT  DISTINCT
	call.CallID,
	call.CallNumber,
	ReferralType.ReferralTypeName AS 'PreliminaryRefType',
	ReferralType.ReferralTypeID,
	LT.CallDateTime AS BasedOnDT,
	/* Caller Information */
	Organization.OrganizationName AS 'ReferralFacility',
	SubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'ReferralPerson',

	/* Initial Approach -  */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null
		 THEN isnull(HospitalApproach.ApproachTypeName, ApproachType.ApproachTypeName) -- pull from Secondary
		 ELSE ApproachType.ApproachTypeName     -- pull from Triage
	END AS 'InitialApproachType',

	/* Initial Approach Outcome - */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null and SecondaryApproach.SecondaryHospitalOutcome > 0
		 THEN (CASE SecondaryApproach.SecondaryHospitalOutcome
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
		 ELSE
			  (CASE Referral.ReferralGeneralConsent
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
	END AS 'InitialConsent',
	
	/* Initial Approacher - */
	Referral.ReferralApproachedByPersonID,
	
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null
		 THEN ISNULL(HospitalApproachPerson.PersonFirst, ApproachPerson.PersonFirst) + ' ' + ISNULL(HospitalApproachPerson.PersonLast, ApproachPerson.PersonLast)
		 ELSE ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast
	END AS 'InitialApproacher',

	/* Final Approach - Display values only if Secondary Servicelevel is turned ON */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN InformedApproach.FSApproachTypeName
		 ELSE '' 
	END AS 'FinalApproachType',

	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN 
				(CASE SecondaryApproach.SecondaryApproachOutcome
					WHEN 1 THEN 'Yes-Verbal'
					WHEN 2 THEN 'Yes-Written'
					WHEN 3 THEN 'No'
					WHEN 4 THEN 'Undecided' 
					ELSE null 
				 END)
		 ELSE null
	END AS 'FinalApproachOutcome',
	
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN ISNULL(InformedApproachPerson.PersonFirst, null) + ' ' + ISNULL(InformedApproachPerson.PersonLast, null)
		 ELSE null
	END AS 'FinalApproacher',

	/* Patient Information */
	--IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') AS 'PatientName',
	CASE WHEN ServiceLevel.ServiceLevelLastName = -1 and ServiceLevel.ServiceLevelFirstName = -1 THEN IsNull(Referral.ReferralDonorLastName, '') + ', ' + IsNull(Referral.ReferralDonorFirstName, '') + ' ' + ISNULL(Referral.ReferralDonorNameMI,'') ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientName', 
	CASE WHEN ServiceLevel.ServiceLevelGender = -1 THEN Referral.ReferralDonorGender ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientGender', 
	CASE WHEN ServiceLevel.ServiceLevelAge = -1 THEN Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientAge', 
	CASE WHEN ServiceLevel.ServiceLevelRace = -1 THEN race.RaceName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'PatientRace', 
	CASE WHEN ServiceLevel.ServiceLevelRecNum = -1 THEN Referral.ReferralDonorRecNumber ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'MedicalRecordNumber', 
	ISNULL(RegistryStatusType.RegistryType, 'Not on Registry') AS RegistryStatus,
	CauseOfDeathName AS 'CauseOfDeath',
	--dbo.fn_rpt_ConvertDateTime(Referral.ReferralCallerOrganizationID, Referral.ReferralDonorDeathDate, @DisplayMT) 
	--LT.ReferralDonorDeathDateTime AS 'CardiacDeathDateTime',
	CASE WHEN ServiceLevel.ServiceLevelDeathDate = -1 THEN CASE WHEN ISNULL(Referral.ReferralDonorDeathDate, '') = '' THEN ' ' ELSE convert(char(10),Referral.ReferralDonorDeathDate,101) + ' '+ Referral.ReferralDonorDeathTime END ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'CardiacDeathDateTime',
	Referral.ReferralDonorDeathDate,
	/* Disposition */
		/* Custom Mapping
		1. USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client report.
			ref: sub_DynamicDonorCategory.rdl

		Note: If client's service level is turned off, default values are set by the 
		function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
		future by changing the return value in the function. All reports using this function will 
		receive the new default value. Passing the function either a blank ('') or NULL value will cause
		the default value to be returned. If the UserOrg = 194 all data will be displaied */

		/* Organ @UserOrgId = 194 OR */
		--AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateOrgan = -1 THEN AppropOrgan.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOrgan,
		
		/* Bone*/
		--AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateBone = -1 THEN AppropBone.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryBone,

		/* Tissue*/
		--AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateTissue = -1 THEN AppropTissue.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryTissue, 

		/* Skin*/
		--AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateSkin = -1 THEN AppropSkin.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoverySkin, 

		/* Valves*/
		--AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateValves = -1 THEN AppropValve.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryValve, 

		/* Eyes*/
		--AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateEyes = -1 THEN AppropEyes.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryEyes, 

		/* Other*/
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateRsch = -1 THEN AppropRsch.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachRsch = -1 THEN ApproaRsch.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentRsch = -1 THEN ConsentRsch.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryRsch = -1 THEN RecoveryRsch.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOther,

		/* RS Search parameters */
		Referral.ReferralDonorLastName AS 'PatientLastName',
		Referral.ReferralDonorFirstName AS 'PatientFirstName',

				
		/* RS sub-report paramaters for DynamicDonorCategory */
		Referral.ReferralCallerOrganizationID,
		SourceCode.SourceCodeID,
		SourceCode.SourceCodeName,
		ReferralGeneralConsent,
		ReferralApproachTypeID,
		ReferralOrganAppropriateID,
		ReferralOrganApproachID,
		ReferralOrganConsentID,
		ReferralOrganConversionID  ,
		ReferralBoneAppropriateID  ,
		ReferralBoneApproachID  ,
		ReferralBoneConsentID  ,
		ReferralBoneConversionID  ,
		ReferralTissueAppropriateID  ,
		ReferralTissueApproachID  ,
		ReferralTissueConsentID  ,
		ReferralTissueConversionID  ,
		ReferralSkinAppropriateID  ,
		ReferralSkinApproachID  ,
		ReferralSkinConsentID  ,
		ReferralSkinConversionID  ,
		ReferralEyesTransAppropriateID  ,
		ReferralEyesTransApproachID  ,
		ReferralEyesTransConsentID  ,
		ReferralEyesTransConversionID  ,
		ReferralEyesRschAppropriateID  ,
		ReferralEyesRschApproachID  ,
		ReferralEyesRschConsentID  ,
		ReferralEyesRschConversionID  ,
		ReferralValvesAppropriateID  ,
		ReferralValvesApproachID  ,
		ReferralValvesConsentID  ,
		ReferralValvesConversionID , 
		FSCaseBillSecondaryUserID ,
		FSCaseBillApproachUserID ,
		FSCaseBillMedSocUserID ,
		FSCaseBillFamUnavailUserID ,
		FSCaseBillCryoFormUserID ,
		FSCaseBillApproachCount ,
		FSCaseBillMedSocCount ,
		FSCaseBillCryoFormCount,
		RegistryStatus.RegistryStatus
		

FROM Call
	JOIN --- NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
	 --- converting the date as appropriate
	 --- The function limits the data returned by daterange and/or CallID
	(
		SELECT 		
			CallID, 
			CallDateTime 			
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		@CallID						 ,
		@ReferralStartDateTime		 ,
		@ReferralEndDateTime		 ,
		@CardiacStartDateTime		 ,
		@CardiacEndDateTime			 , 
		@DisplayMT		 )
	) LT ON LT.CallID = Call.CallID 
	JOIN Referral ON Referral.CallID = Call.CallID 
	--JOIN @listTable LT ON LT.CallID = Call.CallID
	LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID 
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 
	LEFT JOIN ServiceLevelSecondary ON ServiceLevelSecondary.ServiceLevelID = CC.ServiceLevelID

	/* Changed to LEFT JOIN to display triage data Ref:OutcomeByCategory Report
		See WHERE clause addition below*/
	LEFT JOIN FSCase ON FSCase.CallID = Call.CallID

	/* Hospital Approach */
	LEFT JOIN SecondaryApproach ON SecondaryApproach.CallID = Call.CallID
	LEFT JOIN ApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
	LEFT JOIN Person AS HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy

	/* Informed Approach */
	LEFT JOIN FSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
	LEFT JOIN Person AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy

	LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
	LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID
	LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID 
	LEFT JOIN RegistryStatus ON RegistryStatus.CallId = Call.CallId 
	LEFT JOIN RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID
	LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
	LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
	LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
	LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
	LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
	LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
	LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
	LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
	LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
	LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
	LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
	LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
	LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
	LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
	LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
	LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
	LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
	LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
	LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
	LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
	LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
	LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
	LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 

WHERE 
	
	/* Search - ReportGroup */
	WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)

	AND Call.SourceCodeID IN 
			(SELECT SourceCodeID 
				FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName))
	/* Search - Organization */
		AND IsNull(Referral.ReferralCallerOrganizationID, 0) = IsNull(ISNull(@OrganizationID, Referral.ReferralCallerOrganizationID), 0)
		
	/* Changed to display triage data Ref:OutcomeByCategory Report
		See LEFT JOIN above */
		--AND ISNull(@Type_Outcome, FSCase.CallID) = ISNull(@Type_Outcome, FSCase.CallID)

	/* Search - SourceCodeID - needed for billable link */
	--	AND IsNull(Call.SourceCodeID, 0) = IsNull(@SourceCodeID, IsNull(Call.SourceCodeID, 0))
	
	/* Search - Referral Type */
		AND IsNull(Referral.ReferralTypeID, 0) = IsNull(@ReferralType, IsNull(Referral.ReferralTypeID, 0))

	/* Search - CauseOfDeath */
		AND IsNull(Referral.ReferralDonorCauseOfDeathID, 0) = IsNull(@CauseOfDeath, IsNull(Referral.ReferralDonorCauseOfDeathID, 0))

	/* Search - Lower/Upper Age Limit */
	AND (  --- either use the fn_rpt_DonorAgeYear or ignore
		(dbo.fn_rpt_DonorAgeYear(ReferralDOB,ReferralDonorDeathDate,ReferralDonorAge,ReferralDonorAgeUnit)
		BETWEEN ISNULL(@LowerAgeLimit, 0) AND ISNULL(@UpperAgeLimit, 0))
	OR
		(ISNULL(@LowerAgeLimit, 0) = 0 AND ISNULL(@UpperAgeLimit, 0) = 0)
	)
			
	/* Search - Coordinator */
		AND IsNull(LogEvent.StatEmployeeID, 0) = ISNULL(@CoordinatorID, IsNull(LogEvent.StatEmployeeID, 0))

	/* Search - Gender */
		--AND IsNull(Referral.ReferralDonorGender, 0) = ISNULL(@Gender, IsNull(Referral.ReferralDonorGender,0))
		AND ISNULL(PATINDEX(@Gender, ISNULL(Referral.ReferralDonorGender, 0)), -1) <> 0		
	
	/* Search (wildcards permitted) - PatientLastName */
		--AND PATINDEX(IsNull(@PatientLastName, IsNull(Referral.ReferralDonorLastName, 0)), IsNull(Referral.ReferralDonorLastName, 0)) > 0
		AND ISNULL(PATINDEX(@PatientLastName, ISNULL(Referral.ReferralDonorLastName, 0)), -1) <> 0
	/* Search (wildcards permitted) - PatientFirstName */
		--AND PATINDEX(IsNull(@PatientFirstName, IsNull(Referral.ReferralDonorFirstName, 0)), IsNull(Referral.ReferralDonorFirstName, 0)) > 0
		AND ISNULL(PATINDEX(@PatientFirstName, ISNULL(Referral.ReferralDonorFirstName, 0)), -1) <> 0
	/* Search (wildcards permitted) - Medical Record# */
		AND ISNULL(PATINDEX(@MedicalRecordNumber, ISNULL(Referral.ReferralDonorRecNumber, 0)), -1) <> 0


 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QA'
		DROP  Procedure  sps_rpt_QA
	END

GO

PRINT 'Creating Procedure sps_rpt_QA'
GO
CREATE Procedure sps_rpt_QA
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@HowIdentifiedID			int = null,
	@ZeroErrors					int = Null,
	@Personids	 				varchar(8000) = NULL,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QA.sql
**		Name: sps_rpt_QA.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth					Initial release
**		08/14/2009		ccarroll			Created temp table. split sproc into two locations,
**											one for TrackingForm and one for Error Log.
**											Added WHERE to only show errors.
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
 
IF  @ZeroErrors = 0
	BEGIN
		SET @ZeroErrors	= Null
	END
ELSE
	BEGIN
		SET @ZeroErrors	= 0
	END
	
CREATE TABLE #Temp_QA
   (
	[SourceCode] [varchar] (15) NULL,
	[CallDateTime] [Datetime] Null,
	[QATrackingNumber] [varchar] (20) Null,
	[QAErrorLogNumberOfErrors] [int] Null,
	[QAErrorLogComments] [varchar] (1000)Null,
	[HowIdentified] [varchar] (250)Null,
	[Employee] [varchar] (101)Null,
	[EmployeeFirst] [varchar] (50)Null,
	[EmployeeLast] [varchar] (50)Null,
	[RefMonthNum] [datetime] Null,
	[RefMonth] [varchar] (20) Null,
	[RefYear] [datetime] Null,
	[ErrMonthNum] [datetime] Null,
	[ErrMonth] [varchar] (20) Null,
	[ErrYear] [datetime] Null,
	[ProcessStep] [varchar] (255) Null,
	[ErrorType] [varchar] (255) Null,
	[ErrorLocation] [varchar] (255)Null,
	[QATrackingEventDateTime] [datetime] Null
   )
   
TRUNCATE TABLE #Temp_QA

	INSERT #Temp_QA
		exec sps_rpt_QATrackingForm_Select
				@ErrorLocationID,
				@ProcessStepID,
				@ErrorTypeID,
				@HowIdentifiedID,
				@ZeroErrors,
				@Personids,
				@CallStartDateTime,
				@CallEndDateTime,
				@ErrorStartDateTime,
				@ErrorEndDateTime,
				@ReportGroupID,
				@OrganizationID,
				@SourceCodeName,
				@DisplayMT

	INSERT #Temp_QA
		exec sps_rpt_QAErrorLog_Select
				@ErrorLocationID,
				@ProcessStepID,
				@ErrorTypeID,
				@HowIdentifiedID,
				@ZeroErrors,
				@Personids,
				@CallStartDateTime,
				@CallEndDateTime,
				@ErrorStartDateTime,
				@ErrorEndDateTime,
				@ReportGroupID,
				@OrganizationID,
				@SourceCodeName,
				@DisplayMT
				
				
SELECT * FROM #Temp_QA
WHERE IsNull(QAErrorLogNumberOfErrors,0) > 0
ORDER BY
QATrackingNumber,
EmployeeLast,
ErrorLocation

 GO 

  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAErrorLog_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAErrorLog_Select'
		DROP  Procedure  sps_rpt_QAErrorLog_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_QAErrorLog_Select'
GO
CREATE Procedure sps_rpt_QAErrorLog_Select
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@HowIdentifiedID			int = null,
	@ZeroErrors					int = Null,
	@Personids	 				varchar(8000) = NULL,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAErrorLog_Select.sql
**		Name: sps_rpt_QAErrorLog_Select.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth			Initial release
**		08/18/2009		ccarroll	removed un-necessary joins
**		10/06/2009		ccarroll	added PATINDEX to @Personids selection in WHERE 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT  QATrackingSourceCode as SourceCode,
		QATrackingReferralDateTime as CallDateTime,
		QATrackingNumber,
		QAErrorLogNumberOfErrors,
		QAerrorlogComments,

(SELECT     QAErrorLogHowIdentifiedDescription
                            FROM          QAErrorLogHowIdentified
                            WHERE      QAErrorLogHowIdentifiedid = qaerrorlog.QAErrorLogHowIdentifiedid) AS HowIdentified,
 (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLog.StatEmployeeID) AS Employee,
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = QAErrorLog.StatEmployeeID) AS EmployeeFirst,
 (SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLog.StatEmployeeID) AS EmployeeLast,
datepart(month,QATrackingReferralDateTime) as refmonthnum,datename(month,QATrackingReferralDateTime) as refmonth,datename(year,QATrackingReferralDateTime) as RefYear,
datepart(month,QAErrorLogDateTime) as errmonthnum,datename(month,QAErrorLogDateTime) as errmonth,datename(year,QAErrorLogDateTime) as ErrYear,
                          (SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = QAErrorLog.QAProcessStepID) AS ProcessStep,
                          (SELECT     qaerrortypedescription
                            FROM          qaerrortype
                            WHERE      qaerrortypeid = qaerrorlog.qaerrortypeid) AS ErrorType,
                          (SELECT     qaerrorlocationdescription
                            FROM          qaerrorlocation
                            WHERE      qaerrorlocationid = qaerrorlog.qaerrorlocationid) AS ErrorLocation, '' AS QATrackingEventDateTime
FROM			QAErrorLog 
INNER JOIN		QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
                      --QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      --QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
                      
WHERE 
QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
and QAErrorLog.QAErrorLocationID = ISNULL(@ErrorLocationID, QAErrorLog.QAErrorLocationID)
and isnull(QAErrorLogHowIdentifiedid,0) = ISNULL(@HowIdentifiedID, isnull(QAErrorLogHowIdentifiedid,0))
and QAErrorLog.QAProcessStepID = ISNULL(@ProcessStepID, QAErrorLog.QAProcessStepID)
and QAErrorLog.QAErrorTypeID = ISNULL(@ErrorTypeID, QAErrorLog.QAErrorTypeID)	
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
And QAErrorLogNumberOfErrors BETWEEN ISNULL(@ZeroErrors, 0) AND ISNULL(@ZeroErrors, 99999)
--AND QAErrorLog.StatEmployeeID IN(SELECT * FROM dbo.ParseVarcharValueString(@Personids))
AND PATINDEX('%' + CAST(QAErrorLog.StatEmployeeID AS varchar)+ '%', IsNull(@Personids, CAST(QAErrorLog.StatEmployeeID AS varchar))) > 0

GO

  

 GO 

 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QATrackingForm_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QATrackingForm_Select'
		DROP  Procedure  sps_rpt_QATrackingForm_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_QATrackingForm_Select'
GO
CREATE Procedure sps_rpt_QATrackingForm_Select
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@HowIdentifiedID			int = null,
	@ZeroErrors					int = Null,
	@Personids	 				varchar(8000) = NULL,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QATrackingForm_Select.sql
**		Name: sps_rpt_QATrackingForm_Select.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth			Initial release
**		08/18/2009		ccarroll	added case statement to count form errors
**		10/06/2009		ccarroll	added PATINDEX to @Personids selection in WHERE 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT		QATrackingSourceCode as SourceCode,
			QATrackingReferralDateTime as CallDateTime,
			QATrackingNumber,
			CASE WHEN IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				 WHEN IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
			ELSE 0 END AS QAErrorLogNumberOfErrors,
			QAerrorlogComments,
(SELECT     QAErrorLogHowIdentifiedDescription
                            FROM          QAErrorLogHowIdentified
                            WHERE      QAErrorLogHowIdentifiedid = qaerrorlog.QAErrorLogHowIdentifiedid) AS HowIdentified,
 (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS Employee,
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS EmployeeFirst,
 (SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS EmployeeLast,
datepart(month,QATrackingReferralDateTime) as refmonthnum,datename(month,QATrackingReferralDateTime) as refmonth,datename(year,QATrackingReferralDateTime) as refyear,
datepart(month,QAErrorLogDateTime) as errmonthnum,datename(month,QAErrorLogDateTime) as errmonth,datename(year,QAErrorLogDateTime) as erryear,
                          (SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = qatrackingform.qaprocessstepid) AS ProcessStep,
                          (SELECT     qaerrortypedescription
                            FROM          qaerrortype
                            WHERE      qaerrortypeid = qaerrorlog.qaerrortypeid) AS Errortype,
                          (SELECT     qaerrorlocationdescription
                            FROM          qaerrorlocation
                            WHERE      qaerrorlocationid = qaerrorlog.qaerrorlocationid) AS ErrorLocation, QATrackingForm.QATrackingEventDateTime
FROM         QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
                      
WHERE 
QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
and QAErrorLog.QAErrorLocationID = ISNULL(@ErrorLocationID, QAErrorLog.QAErrorLocationID)
and isnull(QAErrorLogHowIdentifiedid,0) = ISNULL(@HowIdentifiedID, isnull(QAErrorLogHowIdentifiedid,0))
and qatrackingform.QAProcessStepID = ISNULL(@ProcessStepID, qatrackingform.QAProcessStepID)
and QAErrorLog.QAErrorTypeID = ISNULL(@ErrorTypeID, QAErrorLog.QAErrorTypeID)	
And QATrackingEventDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
And QAErrorLogNumberOfErrors BETWEEN ISNULL(@ZeroErrors, 0) AND ISNULL(@ZeroErrors, 99999)
--and qatrackingform.personid IN(SELECT * FROM dbo.ParseVarcharValueString(@Personids))
AND PATINDEX('%' + CAST(qatrackingform.personid AS varchar)+ '%', IsNull(@Personids, CAST(qatrackingform.personid AS varchar))) > 0

GO

  

 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyCAPA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAApproved'
		DROP  Procedure  sps_rpt_QAApproved
	END

GO

PRINT 'Creating Procedure sps_rpt_QAApproved'
GO
CREATE Procedure sps_rpt_QAApproved
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAApproved.sql
**		Name: sps_rpt_QAApproved.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      5/2009			jth			Initial release
*******************************************************************************/ 

SELECT DISTINCT (case  when len(QATrackingSourceCode) > 0  then QATrackingSourceCode else 'N/A' end)  SourceCode, 
                      QATracking.QATrackingReferralDateTime as CallDateTime, QATracking.QATrackingNumber  
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
WHERE QATrackingApproved=1 and
OrganizationID = ISNULL(@OrganizationID, OrganizationID)
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
GO

 

 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyCAPA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAbyCAPA'
		DROP  Procedure  sps_rpt_QAbyCAPA
	END

GO

PRINT 'Creating Procedure sps_rpt_QAbyCAPA'
GO
CREATE Procedure sps_rpt_QAbyCAPA
	@TrackingNum				varchar(20) = Null,
	@CAPANum				varchar(20) = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
		
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAbyCAPA.sql
**		Name: sps_rpt_QAbyCAPA.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      5/2009			jth					Initial release
**      08/09           jth					only display records with a capa number
**		10/03/2009		ccarroll			return all dates when @TrackingNum or @CAPANum used 
*******************************************************************************/

IF LEN(@TrackingNum) > 0 OR LEN(@CAPANum) > 0
BEGIN
	SET @CallStartDateTime = Null
	SET @CallEndDateTime = Null
	SET @ErrorStartDateTime = Null
	SET @ErrorEndDateTime = Null
END

SELECT DISTINCT 
                      QATrackingForm.QATrackingFormID,  (case  when len(QATrackingForm.QATrackingCAPANumber) > 0  then QATrackingForm.QATrackingCAPANumber else 'N/A' end) QATrackingCAPANumber, 
	          (case  when len(QATrackingSourceCode) > 0  then QATrackingSourceCode else 'N/A' end)  SourceCode, 
                      QATracking.QATrackingReferralDateTime, QATracking.QATrackingNumber
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
                      
WHERE 
OrganizationID = ISNULL(@OrganizationID, OrganizationID)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
and QATrackingNumber = ISNULL(@TrackingNum,QATrackingNumber)
and QATrackingCAPANumber = ISNULL(@CAPANum,QATrackingCAPANumber)
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
and qatrackingcapanumber > '0'
GO


 GO 

  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyError')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAbyError'
		DROP  Procedure  sps_rpt_QAbyError
	END

GO

PRINT 'Creating Procedure sps_rpt_QAbyError'
GO
 
 CREATE Procedure sps_rpt_QAbyError
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@ZeroErrors					int = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAbyError.sql
**		Name: sps_rpt_QAbyError.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth			Initial release
**		09/18/2009		ccarroll	added WHERE IsNull(QAErrorLogNumberOfErrors,0) > 0
**		10/03/2009		ccarroll	added @ErrorTypeID to WHERE
*******************************************************************************/ 
IF  @ZeroErrors = 0
BEGIN
	SET @ZeroErrors	= Null
end
else
BEGIN
	SET @ZeroErrors	= 0
end
SELECT  QATrackingSourceCode as SourceCode, 
case when (qatrackingform.qatrackingformid)is not null then
			CASE WHEN IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				 WHEN IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
			ELSE 0 END
else
QAErrorLog.QAErrorLogNumberOfErrors
end
AS QAErrorLogNumberOfErrors,
QATrackingReferralDateTime as CallDateTime, QATrackingNumber, 
datepart(month,QATrackingReferralDateTime) as refmonthnum,datename(month,QATrackingReferralDateTime) as refmonth,datename(year,QATrackingReferralDateTime) as refyear,
datepart(month,QAErrorLogDateTime) as errmonthnum,datename(month,QAErrorLogDateTime) as errmonth,datename(year,QAErrorLogDateTime) as erryear,
 case when (qatrackingform.qaprocessstepid)is not null then
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = qatrackingform.qaprocessstepid)
else
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = qaerrorlog.qaprocessstepid)
end
 AS ProcessStep,
                          (SELECT     qaerrortypedescription
                            FROM          qaerrortype
                            WHERE      qaerrortypeid = qaerrorlog.qaerrortypeid) AS Errortype,
                          (SELECT     qaerrorlocationdescription
                            FROM          qaerrorlocation
                            WHERE      qaerrorlocationid = qaerrorlog.qaerrorlocationid) AS ErrorLocation, QATrackingForm.QATrackingEventDateTime
/*FROM         QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
                      INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID*/
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID                      
WHERE 
qatracking.OrganizationID = ISNULL(@OrganizationID, qatracking.OrganizationID)
AND (
		(IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1)
	OR	(IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1)
	OR	(IsNull(QAErrorLogNumberOfErrors,0) > 0)
	)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
and qaerrorlog.QAErrorLocationID = ISNULL(@ErrorLocationID, qaerrorlog.QAErrorLocationID)
AND QAErrorLog.QAErrorTypeID = ISNULL(@ErrorTypeID ,QAErrorLog.QAErrorTypeID)
and isnull(qatrackingform.QAProcessStepID,qaerrorlog.qaprocessstepid) = ISNULL(@ProcessStepID, isnull(qatrackingform.QAProcessStepID,qaerrorlog.qaprocessstepid))
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
--And QAErrorLogNumberOfErrors BETWEEN ISNULL(@ZeroErrors, 0) AND ISNULL(@ZeroErrors, 99999)
GO

 

 GO 

 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAbyTrackingNumber'
		DROP  Procedure  sps_rpt_QAbyTrackingNumber
	END

GO

PRINT 'Creating Procedure sps_rpt_QAbyTrackingNumber'
GO
 
 CREATE Procedure sps_rpt_QAbyTrackingNumber
	@TrackingNum				varchar(20) = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAbyTrackingNumber.sql
**		Name: sps_rpt_QAbyTrackingNumber.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      5/2009			jth					Initial release
**		08/018/2009		ccarroll			added CASE statement for error counts
**		09/21/2009		ccarroll			Change WHERE clause to include Tracking Numbers which
**											have errors defined by GenerateLogIfYes and GenerareLogIfNo options.
**		10/03/2009		ccarroll			changed QAErrorLogCorrection to CorrectionLog to match sort option
*******************************************************************************/ 
IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   null
	END
			

SELECT DISTINCT 
                      QATrackingForm.QATrackingFormID,  
	         
                      QATracking.QATrackingReferralDateTime,
                      QATracking.QATrackingNumber,
case when (qatrackingform.qatrackingformid)is not null then
			CASE WHEN IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				 WHEN IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
			ELSE 0 END
else
QAErrorLog.QAErrorLogNumberOfErrors
end
AS QAErrorLogNumberOfErrors,
case when (qatrackingform.qatrackingformid)is not null then                      
 (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid)
else
(SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = statemployeeid)
end
 AS Employee,
case when (qatrackingform.qatrackingformid)is not null then
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) 
else
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = statemployeeid)
end
AS EmployeeFirst,
case when (qatrackingform.qatrackingformid)is not null then
 (SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid)
else
(SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = statemployeeid)
end
 AS EmployeeLast,
case when (qatrackingform.qatrackingformid)is not null then
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = qatrackingform.qaprocessstepid)
else
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = qaerrorlog.qaprocessstepid)
end
 AS ProcessStep,

                          (SELECT     qaerrortypedescription
                            FROM          qaerrortype
                            WHERE      qaerrortypeid = qaerrorlog.qaerrortypeid) AS Errortype,
                          (SELECT     qaerrorlocationdescription
                            FROM          qaerrorlocation
                            WHERE      qaerrorlocationid = qaerrorlog.qaerrorlocationid) AS ErrorLocation,
                          (SELECT     QAErrorLogHowIdentifiedDescription
                            FROM          QAErrorLogHowIdentified
                            WHERE      QAErrorLogHowIdentifiedid = qaerrorlog.QAErrorLogHowIdentifiedid) AS HowIdentified,
QAErrorLog.QAErrorLogDateTime, QAerrorlog.QAerrorlogComments, QAErrorLog.QAErrorLogTicketNumber,
QAErrorLog.QAErrorLogCorrection AS CorrectionLog
/*Old JoinsFROM         QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
*/ 
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
                     
WHERE 
QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID)
AND QATrackingNumber = ISNULL(@TrackingNum,QATrackingNumber)
AND QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
AND QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
AND (
		(IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1)
	OR	(IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1)
	OR	(IsNull(QAErrorLogNumberOfErrors,0) > 0)
	)
	


 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAFormsCompletedBy')
      BEGIN
            PRINT 'Dropping Procedure sps_rpt_QAFormsCompletedBy'
            DROP  Procedure  sps_rpt_QAFormsCompletedBy
      END

GO

PRINT 'Creating Procedure sps_rpt_QAFormsCompletedBy'
GO

CREATE Procedure sps_rpt_QAFormsCompletedBy
      @TrackingNum                        varchar(20) = Null,
      @CompletedByID              int = Null,
      @CallStartDateTime                DateTime = Null,
      @CallEndDateTime            DateTime = Null,
      @ErrorStartDateTime               DateTime = Null,
      @ErrorEndDateTime             DateTime = Null,
            
      @ReportGroupID                      int = Null,
      @OrganizationID                     int = Null,
      @SourceCodeName                     varchar(10) = Null,
      
      @DisplayMT                          int = Null

AS
/******************************************************************************
**          File: sps_rpt_QAFormsCompletedBy.sql
**          Name: sps_rpt_QAFormsCompletedBy.sql
**          Desc: 
**
**              
**          Return values:
** 
**          Called by:   
**              
**          Parameters:
**          Input                                     Output
**     ----------                                     -----------
**          See above
**
**          Auth: jth
**          Date: 05/2009
*******************************************************************************
**          Change History
*******************************************************************************
**          Date:             Author:                       Description:
**          --------          --------                -------------------------------------------
**      5/2009                jth               Initial release
**		09/18/2009				ccarroll		restored to original (production release)
**												modified to only return Form data.
**		10/03/2009			 ccarroll			added date bypass for @TrackingNum
*******************************************************************************/ 
IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   Null
	END

SELECT DISTINCT QATrackingForm.QATrackingFormID, QATrackingForm.QATrackingFormPoints, QATracking.QATrackingNumber,
                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS Employee, QAErrorLog.StatEmployeeID,
                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = statemployeeid) AS CompletedBy, QATrackingForm.PersonID,
                            (case  when len(QATrackingSourceCode) > 0  then QATrackingSourceCode else 'N/A' end)  SourceCode,
                  case when   QATrackingNumber NOT LIKE '%[A-Z]%'  then
                  case when        LEN(QATrackingNumber) < 10 then
                          (SELECT     TOP 1 ISNULL(MessageType.MessageTypeName, ReferralType.ReferralTypeName)
                            FROM          ReferralType INNER JOIN
                                                   Referral ON ReferralType.ReferralTypeID = Referral.ReferralTypeID INNER JOIN
                                                   WebReportGroupOrg ON Referral.ReferralCallerOrganizationID = WebReportGroupOrg.OrganizationID RIGHT OUTER JOIN
                                                   MessageType INNER JOIN
                                                   Message ON MessageType.MessageTypeID = Message.MessageTypeID RIGHT OUTER JOIN
                                                   CallType INNER JOIN
                                                   Call INNER JOIN
                                                   SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID ON CallType.CallTypeID = Call.CallTypeID ON 
                                                   Message.CallID = Call.CallID ON Referral.CallID = Call.CallID
                            WHERE      call.callid  = ISNULL(@TrackingNum,QATrackingNumber)) end
                      else 'N/A' end AS CallTypeName
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
                      
WHERE
QATrackingForm.QATrackingFormID Is Not Null 
AND OrganizationID = ISNULL(@OrganizationID, OrganizationID)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
and QATrackingNumber = ISNULL(@TrackingNum,QATrackingNumber)
AND  StatEmployeeID = ISNULL(@CompletedByID, StatEmployeeID)
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
GO


 GO 

 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonTitleListByOrganizationId')
	BEGIN
		PRINT 'Dropping Procedure GetPersonTitleListByOrganizationId'
		DROP  Procedure  GetPersonTitleListByOrganizationId
	END

GO

PRINT 'Creating Procedure GetPersonTitleListByOrganizationId'
GO
 
CREATE PROCEDURE GetPersonTitleListByOrganizationId
	@OrganizationId	INT = NULL,
	@PersonTypeID int = null
AS
/******************************************************************************
**		File: GetPersonTitleListByOrganizationId.sql
**		Name: GetPersonTitleListByOrganizationId
**		Desc: Returns a list of People and Titles by OrganizationID and Title
**
** 
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 06/09/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/2009		jth				initial
**		08/14/2009	ccarroll		changed JOIN to QATrackingForm (personID) was QAErrorLog (personID)
*******************************************************************************/
IF @PersonTypeID = 0 
BEGIN
	SET  @PersonTypeID = null
END

SELECT   distinct  
	p.PersonID,
	ISNULL(PersonLast, '') + ', ' + ISNUll(PersonFirst, '') + ' ' + ISNULL(PersonMI, '') PersonName,
	PersonType.PersonTypeName 'PersonTitle',
	p.PersonTypeID
	
FROM Person p 
JOIN PersonType ON PersonType.PersonTypeID = p.PersonTypeID
JOIN QATrackingForm ON p.PersonID = QATrackingForm.PersonID
--JOIN QAErrorLog ON p.PersonID = QAErrorLog.StatEmployeeID

WHERE    
	(OrganizationID = ISNULL(@OrganizationId, 0)) 
	AND	(p.PersonTypeID = ISNULL(@PersonTypeID, p.PersonTypeID)) 
	AND p.Inactive =  0


UNION 

SELECT   distinct  
	p.PersonID,
	ISNULL(PersonLast, '') + ', ' + ISNUll(PersonFirst, '') + ' ' + ISNULL(PersonMI, '') PersonName,
	PersonType.PersonTypeName 'PersonTitle',
	p.PersonTypeID
	
FROM Person p 
JOIN PersonType ON PersonType.PersonTypeID = p.PersonTypeID
--JOIN QATrackingForm ON p.PersonID = QATrackingForm.PersonID
JOIN QAErrorLog ON p.PersonID = QAErrorLog.StatEmployeeID

WHERE    
	(OrganizationID = ISNULL(@OrganizationId, 0)) 
	AND	(p.PersonTypeID = ISNULL(@PersonTypeID, p.PersonTypeID)) 
	AND p.Inactive =  0


ORDER BY 2
	
GO


 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'TF' AND name = 'ParseVarcharValueString')
	BEGIN
		PRINT 'Dropping Function dbo.ParseVarcharValueString'
		DROP  Function dbo.ParseVarcharValueString
	END

GO

PRINT 'Creating Function dbo.ParseVarcharValueString'
GO



CREATE Function dbo.ParseVarcharValueString
	(
	@InputString varchar(8000)
	)
RETURNS @StringValues TABLE (StringValue Varchar(100)) 
AS
/******************************************************************************
**		File: ParseVarcharValueString.sql
**		Name: dbo.ParseVarcharValueString
**		Desc: This udf will build a table of Strings based on a comma seperated list 
**		Used for custom control to parse out employee selection from employee datagrid
**		Return values: single column table of Strings
**		
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**		
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**		6/2009		jth			initial
*******************************************************************************/

	BEGIN
		-- build a table to help with the parse
		declare @Numbers table
			(Number int identity(1,1),
			name varchar(1))
		declare @maxvalue int
		select  @maxvalue  = 0
		while @maxvalue < 200
		begin
			insert @Numbers (name)
			select ''

			select @maxvalue = scope_identity()
		end

		INSERT @StringValues
		SELECT 
			substring(
						',' + @InputString + ',', --- expression
						Number + 1, --- start
						charindex(
									',', -- find what
									',' + @InputString + ',', -- search what
									Number + 1 -- optional start location
								 ) - Number - 1 --- length
					 )
                 AS Value
          FROM   
				@Numbers -- variable table built above
          WHERE  
				Number <= len(',' + @InputString + ',') - 1
          AND  
				substring(',' + @InputString + ',', Number, 1) = ','

order by 1
	
	
		RETURN
	END










 GO 

 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAScorebyEmployee')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAScorebyEmployee'
		DROP  Procedure  sps_rpt_QAScorebyEmployee
	END

GO

PRINT 'Creating Procedure sps_rpt_QAScorebyEmployee'
GO
 
 CREATE Procedure sps_rpt_QAScorebyEmployee
	
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@Personids	 				varchar(8000) = NULL,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAScorebyEmployee.sql
**		Name: sps_rpt_QAScorebyEmployee.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth			Initial release
**		08/17/2009		ccarroll	Added SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
**		10/06/2009		ccarroll	added PATINDEX to @Personids selection in WHERE
**		10/07/2009		ccarroll	removed QAErrorTypeGenerateLogIfYes from WHERE 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT DISTINCT 
QATrackingForm.QATrackingFormID, QATrackingSourceCode as SourceCode, QATracking.QATrackingReferralDateTime AS CallDateTime, QATracking.QATrackingNumber, 
QATrackingForm.QATrackingEventDateTime, QATracking.QATrackingReferralTypeID, QATrackingForm.QATrackingFormPoints,
(SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS Employee,
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS EmployeeFirst,
 (SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS EmployeeLast,
datepart(month,QATrackingReferralDateTime) as refmonthnum,datename(month,QATrackingReferralDateTime) as refmonth,datename(year,QATrackingReferralDateTime) as refyear,
datepart(month,QAErrorLogDateTime) as errmonthnum,datename(month,QAErrorLogDateTime) as errmonth,datename(year,QAErrorLogDateTime) as erryear,
                      case when	QATrackingNumber NOT LIKE '%[A-Z]%'  then
			case when        LEN(QATrackingNumber) < 10 then
                          (SELECT     TOP 1 ISNULL(MessageType.MessageTypeName, ReferralType.ReferralTypeName)
                            FROM          ReferralType INNER JOIN
                                                   Referral ON ReferralType.ReferralTypeID = Referral.ReferralTypeID INNER JOIN
                                                   WebReportGroupOrg ON Referral.ReferralCallerOrganizationID = WebReportGroupOrg.OrganizationID RIGHT OUTER JOIN
                                                   MessageType INNER JOIN
                                                   Message ON MessageType.MessageTypeID = Message.MessageTypeID RIGHT OUTER JOIN
                                                   CallType INNER JOIN
                                                   Call INNER JOIN
                                                   SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID ON CallType.CallTypeID = Call.CallTypeID ON 
                                                   Message.CallID = Call.CallID ON Referral.CallID = Call.CallID
                            WHERE      call.callid  = QATrackingNumber) end
			    else 'N/A' end AS CallTypeName
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID			    
/*FROM         QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID*/
WHERE 
qatracking.OrganizationID = ISNULL(@OrganizationID, qatracking.OrganizationID)
--and qatrackingform.personid IN(SELECT * FROM dbo.ParseVarcharValueString(@Personids))
AND PATINDEX('%' + CAST(qatrackingform.personid AS varchar)+ '%', IsNull(@Personids, CAST(qatrackingform.personid AS varchar))) > 0

--AND (
--		(IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1)
--	OR	(IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1)
--	OR	(IsNull(QAErrorLogNumberOfErrors,0) > 0)
--	)
	
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')

 

 GO 

 /* Script to modify report names */
DECLARE @dbname varchar(100)
SET @dbname = (SELECT db_name())

IF @dbname = '_ReferralProd'
BEGIN
	DECLARE @OldURL Varchar(255)
	DECLARE @NewURL Varchar(255)

	SET @OldURL = 'OrganizationAuditTrail'
	SET @NewURL = 'AuditTrailOrganization'
	UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

	SET @OldURL = 'PersonAuditTrail'
	SET @NewURL = 'AuditTrailPerson'
	UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

	SET @OldURL = 'MessageAuditTrail'
	SET @NewURL = 'AuditTrailMessage'
	UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

	SET @OldURL = 'ImportOfferAuditTrail'
	SET @NewURL = 'AuditTrailImportOffer'
	UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

	SET @OldURL = 'Processor Number'
	SET @NewURL = 'ProcessorNumber'
	UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL

	SET @OldURL = 'Conversion Rate'
	SET @NewURL = 'FS Conversion Rate'
	UPDATE Report SET ReportVirtualURL = Replace(ReportVirtualURL, @OldURL, @NewURL) WHERE ReportVirtualURL LIKE '%' + @OldURL
END
 GO 

