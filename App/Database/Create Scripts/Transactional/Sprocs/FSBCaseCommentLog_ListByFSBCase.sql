SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseCommentLog_ListByFSBCase]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseCommentLog_ListByFSBCase]
GO


Create Procedure [dbo].[FSBCaseCommentLog_ListByFSBCase]
(
	@FSBCaseId int
)
As
Begin

	Select
		FSBCaseCommentLogId,
		Comment,
		FSBCaseId,
		InsertedBy,
		UpdatedBy,
		DateInserted,
		DateUpdated
	From
		[dbo].[FSBCaseCommentLog]
	Where
		FSBCaseId = @FSBCaseId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

