SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseType_Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCaseType_Create]
GO


Create Procedure [dbo].[FSBCaseType_Create]
(
	@FSBCaseTypeId int OUTPUT,
	@FSBCaseTypeName nvarchar(50),
	@InsertedBy nvarchar(50),
	@UpdatedBy nvarchar(50)
)
As
Begin

	Insert Into [dbo].[FSBCaseType]
	( 
		FSBCaseTypeName,
		InsertedBy,
		UpdatedBy,
		DateInserted
	 )
	Values
	( 
		@FSBCaseTypeName,
		@InsertedBy,
		@UpdatedBy,
		GetDate()
	 );

	Set @FSBCaseTypeId = Scope_Identity();

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

