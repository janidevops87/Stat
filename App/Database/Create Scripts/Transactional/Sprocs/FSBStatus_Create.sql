SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBStatus_Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBStatus_Create]
GO


Create Procedure [dbo].[FSBStatus_Create]
(
	@FSBStatusId int OUTPUT,
	@FSBStatusName nvarchar(50),
	@FSBCaseTypeId int,
	@Color nvarchar(50),
	@ThresholdMinutes smallint,
	@InsertedBy nvarchar(50),
	@UpdatedBy nvarchar(50)
)
As
Begin

	Insert Into [dbo].[FSBStatus]
	( 
		FSBStatusName,
		FSBCaseTypeId,
		Color,
		ThresholdMinutes,
		InsertedBy,
		UpdatedBy,
		DateInserted
	 )
	Values
	( 
		@FSBStatusName,
		@FSBCaseTypeId,
		@Color,
		@ThresholdMinutes,
		@InsertedBy,
		@UpdatedBy,
		GetDate()
	 );

	Set @FSBStatusId = Scope_Identity();

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

