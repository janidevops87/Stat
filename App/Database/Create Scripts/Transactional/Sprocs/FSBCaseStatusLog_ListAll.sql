SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseStatusLog_ListAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseStatusLog_ListAll]
GO


Create Procedure [dbo].[FSBCaseStatusLog_ListAll]
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

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

