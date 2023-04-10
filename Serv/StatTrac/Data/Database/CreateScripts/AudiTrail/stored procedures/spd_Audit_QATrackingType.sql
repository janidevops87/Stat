 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spd_Audit_QATrackingType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spd_Audit_QATrackingType]
	PRINT 'Dropping Procedure: spd_Audit_QATrackingType'
END
	PRINT 'Creating Procedure: spd_Audit_QATrackingType'
GO

CREATE PROCEDURE [dbo].[spd_Audit_QATrackingType]
(
	@QATrackingTypeID int
)
/******************************************************************************
**		File: spd_Audit_QATrackingType.sql 
**		Name: spd_Audit_QATrackingType
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
**		7/7/2009	bret	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

GO
