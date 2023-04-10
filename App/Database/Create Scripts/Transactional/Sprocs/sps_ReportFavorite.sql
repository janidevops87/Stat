

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportFavorite')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportFavorite';
		DROP Procedure sps_ReportFavorite;
	END
GO

PRINT 'Creating Procedure sps_ReportFavorite';
GO


CREATE PROCEDURE sps_ReportFavorite
	@WebPersonId int
AS

/******************************************************************************
**	File: sps_ReportFavorite.sql
**	Name: sps_ReportFavorite
**	Desc: Pulls favorite reports for a user
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
SELECT  DISTINCT
		f.ReportFavoriteID,
		f.ReportID,
		f.WebPersonID,
		f.SortOrder,
		f.LastModified
FROM dbo.ReportFavorite f
INNER JOIN UserRoles ur on f.WebPersonID = ur.WebPersonID
INNER JOIN ReportRule rr on ur.RoleID = rr.RoleID AND f.ReportID = rr.ReportID
INNER JOIN [dbo].[Report] r ON r.ReportID = f.ReportID
WHERE f.WebPersonID = @WebPersonId 
ORDER BY f.SortOrder

GO

GRANT EXEC ON sps_ReportFavorite TO PUBLIC
GO
