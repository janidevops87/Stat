

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spd_ReportFavorite')
	BEGIN
		PRINT 'Dropping Procedure spd_ReportFavorite';
		DROP Procedure spd_ReportFavorite;
	END
GO

PRINT 'Creating Procedure spd_ReportFavorite';
GO


CREATE PROCEDURE spd_ReportFavorite
	@WebPersonID int,
	@ReportID int
AS

/******************************************************************************
**	File: spd_ReportFavorite.sql
**	Name: spd_ReportFavorite
**	Desc: Deletes a favorite report for a user
**	Auth: Aykut Ucar
**	Date: 12/01/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/01/2020		Aykut Ucar			Initial Sproc Creation
*******************************************************************************/

DELETE FROM dbo.ReportFavorite WHERE WebPersonID = @WebPersonID AND ReportID = @ReportID;
GO

GRANT EXEC ON spd_ReportFavorite TO PUBLIC
GO
