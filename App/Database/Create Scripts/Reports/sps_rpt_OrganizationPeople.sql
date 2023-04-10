IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_OrganizationPeople')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_OrganizationPeople';
	DROP PROCEDURE sps_rpt_OrganizationPeople;
END

GO

PRINT 'Creating Procedure sps_rpt_OrganizationPeople';
GO

CREATE PROCEDURE sps_rpt_OrganizationPeople
(		
	@ReportGroupID 	INT,
	@OrganizationID	INT
)
AS  

/******************************************************************************
**		File: sps_rpt_OrganizationPeople.sql
**		Name: sps_rpt_OrganizationPeople
**		Desc: returns a list of people associated with a 
**
**              
**		Return values:
** 
**		Called by:   OrganizationPeople.rdl
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: Mike Berenson 
**		Date: 09/15/2020
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**    
*******************************************************************************/
BEGIN

	SELECT 
		o.OrganizationName AS Hospital,
		o.OrganizationAddress1 AS Address,
		o.OrganizationCity AS City,
		s.StateAbbrv AS State,
		o.OrganizationZipCode AS Zip,
		'(' + ph.PhoneAreaCode + ') ' + ph.PhonePrefix +  '-' + ph.PhoneNumber AS Phone,
		p.PersonID,
	    p.PersonLast,
		p.PersonFirst,
	    pt.PersonTypeName AS Title,
		p.Inactive AS Status
	FROM Person p
		JOIN PersonType pt ON p.PersonTypeID = pt.PersonTypeID
		JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = p.OrganizationID
		JOIN Organization o ON o.OrganizationID = p.OrganizationID
		JOIN [State] s ON s.StateID = o.StateID
		JOIN Phone ph ON ph.PhoneID = o.PhoneID
	WHERE 
		wrgo.WebReportGroupID = @ReportGroupID
		AND p.OrganizationID = @OrganizationID
 	ORDER BY 
		p.PersonLast, 
		p.PersonFirst;

END
GO

GRANT EXECUTE ON sps_rpt_OrganizationPeople TO PUBLIC;
GO