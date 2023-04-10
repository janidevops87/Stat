

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ReferralSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure ReferralSelectDataSet'
		PRINT Getdate()
		DROP Procedure ReferralSelectDataSet
	END
GO

PRINT 'Creating Procedure ReferralSelectDataSet'
PRINT Getdate()
GO
CREATE Procedure ReferralSelectDataSet
(
		@CallID int = null
)
AS
/******************************************************************************
**	File: ReferralSelectDataSet.sql
**	Name: ReferralSelectDataSet
**	Desc: Selects multiple rows of Referral Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/7/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/7/2011		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	EXEC CallSelect @CallID = @CallID
	EXEC ReferralSelect  @CallID = @CallID
GO

GRANT EXEC ON ReferralSelectDataSet TO PUBLIC
GO
