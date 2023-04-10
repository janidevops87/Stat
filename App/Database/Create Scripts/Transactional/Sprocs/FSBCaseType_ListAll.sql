SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseType_ListAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseType_ListAll]
GO


Create Procedure [dbo].[FSBCaseType_ListAll]
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

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

