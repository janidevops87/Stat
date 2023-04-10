

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spu_ReportFavorite')
	BEGIN
		PRINT 'Dropping Procedure spu_ReportFavorite';
		DROP Procedure spu_ReportFavorite;
	END
GO

PRINT 'Creating Procedure spu_ReportFavorite';
GO


CREATE PROCEDURE spu_ReportFavorite
	@WebPersonId int,
	@ReportID int = NULL,
	@SortReports varchar(4000) = NULL
AS

/******************************************************************************
**	File: spu_ReportFavorite.sql
**	Name: spu_ReportFavorite
**	Desc: Updates sort order or adds or deletes a favorite report for a user
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

IF (@ReportId IS NULL AND @SortReports IS NOT NULL)
	BEGIN
	DECLARE 
	@tempReportId NVARCHAR(100),
	@posReport INT,
	@counter INT;

	CREATE TABLE #temp (
		reportId varchar(100),
		SortOrder int
	)
	SET @counter=0;
	WHILE CHARINDEX(',', @SortReports) > 0
	BEGIN
	  SELECT @posReport  = CHARINDEX(',', @SortReports);
	  SELECT @tempReportId = SUBSTRING(@SortReports, 1, @posReport-1);

	  INSERT INTO #temp VALUES (@tempReportId, @counter);
	  SET @counter=@counter+1;

	  SELECT @SortReports = SUBSTRING(@SortReports, @posReport+1, LEN(@SortReports)-@posReport);
	END

	SET @counter=0;
	SELECT  TOP(1) @tempReportId=reportId FROM #temp ORDER BY SortOrder;

	WHILE (SELECT COUNT(1) FROM #temp) > 0
		BEGIN
			UPDATE dbo.ReportFavorite
			SET SortOrder=@counter, LastModified=GETUTCDATE()
			WHERE ReportID = @tempReportId AND WebPersonID = @WebPersonID;

			SET @counter=@counter+1;
			DELETE FROM #temp WHERE reportId=@tempReportId;
			SELECT  TOP(1) @tempReportId=reportId FROM #temp ORDER BY SortOrder;
		END
	drop table #temp;
	END

--New
IF (@ReportId IS NOT NULL AND @SortReports IS NULL)
	BEGIN
		IF (NOT EXISTS(SELECT 1 FROM dbo.ReportFavorite WHERE WebPersonID = @WebPersonId AND ReportId=@ReportId))
		BEGIN
			DECLARE @sortOrder int= (SELECT max(SortOrder)+1 FROM  dbo.ReportFavorite WHERE WebPersonID = @WebPersonId);
			INSERT INTO dbo.ReportFavorite (ReportID, WebPersonID,SortOrder, LastModified)
			VALUES (@ReportId, @WebPersonId, COALESCE(@sortOrder,1), GETUTCDATE());
		END
	END
GO


GRANT EXEC ON spu_ReportFavorite TO PUBLIC
GO
