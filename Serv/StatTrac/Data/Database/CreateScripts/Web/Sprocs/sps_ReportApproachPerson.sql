 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_ReportApproachPerson')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportApproachPerson'
		DROP  Procedure  sps_ReportApproachPerson
	END

GO

PRINT 'Creating Procedure sps_ReportApproachPerson'
GO
CREATE Procedure sps_ReportApproachPerson
	
AS

/******************************************************************************
**		File: sps_ReportApproachPerson.sql
**		Name: sps_ReportApproachPerson
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
**		--------		--------				-------------------------------------------
**    04/12/07			Bret Knoll				initial build
*******************************************************************************/

SELECT DISTINCT
	P.PersonID, LTRIM(P.PersonLast) + ', ' + LTRIM(P.PersonFirst)  'CoordinatorName'
FROM
	Person P
JOIN 
	SecondaryApproach  Approach ON Approach.SecondaryApproachedBy = p.PersonID
WHERE
	P.Inactive = 0

ORDER BY
	LTRIM(P.PersonLast) + ', ' + LTRIM(P.PersonFirst)  		
	

GO

GRANT EXEC ON sps_ReportApproachPerson TO PUBLIC

GO
