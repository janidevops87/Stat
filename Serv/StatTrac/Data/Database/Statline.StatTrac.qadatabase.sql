-- -- -- File Manifest Created On:5/3/2010 9:21:49 AM-- -- --  
-- C:/2005Projects/Statline/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/QA.sql
-- -- -- File Manifest Created On:5/3/2010 9:22:16 AM-- -- --  
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/DeleteQAErrorLogMulti.sql
-- C:/Projects/Statline/StatTrac/Development/Sql2008/Main/Database/Create Scripts/Transactional/Sprocs/GetPendingReview.sql
-- C:/Projects/Statline/StatTrac/Development/Sql2008/Main/Database/Create Scripts/Transactional/Sprocs/GetPersonListByOrganizationIdWeb1.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetPoints.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAErrorType.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAErrorTypes.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAForm.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAGridAddEditQualityMonitoringForm.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAGridErrorTypeLog.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAGridErrorTypesByEmployee.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAGridManageErrorLists.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAGridManageErrorLists1.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAGridPendingReview.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQAMonitoringForm.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQATracking.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetQATrackingType.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetReferralInfo.sql
-- C:/Projects/Statline/StatTrac/Development/SQL2008/Main/Database/Create Scripts/Transactional/Sprocs/GetValidTrackingNumber.sql
-- C:/Projects/Statline/StatTrac/Development/Sql2008/Main/Database/Create Scripts/Transactional/Sprocs/sps_SecondaryDispositionRetrieveGridForDotNet.sql
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
	@TrackingTypeID				int = Null,
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
				@TrackingTypeID,
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


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAErrorLogMulti]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAErrorLogMulti]
	PRINT 'Dropping Procedure: DeleteQAErrorLogMulti'
END
	PRINT 'Creating Procedure: DeleteQAErrorLogMulti'
GO

CREATE PROCEDURE [dbo].[DeleteQAErrorLogMulti]
(
	@LastStatEmployeeID int,
	@QAErrorLocationID int,
	@QAErrorLogPersonID int
)
/******************************************************************************
**		File: DeleteQAErrorLogMulti.sql
**		Name: DeleteQAErrorLogMulti
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: jth
**		Date: 03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**      03/09       jth         needs to delete by employeeid and locationid
**      1/10        jth         change to use new field qaerrorlogpersonid
**		4/2010		bret		fixed param Name
*******************************************************************************/
AS
	SET NOCOUNT ON

	UPDATE
			[QAErrorLog]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE  
		[QAErrorLogPersonID] = @QAErrorLogPersonID and
		[QAErrorLocationID] = @QAErrorLocationID

	DELETE 
	FROM   [QAErrorLog]
	WHERE  
		[StatEmployeeID] = @LastStatEmployeeID and
		[QAErrorLocationID] = @QAErrorLocationID

	RETURN @@Error
GO 

 GO 

--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPendingReview')
	BEGIN
		PRINT 'Dropping Procedure GetPendingReview'
		DROP  Procedure  GetPendingReview
	END

GO

PRINT 'Creating Procedure GetPendingReview'
GO

CREATE PROCEDURE GetPendingReview
@QATrackingID int = NULL,
@OrganizationID int = NULL,
@returnVal dec(5,2) OUTPUT
AS
/******************************************************************************
**		File: GetPendingReview.sql
**		Name: GetPendingReview
**		Desc: Returns whether a error and tracking number is in pending review or not
**
** 
**		
**
**		Auth: jth
**		Date: 03/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		3.10	    jth					initial
**	   04/2010		bret			updating to include in release
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT  @returnVal = COUNT(*)    
 From QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID

WHERE 
		QAErrorLog.QATrackingID = IsNull(@QATrackingID, QAErrorLog.QATrackingID) AND
		QAErrorLog.QAErrorStatusID = 1 and
		QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)



GO
 

 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonListByOrganizationIdWeb1')
	BEGIN
		PRINT 'Dropping Procedure GetPersonListByOrganizationIdWeb1'
		DROP  Procedure  GetPersonListByOrganizationIdWeb1
	END

GO

PRINT 'Creating Procedure GetPersonListByOrganizationIdWeb1'
GO 

 
CREATE PROCEDURE GetPersonListByOrganizationIdWeb1
	@OrganizationId	INT = NULL,
	@OrganizationId1	INT = NULL,
	@Inactive		INT = NULL
AS
/******************************************************************************
**		File: GetPersonListByOrganizationIdWeb1.sql
**		Name: GetPersonListByOrganizationIdWeb1
**		Desc: Returns a list of People by OrganizationID and a second one if they want, but in first name order like stattrac
**			  
** 
**		Called by:   QAMonitoring.ascx
**              
**
**		Auth: jth
**		Date: 10/30/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		10.08	    jth					initial
**	   04/2010		bret			updating to include in release
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT     
	PersonID, 
	Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast  PersonName
FROM         
	Person
WHERE     
	(OrganizationID = ISNULL(@OrganizationId, 0) or OrganizationID = ISNULL(@OrganizationID1, 0)) 	
	 
AND 
	(Inactive = ISNULL(@Inactive, 0))
	
order by 2
GO
 

 GO 

--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPoints')
	BEGIN
		PRINT 'Dropping Procedure GetPoints'
		DROP  Procedure  GetPoints
	END

GO

PRINT 'Creating Procedure GetPoints'
GO

CREATE PROCEDURE GetPoints
	@QAMonitoringFormID int,
	@QATrackingFormID int,
	@returnVal dec(5,2) OUTPUT

/******************************************************************************
**		File: GetPoints.sql
**		Name: GetPoints
**		Desc:  Need to get points for an error
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**	   04/2010		bret			updating to include in release
**		
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED



BEGIN
--Insert the values

CREATE TABLE #Points
     (
     [PointsNo][int]NULL,
     [AutoZero][int]NULL, 
     [Earned][int]NULL,
     [Available][int]NULL,
     [Tot][int]NULL
     )

     INSERT #Points
     (PointsNo,AutoZero,Earned, Available, Tot)
        
SELECT     
QAErrorLog.QAErrorLogPointsNo,
QAErrorTypeAutomaticZeroScore,
(CASE QAErrorLog.QAErrorLogPointsYes WHEN 1 THEN QAErrorType.QAErrorTypeAssignedPoints ELSE 0 END),
(CASE QAErrorLog.QAErrorLogPointsNA WHEN 1 THEN 
Case  when QAErrorType.QAErrorTypeAssignedPoints > 0 then -QAErrorType.QAErrorTypeAssignedPoints end ELSE 0 END) , 
(Case  when QAErrorType.QAErrorTypeAssignedPoints > 0 then QAErrorTypeAssignedPoints end)
FROM         QAErrorLog INNER JOIN
                      QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID INNER JOIN
                      QAErrorType ON QAMonitoringFormTemplate.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QATrackingFormErrors ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID INNER JOIN
                      QATrackingForm ON QATrackingFormErrors.QATrackingFormID = QATrackingForm.QATrackingFormID
WHERE     (QAMonitoringFormTemplate.QAMonitoringFormID = @QAMonitoringFormID) AND (QATrackingFormErrors.QATrackingFormID = @QATrackingFormID)

--Select the column to send back
Begin
	set @returnVal = 0
end
begin
if (select count(*)  from #Points where pointsno =1 and autozero = 1) = 0
	BEGIN 
		if (select (CAST(sum(available) AS DECIMAL(5,1))+ CAST(sum(tot) AS DECIMAL(5,1))) from #Points) > 0
		Begin
			if (select CAST(sum(earned) AS DECIMAL(5,1)) from #Points)  > 0
			Begin
				select @returnVal = CAST(sum(earned) AS DECIMAL(5,1)) / (CAST(sum(available) AS DECIMAL(5,1))+ CAST(sum(tot) AS DECIMAL(5,1)) )   from #Points
			end
		End
	END
end
DROP TABLE #Points

--Return Value


RETURN @returnVal


END

GO


 GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorType]
	PRINT 'Dropping Procedure: GetQAErrorType'
END
	PRINT 'Creating Procedure: GetQAErrorType'
GO

CREATE PROCEDURE [dbo].[GetQAErrorType]
(
@QAErrorTypeID int = null
	--@OrganizationID int = NULL,
	--@QAErrorTypeActive smallint = NULL
)
/******************************************************************************
**		File: GetQAErrorType.sql
**		Name: GetQAErrorType
**		Desc: Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      02/19/09    jth         took out unnecessary parms  
**      03/09       jth         added qatrackingtypeid
**		08/17/2009  ccarroll	added Column QAErrorTypeGenerateLogIfYes (used in reports) 
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	/*
	IF @QAErrorTypeID = 0
		BEGIN
			
			SET @QAErrorTypeID = Null
		END

	IF @QAErrorTypeActive = null
		BEGIN
			
			SET @QAErrorTypeActive =0
		END
ELSE 
		BEGIN
			
			SET @QAErrorTypeActive =null
		END
		*/

	SELECT
		[QAErrorTypeID],
		[OrganizationID],
		[QAErrorLocationID],
		[QAErrorTypeDescription],
		[QAErrorRequireReview],
		[QAErrorTypeActive],
		[QAErrorTypeInactiveComments],
		[QAErrorTypeAssignedPoints],
		[QAErrorTypeAutomaticZeroScore],
		[QAErrorTypeDisplayNA],
		[QAErrorTypeDisplayComments],
		[QAErrorTypeGenerateLogIfNo],
		[QAErrorTypeGenerateLogIfYes],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		[QATrackingTypeID]
	
	FROM
			[QAErrorType]
	WHERE 
		[QAErrorTypeID] = IsNull(@QAErrorTypeID, QAErrorTypeID) --AND
		--[OrganizationID] = IsNull(@OrganizationID, OrganizationID) AND
		--[QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID) AND
		--[QAErrorTypeActive] = IsNull(@QAErrorTypeActive, QAErrorTypeActive)
order by QAErrorTypeDescription

	RETURN @@Error
GO




 GO 


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorTypes]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorTypes]
	PRINT 'Dropping Procedure: GetQAErrorTypes'
END
	PRINT 'Creating Procedure: GetQAErrorTypes'
GO
 
CREATE PROCEDURE [dbo].[GetQAErrorTypes]
(
	@OrganizationID int = NULL,
	@QAErrorLocationID int = NULL
)
/******************************************************************************
**		File: GetQAErrorTypes.sql
**		Name: GetQAErrorTypes
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/2009		jth			initial
**      03/10       jth         added location parm
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
IF @QAErrorLocationID = 0
		BEGIN
			
			SET @QAErrorLocationID = Null
		END
	SELECT distinct 
		QAErrorTypeDescription,
		QAErrorTypeID,
		QAErrorTypeGenerateLogIfNo
		
	FROM
			QAErrorType
	
where organizationid = @OrganizationID and QAErrorTypeActive = 1
and [QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID)
order by QAErrorTypeDescription

	RETURN @@Error

GO


 GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAForm]
	PRINT 'Dropping Procedure: GetQAForm'
END
	PRINT 'Creating Procedure: GetQAForm'
GO

CREATE PROCEDURE [dbo].[GetQAForm]
(
	@OrganizationID int = NULL,
	@ErrorTypeID      int = null
)
/******************************************************************************
**		File: GetQAForm.sql
**		Name: GetQAForm
**		Desc:  Used on ddl for error list (forms config)
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	jth     	initial
**      03/2009		jth			add active criteria
**      02/10       jth         add errortypeid take out 
**	   04/2010		bret			updating to include in release
**      
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT DISTINCT QAMonitoringForm.QAMonitoringFormID, QAMonitoringForm.QAMonitoringFormName, (Select QAMonitoringFormTemplateActive from QAMonitoringFormTemplate where QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID and QAMonitoringFormTemplate.QAErrorTypeID = @ErrorTypeID) as QAMonitoringFormTemplateActive,
(Select QAMonitoringFormTemplateID from QAMonitoringFormTemplate where QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID and QAMonitoringFormTemplate.QAErrorTypeID = @ErrorTypeID) as QAMonitoringFormTemplateID,
(select QATrackingType.QATrackingTypeDescription from QATrackingType where QATrackingType.QATrackingTypeID = QAMonitoringForm.QATrackingTypeID) as TrackingDesc
FROM         QAMonitoringForm 
WHERE     (QAMonitoringForm.OrganizationID = @OrganizationID) AND (QAMonitoringForm.QAMonitoringFormActive = 1) 
ORDER BY QAMonitoringForm.QAMonitoringFormName
	


	RETURN @@Error
GO


 

 GO 

  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridAddEditQualityMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridAddEditQualityMonitoringForm]
	PRINT 'Dropping Procedure: GetQAGridAddEditQualityMonitoringForm'
END
	PRINT 'Creating Procedure: GetQAGridAddEditQualityMonitoringForm'
GO

CREATE PROCEDURE [dbo].[GetQAGridAddEditQualityMonitoringForm]
(
	@QAMonitoringFormID int = NULL,
	@QATrackingFormID int = Null
)
/******************************************************************************
**		File: GetQAGridAddEditQualityMonitoringForm.sql
**		Name: GetQAGridAddEditQualityMonitoringForm
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/10/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/10/2009	ccarroll	initial
**      02/09       jth         use tracking number and not trackingid
**      02/09       jth         fixed join to return correct error type data
**      03/09       jth         added columns and order by
**      03/09       jth         where clause had search by tracking number and s/b formid
**      04/09       jth         added trackingformid as criteria
**		12/08/2009	ccarroll	removed table alias in ORDER BY for SQL Server 2008 update.
**		03/16/2010	ccarroll	Added this note for inclusion in release
********************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
				QAErrorLog.QAErrorLogID,
				QAMonitoringForm.QAMonitoringFormName,
				QAErrorLocation.QAErrorLocationID,
				isnull(QAErrorLocation.QAErrorLocationDescription,'Default') as QAErrorLocationDescription,
				--QAMonitoringFormTemplate.QAMonitoringFormTemplateOrder,
				QAErrorType.QAErrorTypeDescription,
				QAErrorType.QAErrorTypeAssignedPoints,
				QAErrorLog.QAErrorLogPointsYes,
				QAErrorLog.QAErrorLogPointsNo,
				QAErrorLog.QAErrorLogPointsNA,
				QAErrorLog.QAErrorLogComments,
				QAErrorLog.StatEmployeeID,
				QAErrorType.QAErrorTypeDisplayNA,
				QAErrorType.QAErrorTypeDisplayComments, 
                QAMonitoringForm.QAMonitoringFormCalculateScore,
                QAErrorType.QAErrorTypeAutomaticZeroScore,
                QAMonitoringForm.QAMonitoringFormID,
                QAErrorType.QAErrorTypeGenerateLogIfNo,
                QAErrorLog.QAErrorLogNumberOfErrors,
                isnull(QAMonitoringFormTemplate.QAMonitoringFormTemplateOrder,0) AS QAMonitoringFormTemplateOrder, 
				QALogos.ImageName
	FROM            QATrackingFormErrors INNER JOIN
                      QAErrorLog INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID ON 
                      QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID LEFT OUTER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID LEFT OUTER JOIN
                      QAMonitoringFormTemplate ON 
                      QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID LEFT OUTER JOIN
                      QALogos RIGHT OUTER JOIN
                      QAMonitoringForm ON QALogos.OrganizationID = QAMonitoringForm.OrganizationID AND 
                      QALogos.TrackingTypeID = QAMonitoringForm.QATrackingTypeID ON 
                      QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID LEFT OUTER JOIN
                      QAErrorLocation ON QAErrorType.QAErrorLocationID = QAErrorLocation.QAErrorLocationID

	WHERE		QAMonitoringFormTemplate.QAMonitoringFormID =  @QAMonitoringFormID and QATrackingFormID = @QATrackingFormID
	
	ORDER BY
				QAErrorLocationDescription,
				QAMonitoringFormTemplateOrder
	
	RETURN @@Error
GO




 GO 

 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridErrorTypeLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridErrorTypeLog]
	PRINT 'Dropping Procedure: GetQAGridErrorTypeLog'
END
	PRINT 'Creating Procedure: GetQAGridErrorTypeLog'
GO

CREATE PROCEDURE [dbo].[GetQAGridErrorTypeLog]
(
	@QATrackingID int = NULL,
	@QAErrorLocationID int = NULL,
	@PersonID int = NULL
)
/******************************************************************************
**		File: GetQAGridErrorTypeLog.sql
**		Name: GetQAGridErrorTypeLog
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/28/2009	ccarroll	initial
**      02/09       jth         we don't need tracking number
**      1/10        jth         change to use new field qaerrorlogpersonid
**      2/10        jth         put tracking id back in as parm
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
				QAErrorLog.QAErrorLogID,
				QAErrorLog.QAErrorTypeID,
				QAErrorType.QAErrorTypeDescription,
				QAErrorLog.QAProcessStepID,
				QAProcessStep.QAProcessStepDescription,
				QAErrorLog.QAErrorLogNumberOfErrors,
				CONVERT(CHAR(10),QAErrorLog.QAErrorLogDateTime,101) + ' ' +
				CONVERT(CHAR(5),QAErrorLog.QAErrorLogDateTime,108) as QAErrorLogDateTimeString,
				QAErrorLog.QAErrorLogDateTime,
				QAErrorLog.QAErrorLogHowIdentifiedID,
				QAErrorLogHowIdentified.QAErrorLogHowIdentifiedDescription,
				QAErrorLog.QAErrorLogTicketNumber,
				QAErrorLog.QAErrorLogComments,
				QAErrorLog.QAErrorStatusID,
				QAErrorStatus.QAErrorStatusDescription,
				QAErrorLog.QAErrorLogCorrection,
				CONVERT(CHAR(10),QAErrorLogCorrectionLastModified,101) + ' ' +
				CONVERT(CHAR(5),QAErrorLogCorrectionLastModified,108)+ '  ' +
				(select statemployeefirstname + ' ' + statemployeelastname from statemployee where statemployeeid = QAErrorLogCorrectionPersonID)
				as QAErrorLogCorrectionLog,
				QAErrorLog.QAErrorLocationID,QAErrorLog.StatEmployeeID,QAErrorLog.QAErrorLogPersonID,
				(select QAErrorLocationDescription from  QAErrorLocation where  QAErrorLocation.QAErrorLocationID = QAErrorLog.QAErrorLocationID) as  'LocationDesc',
				(select QATrackingType.QATrackingTypeDescription from  QATrackingType where  QATrackingType.QATrackingTypeID=(select QATracking.QATrackingTypeID from QATracking where QATracking.QATrackingID = QAErrorLog.QATrackingID)) as  'TrackingTypeDesc'
	FROM		QAErrorLog
	
	LEFT JOIN	QAErrorType ON QAErrorType.QAErrorTypeID = QAErrorLog.QAErrorTypeID
	LEFT JOIN	QAProcessStep ON QAProcessStep.QAProcessStepID = QAErrorLog.QAProcessStepID
	LEFT JOIN	QAErrorLogHowIdentified ON QAErrorLogHowIdentified.QAErrorLogHowIdentifiedID = QAErrorLog.QAErrorLogHowIdentifiedID
	LEFT JOIN	QAErrorStatus ON QAErrorStatus.QAErrorStatusID = QAErrorLog.QAErrorStatusID
	WHERE
			QAErrorLog.QAErrorLogPersonID = @PersonID AND
			QAErrorLog.QATrackingID = IsNull(@QATrackingID, QAErrorLog.QATrackingID) AND
			QAErrorLog.QAErrorLocationID = IsNull(@QAErrorLocationID, QAErrorLog.QAErrorLocationID) and
			(QAErrorLog.QAErrorLogNumberOfErrors > 0 or QAMonitoringFormTemplateID is null)
			

	RETURN @@Error
GO


 

 GO 

 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridErrorTypesByEmployee]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridErrorTypesByEmployee]
	PRINT 'Dropping Procedure: GetQAGridErrorTypesByEmployee'
END
	PRINT 'Creating Procedure: GetQAGridErrorTypesByEmployee'
GO

CREATE PROCEDURE [dbo].[GetQAGridErrorTypesByEmployee]
(
	@OrganizationID int = NULL,
	@QATrackingNumber varchar(20) = NULL,
	@TrackingTypeID int = NULL
)
/******************************************************************************
**		File: GetQAGridErrorTypesByEmployee.sql
**		Name: GetQAGridErrorTypesByEmployee
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/30/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/30/2009	ccarroll	initial
**      02/09       jth			fixed to use correct parms,joining to statemployee by wrong id, added PersonID and QAErrorLocation.QAErrorLocationID
**      03/09       jth         sql did not summarize
**      04/09       jth         change with new tracking tables
**      02/10       jth         don't join to tracking form table any longer and added trackingid
**      03/10       jth         search with trackingtypeid and exclude forms
**	   04/2010		bret			updating to include in release
**      04/10       jth         added numberoferrors > 0 and if form template is null criteria 
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
				IsNull(Person.PersonFirst, '') + ' ' + IsNull(Person.PersonLast, '') AS 'StatEmployeeName',
				--QAErrorLog.QAErrorTypeID,
				Person.PersonID,QAErrorLog.QATrackingID,
				QAErrorLocation.QAErrorLocationID,
				QAErrorLocation.QAErrorLocationDescription,QATrackingTypeID,QATrackingNumber,
				Sum(QAErrorLog.QAErrorLogNumberOfErrors) as QAErrorLogNumberOfErrors
				
	FROM		 QAErrorLog INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID INNER JOIN
                      Person ON QAErrorLog.QAErrorLogPersonID = Person.PersonID LEFT OUTER JOIN
                      QAErrorLocation ON QAErrorLog.QAErrorLocationID = QAErrorLocation.QAErrorLocationID
	WHERE
			QAErrorLocation.OrganizationID = IsNull(@OrganizationID,QAErrorLocation.OrganizationID) and
			QATracking.QATrackingNumber = @QATrackingNumber and
			QATracking.QATrackingTypeID = @TrackingTypeID and
			(QAErrorLog.QAErrorLogNumberOfErrors > 0 or QAMonitoringFormTemplateID is null)
			--and QAMonitoringFormTemplateID is null
GROUP BY Person.PersonID, QAErrorLog.QATrackingID, Person.PersonLast, Person.PersonFirst, QAErrorLocation.QAErrorLocationID, QAErrorLocation.QAErrorLocationDescription,QATrackingTypeID,QATrackingNumber
order by Person.personlast,QAErrorLocation.QAErrorLocationDescription			
			

	RETURN @@Error
GO
 

 GO 

 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridManageErrorLists]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridManageErrorLists]
	PRINT 'Dropping Procedure: GetQAGridManageErrorLists'
END
	PRINT 'Creating Procedure: GetQAGridManageErrorLists'
GO

CREATE PROCEDURE [dbo].[GetQAGridManageErrorLists]
(
	@OrganizationID int = NULL,
	@QAMonitoringFormID int = NULL,
	--@QAMonitoringFormTemplateID int = NULL,
	@QAErrorTypeActive smallint = NULL
)
/******************************************************************************
**		File: GetQAGridManageErrorLists.sql
**		Name: GetQAGridManageErrorLists
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/28/2009	ccarroll	initial
**      02/09       jth         set templateid to null if 0 passed in 
**      03/09       jth         no active logic
**      05/09       jth         took out join to form, since some error types don't have one
**      02/10       jth         broke out to do forms and error list
**      03/10       jth         added tracking type desc
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
if (@QAMonitoringFormID=0)
begin
	set @QAMonitoringFormID = null
end
IF @QAErrorTypeActive = 0
		BEGIN
			/* Display All ErrorTypes */
			SET @QAErrorTypeActive =1
		END
ELSE 
		BEGIN
			/* Only display active ErrorTypes */	 
			SET @QAErrorTypeActive =null
		END
	SELECT
				--QAMonitoringFormTemplate.QAMonitoringFormTemplateID,
				QAErrorType.QAErrorTypeActive,
				--QAMonitoringFormTemplate.QAMonitoringFormTemplateOrder,
				QAErrorType.QAErrorTypeID,QAErrorType.QATrackingTypeID,
				QAErrorType.QAErrorTypeDescription,
				QAErrorLocation.QAErrorLocationDescription,
				--QAMonitoringForm.QAMonitoringFormID,QAMonitoringForm.QAMonitoringFormName,
				QAErrorLocation.QAErrorLocationID,
				(select QATrackingType.QATrackingTypeDescription from QATrackingType where QATrackingType.QATrackingTypeID = QAErrorType.QATrackingTypeID) as TrackingDesc
	
	FROM         --QAMonitoringFormTemplate INNER JOIN
                      --QAErrorType inner join ON QAMonitoringFormTemplate.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QAErrorType inner join QAErrorLocation ON QAErrorType.QAErrorLocationID = QAErrorLocation.QAErrorLocationID 
                      --LEFT OUTER JOIN QAMonitoringForm ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
	WHERE     (QAErrorType.QAErrorTypeActive = ISNULL(@QAErrorTypeActive, QAErrorType.QAErrorTypeActive)) AND (QAErrorType.OrganizationID = ISNULL(@OrganizationID, 
                      QAErrorType.OrganizationID)) 
                      --AND (ISNULL(ISNULL(@QAMonitoringFormID, QAMonitoringFormTemplate.QAMonitoringFormID), - 1) = ISNULL(QAMonitoringFormTemplate.QAMonitoringFormID, - 1))
order by 5,4
	RETURN @@Error
GO




 GO 

 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridManageErrorLists1]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridManageErrorLists1]
	PRINT 'Dropping Procedure: GetQAGridManageErrorLists1'
END
	PRINT 'Creating Procedure: GetQAGridManageErrorLists1'
GO

CREATE PROCEDURE [dbo].[GetQAGridManageErrorLists1]
(
	@OrganizationID int = NULL,
	@QAMonitoringFormID int = NULL,
	--@QAMonitoringFormTemplateID int = NULL,
	@QAErrorTypeActive smallint = NULL
)
/******************************************************************************
**		File: GetQAGridManageErrorLists.sql
**		Name: GetQAGridManageErrorLists
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/28/2009	ccarroll	initial
**      02/09       jth         set templateid to null if 0 passed in 
**      03/09       jth         no active logic
**      05/09       jth         took out join to form, since some error types don't have one
**      02/10       jth         broke out to do forms and error list
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
--if (@QAMonitoringFormID=0)
--begin
--	set @QAMonitoringFormID = null
--end
IF @QAErrorTypeActive = 0
		BEGIN
			/* Display All ErrorTypes */
			SET @QAErrorTypeActive =1
		END
ELSE 
		BEGIN
			/* Only display active ErrorTypes */	 
			SET @QAErrorTypeActive =null
		END
	SELECT
				QAMonitoringFormTemplate.QAMonitoringFormTemplateID,
				QAErrorType.QAErrorTypeActive,
				QAMonitoringFormTemplate.QAMonitoringFormTemplateOrder,
				QAErrorType.QAErrorTypeID,QAErrorType.QATrackingTypeID,
				QAErrorType.QAErrorTypeDescription,
				QAErrorLocation.QAErrorLocationDescription,
				QAMonitoringForm.QAMonitoringFormID,QAMonitoringForm.QAMonitoringFormName,
				QAErrorLocation.QAErrorLocationID,
				(select QATrackingType.QATrackingTypeDescription from QATrackingType where QATrackingType.QATrackingTypeID = QAErrorType.QATrackingTypeID) as TrackingDesc
	FROM         QAMonitoringFormTemplate INNER JOIN
                      QAErrorType ON QAMonitoringFormTemplate.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QAErrorLocation ON QAErrorType.QAErrorLocationID = QAErrorLocation.QAErrorLocationID LEFT OUTER JOIN
                      QAMonitoringForm ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
	WHERE     (QAErrorType.QAErrorTypeActive = ISNULL(@QAErrorTypeActive, QAErrorType.QAErrorTypeActive)) AND (QAErrorType.OrganizationID = ISNULL(@OrganizationID, 
                      QAErrorType.OrganizationID)) AND (ISNULL(ISNULL(@QAMonitoringFormID, QAMonitoringFormTemplate.QAMonitoringFormID), - 1) 
                      = ISNULL(QAMonitoringFormTemplate.QAMonitoringFormID, - 1))
    order by 7,3

	RETURN @@Error
GO


 

 GO 

 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridPendingReview]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridPendingReview]
	PRINT 'Dropping Procedure: GetQAGridPendingReview'
END
	PRINT 'Creating Procedure: GetQAGridPendingReview'
GO

CREATE PROCEDURE [dbo].[GetQAGridPendingReview]
(
	--@QATrackingID int = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetQAGridPendingReview.sql
**		Name: GetQAGridPendingReview
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/30/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/30/2009	ccarroll	initial
**      02/09       jth         don't need trackingid
**      03/09       jth         sql returning wrong fields
**      04/09       jth         add join to form template to get formid
**      04/09       jth         reworked because of new tables
**		09/18/2009	ccarroll	changed EventDate and StatEmployeeName for ErrorTypes
**      02/2010     jth         added if person is null, so that pending forms won't show if not completed with an employee
**	   04/2010		bret			updating to include in release
**      04/2010     jth         implemented Steve's speed changes
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT DISTINCT 
       QATracking.QATrackingID, 
       QATracking.QATrackingNumber, 
       QATracking.QATrackingReferralDateTime, 
       QATrackingForm.QATrackingFormID, 
       QAMFT.QAMonitoringFormID as QAMonitoringFormID,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAE1.QAErrorLocationDescription
            ELSE NULL 
       END AS LocationDesc,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAE1.QAErrorLocationID
            ELSE NULL 
       END AS LocationID,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN 'Error Type' 
            ELSE 'QM Form'
       END AS 'TrackingType',
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAErrorlog.qaerrorlogid
            ELSE NULL 
       END AS qaerrorlogid,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAET1.qaerrortypedescription
            ELSE NULL 
       END AS QAErrorTypeDescription,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAEPS.qaprocessstepdescription
            ELSE NULL 
       END AS QAProcessStepDescription,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null
            THEN QAELHI.QAErrorLogHowIdentifiedDescription
            ELSE NULL 
       END AS QAErrorLogHowIdentifiedDescription,
       Person.PersonID,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN
                  CONVERT(CHAR(10),QAErrorLog.LastModified,101) + ' ' +
                  CONVERT(CHAR(5),QAErrorLog.LastModified,108)
            ELSE
                  CONVERT(CHAR(10),QATrackingForm.QATrackingEventDateTime,101) + ' ' +
                  CONVERT(CHAR(5),QATrackingForm.QATrackingEventDateTime,108)
       END AS QATrackingEventDateTimeString,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            then ISNULL(P1.PersonFirst, '') + ' ' + ISNULL(P1.PersonLast, '')
            else ISNULL(P2.PersonFirst, '') + ' ' + ISNULL(P2.PersonLast, '')
       end as Employee,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
                  THEN ISNULL(SE.StatEmployeeFirstName, '') + ' ' + ISNULL(SE.StatEmployeeLastName, '') 
            ELSE ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
       END AS StatEmployeeName,
       CASE WHEN QAErrorLog.QAMonitoringFormTemplateID IS Null 
            THEN QAErrorLog.LastModified
            ELSE QATrackingEventDateTime 
       END AS QATrackingEventDateTime,       
       QAErrorLogPersonID,
       QATT.QATrackingTypeDescription as 'TrackingDesc'
FROM   QATracking INNER JOIN QAErrorLog ON (QATracking.QATrackingID = QAErrorLog.QATrackingID) 
                  INNER JOIN Person ON (Person.PersonID = QAErrorLog.StatEmployeeID)
                  LEFT OUTER JOIN QATrackingFormErrors ON (QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID)
                          LEFT OUTER JOIN QAMonitoringFormTemplate QAMFT ON (QAErrorLog.QAMonitoringFormTemplateID = QAMFT.QAMonitoringFormTemplateID)
                  LEFT OUTER JOIN QAErrorLocation QAE1 ON (QAErrorLog.QAErrorLocationID = QAE1.QAErrorLocationID )  
                  LEFT OUTER JOIN QAErrorType QAET1 ON (qaerrorlog.qaerrortypeid  = QAET1.qaerrortypeid )
                  LEFT OUTER JOIN QATrackingForm ON (QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID )
                  LEFT OUTER JOIN QAProcessStep QAEPS ON (qaerrorlog.qaprocessstepid = QAEPS.qaprocessstepid)
                  LEFT OUTER JOIN QAErrorLogHowIdentified QAELHI ON (QAErrorLog.QAErrorLogHowIdentifiedid = QAELHI.QAErrorLogHowIdentifiedid)
                  LEFT OUTER JOIN Person P1 ON (QAErrorLog.QAErrorLogPersonID = P1.personid)
                  LEFT OUTER JOIN Person P2 ON (QATrackingForm.personid = P2.personid)
                  INNER JOIN StatEmployee SE ON (QAErrorLog.LastStatEmployeeID = SE.StatEmployeeID) 
                  LEFT OUTER JOIN QATrackingType QATT ON (QATracking.QATrackingTypeID = QATT.QATrackingTypeID)
      WHERE QAErrorLog.QAErrorStatusID = 1 and
            QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)
            and QAErrorLog.qaerrorlogpersonid is not null


	RETURN @@Error
GO




 GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAMonitoringForm]
	PRINT 'Dropping Procedure: GetQAMonitoringForm'
END
	PRINT 'Creating Procedure: GetQAMonitoringForm'
GO

CREATE PROCEDURE [dbo].[GetQAMonitoringForm]
(
	@QAMonitoringFormID int = NULL,
	@OrganizationID int = NULL,
	@QATrackingNumber varchar(20) = NULL,
	@EmployeeID int = NULL

)
/******************************************************************************
**		File: GetQAMonitoringForm.sql
**		Name: GetQAMonitoringForm
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      02/09       jth         added employeeid and trackingnumber parm; added joing to tracking table, rework selected fields
**      03/09       jth         added military time string 
**      04/09       jth         reworked to use new tracking tables
**      03/10       jth         added trackingid for querystring
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT distinct
		QATrackingForm.QATrackingFormID,
		QATrackingEventDateTime,(select ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')from person where person.personid=statemployeeid) as CompletedBy,
		CONVERT(CHAR(10),QATrackingEventDateTime,101) + ' ' +
		CONVERT(CHAR(5),QATrackingEventDateTime,108) as LastModifiedString,
		QATrackingFormPoints,qatracking.QATrackingID,
		(select qaprocessstepdescription from qaprocessstep where qaprocessstep.qaprocessstepid = qatrackingform.qaprocessstepid) as QAProcessStepDescription
		
	
	FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID INNER JOIN
                      QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID INNER JOIN
                      QATrackingFormErrors ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID INNER JOIN
                      QATrackingForm ON QATrackingFormErrors.QATrackingFormID = QATrackingForm.QATrackingFormID 
                      --AND  QAErrorLog.StatEmployeeID = QATrackingForm.PersonID
	WHERE 
		QAMonitoringFormTemplate.QAMonitoringFormID = IsNull(@QAMonitoringFormID, QAMonitoringFormTemplate.QAMonitoringFormID) AND
		OrganizationID = IsNull(@OrganizationID, OrganizationID) and
		QATracking.QATrackingNumber = IsNull(@QATrackingNumber, QATrackingNumber) and 
		PersonID = IsNull(@EmployeeID, StatEmployeeID)
		 and QAErrorLog.qaerrorlogpersonid is not null

	RETURN @@Error
GO




 GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATracking]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATracking]
	PRINT 'Dropping Procedure: GetQATracking'
END
	PRINT 'Creating Procedure: GetQATracking'
GO

CREATE PROCEDURE [dbo].[GetQATracking]
(
	@QATrackingNumber varchar(20) = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetQATracking.sql
**		Name: GetQATracking
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      03/10       jth         change to do this by tracking number...this is used for dupe checking
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QATrackingID],
		[OrganizationID],
		[QATrackingTypeID],
		[QATrackingNumber],
		[QATrackingNotes],
		[QATrackingSourceCode],
		[QATrackingReferralDateTime],
		[QATrackingReferralTypeID],
		[QATrackingStatusID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QATracking]
	WHERE 
		[QATrackingNumber] = IsNull(@QATrackingNumber, QATrackingNumber) AND
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID)


	RETURN @@Error
GO




 GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATrackingType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATrackingType]
	PRINT 'Dropping Procedure: GetQATrackingType'
END
	PRINT 'Creating Procedure: GetQATrackingType'
GO

CREATE PROCEDURE GetQATrackingType
(
@OrganizationID int = NULL
)

/******************************************************************************
**		File: GetQATrackingType.sql
**		Name: GetQATrackingType
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      02/17/09    jth			qatrackingid is not in table   
**      03/10       jth			remove fields not needed
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	
	SELECT
		[QATrackingTypeID],
		
		[QATrackingTypeDescription]
		
	
	FROM
			[QATrackingType]
	WHERE 
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID)


	RETURN @@Error
GO



 GO 

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetReferralInfo]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetReferralInfo]
	PRINT 'Dropping Procedure: GetReferralInfo'
END
	PRINT 'Creating Procedure: GetReferralInfo'
GO

CREATE PROCEDURE [dbo].[GetReferralInfo]
(
	@CallID int = NULL,
	@WebReportGroupID int = null
)
/******************************************************************************
**		File: GetReferralInfo.sql
**		Name: GetReferralInfo
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/2009		jth			initial
**	   04/2010		bret			updating to include in release
**      04/10       jth          if report group id is 37, accept all
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
IF @WebReportGroupID =37
		BEGIN
			/* Display All ProcessSteps */
			SET @WebReportGroupID = null
		END
	SELECT top 1    Call.CallDateTime, SourceCode.SourceCodeName, Call.CallID, CallTypeName,
                      ISNULL(MessageType.MessageTypeID, Referral.ReferralTypeID) 
                      AS ReferralTypeID1, ISNULL(MessageType.MessageTypeName, ReferralType.ReferralTypeName) AS ReferralTypeName
FROM         ReferralType INNER JOIN
                      Referral ON ReferralType.ReferralTypeID = Referral.ReferralTypeID INNER JOIN
                      WebReportGroupOrg ON Referral.ReferralCallerOrganizationID = WebReportGroupOrg.OrganizationID RIGHT OUTER JOIN
                      MessageType INNER JOIN
                      Message ON MessageType.MessageTypeID = Message.MessageTypeID RIGHT OUTER JOIN
                      CallType INNER JOIN
                      Call INNER JOIN
                      SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID ON CallType.CallTypeID = Call.CallTypeID ON Message.CallID = Call.CallID ON 
                      Referral.CallID = Call.CallID
	WHERE 
		Call.CallID = @CallID 
		and WebReportGroupOrg.WebReportGroupID = isnull(@WebReportGroupID,WebReportGroupOrg.WebReportGroupID)
		


	RETURN @@Error
GO


  

 GO 

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetValidTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure GetValidTrackingNumber'
		DROP  Procedure  GetValidTrackingNumber
	END

GO

PRINT 'Creating Procedure GetValidTrackingNumber'
GO  
CREATE PROCEDURE GetValidTrackingNumber
	@CallID						int = Null,
	@ReportGroupID				int = Null,
	@returnVal int OUTPUT
	
	

AS
/******************************************************************************
	
**		File: GetValidTrackingNumber.sql
**		Name: GetValidTrackingNumber
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: QA
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: jth
**		Date: 3/2009
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**     03/2009      jth             initial
**     02/10        jth             added report group id
**	   04/2010		bret			updating to include in release
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
set @returnval = 0


SELECT  @returnVal=count(*) FROM Call INNER JOIN
Referral ON Call.CallID = Referral.CallID
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
WHERE     (Call.CallID = @CallID)    
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


RETURN @returnVal
GO 

 GO 

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionRetrieveGridForDotNet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionRetrieveGridForDotNet]
GO

CREATE PROCEDURE sps_SecondaryDispositionRetrieveGridForDotNet 
	@CallID   INT 

AS
/******************************************************************************
**		File: sps_SecondaryDispositionRetrieveGridForDotNet.sql
**		Name: sps_SecondaryDispositionRetrieveGridForDotNet
**		Desc: 
**
**              
**		Return values: 
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**  @CallID int,
**		Auth: Dave Hoffmann
**		Date: 09/01/2001
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		2/15/05		Scott Plummer - SAP	Rewrote query to use table variable for join*****										instead of joining to subselect after
**										timeouts and slow queries appearing.
**		05/25/07	Bret Knoll			Add Comment block
**										Cannot use read transaction level
**		04/2010		Bret Knoll			Created new Sproc from sps_SecondaryDispositionRetrieveGrid to add column for processor sort
*******************************************************************************/
SET NOCOUNT ON

DECLARE @dispTbl Table (CallID Int,
			CriteriaID Int,
			DonorCategoryID Int,
			ServiceLevelID Int,
			SLAppropriate Int,
			SLApproach Int,
			SLConsent Int,
			SLRecovery Int
			) 

-- First, get the donor category information for this call and insert
-- it into a table variable to be used to join to the larger query below.
INSERT INTO @dispTbl
SELECT cc.CallID,
       CASE dc.DonorCategoryID
         WHEN 1 THEN cc.OrganCriteriaID
         WHEN 2 THEN cc.BoneCriteriaID
         WHEN 3 THEN cc.TissueCriteriaID
         WHEN 4 THEN cc.SkinCriteriaID
         WHEN 5 THEN cc.ValvesCriteriaID
         WHEN 6 THEN cc.EyesCriteriaID
         WHEN 7 THEN cc.OtherCriteriaID
         ELSE 0
       END CriteriaID,
       dc.DonorCategoryID, cc.ServiceLevelID,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelAppropriateOrgan
         WHEN 2 THEN sl.ServiceLevelAppropriateBone
         WHEN 3 THEN sl.ServiceLevelAppropriateTissue
         WHEN 4 THEN sl.ServiceLevelAppropriateSkin
         WHEN 5 THEN sl.ServiceLevelAppropriateValves
         WHEN 6 THEN sl.ServiceLevelAppropriateEyes
         WHEN 7 THEN sl.ServiceLevelAppropriateRsch
         ELSE 0
       END SLAppropriate,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelApproachOrgan
         WHEN 2 THEN sl.ServiceLevelApproachBone
         WHEN 3 THEN sl.ServiceLevelApproachTissue
         WHEN 4 THEN sl.ServiceLevelApproachSkin
         WHEN 5 THEN sl.ServiceLevelApproachValves
         WHEN 6 THEN sl.ServiceLevelApproachEyes
         WHEN 7 THEN sl.ServiceLevelApproachRsch
         ELSE 0
       END SLApproach,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelConsentOrgan
         WHEN 2 THEN sl.ServiceLevelConsentBone
         WHEN 3 THEN sl.ServiceLevelConsentTissue
         WHEN 4 THEN sl.ServiceLevelConsentSkin
         WHEN 5 THEN sl.ServiceLevelConsentValves
         WHEN 6 THEN sl.ServiceLevelConsentEyes
         WHEN 7 THEN sl.ServiceLevelConsentRsch
         ELSE 0
       END SLConsent,
       CASE dc.DonorCategoryID
         WHEN 1 THEN sl.ServiceLevelRecoveryOrgan
         WHEN 2 THEN sl.ServiceLevelRecoveryBone
         WHEN 3 THEN sl.ServiceLevelRecoveryTissue
         WHEN 4 THEN sl.ServiceLevelRecoverySkin
         WHEN 5 THEN sl.ServiceLevelRecoveryValves
         WHEN 6 THEN sl.ServiceLevelRecoveryEyes
         WHEN 7 THEN sl.ServiceLevelRecoveryRsch
         ELSE 0
       END SLRecovery
	FROM CallCriteria cc, DonorCategory dc,ServiceLevel sl 
	WHERE cc.ServiceLevelID = sl.ServiceLevelID
	AND cc.CallID = @CallId;

-- Now use the table created above (aliased as J) to join to data from other tables.
SELECT J.CallID, J.CriteriaID, J.DonorCategoryID,
       DonorCategory = CASE
                         WHEN J.CriteriaID = 0 OR J.CriteriaID IS NULL THEN
                            DCN.DonorCategoryName
                         ELSE
                            ddc.DynamicDonorCategoryName 
                         END,
       sc.SubCriteriaID, st.SubTypeID, st.SubTypeName, sc.ProcessorID, 
       NULL btn1, NULL btn2, o.OrganizationName ProcessorName, 
       Appropriate = SecondaryDispositionAppropriate,  
       Approach =    SecondaryDispositionApproach,  
       Consent =     SecondaryDispositionConsent,
       Recovery =    SecondaryDispositionConversion, NULL buffer, 
       J.SLAppropriate, J.SLApproach, J.SLConsent, J.SLRecovery, 
       ARO = CASE 
			WHEN J.DonorCategoryID = 1 AND r.ReferralOrganAppropriateID      = 1 THEN 0
			WHEN J.DonorCategoryID = 2 AND r.ReferralBoneAppropriateID       = 1 THEN 0
			WHEN J.DonorCategoryID = 3 AND r.ReferralTissueAppropriateID     = 1 THEN 0
			WHEN J.DonorCategoryID = 4 AND r.ReferralSkinAppropriateID       = 1 THEN 0
			WHEN J.DonorCategoryID = 5 AND r.ReferralValvesAppropriateID     = 1 THEN 0
			WHEN J.DonorCategoryID = 6 AND r.ReferralEyesTransAppropriateID  = 1 THEN 0
			WHEN J.DonorCategoryID = 7 AND r.ReferralEyesRschAppropriateID   = 1 THEN 0
			ELSE -1
		END,
        CRO = ISNULL(SecondaryDispositionCRO, 0), 0 PRO	,
        ProcessorOrder = COALESCE(sc.ProcessorPrecedence, 0)

FROM ServiceLevel sl 
	INNER JOIN @dispTbl J ON sl.ServiceLevelID = J.ServiceLevelID 
	LEFT OUTER JOIN SubCriteria sc 
	INNER JOIN Organization o ON sc.ProcessorID = o.OrganizationID 
	RIGHT OUTER JOIN SubType st 
	INNER JOIN CriteriaSubType cst ON st.SubTypeID = cst.SubTypeID ON sc.SubtypeID = cst.SubTypeID 
		AND sc.CriteriaID = cst.CriteriaID ON J.CriteriaID = sc.CriteriaID AND J.DonorCategoryID = sc.DonorCategoryID
	LEFT JOIN Referral r ON r.CallID = J.CallID
	LEFT JOIN DonorCategory DCN ON DCN.DonorCategoryID =  J.DonorCategoryID 	
	LEFT JOIN SecondaryDisposition SD (NOLOCK) ON SD.CallID = J.CallID AND SD.SubCriteriaID = sc.SubCriteriaID
	LEFT JOIN Criteria c ON c.CriteriaID = J.CriteriaID
	LEFT JOIN DynamicDonorCategory ddc ON ddc.DynamicDonorCategoryID = c.DynamicDonorCategoryID
	
ORDER BY J.DonorCategoryID, cst.SubCriteriaPrecedence, ProcessorOrder, sc.SUBCRITERIAID;

RETURN @@ROWCOUNT;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 

 GO 

