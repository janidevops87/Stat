SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBStatus_ListByFSBStatusName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBStatus_ListByFSBStatusName]
GO


Create Procedure [dbo].[FSBStatus_ListByFSBStatusName]
(
	@filter VarChar(100)
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
		@filter Is Null Or Lower( FSBStatusName ) Like '%' + Lower( @filter) + '%';

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

