PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:4/27/2012 1:14:09 PM-- -- --  
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAErrorLocation.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAErrorLog.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAErrorLogHowIdentified.sql.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAErrorStatus.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAErrorType.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAMonitoringForm.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAMonitoringFormTemplate.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QAProcessStep.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QATracking.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QATrackingForm.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QATrackingFormErrors.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QATrackingStatus.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spi_Audit_QATrackingType.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAErrorLocation.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAErrorLog.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAErrorLogHowIdentified.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAErrorStatus.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAErrorType.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAMonitoringForm.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAMonitoringFormTemplate.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QAProcessStep.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QATracking.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QATrackingForm.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QATrackingFormErrors.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QATrackingStatus.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/AudiTrail/stored procedures/spu_Audit_QATrackingType.sql

PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAErrorLocation.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAErrorLocation]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAErrorLocation]
			PRINT 'Dropping Procedure: spi_Audit_QAErrorLocation'
	END

PRINT 'Creating Procedure: spi_Audit_QAErrorLocation'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAErrorLocation]
(
	@QAErrorLocationID int = NULL,
	@OrganizationID int = NULL,
	@QAErrorLocationDescription varchar(255) = NULL,
	@QAErrorLocationActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAErrorLocation.sql
**		Name: spi_Audit_QAErrorLocation
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAErrorLocation]
	(
		[QAErrorLocationID],
		[OrganizationID],
		[QAErrorLocationDescription],
		[QAErrorLocationActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorLocationID,
		@OrganizationID,
		@QAErrorLocationDescription,
		@QAErrorLocationActive,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)

	RETURN @@Error
GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAErrorLog.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAErrorLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAErrorLog]
			PRINT 'Dropping Procedure: spi_Audit_QAErrorLog'
	END

PRINT 'Creating Procedure: spi_Audit_QAErrorLog'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAErrorLog]
(
	@QAErrorLogID int = NULL OUTPUT,
	@QATrackingID int = NULL,
	@QAProcessStepID int = NULL,
	@QAErrorLocationID int = NULL,
	@QAErrorTypeID int = NULL,
	@QAMonitoringFormTemplateID int = NULL,
	@StatEmployeeID int = NULL,
	@QAErrorLogNumberOfErrors int = NULL,
	@QAErrorLogDateTime datetime = NULL,
	@QAErrorLogHowIdentifiedID int = NULL,
	@QAErrorLogTicketNumber varchar(20) = NULL,
	@QAErrorLogComments varchar(1000) = NULL,
	@QAErrorLogCorrection varchar(1000) = NULL,
	@QAErrorLogCorrectionPersonID int = NULL,
	@QAErrorLogCorrectionLastModified datetime = NULL,
	@QAErrorLogPointsYes smallint = NULL,
	@QAErrorLogPointsNo smallint = NULL,
	@QAErrorLogPointsNA smallint = NULL,
	@QAErrorStatusID int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAErrorLog.sql
**		Name: spi_Audit_QAErrorLog
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/8/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/8/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAErrorLog]
	(
		[QAErrorLogID],
		[QATrackingID],
		[QAProcessStepID],
		[QAErrorLocationID],
		[QAErrorTypeID],
		[QAMonitoringFormTemplateID],
		[StatEmployeeID],
		[QAErrorLogNumberOfErrors],
		[QAErrorLogDateTime],
		[QAErrorLogHowIdentifiedID],
		[QAErrorLogTicketNumber],
		[QAErrorLogComments],
		[QAErrorLogCorrection],
		[QAErrorLogCorrectionPersonID],
		[QAErrorLogCorrectionLastModified],
		[QAErrorLogPointsYes],
		[QAErrorLogPointsNo],
		[QAErrorLogPointsNA],
		[QAErrorStatusID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorLogID,
		@QATrackingID,
		@QAProcessStepID,
		@QAErrorLocationID,
		@QAErrorTypeID,
		@QAMonitoringFormTemplateID,
		@StatEmployeeID,
		@QAErrorLogNumberOfErrors,
		@QAErrorLogDateTime,
		@QAErrorLogHowIdentifiedID,
		@QAErrorLogTicketNumber,
		@QAErrorLogComments,
		@QAErrorLogCorrection,
		@QAErrorLogCorrectionPersonID,
		@QAErrorLogCorrectionLastModified,
		@QAErrorLogPointsYes,
		@QAErrorLogPointsNo,
		@QAErrorLogPointsNA,
		@QAErrorStatusID,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAErrorLogHowIdentified.sql.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAErrorLogHowIdentified]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAErrorLogHowIdentified]
			PRINT 'Dropping Procedure: spi_Audit_QAErrorLogHowIdentified'
	END

PRINT 'Creating Procedure: spi_Audit_QAErrorLogHowIdentified'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAErrorLogHowIdentified]
(
	@QAErrorLogHowIdentifiedID int = NULL,
	@QAErrorLogHowIdentifiedDescription varchar(250) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAErrorLogHowIdentified.sql
**		Name: spi_Audit_QAErrorLogHowIdentified
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAErrorLogHowIdentified]
	(
		[QAErrorLogHowIdentifiedID],
		[QAErrorLogHowIdentifiedDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorLogHowIdentifiedID,
		@QAErrorLogHowIdentifiedDescription,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAErrorStatus.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAErrorStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAErrorStatus]
			PRINT 'Dropping Procedure: spi_Audit_QAErrorStatus'
	END

PRINT 'Creating Procedure: spi_Audit_QAErrorStatus'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAErrorStatus]
(
	@QAErrorStatusID int = NULL,
	@QAErrorStatusDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAErrorStatus.sql
**		Name: spi_Audit_QAErrorStatus
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAErrorStatus]
	(
		[QAErrorStatusID],
		[QAErrorStatusDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorStatusID,
		@QAErrorStatusDescription,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAErrorType.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAErrorType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAErrorType]
			PRINT 'Dropping Procedure: spi_Audit_QAErrorType'
	END

PRINT 'Creating Procedure: spi_Audit_QAErrorType'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAErrorType]
(
	@QAErrorTypeID int = NULL,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QAErrorLocationID int = NULL,
	@QAErrorTypeDescription varchar(255) = NULL,
	@QAErrorRequireReview smallint = NULL,
	@QAErrorTypeActive smallint = NULL,
	@QAErrorTypeInactiveComments varchar(1000) = NULL,
	@QAErrorTypeAssignedPoints int = NULL,
	@QAErrorTypeAutomaticZeroScore smallint = NULL,
	@QAErrorTypeDisplayNA smallint = NULL,
	@QAErrorTypeDisplayComments smallint = NULL,
	@QAErrorTypeGenerateLogIfNo smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAErrorType.sql
**		Name: spi_Audit_QAErrorType
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAErrorType]
	(
		[QAErrorTypeID],
		[OrganizationID],
		[QATrackingTypeID],
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
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorTypeID,
		@OrganizationID,
		@QATrackingTypeID,
		@QAErrorLocationID,
		@QAErrorTypeDescription,
		@QAErrorRequireReview,
		@QAErrorTypeActive,
		@QAErrorTypeInactiveComments,
		@QAErrorTypeAssignedPoints,
		@QAErrorTypeAutomaticZeroScore,
		@QAErrorTypeDisplayNA,
		@QAErrorTypeDisplayComments,
		@QAErrorTypeGenerateLogIfNo,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
 
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAMonitoringForm.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAMonitoringForm]
			PRINT 'Dropping Procedure: spi_Audit_QAMonitoringForm'
	END

PRINT 'Creating Procedure: spi_Audit_QAMonitoringForm'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAMonitoringForm]
(
	@QAMonitoringFormID int = NULL,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QAMonitoringFormName varchar(255) = NULL,
	@QAMonitoringFormRequireReview smallint = NULL,
	@QAMonitoringFormCalculateScore smallint = NULL,
	@QAMonitoringFormActive smallint = NULL,
	@QAMonitoringFormInactiveComments varchar(1000) = NULL,
	@QAMonitoringFormScore decimal(5,0) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAMonitoringForm.sql
**		Name: spi_Audit_QAMonitoringForm
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAMonitoringForm]
	(
		[QAMonitoringFormID],
		[OrganizationID],
		[QATrackingTypeID],
		[QAMonitoringFormName],
		[QAMonitoringFormRequireReview],
		[QAMonitoringFormCalculateScore],
		[QAMonitoringFormActive],
		[QAMonitoringFormInactiveComments],
		[QAMonitoringFormScore],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAMonitoringFormID,
		@OrganizationID,
		@QATrackingTypeID,
		@QAMonitoringFormName,
		@QAMonitoringFormRequireReview,
		@QAMonitoringFormCalculateScore,
		@QAMonitoringFormActive,
		@QAMonitoringFormInactiveComments,
		@QAMonitoringFormScore,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAMonitoringFormTemplate.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAMonitoringFormTemplate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAMonitoringFormTemplate]
			PRINT 'Dropping Procedure: spi_Audit_QAMonitoringFormTemplate'
	END

PRINT 'Creating Procedure: spi_Audit_QAMonitoringFormTemplate'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAMonitoringFormTemplate]
(
	@QAMonitoringFormTemplateID int = NULL,
	@QAMonitoringFormID int = NULL,
	@QAErrorTypeID int,
	@QAMonitoringFormTemplateOrder int = NULL,
	@QAMonitoringFormTemplateActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAMonitoringFormTemplate.sql
**		Name: spi_Audit_QAMonitoringFormTemplate
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAMonitoringFormTemplate]
	(
		[QAMonitoringFormTemplateID],
		[QAMonitoringFormID],
		[QAErrorTypeID],
		[QAMonitoringFormTemplateOrder],
		[QAMonitoringFormTemplateActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAMonitoringFormTemplateID,
		@QAMonitoringFormID,
		@QAErrorTypeID,
		@QAMonitoringFormTemplateOrder,
		@QAMonitoringFormTemplateActive,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QAProcessStep.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAProcessStep]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAProcessStep]
			PRINT 'Dropping Procedure: spi_Audit_QAProcessStep'
	END

PRINT 'Creating Procedure: spi_Audit_QAProcessStep'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAProcessStep]
(
	@QAProcessStepID int = NULL,
	@OrganizationID int = NULL,
	@QAProcessStepDescription varchar(255) = NULL,
	@QAProcessStepActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAProcessStep.sql
**		Name: spi_Audit_QAProcessStep
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAProcessStep]
	(
		[QAProcessStepID],
		[OrganizationID],
		[QAProcessStepDescription],
		[QAProcessStepActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAProcessStepID,
		@OrganizationID,
		@QAProcessStepDescription,
		@QAProcessStepActive,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QATracking.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATracking]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATracking]
			PRINT 'Dropping Procedure: spi_Audit_QATracking'
	END

PRINT 'Creating Procedure: spi_Audit_QATracking'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATracking]
(
	@QATrackingID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QATrackingNumber varchar(20) = NULL,
	@QATrackingNotes varchar(1000) = NULL,
	@QATrackingSourceCode varchar(15) = NULL,
	@QATrackingReferralDateTime datetime = NULL,
	@QATrackingReferralTypeID int = NULL,
	@QATrackingStatusID int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATracking.sql
**		Name: spi_Audit_QATracking
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATracking]
	(
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
	)
	VALUES
	(
		@QATrackingID,
		@OrganizationID,
		@QATrackingTypeID,
		@QATrackingNumber,
		@QATrackingNotes,
		@QATrackingSourceCode,
		@QATrackingReferralDateTime,
		@QATrackingReferralTypeID,
		@QATrackingStatusID,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QATrackingForm.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATrackingForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATrackingForm]
			PRINT 'Dropping Procedure: spi_Audit_QATrackingForm'
	END

PRINT 'Creating Procedure: spi_Audit_QATrackingForm'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATrackingForm]
(
	@QATrackingFormID int = NULL,
	@QAProcessStepID int = NULL,
	@PersonID int = NULL,
	@QATrackingEventDateTime datetime = NULL,
	@QATrackingCAPANumber varchar(20) = NULL,
	@QATrackingApproved smallint = NULL,
	@QATrackingStatusID int = NULL,
	@QATrackingFormPoints numeric(5,4) = NULL,
	@QATrackingFormComments varchar(1000) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATrackingForm.sql
**		Name: spi_Audit_QATrackingForm
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATrackingForm]
	(
		[QATrackingFormID],
		[QAProcessStepID],
		[PersonID],
		[QATrackingEventDateTime],
		[QATrackingCAPANumber],
		[QATrackingApproved],
		[QATrackingStatusID],
		[QATrackingFormPoints],
		[QATrackingFormComments],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingFormID,
		@QAProcessStepID,
		@PersonID,
		@QATrackingEventDateTime,
		@QATrackingCAPANumber,
		@QATrackingApproved,
		@QATrackingStatusID,
		@QATrackingFormPoints,
		@QATrackingFormComments,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
 
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QATrackingFormErrors.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATrackingFormErrors]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATrackingFormErrors]
			PRINT 'Dropping Procedure: spi_Audit_QATrackingFormErrors'
	END

PRINT 'Creating Procedure: spi_Audit_QATrackingFormErrors'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATrackingFormErrors]
(
	@QATrackingFormErrorsID int = NULL,
	@QATrackingFormID int = NULL,
	@QAErrorLogID int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATrackingFormErrors.sql
**		Name: spi_Audit_QATrackingFormErrors
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATrackingFormErrors]
	(
		[QATrackingFormErrorsID],
		[QATrackingFormID],
		[QAErrorLogID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingFormErrorsID,
		@QATrackingFormID,
		@QAErrorLogID,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QATrackingStatus.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATrackingStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATrackingStatus]
			PRINT 'Dropping Procedure: spi_Audit_QATrackingStatus'
	END

PRINT 'Creating Procedure: spi_Audit_QATrackingStatus'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATrackingStatus]
(
	@QATrackingStatusID int = NULL,
	@QATrackingStatusDescription varchar(250) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATrackingStatus.sql
**		Name: spi_Audit_QATrackingStatus
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATrackingStatus]
	(
		[QATrackingStatusID],
		[QATrackingStatusDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingStatusID,
		@QATrackingStatusDescription,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spi_Audit_QATrackingType.sql'
GO
 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATrackingType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATrackingType]
			PRINT 'Dropping Procedure: spi_Audit_QATrackingType'
	END

PRINT 'Creating Procedure: spi_Audit_QATrackingType'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATrackingType]
(
	@QATrackingTypeID int = NULL,
	@OrganizationID int = NULL,
	@QATrackingTypeDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATrackingType.sql
**		Name: spi_Audit_QATrackingType
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATrackingType]
	(
		[QATrackingTypeID],
		[OrganizationID],
		[QATrackingTypeDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingTypeID,
		@OrganizationID,
		@QATrackingTypeDescription,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAErrorLocation.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAErrorLocation'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorLocation'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorLocation
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorLocation
(
 @QAErrorLocationID int 
,@OrganizationID int 
,@QAErrorLocationDescription varchar(255)
,@QAErrorLocationActive smallint 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorLocation
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QAErrorLocationDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QAErrorLocationActive 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --AuditLogTypeID 
)


INSERT INTO dbo.QAErrorLocation
(
 QAErrorLocationID
,OrganizationID
,QAErrorLocationDescription
,QAErrorLocationActive
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QAErrorLocationDescription, '') = '' THEN 'ILB'  ELSE @QAErrorLocationDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QAErrorLocationActive, 0) = 0 THEN -2 ELSE @QAErrorLocationActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAErrorLog.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAErrorLog'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorLog'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorLog
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorLog
(
 @QAErrorLogID int 
,@QATrackingID int 
,@QAProcessStepID int 
,@QAErrorLocationID int 
,@QAErrorTypeID int 
,@QAMonitoringFormTemplateID int 
,@StatEmployeeID int 
,@QAErrorLogNumberOfErrors int 
,@QAErrorLogDateTime datetime 
,@QAErrorLogHowIdentifiedID int 
,@QAErrorLogTicketNumber varchar(20)
,@QAErrorLogComments varchar(1000)
,@QAErrorLogCorrection varchar(1000)
,@QAErrorLogCorrectionPersonID int 
,@QAErrorLogCorrectionLastModified datetime 
,@QAErrorLogPointsYes smallint 
,@QAErrorLogPointsNo smallint 
,@QAErrorLogPointsNA smallint 
,@QAErrorStatusID int 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@QAErrorLogPersonID int 
,@PKC1 int
,@Bitmap binary(4)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorLog
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QATrackingID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QAProcessStepID 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QAErrorLocationID 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --QAErrorTypeID 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --QAMonitoringFormTemplateID 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --StatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 128 <> 128 --QAErrorLogNumberOfErrors 
AND SUBSTRING(@Bitmap, 2, 0) & 1 <> 1 --QAErrorLogDateTime 
AND SUBSTRING(@Bitmap, 2, 0) & 2 <> 2 --QAErrorLogHowIdentifiedID 
AND SUBSTRING(@Bitmap, 2, 0) & 4 <> 4 --QAErrorLogTicketNumber 
AND SUBSTRING(@Bitmap, 2, 0) & 8 <> 8 --QAErrorLogComments 
AND SUBSTRING(@Bitmap, 2, 0) & 16 <> 16 --QAErrorLogCorrection 
AND SUBSTRING(@Bitmap, 2, 0) & 32 <> 32 --QAErrorLogCorrectionPersonID 
AND SUBSTRING(@Bitmap, 2, 0) & 64 <> 64 --QAErrorLogCorrectionLastModified 
AND SUBSTRING(@Bitmap, 2, 0) & 128 <> 128 --QAErrorLogPointsYes 
AND SUBSTRING(@Bitmap, 3, 0) & 1 <> 1 --QAErrorLogPointsNo 
AND SUBSTRING(@Bitmap, 3, 0) & 2 <> 2 --QAErrorLogPointsNA 
AND SUBSTRING(@Bitmap, 3, 0) & 4 <> 4 --QAErrorStatusID 
AND SUBSTRING(@Bitmap, 3, 0) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 3, 0) & 16 <> 16 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 3, 0) & 32 <> 32 --AuditLogTypeID 
AND SUBSTRING(@Bitmap, 3, 0) & 64 <> 64 --QAErrorLogPersonID 
)


INSERT INTO dbo.QAErrorLog
(
 QAErrorLogID
,QATrackingID
,QAProcessStepID
,QAErrorLocationID
,QAErrorTypeID
,QAMonitoringFormTemplateID
,StatEmployeeID
,QAErrorLogNumberOfErrors
,QAErrorLogDateTime
,QAErrorLogHowIdentifiedID
,QAErrorLogTicketNumber
,QAErrorLogComments
,QAErrorLogCorrection
,QAErrorLogCorrectionPersonID
,QAErrorLogCorrectionLastModified
,QAErrorLogPointsYes
,QAErrorLogPointsNo
,QAErrorLogPointsNA
,QAErrorStatusID
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
,QAErrorLogPersonID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QATrackingID, 0) = 0 THEN -2 ELSE @QATrackingID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QAProcessStepID, 0) = 0 THEN -2 ELSE @QAProcessStepID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QAErrorLocationID, 0) = 0 THEN -2 ELSE @QAErrorLocationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@QAErrorTypeID, 0) = 0 THEN -2 ELSE @QAErrorTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@QAMonitoringFormTemplateID, 0) = 0 THEN -2 ELSE @QAMonitoringFormTemplateID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@StatEmployeeID, 0) = 0 THEN -2 ELSE @StatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 128 = 128 AND ISNULL(@QAErrorLogNumberOfErrors, 0) = 0 THEN -2 ELSE @QAErrorLogNumberOfErrors END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 1 = 1 AND ISNULL(@QAErrorLogDateTime, '') = '' THEN '1900-01-01'  ELSE @QAErrorLogDateTime END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 2 = 2 AND ISNULL(@QAErrorLogHowIdentifiedID, 0) = 0 THEN -2 ELSE @QAErrorLogHowIdentifiedID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 4 = 4 AND ISNULL(@QAErrorLogTicketNumber, '') = '' THEN 'ILB'  ELSE @QAErrorLogTicketNumber END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 8 = 8 AND ISNULL(@QAErrorLogComments, '') = '' THEN 'ILB'  ELSE @QAErrorLogComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 16 = 16 AND ISNULL(@QAErrorLogCorrection, '') = '' THEN 'ILB'  ELSE @QAErrorLogCorrection END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 32 = 32 AND ISNULL(@QAErrorLogCorrectionPersonID, 0) = 0 THEN -2 ELSE @QAErrorLogCorrectionPersonID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 64 = 64 AND ISNULL(@QAErrorLogCorrectionLastModified, '') = '' THEN '1900-01-01'  ELSE @QAErrorLogCorrectionLastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 128 = 128 AND ISNULL(@QAErrorLogPointsYes, 0) = 0 THEN -2 ELSE @QAErrorLogPointsYes END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 1 = 1 AND ISNULL(@QAErrorLogPointsNo, 0) = 0 THEN -2 ELSE @QAErrorLogPointsNo END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 2 = 2 AND ISNULL(@QAErrorLogPointsNA, 0) = 0 THEN -2 ELSE @QAErrorLogPointsNA END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 4 = 4 AND ISNULL(@QAErrorStatusID, 0) = 0 THEN -2 ELSE @QAErrorStatusID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 16 = 16 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 32 = 32 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 64 = 64 AND ISNULL(@QAErrorLogPersonID, 0) = 0 THEN -2 ELSE @QAErrorLogPersonID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAErrorLogHowIdentified.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAErrorLogHowIdentified'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorLogHowIdentified'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorLogHowIdentified
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorLogHowIdentified
(
 @QAErrorLogHowIdentifiedID int 
,@QAErrorLogHowIdentifiedDescription varchar(250)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorLogHowIdentified
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QAErrorLogHowIdentifiedDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --AuditLogTypeID 
)


INSERT INTO dbo.QAErrorLogHowIdentified
(
 QAErrorLogHowIdentifiedID
,QAErrorLogHowIdentifiedDescription
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QAErrorLogHowIdentifiedDescription, '') = '' THEN 'ILB'  ELSE @QAErrorLogHowIdentifiedDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAErrorStatus.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAErrorStatus'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorStatus'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorStatus
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorStatus
(
 @QAErrorStatusID int 
,@QAErrorStatusDescription varchar(255)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorStatus
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QAErrorStatusDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --AuditLogTypeID 
)


INSERT INTO dbo.QAErrorStatus
(
 QAErrorStatusID
,QAErrorStatusDescription
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QAErrorStatusDescription, '') = '' THEN 'ILB'  ELSE @QAErrorStatusDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAErrorType.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAErrorType'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorType'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorType
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorType
(
 @QAErrorTypeID int 
,@OrganizationID int 
,@QATrackingTypeID int 
,@QAErrorLocationID int 
,@QAErrorTypeDescription varchar(255)
,@QAErrorRequireReview smallint 
,@QAErrorTypeActive smallint 
,@QAErrorTypeInactiveComments varchar(1000)
,@QAErrorTypeAssignedPoints int 
,@QAErrorTypeAutomaticZeroScore smallint 
,@QAErrorTypeDisplayNA smallint 
,@QAErrorTypeDisplayComments smallint 
,@QAErrorTypeGenerateLogIfNo smallint 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@QAErrorTypeGenerateLogIfYes smallint 
,@PKC1 int
,@Bitmap binary(3)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorType
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QATrackingTypeID 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QAErrorLocationID 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --QAErrorTypeDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --QAErrorRequireReview 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --QAErrorTypeActive 
AND SUBSTRING(@Bitmap, 1, 0) & 128 <> 128 --QAErrorTypeInactiveComments 
AND SUBSTRING(@Bitmap, 2, 0) & 1 <> 1 --QAErrorTypeAssignedPoints 
AND SUBSTRING(@Bitmap, 2, 0) & 2 <> 2 --QAErrorTypeAutomaticZeroScore 
AND SUBSTRING(@Bitmap, 2, 0) & 4 <> 4 --QAErrorTypeDisplayNA 
AND SUBSTRING(@Bitmap, 2, 0) & 8 <> 8 --QAErrorTypeDisplayComments 
AND SUBSTRING(@Bitmap, 2, 0) & 16 <> 16 --QAErrorTypeGenerateLogIfNo 
AND SUBSTRING(@Bitmap, 2, 0) & 32 <> 32 --LastModified 
AND SUBSTRING(@Bitmap, 2, 0) & 64 <> 64 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 2, 0) & 128 <> 128 --AuditLogTypeID 
AND SUBSTRING(@Bitmap, 3, 0) & 1 <> 1 --QAErrorTypeGenerateLogIfYes 
)


INSERT INTO dbo.QAErrorType
(
 QAErrorTypeID
,OrganizationID
,QATrackingTypeID
,QAErrorLocationID
,QAErrorTypeDescription
,QAErrorRequireReview
,QAErrorTypeActive
,QAErrorTypeInactiveComments
,QAErrorTypeAssignedPoints
,QAErrorTypeAutomaticZeroScore
,QAErrorTypeDisplayNA
,QAErrorTypeDisplayComments
,QAErrorTypeGenerateLogIfNo
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
,QAErrorTypeGenerateLogIfYes
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QATrackingTypeID, 0) = 0 THEN -2 ELSE @QATrackingTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QAErrorLocationID, 0) = 0 THEN -2 ELSE @QAErrorLocationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@QAErrorTypeDescription, '') = '' THEN 'ILB'  ELSE @QAErrorTypeDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@QAErrorRequireReview, 0) = 0 THEN -2 ELSE @QAErrorRequireReview END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@QAErrorTypeActive, 0) = 0 THEN -2 ELSE @QAErrorTypeActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 128 = 128 AND ISNULL(@QAErrorTypeInactiveComments, '') = '' THEN 'ILB'  ELSE @QAErrorTypeInactiveComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 1 = 1 AND ISNULL(@QAErrorTypeAssignedPoints, 0) = 0 THEN -2 ELSE @QAErrorTypeAssignedPoints END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 2 = 2 AND ISNULL(@QAErrorTypeAutomaticZeroScore, 0) = 0 THEN -2 ELSE @QAErrorTypeAutomaticZeroScore END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 4 = 4 AND ISNULL(@QAErrorTypeDisplayNA, 0) = 0 THEN -2 ELSE @QAErrorTypeDisplayNA END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 8 = 8 AND ISNULL(@QAErrorTypeDisplayComments, 0) = 0 THEN -2 ELSE @QAErrorTypeDisplayComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 16 = 16 AND ISNULL(@QAErrorTypeGenerateLogIfNo, 0) = 0 THEN -2 ELSE @QAErrorTypeGenerateLogIfNo END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 32 = 32 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 64 = 64 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 128 = 128 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 0) & 1 = 1 AND ISNULL(@QAErrorTypeGenerateLogIfYes, 0) = 0 THEN -2 ELSE @QAErrorTypeGenerateLogIfYes END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAMonitoringForm.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAMonitoringForm'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAMonitoringForm'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAMonitoringForm
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAMonitoringForm
(
 @QAMonitoringFormID int 
,@OrganizationID int 
,@QATrackingTypeID int 
,@QAMonitoringFormName varchar(255)
,@QAMonitoringFormCalculateScore smallint 
,@QAMonitoringFormRequireReview smallint 
,@QAMonitoringFormActive smallint 
,@QAMonitoringFormInactiveComments varchar(1000)
,@QAMonitoringFormScore decimal 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAMonitoringForm
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QATrackingTypeID 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QAMonitoringFormName 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --QAMonitoringFormCalculateScore 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --QAMonitoringFormRequireReview 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --QAMonitoringFormActive 
AND SUBSTRING(@Bitmap, 1, 0) & 128 <> 128 --QAMonitoringFormInactiveComments 
AND SUBSTRING(@Bitmap, 2, 0) & 1 <> 1 --QAMonitoringFormScore 
AND SUBSTRING(@Bitmap, 2, 0) & 2 <> 2 --LastModified 
AND SUBSTRING(@Bitmap, 2, 0) & 4 <> 4 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 2, 0) & 8 <> 8 --AuditLogTypeID 
)


INSERT INTO dbo.QAMonitoringForm
(
 QAMonitoringFormID
,OrganizationID
,QATrackingTypeID
,QAMonitoringFormName
,QAMonitoringFormCalculateScore
,QAMonitoringFormRequireReview
,QAMonitoringFormActive
,QAMonitoringFormInactiveComments
,QAMonitoringFormScore
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QATrackingTypeID, 0) = 0 THEN -2 ELSE @QATrackingTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QAMonitoringFormName, '') = '' THEN 'ILB'  ELSE @QAMonitoringFormName END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@QAMonitoringFormCalculateScore, 0) = 0 THEN -2 ELSE @QAMonitoringFormCalculateScore END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@QAMonitoringFormRequireReview, 0) = 0 THEN -2 ELSE @QAMonitoringFormRequireReview END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@QAMonitoringFormActive, 0) = 0 THEN -2 ELSE @QAMonitoringFormActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 128 = 128 AND ISNULL(@QAMonitoringFormInactiveComments, '') = '' THEN 'ILB'  ELSE @QAMonitoringFormInactiveComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 1 = 1 AND ISNULL(@QAMonitoringFormScore, 0) = 0 THEN -2 ELSE @QAMonitoringFormScore END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 2 = 2 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 4 = 4 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 8 = 8 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAMonitoringFormTemplate.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAMonitoringFormTemplate'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAMonitoringFormTemplate'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAMonitoringFormTemplate
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAMonitoringFormTemplate
(
 @QAMonitoringFormTemplateID int 
,@QAMonitoringFormID int 
,@QAErrorTypeID int 
,@QAMonitoringFormTemplateOrder int 
,@QAMonitoringFormTemplateActive smallint 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAMonitoringFormTemplate
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QAMonitoringFormID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QAErrorTypeID 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QAMonitoringFormTemplateOrder 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --QAMonitoringFormTemplateActive 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 128 <> 128 --AuditLogTypeID 
)


INSERT INTO dbo.QAMonitoringFormTemplate
(
 QAMonitoringFormTemplateID
,QAMonitoringFormID
,QAErrorTypeID
,QAMonitoringFormTemplateOrder
,QAMonitoringFormTemplateActive
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QAMonitoringFormID, 0) = 0 THEN -2 ELSE @QAMonitoringFormID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QAErrorTypeID, 0) = 0 THEN -2 ELSE @QAErrorTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QAMonitoringFormTemplateOrder, 0) = 0 THEN -2 ELSE @QAMonitoringFormTemplateOrder END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@QAMonitoringFormTemplateActive, 0) = 0 THEN -2 ELSE @QAMonitoringFormTemplateActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 128 = 128 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QAProcessStep.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QAProcessStep'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAProcessStep'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAProcessStep
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAProcessStep
(
 @QAProcessStepID int 
,@OrganizationID int 
,@QAProcessStepDescription varchar(255)
,@QAProcessStepActive smallint 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAProcessStep
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QAProcessStepDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QAProcessStepActive 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --AuditLogTypeID 
)


INSERT INTO dbo.QAProcessStep
(
 QAProcessStepID
,OrganizationID
,QAProcessStepDescription
,QAProcessStepActive
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QAProcessStepDescription, '') = '' THEN 'ILB'  ELSE @QAProcessStepDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QAProcessStepActive, 0) = 0 THEN -2 ELSE @QAProcessStepActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QATracking.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QATracking'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATracking'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATracking
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATracking
(
 @QATrackingID int 
,@OrganizationID int 
,@QATrackingTypeID int 
,@QATrackingNumber varchar(20)
,@QATrackingNotes varchar(1000)
,@QATrackingSourceCode varchar(15)
,@QATrackingReferralDateTime datetime 
,@QATrackingReferralTypeID int 
,@QATrackingStatusID int 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATracking
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QATrackingTypeID 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QATrackingNumber 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --QATrackingNotes 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --QATrackingSourceCode 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --QATrackingReferralDateTime 
AND SUBSTRING(@Bitmap, 1, 0) & 128 <> 128 --QATrackingReferralTypeID 
AND SUBSTRING(@Bitmap, 2, 0) & 1 <> 1 --QATrackingStatusID 
AND SUBSTRING(@Bitmap, 2, 0) & 2 <> 2 --LastModified 
AND SUBSTRING(@Bitmap, 2, 0) & 4 <> 4 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 2, 0) & 8 <> 8 --AuditLogTypeID 
)


INSERT INTO dbo.QATracking
(
 QATrackingID
,OrganizationID
,QATrackingTypeID
,QATrackingNumber
,QATrackingNotes
,QATrackingSourceCode
,QATrackingReferralDateTime
,QATrackingReferralTypeID
,QATrackingStatusID
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QATrackingTypeID, 0) = 0 THEN -2 ELSE @QATrackingTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QATrackingNumber, '') = '' THEN 'ILB'  ELSE @QATrackingNumber END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@QATrackingNotes, '') = '' THEN 'ILB'  ELSE @QATrackingNotes END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@QATrackingSourceCode, '') = '' THEN 'ILB'  ELSE @QATrackingSourceCode END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@QATrackingReferralDateTime, '') = '' THEN '1900-01-01'  ELSE @QATrackingReferralDateTime END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 128 = 128 AND ISNULL(@QATrackingReferralTypeID, 0) = 0 THEN -2 ELSE @QATrackingReferralTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 1 = 1 AND ISNULL(@QATrackingStatusID, 0) = 0 THEN -2 ELSE @QATrackingStatusID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 2 = 2 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 4 = 4 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 8 = 8 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QATrackingForm.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QATrackingForm'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATrackingForm'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATrackingForm
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATrackingForm
(
 @QATrackingFormID int 
,@QAProcessStepID int 
,@PersonID int 
,@QATrackingEventDateTime datetime 
,@QATrackingCAPANumber varchar(20)
,@QATrackingApproved smallint 
,@QATrackingStatusID int 
,@QATrackingFormPoints numeric 
,@QATrackingFormComments varchar(1000)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATrackingForm
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QAProcessStepID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --PersonID 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --QATrackingEventDateTime 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --QATrackingCAPANumber 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --QATrackingApproved 
AND SUBSTRING(@Bitmap, 1, 0) & 64 <> 64 --QATrackingStatusID 
AND SUBSTRING(@Bitmap, 1, 0) & 128 <> 128 --QATrackingFormPoints 
AND SUBSTRING(@Bitmap, 2, 0) & 1 <> 1 --QATrackingFormComments 
AND SUBSTRING(@Bitmap, 2, 0) & 2 <> 2 --LastModified 
AND SUBSTRING(@Bitmap, 2, 0) & 4 <> 4 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 2, 0) & 8 <> 8 --AuditLogTypeID 
)


INSERT INTO dbo.QATrackingForm
(
 QATrackingFormID
,QAProcessStepID
,PersonID
,QATrackingEventDateTime
,QATrackingCAPANumber
,QATrackingApproved
,QATrackingStatusID
,QATrackingFormPoints
,QATrackingFormComments
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QAProcessStepID, 0) = 0 THEN -2 ELSE @QAProcessStepID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@PersonID, 0) = 0 THEN -2 ELSE @PersonID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@QATrackingEventDateTime, '') = '' THEN '1900-01-01'  ELSE @QATrackingEventDateTime END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@QATrackingCAPANumber, '') = '' THEN 'ILB'  ELSE @QATrackingCAPANumber END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@QATrackingApproved, 0) = 0 THEN -2 ELSE @QATrackingApproved END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 64 = 64 AND ISNULL(@QATrackingStatusID, 0) = 0 THEN -2 ELSE @QATrackingStatusID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 128 = 128 AND ISNULL(@QATrackingFormPoints, 0) = 0 THEN -2 ELSE @QATrackingFormPoints END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 1 = 1 AND ISNULL(@QATrackingFormComments, '') = '' THEN 'ILB'  ELSE @QATrackingFormComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 2 = 2 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 4 = 4 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 0) & 8 = 8 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QATrackingFormErrors.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QATrackingFormErrors'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATrackingFormErrors'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATrackingFormErrors
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATrackingFormErrors
(
 @QATrackingFormErrorsID int 
,@QATrackingFormID int 
,@QAErrorLogID int 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATrackingFormErrors
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QATrackingFormID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QAErrorLogID 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --AuditLogTypeID 
)


INSERT INTO dbo.QATrackingFormErrors
(
 QATrackingFormErrorsID
,QATrackingFormID
,QAErrorLogID
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QATrackingFormID, 0) = 0 THEN -2 ELSE @QATrackingFormID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QAErrorLogID, 0) = 0 THEN -2 ELSE @QAErrorLogID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QATrackingStatus.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QATrackingStatus'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATrackingStatus'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATrackingStatus
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATrackingStatus
(
 @QATrackingStatusID int 
,@QATrackingStatusDescription varchar(250)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATrackingStatus
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --QATrackingStatusDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --AuditLogTypeID 
)


INSERT INTO dbo.QATrackingStatus
(
 QATrackingStatusID
,QATrackingStatusDescription
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@QATrackingStatusDescription, '') = '' THEN 'ILB'  ELSE @QATrackingStatusDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\AudiTrail\stored procedures\spu_Audit_QATrackingType.sql'
GO
PRINT 'Sproc: dbo.spu_Audit_QATrackingType'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATrackingType'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATrackingType
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATrackingType
(
 @QATrackingTypeID int 
,@OrganizationID int 
,@QATrackingTypeDescription varchar(255)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATrackingType
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QATrackingTypeDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --AuditLogTypeID 
)


INSERT INTO dbo.QATrackingType
(
 QATrackingTypeID
,OrganizationID
,QATrackingTypeDescription
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QATrackingTypeDescription, '') = '' THEN 'ILB'  ELSE @QATrackingTypeDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO


GO
