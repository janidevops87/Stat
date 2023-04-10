IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_OrganizationPeopleLog')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_OrganizationPeopleLog';
	DROP PROCEDURE sps_rpt_OrganizationPeopleLog;
END

GO

PRINT 'Creating Procedure sps_rpt_OrganizationPeopleLog';
GO

CREATE PROCEDURE sps_rpt_OrganizationPeopleLog
(		
	@ReportGroupID 	INT,
	@OrganizationID	INT,
	@PersonID INT
)
AS  

/******************************************************************************
**		File: sps_rpt_OrganizationPeopleLog.sql
**		Name: sps_rpt_OrganizationPeopleLog
**		Desc: returns a log records for a person 
**
**              
**		Return values:
** 
**		Called by:   OrganizationPeopleLog.rdl
**              

*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**		01/27/2021		Pam Scheichenost	Initial Creation
*******************************************************************************/
BEGIN

SELECT 
	p.PersonFirst, 
	p.PersonLast, 
	pt.PersonTypeName, 
	p.Inactive, 
	o.OrganizationName, 
	p.LastModified 
From Person p 
Join PersonType pt on p.PersonTypeId = pt.PersonTypeId 
Join Organization o on p.OrganizationId = o.OrganizationId 
Where p.PersonId = @PersonID 
And p.organizationid = @OrganizationID 
union  
SELECT 
	p.PersonFirst, 
	p.PersonLast, 
	pt.PersonTypeName, 
	p.Inactive, 
	o.OrganizationName, 
	p.LastModified 
From PersonLog p 
Join PersonType pt on p.PersonTypeId = pt.PersonTypeId 
Join Organization o on p.OrganizationId = o.OrganizationId 
Where p.PersonId = @PersonID 
And p.organizationid = @OrganizationID 
Order By p.LastModified desc

END
GO

GRANT EXECUTE ON sps_rpt_OrganizationPeople TO PUBLIC;
GO