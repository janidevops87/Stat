SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_ListAll]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_ListAll]
GO


Create Procedure [dbo].[FSBCase_ListAll]
As
Begin

	Select
		FSBCaseId,
		SourceCodeId,
		ReferralNumber,
		PatientName,
		FSCPersonId,
		ISNULL(PreviousFSCPersonID, 0) AS 'PreviousFSCPersonID',
		FSBCaseTypeId,
		InsertedBy,
		UpdatedBy,
		DateInserted,
		DateUpdated
	From
		[dbo].[FSBCase]

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

