

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectNoCallType')
	BEGIN
		PRINT 'Dropping Procedure SelectNoCallType'
		PRINT GETDATE()
		DROP Procedure SelectNoCallType
	END
GO

PRINT 'Creating Procedure SelectNoCallType'
PRINT GETDATE()
GO
CREATE Procedure SelectNoCallType
(
		@NoCallTypeID int = null output					
)
AS
/******************************************************************************
**	File: SelectNoCallType.sql
**	Name: SelectNoCallType
**	Desc: Selects multiple rows of NoCallType Based on Id  fields 
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
		NoCallType.NoCallTypeID,
		NoCallType.NoCallTypeName,
		NoCallType.Verified,
		NoCallType.Inactive,
		NoCallType.LastModified,
		NoCallType.UpdatedFlag
	FROM 
		dbo.NoCallType 

	WHERE 
		NoCallType.NoCallTypeID = ISNULL(@NoCallTypeID, NoCallType.NoCallTypeID)				

GO

GRANT EXEC ON SelectNoCallType TO PUBLIC
GO
