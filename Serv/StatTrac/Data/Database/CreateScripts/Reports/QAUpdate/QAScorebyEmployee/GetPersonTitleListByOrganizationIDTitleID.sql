 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetPersonTitleListByOrganizationId')
	BEGIN
		PRINT 'Dropping Procedure GetPersonTitleListByOrganizationId'
		DROP  Procedure  GetPersonTitleListByOrganizationId
	END

GO

PRINT 'Creating Procedure GetPersonTitleListByOrganizationId'
GO
 
CREATE PROCEDURE GetPersonTitleListByOrganizationId
	@OrganizationId	INT = NULL,
	@PersonTypeID int = null
AS
/******************************************************************************
**		File: GetPersonTitleListByOrganizationId.sql
**		Name: GetPersonTitleListByOrganizationId
**		Desc: Returns a list of People and Titles by OrganizationID and Title
**
** 
**		Called by:   
**              
**
**		Auth: Bret Knoll
**		Date: 06/09/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/2009		jth				initial
**		08/14/2009	ccarroll		changed JOIN to QATrackingForm (personID) was QAErrorLog (personID)
**		04/12/2018	mberenson		removed requirement that employee has a record in QAErrorLog or QATrackingForm (tfs bug 56754)
*******************************************************************************/
IF @PersonTypeID = 0 
BEGIN
	SET  @PersonTypeID = null
END

SELECT   distinct  
	p.PersonID,
	ISNULL(PersonLast, '') + ', ' + ISNUll(PersonFirst, '') + ' ' + ISNULL(PersonMI, '') PersonName,
	PersonType.PersonTypeName 'PersonTitle',
	p.PersonTypeID
	
FROM Person p 
JOIN PersonType ON PersonType.PersonTypeID = p.PersonTypeID

WHERE    
	(OrganizationID = ISNULL(@OrganizationId, 0)) 
	AND	(p.PersonTypeID = ISNULL(@PersonTypeID, p.PersonTypeID)) 
	AND p.Inactive =  0

ORDER BY 2
	
GO
