

IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'SelectRegistryStatusType')
	BEGIN
		PRINT 'Dropping Procedure SelectRegistryStatusType';
		DROP Procedure SelectRegistryStatusType;
	END
GO

PRINT 'Creating Procedure SelectRegistryStatusType';
GO
CREATE Procedure SelectRegistryStatusType
(
		@ID int = null output					
)
AS
/******************************************************************************
**	File: SelectRegistryStatusType.sql
**	Name: SelectRegistryStatusType
**	Desc: Selects multiple rows of RegistryStatusType Based on Id  fields 
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
		RegistryStatusType.ID,
		RegistryStatusType.RegistryType
	FROM 
		dbo.RegistryStatusType 
	WHERE 
		@ID IS NULL OR RegistryStatusType.ID = @ID;
	
GO

GRANT EXEC ON SelectRegistryStatusType TO PUBLIC;
GO
