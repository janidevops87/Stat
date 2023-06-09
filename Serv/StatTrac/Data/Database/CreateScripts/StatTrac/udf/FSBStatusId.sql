SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBStatusId]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[FSBStatusId]
GO


Create Function [dbo].[FSBStatusId]
(
	@FSBStatusName nvarchar(50),
	@FSBCaseTypeId Int
)
Returns Int
As
Begin
	
	Declare @FSBStatusId Int

	Select
		@FSBStatusId = FSBStatusId
	From
		[dbo].[FSBStatus]
	Where
		FSBStatusName = @FSBStatusName And
		FSBCaseTypeId = @FSBCaseTypeId
		
	Return @FSBStatusId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

