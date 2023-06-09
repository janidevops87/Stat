SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseType_GetByFSBCaseTypeId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseType_GetByFSBCaseTypeId]
GO


Create Procedure [dbo].[FSBCaseType_GetByFSBCaseTypeId]
(
	@FSBCaseTypeId int
)
As
Begin

	Select
		FSBCaseTypeId,
		FSBCaseTypeName,
		InsertedBy,
		UpdatedBy,
		DateInserted,
		DateUpdated
	From
		[dbo].[FSBCaseType]
	Where
		FSBCaseTypeId = @FSBCaseTypeId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

