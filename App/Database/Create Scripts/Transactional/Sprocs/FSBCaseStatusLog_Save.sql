SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseStatusLog_Save]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseStatusLog_Save]
GO


Create Procedure [dbo].[FSBCaseStatusLog_Save]
(
	@FSBCaseId int,
	@FSBStatusId int,
	@StatusChangedDateTime datetime,
	@InsertedBy nvarchar(50)
)
As
Begin

	If Exists
	(
		Select * From [dbo].[FSBCaseStatusLog]
		Where
			FSBCaseId = @FSBCaseId			 And FSBStatusId = @FSBStatusId			 And StatusChangedDateTime = @StatusChangedDateTime
	)
	Begin

		Update
			[dbo].[FSBCaseStatusLog]
		Set
			InsertedBy = @InsertedBy,
			DateUpdated = GetDate()
		Where
			FSBCaseId = @FSBCaseId			And FSBStatusId = @FSBStatusId			And StatusChangedDateTime = @StatusChangedDateTime

	End
	Else
	Begin
	
		Insert Into [dbo].[FSBCaseStatusLog]
		( 
			FSBCaseId,
			FSBStatusId,
			StatusChangedDateTime,
			InsertedBy,
			DateInserted
		 )
		Values
		( 
			@FSBCaseId,
			@FSBStatusId,
			@StatusChangedDateTime,
			@InsertedBy,
			GetDate()
		 );
	
	End

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

