IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonListByOrganizationIdWeb')
	BEGIN
		PRINT 'Dropping Procedure GetPersonListByOrganizationIdWeb'
		DROP  Procedure  GetPersonListByOrganizationIdWeb
	END

GO

PRINT 'Creating Procedure GetPersonListByOrganizationIdWeb'
GO 

 
CREATE PROCEDURE GetPersonListByOrganizationIdWeb
	@OrganizationId	INT = NULL,
	@Inactive		INT = NULL
AS
/******************************************************************************
**		File: GetPersonListByOrganizationIdWeb.sql
**		Name: GetPersonListByOrganizationIdWeb
**		Desc: Returns a list of People by OrganizationID, but in first name order like stattrac
**
** 
**		Called by:   EventLogUpdate.ascx
**              
**
**		Auth: jth
**		Date: 10/30/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		10.08	    jth					initial
*******************************************************************************/

SELECT     
	PersonID, 
	Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast  PersonName
FROM         
	Person
WHERE     
	(OrganizationID = ISNULL(@OrganizationId, 0)) 
AND 
	(Inactive = ISNULL(@Inactive, 0))
	
order by 2
GO
