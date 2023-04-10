

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportRecent')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportRecent';
		DROP Procedure sps_ReportRecent;
	END
GO

PRINT 'Creating Procedure sps_ReportRecent';
GO


CREATE PROCEDURE sps_ReportRecent
	@WebPersonId int
AS

/******************************************************************************
**	File: sps_ReportRecent.sql
**	Name: sps_ReportRecent
**	Desc: Pulls recent reports for a user
**	Auth: Aykut Ucar
**	Date: 12/01/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/01/2020		Aykut Ucar					Initial Sproc Creation
**	01/21/2021		Pam Scheichenost			Make sure if permissions are taken away, they can't see the reports here
*******************************************************************************/
DELETE FROM [dbo].[ReportRecent] WHERE lastmodified < DATEADD(M, -3, GETUTCDATE());

SELECT DISTINCT TOP (10) rr.[ReportRecentID]
,rr.[ReportID]
,rr.[WebPersonID]
,rr.[LastModified]
FROM [dbo].[ReportRecent] rr
INNER JOIN [dbo].[Report] r ON r.ReportID = rr.ReportID
INNER JOIN UserRoles ur on rr.WebPersonID = ur.WebPersonID
INNER JOIN ReportRule repr on ur.RoleID = repr.RoleID AND repr.ReportID = rr.ReportID
INNER JOIN 
	(SELECT max(lastmodified) as lastModified, ReportId 
	FROM [dbo].[ReportRecent]  
	WHere WebPersonid=@WebPersonId
	Group by ReportID) r1 ON r1.ReportID=rr.ReportID and r1.lastModified=rr.LastModified
WHERE rr.WebPersonid=@WebPersonId
ORDER BY rr.LastModified desc
GO


GRANT EXEC ON sps_ReportRecent TO PUBLIC
GO
