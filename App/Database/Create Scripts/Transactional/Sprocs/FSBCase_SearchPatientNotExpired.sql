SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_SearchPatientNotExpired]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_SearchPatientNotExpired]
GO


Create Procedure [dbo].[FSBCase_SearchPatientNotExpired]
(
	@SourceCodeId Int,
	@ReferralNumber NVarChar(50),
	@PatientName NVarChar(50),
	@FSBStatusId Int,
	@Comment NVarChar(50)
)
As
Begin

Declare @FSBCaseTypeId Int
Set @FSBCaseTypeId = dbo.FSBCaseTypeId( 'Patient Not Expired' )

Declare @FSBPatientNotExpiredClosedStatusId Int
Set @FSBPatientNotExpiredClosedStatusId = dbo.FSBStatusId( 'Closed', @FSBCaseTypeId )

Select
	C.FSBCaseId,
	C.SourceCodeId,
	SC.SourceCodeName,
	C.ReferralNumber, 
	C.PatientName, 
	0 As FSCPersonId, 
	'' As PersonName,
	0 As PreviousFSCPersonId, 
	'' As PreviousPersonName,
	IsNull( SL.FSBStatusId, 0 ) As FSBStatusId,
	IsNull( Stat.FSBStatusName, '' ) As FSBStatusName,
	IsNull( SubString( CCL.Comment, 1, 20 ), 'None' ) As Comment,
	C.FSBCaseTypeId,
	CT.FSBCaseTypeName,
	C.InsertedBy,
	C.UpdatedBy,
	C.DateInserted, 
	C.DateUpdated,
	Case 
		When DateDiff( n, SL.DateInserted, GetDate() ) - Stat.ThresholdMinutes >= 0 Then Stat.Color
		Else 'Black'
	End As TheColor
From
	FSBCase C With ( NoLock )
	Inner Join SourceCode SC With ( NoLock ) On ( SC.SourceCodeId = C.SourceCodeId )
	Inner Join FSBCaseType CT With ( NoLock ) On ( CT.FSBCaseTypeId = C.FSBCaseTypeId )
	Left Outer Join FSBCaseStatusLog SL With ( NoLock ) On 
		( SL.FSBCaseId = C.FSBCaseId And SL.StatusChangedDateTime = 
		( Select Max( StatusChangedDateTime) From FSBCaseStatusLog With ( NoLock ) Where FSBCaseId = C.FSBCaseId ) )
	Left Outer Join FSBStatus Stat With ( NoLock ) On ( Stat.FSBStatusId = SL.FSBStatusId )
	Left Outer Join FSBCaseCommentLog CCL With ( NoLock ) On 
		( CCL.FSBCaseId = C.FSBCaseId And CCL.DateInserted = 
		( Select Max( DateInserted ) From FSBCaseCommentLog With ( NoLock ) Where FSBCaseId = C.FSBCaseId ) )
Where
    ( @SourceCodeId = 0 Or C.SourceCodeId = @SourceCodeId ) And
    ( @ReferralNumber Is Null Or C.ReferralNumber Like '%' + @ReferralNumber +'%' ) And
    ( @PatientName Is Null Or C.PatientName Like '%' + @PatientName + '%' ) And
    ( C.FSBCaseTypeId = @FSBCaseTypeId ) And
    ( (SL.FSBStatusId <> @FSBPatientNotExpiredClosedStatusId  And 
       @FSBStatusId = 0) Or SL.FSBStatusId = @FSBStatusId )  And
    ( @Comment Is Null Or CCL.Comment Like '%' + @Comment + '%' )

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

