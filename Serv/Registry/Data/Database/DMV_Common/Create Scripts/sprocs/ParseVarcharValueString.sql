IF EXISTS (SELECT * FROM sysobjects WHERE type = 'TF' AND name = 'ParseVarcharValueString')
	BEGIN
		PRINT 'Dropping Function dbo.ParseVarcharValueString'
		DROP  Function  dbo.ParseVarcharValueString
	END

GO

PRINT 'Creating Function dbo.ParseVarcharValueString'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE Function dbo.ParseVarcharValueString
	(
	@InputString varchar(8000)
	)
RETURNS @StringValues TABLE (StringValue Varchar(100)) 
AS
/******************************************************************************
**		File: ParseVarcharValueString.sql
**		Name: dbo.ParseVarcharValueString
**		Desc: This udf will build a table of Strings based on a comma seperated list
**
**		Return values: single column table of Strings
**		
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**		Auth: Christopher Carroll
**		Date: 04/14/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**		04/14/2008	Christopher	Carroll	initial
*******************************************************************************/

	BEGIN
		-- build a table to help with the parse
		declare @Numbers table
			(Number int identity(1,1),
			name varchar(1))
		declare @maxvalue int
		select  @maxvalue  = 0
		while @maxvalue < 200
		begin
			insert @Numbers (name)
			select ''

			select @maxvalue = scope_identity()
		end

		INSERT @StringValues
		SELECT 
			substring(
						',' + @InputString + ',', --- expression
						Number + 1, --- start
						charindex(
									',', -- find what
									',' + @InputString + ',', -- search what
									Number + 1 -- optional start location
								 ) - Number - 1 --- length
					 )
                 AS Value
          FROM   
				@Numbers -- variable table built above
          WHERE  
				Number <= len(',' + @InputString + ',') - 1
          AND  
				substring(',' + @InputString + ',', Number, 1) = ','

order by 1
	
	
		RETURN
	END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

