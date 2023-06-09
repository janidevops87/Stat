SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_ListByPatientName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_ListByPatientName]
GO


Create Procedure [dbo].[FSBCase_ListByPatientName]
(
	@filter VarChar(100)
)
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
	Where
		@filter Is Null Or Lower( PatientName ) Like '%' + Lower( @filter) + '%';

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

