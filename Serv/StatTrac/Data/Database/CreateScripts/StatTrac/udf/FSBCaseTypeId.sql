SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseTypeId]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[FSBCaseTypeId]
GO


Create Function [dbo].[FSBCaseTypeId]
(
	@FSBCaseTypeName nvarchar(50)
)
Returns Int
As
Begin
	
	Declare @FSBCaseTypeId Int

	Select
		@FSBCaseTypeId = FSBCaseTypeId
	From
		[dbo].[FSBCaseType]
	Where
		FSBCaseTypeName = @FSBCaseTypeName
		
	Return @FSBCaseTypeId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

