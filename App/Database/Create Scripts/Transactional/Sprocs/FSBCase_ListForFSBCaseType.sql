SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_ListForFSBCaseType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_ListForFSBCaseType]
GO


Create Procedure [dbo].[FSBCase_ListForFSBCaseType]
(
	@FSBCaseTypeId Int
)
As
Begin

Select
	C.FSBCaseId,
	C.SourceCodeId,
	SC.SourceCodeName,
	C.ReferralNumber, 
	C.PatientName, 
	Case When C.FSCPersonId Is Not Null Then C.FSCPersonId Else 0 End As FSCPersonId, 
	Case When C.FSCPersonId Is Not Null
		Then IsNull( P.PersonLast, '' ) + ', ' + IsNull( P.PersonFirst, '' ) + ' ' + IsNull( P.PersonMI, '' )
		Else ''
	End As PersonName,
	(
		Select
			IsNull( S.FSBStatusId, 0 )
		From
			FSBCaseStatusLog CSL
			Inner Join FSBStatus S On ( S.FSBStatusId = CSL.FSBStatusId )
		Where
			CSL.StatusChangedDateTime = ( Select Max( StatusChangedDateTime ) From FSBCaseStatusLog Where FSBCaseId = C.FSBCaseId ) And
			CSL.FSBCaseId = C.FSBCaseId
	) As FSBStatusId,
	(
		Select
			IsNull( S.FSBStatusName, 'None' )
		From
			FSBCaseStatusLog CSL
			Inner Join FSBStatus S On ( S.FSBStatusId = CSL.FSBStatusId )
		Where
			CSL.StatusChangedDateTime = ( Select Max( StatusChangedDateTime ) From FSBCaseStatusLog Where FSBCaseId = C.FSBCaseId ) And
			CSL.FSBCaseId = C.FSBCaseId
	) As FSBStatusName,
	(
		Select
			IsNull( CL.Comment, 'None' )
		From
			FSBCaseCommentLog CL
		Where
			CL.DateInserted = ( Select Max( DateInserted ) From FSBCaseCommentLog Where FSBCaseId = C.FSBCaseId ) And
			CL.FSBCaseId = C.FSBCaseId
	) As Comment,
	C.FSBCaseTypeId,
	CT.FSBCaseTypeName,
	C.InsertedBy,
	C.UpdatedBy,
	C.DateInserted, 
	C.DateUpdated
From
	FSBCase C
	Inner Join SourceCode SC On ( SC.SourceCodeId = C.SourceCodeId )
	Inner Join FSBCaseType CT On ( CT.FSBCaseTypeId = C.FSBCaseTypeId )
	Left Outer Join Person P On ( P.PersonId = C.FSCPersonId )
Where
	C.FSBCaseTypeId = @FSBCaseTypeId

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

