IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'AdministrationGroupListSelect')
	BEGIN
		PRINT 'Dropping Procedure AdministrationGroupListSelect'
		DROP Procedure AdministrationGroupListSelect
	END
GO

CREATE PROCEDURE [dbo].[AdministrationGroupListSelect]
(
	@StatEmployeeUserId int
)
/******************************************************************************
**		File: AdministrationGroupListSelect.sql
**		Name: AdministrationGroupListSelect
**		Desc: Used in drop OrganizationSearch
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		6/19/2009	bret	initial
**		07/12/2010	ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/
AS

/*
**	WARNING IF THIS SPROC IS MODIFIED REVIEW THE GetOrganizationsByAdministrationGroup FUNCTIONS
**
*/

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	DECLARE @organizationId int
	SELECT @organizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeUserId)	
	
	-- Administration Groups
	--1 AlertOrganization
	--2 CriteriaOrganization
	--3 RotationOrganization -- not including this gorup
	--4	ServieLevelOrganization 
	--5 ScheduleGroupOrganization
	--6 SourceCodeOrganization
	
	-- working status is used to only grab work status
	DECLARE @workingStatus int
	SELECT  @workingStatus = HistoryStatusId 
	FROM         HistoryStatus
	WHERE     (HistoryStatusName = 'Working')
	
	--1 Alert
	DECLARE @listControl TABLE
	(
		ListId int IDENTITY(1, 1),
		FieldValue nvarchar(150)
	)
	
	INSERT @listControl
	
	SELECT DISTINCT Alert.AlertGroupName + ' (Alert)' AS FieldValue -- , Alert.AlertID AS AdministrationGroupItemID 
	FROM       Alert
	WHERE
	( 
		PATINDEX('%unused%', AlertGroupName) < 1 
		and
		PATINDEX('%not used%', AlertGroupName) < 1 
	)
	--2 Criteria
	UNION SELECT DISTINCT Criteria.CriteriaGroupName + ' (Criteria)' AS FieldValue --, Criteria.CriteriaID AS AdministrationGroupItemID
	FROM         Criteria
	WHERE     (Criteria.CriteriaStatus = @workingStatus)
	AND
	( 
	PATINDEX('%unused%', CriteriaGroupName) < 1 
	and
	PATINDEX('%not used%', CriteriaGroupName) < 1 
	)
	--3 skipping RotationOrganization

	--4 ServiceLevel
	UNION SELECT DISTINCT ServiceLevelGroupName + ' (Screen Configuration)' AS FieldValue --, ServiceLevelID AS AdministrationGroupItemID
	FROM         ServiceLevel
	WHERE     (ServiceLevelStatus = @workingStatus)
	AND 
		( 
		PATINDEX('%unused%', lower(ServiceLevelGroupName)) < 1 
		and
		PATINDEX('%not used%', lower(ServiceLevelGroupName)) < 1 
		)


	--5 ScheduleGroup
	UNION SELECT DISTINCT RTRIM(LTRIM(ScheduleGroup.ScheduleGroupName)) + ' (Schedule)' AS FieldValue --, ScheduleGroup.ScheduleGroupID AS AdministrationGroupItemID
	FROM         ScheduleGroup
	WHERE
		( 
		PATINDEX('%unused%', ScheduleGroupName) < 1 
		and
		PATINDEX('%not used%', ScheduleGroupName) < 1 
		)
	AND 
		ScheduleGroup.Inactive = 0	
	--6 skipping SourceCode (sourcecode is included in its onwn list. 
	
	
	SELECT ListId, FieldValue FROM @listControl
	ORDER BY 2 -- this is the group name

	RETURN @@Error
GO
