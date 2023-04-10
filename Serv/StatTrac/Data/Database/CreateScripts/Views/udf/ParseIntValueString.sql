if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ParseIntValueString]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[ParseIntValueString]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE FUNCTION dbo.ParseIntValueString
	(
	@IntValuedString varchar(8000)
	)
RETURNS @IntValues TABLE (IntValue int) 
AS
/******************************************************************************
**		File: ParseIntValueString.sql
**		Name: dbo.ParseIntValueString
**		Desc: This udf will build a tabl of integers based on a comma seperated list of integers
**
**		Test: SELECT * FROM dbo.ParseIntValueString('1,2,4,3,80,90')
**			  SELECT * FROM dbo.ParseIntValueString('18,22,39,44,60,66,81,84,89,90,94,108')
**              
**		Return values: single column table of int
**		
**		Called by:   GetDonorTracUsersForInsert
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**		Auth: Bret Knoll
**		Date: 5/4/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**		5/4/2007	Bret Knoll		initial
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

		INSERT @IntValues
		SELECT 
			substring(
						',' + @IntValuedString + ',', --- expression
						Number + 1, --- start
						charindex(
									',', -- find what
									',' + @IntValuedString + ',', -- search what
									Number + 1 -- optional start location
								 ) - Number - 1 --- length
					 )
                 AS Value
          FROM   
				@Numbers -- variable table built above
          WHERE  
				Number <= len(',' + @IntValuedString + ',') - 1
          AND  
				substring(',' + @IntValuedString + ',', Number, 1) = ','

order by 1
	
	
		RETURN
	END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

 