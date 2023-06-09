SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_FamilyServicesBoard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_FamilyServicesBoard]
GO


Create Procedure [dbo].[FSBCase_FamilyServicesBoard]
As
Begin

Declare @FSBCaseTypeId Int
Set @FSBCaseTypeId = dbo.FSBCaseTypeId( 'Family Services' )

Declare @FSBFamilyServicesClosedStatusId Int
Set @FSBFamilyServicesClosedStatusId = dbo.FSBStatusId( 'Closed', @FSBCaseTypeId )

Select
	SC.SourceCodeName,
	C.ReferralNumber, 
	C.PatientName, 
	IsNull( P.PersonLast, '' ) + ', ' + IsNull( P.PersonFirst, '' ) + ' ' + IsNull( P.PersonMI, '' ) As PersonName,
	IsNull( Stat.FSBStatusName, '' ) As FSBStatusName,
	Stat.ThresholdMinutes,
	DateDiff( n, C.DateInserted, GetDate() ) - Stat.ThresholdMinutes As ElapsedMinutes,
	IsNull( SubString( CCL.Comment, 1, 20 ), 'None' ) As Comment,
	C.InsertedBy,
	C.DateInserted, 
	C.UpdatedBy,
	C.DateUpdated,
	Case 
		When DateDiff( n, SL.DateInserted, GetDate() ) - Stat.ThresholdMinutes >= 0 Then Stat.Color
		Else 'Black'
	End As TheColor
From
	FSBCase C With ( NoLock )
	Inner Join SourceCode SC With ( NoLock ) On ( SC.SourceCodeId = C.SourceCodeId )
	Inner Join FSBCaseType CT With ( NoLock ) On ( CT.FSBCaseTypeId = C.FSBCaseTypeId )
	Left Outer Join Person P With ( NoLock ) On ( P.PersonId = C.FSCPersonId )
	Left Outer Join FSBCaseCommentLog CCL With ( NoLock ) On 
		( CCL.FSBCaseId = C.FSBCaseId And CCL.DateInserted = 
		( Select Max( DateInserted ) From FSBCaseCommentLog With ( NoLock ) Where FSBCaseId = C.FSBCaseId ) )
	Left Outer Join FSBCaseStatusLog SL With ( NoLock ) On 
		( SL.FSBCaseId = C.FSBCaseId And SL.StatusChangedDateTime = 
			( Select Max( StatusChangedDateTime) From FSBCaseStatusLog With ( NoLock ) Where FSBCaseId = C.FSBCaseId ) )
	Left Outer Join FSBStatus Stat With ( NoLock ) On ( Stat.FSBStatusId = SL.FSBStatusId)
Where
	( C.FSBCaseTypeId = @FSBCaseTypeId And Stat.FSBStatusId <> @FSBFamilyServicesClosedStatusId )
Order By
	7 Desc

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

