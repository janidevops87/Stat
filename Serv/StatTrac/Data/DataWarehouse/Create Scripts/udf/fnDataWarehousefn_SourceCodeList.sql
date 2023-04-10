
GO
/****** Object:  UserDefinedFunction [dbo].[fnDataWarehousefn_SourceCodeList]    Script Date: 12/15/2008 16:58:21 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[fnDataWarehousefn_SourceCodeList]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
begin
	PRINT 'DROP FUNCTION [dbo].[fnDataWarehousefn_SourceCodeList]'
	DROP FUNCTION [dbo].[fnDataWarehousefn_SourceCodeList]
end
	PRINT 'CREATE FUNCTION [dbo].[fnDataWarehousefn_SourceCodeList]'

GO

declare @sql nvarchar(4000)
set @sql =
'
CREATE FUNCTION [dbo].[fnDataWarehousefn_SourceCodeList]
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
**		Name: fnDataWarehousefn_SourceCodeList
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

	INSERT @SourceCodeList
	SELECT SourceCodeID FROM replacedbname.dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName)
	RETURN 
	END

'

if(db_name() like '%dev%')
begin

	set @sql = replace(@sql, 'replacedbname', '_ReferralDev1')
end
else
begin
	set @sql = replace(@sql, 'replacedbname', '_ReferralProdReport')
end

exec sp_executesql @sql