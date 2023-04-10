SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBOption_ListAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBOption_ListAll]
GO


Create Procedure [dbo].[FSBOption_ListAll]
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

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

