SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBStatus_ListByFSBCaseType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBStatus_ListByFSBCaseType]
GO


Create Procedure [dbo].[FSBStatus_ListByFSBCaseType]
(
	@FSBCaseTypeId int
)
As
Begin

	Select
		FSBStatusId,
		FSBStatusName,
		FSBCaseTypeId,
		Color,
		ThresholdMinutes,
		InsertedBy,
		UpdatedBy,
		DateInserted,
		DateUpdated
	From
		[dbo].[FSBStatus]
	Where
		FSBCaseTypeId = @FSBCaseTypeId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

