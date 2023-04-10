SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBStatus_Delete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBStatus_Delete]
GO


Create Procedure [dbo].[FSBStatus_Delete]
(
	@FSBStatusId int
)
As
Begin

	Delete From 
		[dbo].[FSBStatus]
	Where
		FSBStatusId = @FSBStatusId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

