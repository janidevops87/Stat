

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spu_ReportRecent')
	BEGIN
		PRINT 'Dropping Procedure spu_ReportRecent';
		DROP Procedure spu_ReportRecent;
	END
GO

PRINT 'Creating Procedure spu_ReportRecent';
GO


CREATE PROCEDURE spu_ReportRecent
	@WebPersonId int,
	@ReportID int
AS

/******************************************************************************
**	File: spu_ReportRecent.sql
**	Name: spu_ReportRecent
**	Desc: Updates recent reports for a user
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
INSERT INTO dbo.ReportRecent (WebPersonID, ReportID, LastModified) VALUES (@WebPersonID, @ReportID, GETUTCDATE())
GO


GRANT EXEC ON spu_ReportRecent TO PUBLIC
GO
