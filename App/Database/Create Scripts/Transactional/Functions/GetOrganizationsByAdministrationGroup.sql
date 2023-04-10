 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'TF' AND name = 'GetOrganizationsByAdministrationGroup')
	BEGIN
		PRINT 'Dropping Function GetOrganizationsByAdministrationGroup'
		DROP Function GetOrganizationsByAdministrationGroup
	END
GO

PRINT 'Creating Function GetOrganizationsByAdministrationGroup' 
GO 

CREATE FUNCTION dbo.GetOrganizationsByAdministrationGroup 
(
	@AdministrationGroupFieldValue nvarchar(125)= NULL
)  
RETURNS @OrganizationIDTable TABLE
	(
		OrganizationID int
	) 		
AS
/******************************************************************************
**	File: GetOrganizationsByAdministrationGroup.sql
**	Name: GetOrganizationsByAdministrationGroup
**	Desc: Get the OrganizationId where the Organization is associated to the AdministrationGroup
**	Auth: Bret Knoll
**	Date: 06/24/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	06/24/2009	Bret Knoll		Initial Function Creation
**	7/14/2010	Bret Knoll		Resave for Release
*******************************************************************************/
BEGIN
	--- These variables are used to determine administration group the searh
	DECLARE @stringLen int = LEN(@AdministrationGroupFieldValue)
	DECLARE @currentPosition int = LEN(@AdministrationGroupFieldValue)
	DECLARE @administrationGroupString nvarchar(50)

	--- The @AdministrationGroupFieldValue by the storedprocedure AdministrationGroupListSelect
	--- The procedure places a string (string) at end of the name of the Admin Group "(ServiceLevel)"
	--- This While statement starts at the end of the string and moves back until the '(' is found
	WHILE ((SUBSTRING(@AdministrationGroupFieldValue, @currentPosition, 1) <> '(') AND (@currentPosition <> 0 ))
	BEGIN
		SET @currentPosition  -= 1	
	END
	-- '(' is not found in the @AdministrationGroupFieldValue string then the length of the admin group text is set to 0
	-- , causing the @administrationGroupString to be empty and a empty table to be returned. 
	IF( @currentPosition = 0)
		SET @stringLen = 0
	ELSE
		SET @stringLen = @stringLen - (@currentPosition - 1)

	SET @administrationGroupString = SUBSTRING(@AdministrationGroupFieldValue, @currentPosition, @stringLen)
	SET @AdministrationGroupFieldValue = RTRIM(LTRIM(REPLACE(@AdministrationGroupFieldValue, @administrationGroupString, '')))

	IF (@administrationGroupString = '(Alert)')
	BEGIN
		INSERT @OrganizationIDTable
		SELECT OrganizationId FROM GetOrganizationsByAlertGroup(@AdministrationGroupFieldValue)
	END 
	IF (@administrationGroupString = '(Criteria)')
	BEGIN
		INSERT @OrganizationIDTable
		SELECT OrganizationId FROM GetOrganizationsByCriteriaGroup(@AdministrationGroupFieldValue)
		RETURN
	END 
	IF (@administrationGroupString = '(Screen Configuration)')
	BEGIN
		INSERT @OrganizationIDTable
		SELECT OrganizationId FROM GetOrganizationsByServiceLevelGroup(@AdministrationGroupFieldValue)
	END 
	IF (@administrationGroupString = '(Schedule)')
	BEGIN
		INSERT @OrganizationIDTable
		SELECT OrganizationId FROM GetOrganizationsByScheduleGroup(@AdministrationGroupFieldValue)
	END 
	IF (@administrationGroupString = '')
	BEGIN
		INSERT @OrganizationIDTable
		SELECT 0 AS OrganizationID
	END
	
	RETURN
END	

GO