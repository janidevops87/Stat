SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_Update]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_Update]
GO


Create Procedure [dbo].[FSBCase_Update]
(
	@FSBCaseId int, 
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

	Update
		[dbo].[FSBCase]
	Set
		SourceCodeId = @SourceCodeId,
		ReferralNumber = @ReferralNumber,
		PatientName = @PatientName,
		FSCPersonId = @FSCPersonId,
		PreviousFSCPersonID = FSCPersonId,
		FSBCaseTypeId = @FSBCaseTypeId,
		InsertedBy = @InsertedBy,
		UpdatedBy = @UpdatedBy,
		DateUpdated = GetDate()
	Where
		FSBCaseId = @FSBCaseId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

