

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportYearDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportYearDropDown';
		DROP Procedure sps_ReportYearDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportYearDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportYearDropDown]
	
 AS 
 /******************************************************************************
**	File: sps_ReportYearDropDown.sql
**	Name: sps_ReportYearDropDown
**	Desc: Populates dropdown for report years dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/24/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/24/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

declare
@CurrentDate datetime = GetDate(),
@CurrentYear int,
@Seed int;

SELECT @CurrentYear = YEAR(@CurrentDate);
SELECT @Seed = @CurrentYear - 15;

DECLARE
@Year Table
(
	[value] int,
	[label] varchar(10)
)

WHILE (@Seed <= @CurrentYear)
BEGIN
	INSERT INTO @Year VALUES
	(@Seed, CAST(@Seed as nvarchar(10)));
	SET @Seed = @Seed + 1;
END

SELECT * from @Year
order by [value]
GO

GRANT EXEC ON sps_ReportYearDropDown TO PUBLIC;
GO
