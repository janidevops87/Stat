IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonListByOrganizationIdWeb1')
	BEGIN
		PRINT 'Dropping Procedure GetPersonListByOrganizationIdWeb1'
		DROP  Procedure  GetPersonListByOrganizationIdWeb1
	END

GO

PRINT 'Creating Procedure GetPersonListByOrganizationIdWeb1'
GO 

 
CREATE PROCEDURE GetPersonListByOrganizationIdWeb1
	@OrganizationId	INT = NULL,
	@OrganizationId1	INT = NULL,
	@Inactive		INT = NULL
AS
/******************************************************************************
**		File: GetPersonListByOrganizationIdWeb1.sql
**		Name: GetPersonListByOrganizationIdWeb1
**		Desc: Returns a list of People by OrganizationID and a second one if they want, but in first name order like stattrac
**			  
** 
**		Called by:   QAMonitoring.ascx
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
**	   04/2010		bret			updating to include in release
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT     
	PersonID, 
	Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast  PersonName
FROM         
	Person
WHERE     
	(OrganizationID = ISNULL(@OrganizationId, 0) or OrganizationID = ISNULL(@OrganizationID1, 0)) 	
	 
AND 
	(Inactive = ISNULL(@Inactive, 0))
	
order by 2
GO
 