SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseType_Update]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseType_Update]
GO


Create Procedure [dbo].[FSBCaseType_Update]
(
	@FSBCaseTypeId int, 
	@FSBCaseTypeName nvarchar(50), 
	@InsertedBy nvarchar(50), 
	@UpdatedBy nvarchar(50) 
)
As
Begin

	Update
		[dbo].[FSBCaseType]
	Set
		FSBCaseTypeName = @FSBCaseTypeName,
		InsertedBy = @InsertedBy,
		UpdatedBy = @UpdatedBy,
		DateUpdated = GetDate()
	Where
		FSBCaseTypeId = @FSBCaseTypeId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

