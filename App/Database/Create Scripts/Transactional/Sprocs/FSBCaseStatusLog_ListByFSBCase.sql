SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseStatusLog_ListByFSBCase]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseStatusLog_ListByFSBCase]
GO


Create Procedure [dbo].[FSBCaseStatusLog_ListByFSBCase]
(
	@FSBCaseId int
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
		FSBCaseId = @FSBCaseId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

