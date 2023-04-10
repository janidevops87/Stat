IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_RemoveOldAlphaPageEmailRecords')
	BEGIN
		PRINT 'Dropping Procedure sp_RemoveOldAlphaPageEmailRecords';
		DROP Procedure sp_RemoveOldAlphaPageEmailRecords;
	END
GO

PRINT 'Creating Procedure sp_RemoveOldAlphaPageEmailRecords';
GO
CREATE Procedure sp_RemoveOldAlphaPageEmailRecords
AS
/******************************************************************************
**	File: sp_RemoveOldAlphaPageEmailRecords.sql
**	Name: sp_RemoveOldAlphaPageEmailRecords
**	Desc: Removes old AlphaPage records
**	Auth: Bret Knoll
**	Date: 9/18/2019
**	Called By: SQL Job
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/18/2019		Bret Knoll		Initial Sproc Creation (9376)
*******************************************************************************/

	DELETE FROM AlphaPage 
	WHERE AlphaPageCreated < DateAdd(dd, -90, GetDate());

GO
GRANT EXEC ON sp_RemoveOldAlphaPageEmailRecords TO PUBLIC;
GO