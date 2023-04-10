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