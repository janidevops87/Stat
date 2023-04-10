SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseType_Delete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseType_Delete]
GO


Create Procedure [dbo].[FSBCaseType_Delete]
(
	@FSBCaseTypeId int
)
As
Begin

	Delete From 
		[dbo].[FSBCaseType]
	Where
		FSBCaseTypeId = @FSBCaseTypeId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

