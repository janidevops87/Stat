 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spd_Audit_QAErrorStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spd_Audit_QAErrorStatus]
	PRINT 'Dropping Procedure: spd_Audit_QAErrorStatus'
END
	PRINT 'Creating Procedure: spd_Audit_QAErrorStatus'
GO

CREATE PROCEDURE [dbo].[spd_Audit_QAErrorStatus]
(
	@QAErrorStatusID int
)
/******************************************************************************
**		File: spd_Audit_QAErrorStatus.sql 
**		Name: spd_Audit_QAErrorStatus
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