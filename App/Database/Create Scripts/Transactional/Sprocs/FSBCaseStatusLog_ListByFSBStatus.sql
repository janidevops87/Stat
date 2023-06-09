SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseStatusLog_ListByFSBStatus]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseStatusLog_ListByFSBStatus]
GO


Create Procedure [dbo].[FSBCaseStatusLog_ListByFSBStatus]
(
	@FSBStatusId int
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
		FSBStatusId = @FSBStatusId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

