IF OBJECT_ID (N'dbo.fn_rpt_SecondaryEventCall') IS NOT NULL
    DROP FUNCTION dbo.fn_rpt_SecondaryEventCall
    PRINT 'Dropping Function: dbo.fn_rpt_SecondaryEventCall'
GO
PRINT 'Creating Function: dbo.fn_rpt_SecondaryEventCall'
GO

CREATE FUNCTION [dbo].[fn_rpt_SecondaryEventCall]
	(
	@ReferralStartDateTime	DATETIME = NULL, 
	@ReferralEndDateTime	DATETIME = NULL,
	@ReportGroupID			int			= NULL , 
	@OrganizationID			int			= NULL ,
	@SourceCodeName			varchar (10) = NULL ,
	@ApproacherData			varchar (2000)	= NULL ,
	@ApproacherTitle		int			= NULL,		
	@ApproacherOrganization int			= NULL,
	@DisplayMT				int = NULL
	)

RETURNS 	@finalTable TABLE
	(
		CallID int
	)
AS 
/******************************************************************************
**		File: fn_rpt_SecondaryEventCall.sql
**		Name: fn_rpt_SecondaryEventCall
**
**		Desc: This function returns a list of callID's inside the parameter range
**			  listed above where the first outgoing call to the inital referral 
**			  facility occurs after a secondary pending event or 
**			  Incoming Secondary event after Secondary Pending.
**
**
**              
**		Return values:
** 
**		Called by: 
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll 
**		Date: 7/15/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**		07/15/2008	ccarroll			Initial 
*******************************************************************************/
BEGIN

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
			PATINDEX('%'+ CAST(IsNull(PersonID,'-') AS varchar) + '%', IsNull(@ApproacherData, PersonID)) > 0 AND
			OrganizationID = IsNull(@ApproacherOrganization, OrganizationID)
			AND PersonTypeID = IsNull(@ApproacherTitle, PersonTypeID)
		

				
INSERT @finalTable
	SELECT DISTINCT
			Call.CallID 
	FROM LogEvent
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
  	) LT ON LT.CallID = LogEvent.CallID

	JOIN Call ON LogEvent.CallID = Call.CallID AND LogEvent.LogEventTypeID IN (3, 15, 34)
	JOIN Referral ON Call.CallID = Referral.CallID
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID 

	WHERE   
		Call.SourceCodeID IN
			(SELECT DISTINCT * 
				FROM dbo.fn_SourceCodeList(@ReportGroupID,@SourceCodeName))
	AND Referral.ReferralCallerOrganizationID = ISNULL(@OrganizationID,Referral.ReferralCallerOrganizationID)
	AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
	AND	LogEvent.LogEventTypeID IN
		(SELECT SCE.LogEventTypeID 
		 FROM LogEvent AS SCE /* SCE - 1st Secondary Call Event */
		 LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
		 WHERE SCE.CallID = Call.CallID
		 AND SCE.LogEventNumber >
			(SELECT SPE.LogEventNumber
			 FROM LogEvent AS SPE /* SPE - Secondary Pending Event */
			 WHERE SPE.CallID = Call.CallID
			 AND SPE.LogEventTypeID = 15 /* Secondary Pending */
			 )
			AND (
				 SCE.LogEventTypeID = 3 /* Outgoing Call */
				 AND PATINDEX('%'+ CAST(IsNull(StatEmployee.PersonID,'-2') AS varchar) + '%', IsNull(@ApproacherData, CAST(IsNull(StatEmployee.PersonID,'-2')AS varchar))) > 0
				 AND Referral.ReferralCallerOrganizationID = SCE.OrganizationID
				)
			OR  (SCE.LogEventTypeID = 34 /* Incoming Secondary */
				 AND PATINDEX('%'+ CAST(IsNull(StatEmployee.PersonID,'-2') AS varchar) + '%', IsNull(@ApproacherData, CAST(IsNull(StatEmployee.PersonID,'-2')AS varchar))) > 0
				)
   			GROUP BY LogEvent.LogEventNumber, SCE.LogEventTypeID
			)

	RETURN
END

GO