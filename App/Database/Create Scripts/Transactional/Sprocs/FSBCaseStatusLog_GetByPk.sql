SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseStatusLog_GetByPk]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseStatusLog_GetByPk]
GO


Create Procedure [dbo].[FSBCaseStatusLog_GetByPk]
(
	@FSBCaseId int,
	@FSBStatusId int,
	@StatusChangedDateTime datetime
)
As
Begin

	Select
		FSBCaseId,
		FSBStatusId,
		StatusChangedDateTime,
		InsertedBy,
		DateInserted,
		DateUpdated
	From
		[dbo].[FSBCaseStatusLog]
	Where
		FSBCaseId = @FSBCaseId		And FSBStatusId = @FSBStatusId		And StatusChangedDateTime = @StatusChangedDateTime

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

