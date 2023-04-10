SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_Delete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_Delete]
GO


Create Procedure [dbo].[FSBCase_Delete]
(
	@FSBCaseId int
)
As
Begin

	Delete From 
		[dbo].[FSBCase]
	Where
		FSBCaseId = @FSBCaseId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

