SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase_SearchFamilyServices]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[FSBCase_SearchFamilyServices]
GO


Create Procedure [dbo].[FSBCase_SearchFamilyServices]
(
	@SourceCodeId Int,
	@ReferralNumber NVarChar(50),
	@PatientName NVarChar(50),
	@PersonId Int,
	@FSBStatusId Int,
	@Comment NVarChar(50)
)
As
Begin

Declare @FSBCaseTypeId Int
Set @FSBCaseTypeId = dbo.FSBCaseTypeId( 'Family Services' )

Declare @FSBFamilyServicesClosedStatusId Int
Set @FSBFamilyServicesClosedStatusId = dbo.FSBStatusId( 'Closed', @FSBCaseTypeId )

Declare @FSBSecondaryPendingStatusId Int
Set @FSBSecondaryPendingStatusId = dbo.FSBStatusId( 'Secondary Pending', @FSBCaseTypeId )

Declare @UrgencyThresholdMinutes Int
Set @UrgencyThresholdMinutes = ( Select Cast( OptionValue As Int ) From FSBOption Where OptionName = 'UrgencyThresholdMinutes' )

Select
	C.FSBCaseId,
	C.SourceCodeId,
	SC.SourceCodeName,
	C.ReferralNumber, 
	C.PatientName, 
	ISNULL(C.FSCPersonId, 0) As FSCPersonId, 
	Case When C.FSCPersonId Is Not Null
		Then IsNull( P.PersonLast, '' ) + ', ' + IsNull( P.PersonFirst, '' ) + ' ' + IsNull( P.PersonMI, '' )
		Else ''
	End As PersonName,
	ISNULL(C.PreviousFSCPersonId,0) As PreviousFSCPersonId , 
	Case When C.PreviousFSCPersonId  Is Not Null
		Then IsNull( PP.PersonLast, '' ) + ', ' + IsNull( PP.PersonFirst, '' ) + ' ' + IsNull( PP.PersonMI, '' )
		Else ''
	End As PreviousPersonName,	
	IsNull( SL.FSBStatusId, 0 ) As FSBStatusId,
	IsNull( Stat.FSBStatusName, 'None' ) As FSBStatusName,
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
	Left Outer Join Person P With ( NoLock ) On ( P.PersonId = C.FSCPersonId )
	Left Outer Join Person PP With ( NoLock) On ( PP.PersonId = C.PreviousFSCPersonId )
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
	( @PersonId = 0 Or C.FSCPersonId = @PersonId ) And
	( C.FSBCaseTypeId = @FSBCaseTypeId ) And
	( (SL.FSBStatusId <> @FSBFamilyServicesClosedStatusId ) And 
	( @FSBStatusId = 0) Or SL.FSBStatusId = @FSBStatusId ) And
	( @Comment Is Null Or CCL.Comment Like '%' + @Comment + '%' )

End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

