 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spd_Audit_QAErrorLogHowIdentified]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spd_Audit_QAErrorLogHowIdentified]
	PRINT 'Dropping Procedure: spd_Audit_QAErrorLogHowIdentified'
END
	PRINT 'Creating Procedure: spd_Audit_QAErrorLogHowIdentified'
GO

CREATE PROCEDURE [dbo].[spd_Audit_QAErrorLogHowIdentified]
(
	@QAErrorLogHowIdentifiedID int
)
/******************************************************************************
**		File: spd_Audit_QAErrorLogHowIdentified.sql 
**		Name: spd_Audit_QAErrorLogHowIdentified
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
