

IF OBJECT_ID (N'dbo.fn_SourceCodeListByOrganizationID') IS NOT NULL
   IF EXISTS (SELECT * FROM sys.objects WHERE type = 'V' AND name = 'vwOrganizationSourceCode')
	BEGIN
		PRINT 'DROP VIEW vwOrganizationSourceCode'
		DROP View vwOrganizationSourceCode
	END	
   PRINT 'DROP Function fn_SourceCodeListByOrganizationID' 		
   DROP FUNCTION dbo.fn_SourceCodeListByOrganizationID
GO
PRINT 'Create Function fn_SourceCodeListByOrganizationID'
GO 		
CREATE FUNCTION dbo.fn_SourceCodeListByOrganizationID 
(
	@OrganizationId INT
)
RETURNS NVARCHAR(MAX)
WITH EXECUTE AS CALLER, SCHEMABINDING
AS

/******************************************************************************
**	File: fn_SourceCodeListByOrganizationID.sql
**	Name: fn_SourceCodeListByOrganizationID

**	Auth: Bret Knoll

*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	07/11/2011	jth				Changed to drop view and then drop function, create function and then create view
*******************************************************************************/

BEGIN
    DECLARE @listStr VARCHAR(MAX)
	SELECT 
		@listStr = COALESCE(@listStr+',' ,'') + 
		CASE 
			WHEN COALESCE(SourceCode.Inactive, 0) = 0 
			THEN SourceCode.SourceCodeName ELSE '(' + SourceCode.SourceCodeName + ')'  
			END
	FROM dbo.SourceCode
	JOIN dbo.SourceCodeOrganization ON SourceCode.SourceCodeID = SourceCodeOrganization.SourceCodeID
	WHERE SourceCodeOrganization.OrganizationID = @OrganizationId

     RETURN(COALESCE(@listStr, ''))
END
Go
--now creating view in this script because function must be dropped and created in conjuction with this view
PRINT 'Creating view vwOrganizationSourceCode'

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW vwOrganizationSourceCode
WITH SCHEMABINDING
AS
/******************************************************************************
**	File: vwOrganizationSourceCode.sql
**	Name: vwOrganizationSourceCode
**	Desc: Selects multiple rows of OrganizationSourceCode Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 11/12/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/12/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SELECT 
		dbo.Organization.OrganizationID,
		dbo.fn_SourceCodeListByOrganizationID(Organization.OrganizationID) AS SourceCodeList
	FROM 
		dbo.Organization
	JOIN 
	(SELECT DISTINCT OrganizationID FROM  dbo.SourceCodeOrganization) SourceCodeOrganization  ON Organization.OrganizationID = SourceCodeOrganization.OrganizationID

GO

