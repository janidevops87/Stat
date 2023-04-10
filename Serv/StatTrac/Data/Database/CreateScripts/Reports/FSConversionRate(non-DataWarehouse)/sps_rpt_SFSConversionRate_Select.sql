SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_SFSConversionRate_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure: sps_rpt_SFSConversionRate_Select'
	drop procedure [dbo].[sps_rpt_SFSConversionRate_Select]
End
go

PRINT 'Creating Procedure: sps_rpt_SFSConversionRate_Select'
GO

CREATE     PROCEDURE sps_rpt_SFSConversionRate_Select
	@ReferralStartDateTime		datetime	= NULL ,
	@ReferralEndDateTime		datetime  	= NULL ,
	@ReportGroupID			int			= NULL , 
	@OrganizationID			int			= NULL ,
	@SourceCodeName			varchar (10) = NULL ,
	@ApproacherData			varchar (2000)	= NULL ,
	@ApproacherTitle		int			= NULL,		
	@ApproacherOrganization int			= NULL,
	@DisplayMT				int	= Null 


AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
/******************************************************************************
**		File: sps_rpt_SFSConversionRate_Select.sql
**		Name: sps_rpt_SFSConversionRate_Select
**		Desc: 
**
**		Return values:
** 
**		Called by following Sprocs when All option is selected in report:
**		1. sps_rpt_FSSummary.sql
**
**		Parameters:	See Above
**
**		Auth: ccarroll
**		Date: 07/16/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		07/16/2008		ccarroll				Initial Release
****************************************************************************/

If @DisplayMT Is Null
	BEGIN
	/* Null, 0 - Run in referral facility time
			 1 - Run in Mountain Time */
		SET @DisplayMT = 0
	END

	/*	Create and populate a virtual table of valid Statline,MTF and MTF(ASP)users
   		who have FCS or Manager access to family service cases. */
	DECLARE	@PersonTable table ( 
		ID int identity(1,1), 
		PersonID int NOT NULL )

	INSERT INTO @PersonTable (PersonID)
		SELECT PersonID FROM Person
		WHERE
			PATINDEX('%'+ CAST(IsNull(PersonID,'-2') AS varchar) + '%', IsNull(@ApproacherData, CAST(IsNull(PersonID,'-2') AS varchar))) > 0 AND
			OrganizationID = IsNull(@ApproacherOrganization, OrganizationID)
			AND PersonTypeId = IsNull(@ApproacherTitle, PersonTypeID)

SELECT
		@ReferralStartDateTime = ISNULL(
						@ReferralStartDateTime, 
						CONVERT(VARCHAR, DATEADD(d, -1, GETDATE()), 110) 								),
		@ReferralEndDateTime = ISNULL	(
						@ReferralEndDateTime, 
						CONVERT(VARCHAR, DATEADD(ww, -1, GETDATE()), 110) 
					)

	
	SELECT DISTINCT
		Call.CallID,
		Call.CallDateTime,
		Call.SourceCodeID,
		Call.StatEmployeeID,
		
		/* Approach PersonIDs */
		IsNull(SecondaryApproach.SecondaryApproachedBy, SecondaryApproach.SecondaryConsentBy) AS 'ApproachPersonID',
		EventIncomingPerson.PersonID AS 'LogEventIncomingSecondaryID',
		EventOutgoingPerson.PersonID AS 'LogEventOutgoingCallID',
		SecondaryApproach.SecondaryApproachedBy AS 'SecondaryApproachedBy',
		SecondaryApproach.SecondaryConsentBy AS 'SecondaryConsentBy',
		SecondaryApproach.SecondaryConsentMedSocObtainedBy AS 'SecondaryConsentMedSocObtainedBy',
		FSCasePerson.PersonID AS 'FSCase.FSCaseBillMedSocUserID',
		
		FSCase.FSCaseBillMedSocCount,

		Referral.ReferralGeneralConsent,
		Referral.ReferralTypeID,
		Referral.ReferralCallerOrganizationID,
		RegistryStatus.RegistryStatus, 

		Referral.ReferralOrganAppropriateID,
		Referral.ReferralBoneAppropriateID,
		Referral.ReferralTissueAppropriateID,
		Referral.ReferralSkinAppropriateID,
		Referral.ReferralEyesTransAppropriateID,
		Referral.ReferralEyesRschAppropriateID,
		Referral.ReferralValvesAppropriateID,

		Referral.ReferralOrganApproachID,
		Referral.ReferralBoneApproachID,
		Referral.ReferralTissueApproachID,
		Referral.ReferralSkinApproachID,
		Referral.ReferralEyesTransApproachID,
		Referral.ReferralEyesRschApproachID,
		Referral.ReferralValvesApproachID,

		Referral.ReferralOrganConsentID,
		Referral.ReferralBoneConsentID,
		Referral.ReferralTissueConsentID,
		Referral.ReferralSkinConsentID,
		Referral.ReferralEyesTransConsentID,
		Referral.ReferralEyesRschConsentID,
		Referral.ReferralValvesConsentID,

		Referral.ReferralOrganConversionID,
		Referral.ReferralBoneConversionID,
		Referral.ReferralTissueConversionID,
		Referral.ReferralSkinConversionID,
		Referral.ReferralEyesTransConversionID, 
		Referral.ReferralEyesRschConversionID, 
		Referral.ReferralValvesConversionID 
  FROM Call
 	JOIN	/* NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
			   Converting the date as appropriate
			   The function limits the data returned by date range and/or CallID
			*/
	(
		SELECT 		
			CallID, 
			CallDateTime 
			--ReferralDonorDeathDateTime
		FROM dbo.fn_rpt_ReferralDateTimeConversion 
		(
		Null						,
		@ReferralStartDateTime		,
		@ReferralEndDateTime		,
		Null						,
		Null						, 
		@DisplayMT		 )
  	) LT ON LT.CallID = Call.CallID

  JOIN Referral ON Call.CallID = Referral.CallID
  LEFT JOIN SecondaryApproach ON SecondaryApproach.CallID = Call.CallID

	/* Secondary Approached By */
  LEFT JOIN @PersonTable AS PersonSAB ON SecondaryApproach.SecondaryApproachedBy = PersonSAB.PersonID

	/* Secondary Consent By */
  LEFT JOIN @PersonTable AS PersonSCB ON SecondaryApproach.SecondaryConsentBy = PersonSCB.PersonID

   /* Secondary Consent Med/Soc Obtained By */
  LEFT JOIN @PersonTable AS PersonSCM ON SecondaryApproach.SecondaryConsentMedSocObtainedBy = PersonSCM.PersonID
  
  LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
  LEFT JOIN RegistryStatus ON RegistryStatus.CallID = Call.CallID
  LEFT JOIN LogEvent ON LogEvent.CallID = Call.CallID AND (LogEvent.LogEventTypeID IN (3, 15, 34))
  
  LEFT JOIN LogEvent AS EventOutgoingCall ON EventOutgoingCall.CallID = Call.CallID AND (EventOutgoingCall.LogEventTypeID = 3)
  LEFT JOIN StatEmployee EventOutgoingPerson ON EventOutgoingPerson.StatEmployeeID = EventOutgoingCall.StatEmployeeID
  LEFT JOIN @PersonTable AS PersonEOP ON EventOutgoingPerson.PersonID = PersonEOP.PersonID
  
  LEFT JOIN LogEvent AS EventIncomingSecondary ON EventIncomingSecondary.CallID = Call.CallID AND (EventIncomingSecondary.LogEventTypeID = 34)
  LEFT JOIN StatEmployee EventIncomingPerson ON EventIncomingPerson.StatEmployeeID = EventIncomingSecondary.StatEmployeeID
  LEFT JOIN @PersonTable AS PersonEIP ON EventIncomingPerson.PersonID = PersonEIP.PersonID

  LEFT JOIN FSCase ON FSCase.CallID = Call.CallID
  LEFT JOIN StatEmployee FSCasePerson ON FSCasePerson.StatEmployeeID = FSCase.FSCaseBillMedSocUserID
  LEFT JOIN @PersonTable AS PersonEFC ON FSCasePerson.PersonID = PersonEFC.PersonID

  WHERE  Call.SourceCodeID IN 
		(SELECT DISTINCT * 
			FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName)
		)
  AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID,Referral.ReferralCallerOrganizationID)
  AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
  --AND LogEvent.LogEventTypeID = 15 /* Secondary Pending */
  AND (
			PATINDEX('%'+ CAST(IsNull(SecondaryApproach.SecondaryApproachedBy,'-2') AS varchar) + '%', IsNull(@ApproacherData, CAST(IsNull(SecondaryApproach.SecondaryApproachedBy,'-2') AS varchar))) > 0
	     OR PATINDEX('%'+ CAST(IsNull(SecondaryApproach.SecondaryConsentBy,'-2') AS varchar) + '%', IsNull(@ApproacherData, CAST(IsNull(SecondaryApproach.SecondaryConsentBy,'-2') AS varchar))) > 0
	     OR PATINDEX('%'+ CAST(IsNull(SecondaryApproach.SecondaryConsentMedSocObtainedBy,'-2') AS varchar) + '%', IsNull(@ApproacherData, CAST(IsNull(SecondaryApproach.SecondaryConsentMedSocObtainedBy,'-2') AS varchar))) > 0
	     OR PATINDEX('%'+ CAST(IsNull(FSCasePerson.PersonID,'-2') AS varchar) + '%', IsNull(@ApproacherData, CAST(IsNull(FSCasePerson.PersonID,'-2') AS varchar))) > 0
		 OR
		/* 1st Outgoing Call to same referral facility after After Secondary Pending or Incoming Secondary Event */
		Call.CallID IN (SELECT * FROM dbo.fn_rpt_SecondaryEventCall
							(
							@ReferralStartDateTime, 
							@ReferralEndDateTime,
							@ReportGroupID, 
							@OrganizationID,
							@SourceCodeName,
							@ApproacherData,
							@ApproacherTitle,		
							@ApproacherOrganization,
							@DisplayMT
							)
						)
	 )
 
ORDER BY Call.CallID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
