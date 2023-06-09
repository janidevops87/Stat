SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBOption_GetByPk]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBOption_GetByPk]
GO


Create Procedure [dbo].[FSBOption_GetByPk]
(
	@OptionName nvarchar(50)
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
		OptionName = @OptionName

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

