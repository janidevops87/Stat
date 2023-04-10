IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonListByOrganizationId')
	BEGIN
		PRINT 'Dropping Procedure GetPersonListByOrganizationId'
		DROP  Procedure  GetPersonListByOrganizationId
	END

GO

PRINT 'Creating Procedure GetPersonListByOrganizationId'
GO 

 
CREATE PROCEDURE GetPersonListByOrganizationId
	@OrganizationId	INT = NULL,
	@Inactive		INT = NULL
AS
/******************************************************************************
**		File: GetPersonListByOrganizationId.sql
**		Name: GetPersonListByOrganizationId
**		Desc: Returns a list of People by OrganizationID
**
** 
**		Called by:   CustomParamsMessageImport.ascx
**              
**
**		Auth: Bret Knoll
**		Date: 06/09/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/09/2008	Bret Knoll			initial
*******************************************************************************/

SELECT     
	PersonID, 
	ISNULL(PersonLast, '') + ', ' + ISNUll(PersonFirst, '') + ' ' + ISNULL(PersonMI, '') PersonName
FROM         
	Person
WHERE     
	(OrganizationID = ISNULL(@OrganizationId, 0)) 
AND 
	(Inactive = ISNULL(@Inactive, 0))
	
order by 2
GO
