

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectNOK')
	BEGIN
		PRINT 'Dropping Procedure SelectNOK';
		PRINT GETDATE();
		DROP Procedure SelectNOK;
	END
GO

PRINT 'Creating Procedure SelectNOK';
PRINT GETDATE();
GO
CREATE Procedure SelectNOK
(
		@NOKID int = null 
)
AS
/******************************************************************************
**	File: SelectNOK.sql
**	Name: SelectNOK
**	Desc: Selects multiple rows of NOK Based on Id  fields 
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
		NOK.NOKID,
		NOK.NOKFirstName,
		NOK.NOKLastName,
		NOK.NOKPhone,
		NOK.NOKAddress,
		NOK.NOKCity,
		NOK.NOKStateID,
		NOK.NOKZip,
		NOK.NOKApproachRelation,
		NOK.LastModified,
		NOK.LastStatEmployeeID,
		NOK.AuditLogTypeID
	FROM 
		dbo.NOK 
	WHERE 
		@NOKID IS NULL OR NOK.NOKID = @NOKID;

GO

GRANT EXEC ON SelectNOK TO PUBLIC;
GO
