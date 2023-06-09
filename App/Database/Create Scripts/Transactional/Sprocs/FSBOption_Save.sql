SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBOption_Save]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBOption_Save]
GO


Create Procedure [dbo].[FSBOption_Save]
(
	@OptionName nvarchar(50),
	@OptionValue nvarchar(50),
	@InsertedBy nvarchar(50),
	@UpdatedBy nvarchar(50)
)
As
Begin

	If Exists
	(
		Select * From [dbo].[FSBOption]
		Where
			OptionName = @OptionName
	)
	Begin

		Update
			[dbo].[FSBOption]
		Set
			OptionValue = @OptionValue,
			InsertedBy = @InsertedBy,
			UpdatedBy = @UpdatedBy,
			DateUpdated = GetDate()
		Where
			OptionName = @OptionName

	End
	Else
	Begin
	
		Insert Into [dbo].[FSBOption]
		( 
			OptionName,
			OptionValue,
			InsertedBy,
			UpdatedBy,
			DateInserted
		 )
		Values
		( 
			@OptionName,
			@OptionValue,
			@InsertedBy,
			@UpdatedBy,
			GetDate()
		 );
	
	End

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

