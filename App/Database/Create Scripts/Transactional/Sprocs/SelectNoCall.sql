

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectNoCall')
	BEGIN
		PRINT 'Dropping Procedure SelectNoCall'
		PRINT GETDATE()
		DROP Procedure SelectNoCall
	END
GO

PRINT 'Creating Procedure SelectNoCall'
PRINT GETDATE()
GO
CREATE Procedure SelectNoCall
(
		@CallID int = null
)
AS
/******************************************************************************
**	File: SelectNoCall.sql
**	Name: SelectNoCall
**	Desc: Selects multiple rows of NoCall Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		NoCall.NoCallID,
		NoCall.CallID,
		NoCall.NoCallTypeID,
		NoCall.NoCallDescription,
		NoCall.LastModified,
		NoCall.UpdatedFlag
	FROM 
		dbo.NoCall 
	WHERE 
		NoCall.CallID = ISNULL(@CallID, NoCall.CallID)

GO

GRANT EXEC ON SelectNoCall TO PUBLIC
GO
