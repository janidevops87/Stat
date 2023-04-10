  

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ScheduleGroupOrganizationSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure ScheduleGroupOrganizationSearchSelect'
		DROP Procedure ScheduleGroupOrganizationSearchSelect
	END
GO

PRINT 'Creating Procedure ScheduleGroupOrganizationSearchSelect'
GO
CREATE Procedure ScheduleGroupOrganizationSearchSelect
(
		@OrganizationID int,
		@SourceCodeID Int = Null
)
AS
/******************************************************************************
**	File: ScheduleGroupOrganizationSearchSelect.sql
**	Name: ScheduleGroupOrganizationSearchSelect
**	Desc: Selects multiple rows of ScheduleGroupOrganization Based on Id  fields 
**	Auth: ccarroll
**	Date: 05/16/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	05/16/2011		ccarroll				Initial Sproc Creation
**  06/14/2011		ccarroll				Added JOIN and WHERE for SourceCodeID
**											The Schedule Group Organization must be from a list of
**											already selected sourcecodes  
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	SELECT DISTINCT ScheduleGroupOrganization.ScheduleGroupID
	FROM ScheduleGroupOrganization 
	JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
	WHERE ScheduleGroupOrganization.OrganizationID = @OrganizationID 
	AND ScheduleGroupSourceCode.SourceCodeID = @SourceCodeID

	


	
GO

GRANT EXEC ON ScheduleGroupOrganizationSearchSelect TO PUBLIC
GO
