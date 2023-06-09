SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseStatusLog_Delete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseStatusLog_Delete]
GO


Create Procedure [dbo].[FSBCaseStatusLog_Delete]
(
	@FSBCaseId int,
	@FSBStatusId int,
	@StatusChangedDateTime datetime
)
As
Begin

	Delete From 
		[dbo].[FSBCaseStatusLog]
	Where
		FSBCaseId = @FSBCaseId		And FSBStatusId = @FSBStatusId		And StatusChangedDateTime = @StatusChangedDateTime

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

