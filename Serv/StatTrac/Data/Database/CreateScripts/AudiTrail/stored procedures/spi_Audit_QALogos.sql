 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QALogos]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QALogos]
			PRINT 'Dropping Procedure: spi_Audit_QALogos'
	END

PRINT 'Creating Procedure: spi_Audit_QALogos'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QALogos]
(
	@LogoId int = NULL OUTPUT,
	@LogoName char(100),
	@OrganizationID int,
	@TrackingTypeID int,
	@ImageName varchar(50) = NULL
)
/******************************************************************************
**		File: spi_Audit_QALogos.sql 
**		Name: spi_Audit_QALogos
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/9/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/9/2009	bret	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QALogos]
	(
		[LogoId],
		[LogoName],
		[OrganizationID],
		[TrackingTypeID],
		[ImageName]
	)
	VALUES
	(
		@LogoId,
		@LogoName,
		@OrganizationID,
		@TrackingTypeID,
		@ImageName
	)
	
GO

