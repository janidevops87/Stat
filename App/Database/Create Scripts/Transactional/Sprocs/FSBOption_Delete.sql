SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBOption_Delete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBOption_Delete]
GO


Create Procedure [dbo].[FSBOption_Delete]
(
	@OptionName nvarchar(50)
)
As
Begin

	Delete From 
		[dbo].[FSBOption]
	Where
		OptionName = @OptionName

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

