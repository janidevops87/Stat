IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_FSConversionRateApproachPerson')
	BEGIN
		PRINT 'Dropping Procedure sps_FSConversionRateApproachPerson'
		DROP  Procedure  sps_FSConversionRateApproachPerson
	END

GO

PRINT 'Creating Procedure sps_FSConversionRateApproachPerson'
GO
CREATE Procedure sps_FSConversionRateApproachPerson
	@organizationId INT = NULL,
	@personTypeId	INT = NULL	
AS

/******************************************************************************
**		File: sps_FSConversionRateApproachPerson.sql
**		Name: sps_FSConversionRateApproachPerson
**		Desc: Obtains a list of Statline and MTF Approachers
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 4/12/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**    04/12/07			Bret Knoll		initial build
**		07/09/08		Bret Knoll		Add @organizationID param
*******************************************************************************/

SELECT DISTINCT
	P.PersonID, 
	LTRIM(P.PersonLast) + ', ' + LTRIM(P.PersonFirst)  'PersonName',
	PersonType.PersonTypeName 'PersonTitle',
	0 'Checked'
	
FROM
	Person P
JOIN 
	SecondaryApproach  Approach ON Approach.SecondaryApproachedBy = p.PersonID
JOIN 
	PersonType ON PersonType.PersonTypeID = P.PersonTypeID
WHERE 
	(
	( OrganizationID IN (194, 14019, 3891)--Statline,MTF and MTF(ASP)users
	  and
	@organizationId is null
	)
OR 
	OrganizationID = ISNULL(@organizationId, OrganizationID)
	)
AND
	P.PersonTypeID = ISNUll(@personTypeId, P.PersonTypeID)
	
ORDER BY
	LTRIM(P.PersonLast) + ', ' + LTRIM(P.PersonFirst)

GO

GRANT EXEC ON sps_FSConversionRateApproachPerson TO PUBLIC

GO
