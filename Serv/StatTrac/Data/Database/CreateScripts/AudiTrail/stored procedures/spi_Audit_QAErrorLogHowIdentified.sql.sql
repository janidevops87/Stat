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