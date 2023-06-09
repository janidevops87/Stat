SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseType_ListByFSBCaseTypeName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseType_ListByFSBCaseTypeName]
GO


Create Procedure [dbo].[FSBCaseType_ListByFSBCaseTypeName]
(
	@filter VarChar(100)
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
		@filter Is Null Or Lower( FSBCaseTypeName ) Like '%' + Lower( @filter) + '%';

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

