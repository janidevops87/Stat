SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_Create]
GO


Create Procedure [dbo].[FSBCase_Create]
(
	@FSBCaseId int OUTPUT,
	@SourceCodeId int,
	@ReferralNumber nvarchar(50),
	@PatientName nvarchar(100),
	@FSCPersonId int,
	@FSBCaseTypeId int,
	@InsertedBy nvarchar(50),
	@UpdatedBy nvarchar(50)
)
As
Begin

	Insert Into [dbo].[FSBCase]
	( 
		SourceCodeId,
		ReferralNumber,
		PatientName,
		FSCPersonId,
		PreviousFSCPersonID,
		FSBCaseTypeId,
		InsertedBy,
		UpdatedBy,
		DateInserted
	 )
	Values
	( 
		@SourceCodeId,
		@ReferralNumber,
		@PatientName,
		@FSCPersonId,
		0,
		@FSBCaseTypeId,
		@InsertedBy,
		@UpdatedBy,
		GetDate()
	 );

	Set @FSBCaseId = Scope_Identity();

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

