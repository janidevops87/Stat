SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_GetByFSBCaseId]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_GetByFSBCaseId]
GO


Create Procedure [dbo].[FSBCase_GetByFSBCaseId]
(
	@FSBCaseId int
)
As
Begin

	Select
		ISNULL(FSBCaseId, 0) AS 'FSBCaseId',
		ISNULL(SourceCodeId, 0) AS 'SourceCodeId',
		ReferralNumber,
		PatientName,
		ISNULL(FSCPersonId, 0) AS 'FSCPersonId',
		ISNULL(PreviousFSCPersonID, 0) AS 'PreviousFSCPersonID',
		ISNULL(FSBCaseTypeId, 0) AS 'FSBCaseTypeId',		
		InsertedBy,
		UpdatedBy,
		DateInserted,
		DateUpdated
	From
		[dbo].[FSBCase]
	Where
		FSBCaseId = @FSBCaseId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

