SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBOption_ListByOptionName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBOption_ListByOptionName]
GO


Create Procedure [dbo].[FSBOption_ListByOptionName]
(
	@filter VarChar(100)
)
As
Begin

	Select
		OptionName,
		OptionValue,
		InsertedBy,
		UpdatedBy,
		DateInserted,
		DateUpdated
	From
		[dbo].[FSBOption]
	Where
		@filter Is Null Or Lower( OptionName ) Like '%' + Lower( @filter) + '%';

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

