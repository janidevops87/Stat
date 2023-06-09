SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseCommentLog_Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseCommentLog_Create]
GO


Create Procedure [dbo].[FSBCaseCommentLog_Create]
(
	@FSBCaseCommentLogId int OUTPUT,
	@Comment nvarchar(1000),
	@FSBCaseId int,
	@InsertedBy nvarchar(50),
	@UpdatedBy nvarchar(50)
)
As
Begin

	Insert Into [dbo].[FSBCaseCommentLog]
	( 
		Comment,
		FSBCaseId,
		InsertedBy,
		UpdatedBy,
		DateInserted
	 )
	Values
	( 
		@Comment,
		@FSBCaseId,
		@InsertedBy,
		@UpdatedBy,
		GetDate()
	 );

	Set @FSBCaseCommentLogId = Scope_Identity();

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

