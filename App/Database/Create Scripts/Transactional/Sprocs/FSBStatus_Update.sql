SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBStatus_Update]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBStatus_Update]
GO


Create Procedure [dbo].[FSBStatus_Update]
(
	@FSBStatusId int, 
	@FSBStatusName nvarchar(50), 
	@FSBCaseTypeId int, 
	@Color nvarchar(50),
	@ThresholdMinutes smallint,
	@InsertedBy nvarchar(50), 
	@UpdatedBy nvarchar(50) 
)
As
Begin

	Update
		[dbo].[FSBStatus]
	Set
		FSBStatusName = @FSBStatusName,
		FSBCaseTypeId = @FSBCaseTypeId,
		Color = @Color,
		ThresholdMinutes = @ThresholdMinutes,
		InsertedBy = @InsertedBy,
		UpdatedBy = @UpdatedBy,
		DateUpdated = GetDate()
	Where
		FSBStatusId = @FSBStatusId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

