

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportApproachPersonDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportApproachPersonDropDown';
		DROP Procedure sps_ReportApproachPersonDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportApproachPersonDropDown';
GO


CREATE Procedure [dbo].[sps_ReportApproachPersonDropDown]
	@OrganizationId INT
AS

/******************************************************************************
**		File: sps_ReportApproachPersonDropDown.sql
**		Name: sps_ReportApproachPersonDropDown
**		Desc: Obtains a list of  Approachers
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
**		Date:		Author:					Description:
**		--------		--------			-------------------------------------------
**    12/15/2020		Pam Scheichenost	initial build

*******************************************************************************/

SELECT DISTINCT
	P.PersonID as [value], 
	LTRIM(P.PersonLast) + ', ' + LTRIM(P.PersonFirst)   as [label]
	
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
	@OrganizationId is null
	)
OR 
	OrganizationID = ISNULL(@OrganizationId, OrganizationID)
	)
	
ORDER BY
	LTRIM(P.PersonLast) + ', ' + LTRIM(P.PersonFirst)
GO

GRANT EXEC ON sps_ReportApproachPersonDropDown TO PUBLIC;
GO

