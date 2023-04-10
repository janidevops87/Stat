IF EXISTS (SELECT * FROM sysobjects WHERE type = 'IF' AND name = 'GetCallIdByOrganizationId')
	BEGIN
		PRINT 'Dropping Function GetCallIdByOrganizationId'
		DROP Function GetCallIdByOrganizationId
	END
GO

PRINT 'Creating Function GetCallIdByOrganizationId' 
GO 

CREATE FUNCTION dbo.GetCallIdByOrganizationId
(
	@OrganizationId int
)  
RETURNS TABLE
AS

/******************************************************************************
**	File: GetCallIdByOrganizationId.sql
**	Name: GetCallIdByOrganizationId
**	Desc: Get all the calls that this employee has access to 
**	Auth: Tanvir Ather
**	Date: 03/02/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	03/02/2009	Tanvir Ather	Initial Function Creation
*******************************************************************************/

RETURN  

select c.CallId, 0 AS IsAspLeaseOrganization
from Call c
where c.SourceCodeID in (Select SourceCodeID from dbo.GetSourceCodeByOrganizationId(@OrganizationId))
	and c.SourceCodeID not in (Select SourceCodeId from dbo.GetLeaseSourceCodeByOrganizationId(@OrganizationId))
union

select c.CallId, 1 AS IsAspLeaseOrganization
from Call c
where c.SourceCodeID in 
(
	Select SourceCodeID from dbo.GetLeaseSourceCodeByOrganizationId(@OrganizationId)
)
GO




