 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevel30OrganizationSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevel30OrganizationSelectDataSet'
		DROP Procedure ServiceLevel30OrganizationSelectDataSet
	END
GO

PRINT 'Creating Procedure ServiceLevel30OrganizationSelectDataSet'
GO
CREATE Procedure ServiceLevel30OrganizationSelectDataSet
(
		@ServiceLevelOrganizationID int = null output,
		@StatEmployeeID int = null					
)

AS

/******************************************************************************
**	File: ServiceLevel30OrganizationSelectDataSet.sql
**	Name: ServiceLevel30OrganizationSelectDataSet
**	Desc: Selects Data Set for Administration SourceCode 
**	Auth: ccarroll
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/16/2011		ccarroll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	EXEC dbo.ServiceLevel30OrganizationSelect @ServiceLevelOrganizationID = @ServiceLevelOrganizationID

GO
	
GRANT EXEC ON ServiceLevel30OrganizationSelectDataSet TO PUBLIC
GO
