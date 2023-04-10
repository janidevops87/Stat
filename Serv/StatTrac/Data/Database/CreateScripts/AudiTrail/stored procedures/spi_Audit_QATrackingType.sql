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
