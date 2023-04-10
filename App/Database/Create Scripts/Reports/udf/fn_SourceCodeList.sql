if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_SourceCodeList]') and xtype in (N'FN', N'IF', N'TF'))
begin
	print 'dropping function [dbo].[fn_SourceCodeList]'
	drop function [dbo].[fn_SourceCodeList]
end	
GO
print 'createing function [dbo].[fn_SourceCodeList]'
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE FUNCTION dbo.fn_SourceCodeList
(
	@ReportGroupID int = 0,
	@SourceCodeName varchar(10)
)
RETURNS 
	@SourceCodeList TABLE 
	(
		SourceCodeID int 
	)
AS
/******************************************************************************
**		File: 
**		Name: fn_SourceCodeList
**		Desc: creates a list of SourceCodes 
**
**		
**		Return values:
**		Returns a table variable of sourcecodeid
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		ReportGroupID
**		SourceCodeName
**
**		Called By: Sprocs requiring a list of sourcecodeids by reporgroupid and sourcecodename. These sprocs are primarily for reporting.
**		Auth: Bret Knoll
**		Date: 04/09/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      4/09/07		Bret Knoll				Create Function
*******************************************************************************/
BEGIN
INSERT INTO @SourceCodeList 
	SELECT DISTINCT 
		wrgsc.SourceCodeID
	FROM 
		WebReportGroupSourceCode wrgsc
	JOIN SourceCode sc ON sc.SourceCodeID = wrgsc.SourceCodeID	
	WHERE 
		WebReportGroupID = @ReportGroupID
	AND	(
			@SourceCodeName IS NULL
		OR	sc.SourceCodeName = @SourceCodeName
		);

	/* alternative sql statement or statements */ 
RETURN
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO




 