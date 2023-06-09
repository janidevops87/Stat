SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseCommentLog_Update]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseCommentLog_Update]
GO


Create Procedure [dbo].[FSBCaseCommentLog_Update]
(
	@FSBCaseCommentLogId int, 
	@Comment nvarchar(1000), 
	@FSBCaseId int, 
	@InsertedBy nvarchar(50), 
	@UpdatedBy nvarchar(50) 
)
As
Begin

	Update
		[dbo].[FSBCaseCommentLog]
	Set
		Comment = @Comment,
		FSBCaseId = @FSBCaseId,
		InsertedBy = @InsertedBy,
		UpdatedBy = @UpdatedBy,
		DateUpdated = GetDate()
	Where
		FSBCaseCommentLogId = @FSBCaseCommentLogId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

