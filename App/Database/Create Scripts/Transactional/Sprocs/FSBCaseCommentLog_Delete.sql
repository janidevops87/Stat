SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseCommentLog_Delete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseCommentLog_Delete]
GO


Create Procedure [dbo].[FSBCaseCommentLog_Delete]
(
	@FSBCaseCommentLogId int
)
As
Begin

	Delete From 
		[dbo].[FSBCaseCommentLog]
	Where
		FSBCaseCommentLogId = @FSBCaseCommentLogId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

