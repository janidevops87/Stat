

IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'SelectRegistryStatus')
	BEGIN
		PRINT 'Dropping Procedure SelectRegistryStatus';
		DROP Procedure SelectRegistryStatus;
	END
GO

PRINT 'Creating Procedure SelectRegistryStatus';
GO
CREATE Procedure SelectRegistryStatus
(
		@CallID int = null					
)
AS
/******************************************************************************
**	File: SelectRegistryStatus.sql
**	Name: SelectRegistryStatus
**	Desc: Selects multiple rows of RegistryStatus Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
**	10/14/2019		Mike Berenson		Removed IsNull function from where clause
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT
		RegistryStatus.ID,
		RegistryStatus.RegistryStatus,
		RegistryStatus.CallID,
		RegistryStatus.LastModified,
		RegistryStatus.LastStatEmployeeID,
		RegistryStatus.AuditLogTypeID
	FROM 
		dbo.RegistryStatus 
	WHERE 
		@CallID IS NULL OR RegistryStatus.CallID = @CallID;
GO

GRANT EXEC ON SelectRegistryStatus TO PUBLIC;
GO
