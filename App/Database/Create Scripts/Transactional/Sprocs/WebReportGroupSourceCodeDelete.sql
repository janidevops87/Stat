IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'WebReportGroupSourceCodeDelete')
	BEGIN
		PRINT 'Dropping Procedure WebReportGroupSourceCodeDelete'
		DROP Procedure WebReportGroupSourceCodeDelete
	END
GO

PRINT 'Creating Procedure WebReportGroupSourceCodeDelete'
GO
CREATE Procedure WebReportGroupSourceCodeDelete
(
	@WebReportGroupID INT = NULL, 
	@SourceCodeID  INT = NULL	 	
)
AS
/******************************************************************************
**	File: WebReportGroupSourceCodeDelete.sql
**	Name: WebReportGroupSourceCodeDelete
**	Desc: Updates WebReportGroupSourceCode  
**	Auth: Ed Hawkes
**	Date: 6/29/2016
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	6/29/2016		Ed Hawkes				Initial Sproc Creation 
*******************************************************************************/

DELETE FROM WebReportGroupSourceCode 
WHERE WebReportGroupSourceCode.WebReportGroupID = @WebReportGroupID
AND WebReportGroupSourceCode.SourceCodeId = @SourceCodeID 	

GO

GRANT EXEC ON WebReportGroupSourceCodeDelete TO PUBLIC
GO
