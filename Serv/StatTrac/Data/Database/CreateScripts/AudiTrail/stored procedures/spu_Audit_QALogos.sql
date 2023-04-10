 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spu_Audit_QALogos]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spu_Audit_QALogos]
	PRINT 'Dropping Procedure: spu_Audit_QALogos'
END
	PRINT 'Creating Procedure: spu_Audit_QALogos'
GO

CREATE PROCEDURE [dbo].[spu_Audit_QALogos]
(
	@LogoId int,
	@LogoName char(100),
	@OrganizationID int,
	@TrackingTypeID int,
	@ImageName varchar(50) = NULL,
	@pkc1 int,
	@bitmap binary(4)

)
/******************************************************************************
**		File: spu_Audit_QALogos.sql
**		Name: spu_Audit_QALogos
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