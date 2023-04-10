  

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleGroupOrganizationSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure ScheduleGroupOrganizationSelectDataSet'
		DROP Procedure ScheduleGroupOrganizationSelectDataSet
	END
GO

PRINT 'Creating Procedure ScheduleGroupOrganizationSelectDataSet'
GO
CREATE Procedure ScheduleGroupOrganizationSelectDataSet
(
		@ScheduleGroupOrganizationID int = null output,
		@StatEmployeeID int = null					
)

AS

/******************************************************************************
**	File: ScheduleGroupOrganizationSelectDataSet.sql
**	Name: ScheduleGroupOrganizationSelectDataSet
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


	EXEC dbo.ScheduleGroupOrganizationSelect @ScheduleGroupOrganizationID = @ScheduleGroupOrganizationID

GO
	
GRANT EXEC ON ScheduleGroupOrganizationSelectDataSet TO PUBLIC
GO
