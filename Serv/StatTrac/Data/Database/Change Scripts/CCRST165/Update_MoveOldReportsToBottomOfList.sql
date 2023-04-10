/******************************************************************************
**	File: Update_MoveOldReportsToBottomOfList.sql
**	Name: Update_MoveOldReportsToBottomOfList
**	Desc: Move old reports to bottom of the list by appending title to z-old to front title or report name.
**	Auth: ccarroll	
**	Date: December 30 2011
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**  12/30/2011		ccarroll				initial
*******************************************************************************/


DECLARE @ZOldName AS nvarchar(10) = 'z-old '

IF (SELECT Count(*) FROM Report WHERE ReportDisplayName LIKE @ZOldName + '%') > 0
	BEGIN
		Print @ZOldName + 'Report names already exist: Re-name Aborted'
	END
ELSE
	BEGIN
		Print 'Rename reports to: ' + @ZOldName + '...'
		
		/* Shorten Report Length to 45 characters or less */
		UPDATE Report SET ReportDisplayName = '5.1-Recovered Donor Sum. (All Types - w/Reg)' WHERE ReportID = 105;
		UPDATE Report SET ReportDisplayName = 'CONTRACTS -Client Second. Screening Criteria' WHERE ReportID = 148;
		
		/* Update ReportNames */
		UPDATE Report SET ReportDisplayName = REPLACE(ReportDisplayName, ReportDisplayName, @ZOldName + ReportDisplayName)
		WHERE PATINDEX('/reports%', ReportVirtualURL) > 0  OR  PATINDEX('/form%', ReportVirtualURL) > 0

	END


