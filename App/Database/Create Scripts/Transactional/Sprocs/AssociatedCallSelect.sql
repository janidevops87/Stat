DROP PROCEDURE IF EXISTS [dbo].[AssociatedCallSelect];
PRINT 'Dropping Procedure: AssociatedCallSelect';

PRINT 'Creating Procedure: AssociatedCallSelect';
GO

CREATE PROCEDURE [dbo].[AssociatedCallSelect]
(
	@OrganizationID		INT = NULL,
	@PhoneID			INT = NULL, 
	@userOrganizationID INT = NULL,
	@DBInstance			NVARCHAR(100)	
)
/******************************************************************************
**		File: AssociatedCallSelect.sql
**		Name: AssociatedCallSelect
**		Desc:  Used when user hits delete from Organization Search Screen. 
**				Loads grid of associated Referrals
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/16/2011	bret		initial
**		05/26/2011	bret		Added code to lookup number and search by number instead of PhoneID. 
**									Also, added code to limit by asp
**		03/01/2021	Mike		Refactored with temp tables to run faster and updated logic to include 
**									SourceCodes with a SourceCodeType of Referral.
*******************************************************************************/
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DROP TABLE IF EXISTS #FilteredSourceCodes;
	DROP TABLE IF EXISTS #FilteredCalls;

	DECLARE 
		@StatlineOrganizationId INT				= 194, -- StatLine's OrganizationID from the Organization table
		@Phone					NVARCHAR(20)	= NULL;

	-- Look up the @Phone (phone number string) if @PhoneID is available
	IF(@PhoneID IS NOT NULL AND @PhoneID <> 0)
	BEGIN
		SELECT @Phone = Phone FROM fn_PhoneByPhoneID(@PhoneID);
	END

	-- Load #FilteredSourceCodes
	-- Limits ASP Users to their sourceCode Organization based on their UserOrganizationId
	SELECT 
		sc.SourceCodeId, 
		sc.SourceCodeName
	INTO #FilteredSourceCodes
	FROM
		SourceCode sc
		JOIN SourceCodeOrganization sco ON sco.SourceCodeID = sc.SourceCodeID
	WHERE 
		(
			sc.SourceCodeType = 1		-- Referral
			OR sc.SourceCodeType = 2	-- Message
			OR sc.SourceCodeType = 4	-- Import
		)
		AND sco.OrganizationID = @UserOrganizationId;

	-- Load #FilteredCalls
	SELECT DISTINCT
		CAST(NULL AS VARCHAR(50))	AS 'CallTypeName',
		CAST(NULL AS INT)			AS 'PhoneID',
		CAST(NULL AS VARCHAR(20))	AS 'PHONE',
		c.CallID,
		sc.SourceCodeID,
		sc.SourceCodeName,
		c.CallDateTime,
		CAST(NULL AS VARCHAR(52))	AS 'Name',
		@DBInstance					AS 'DBInstance',
		c.CallTypeID,
		c.StatEmployeeID,
		r.ReferralCallerPhoneID
	INTO #FilteredCalls
	FROM   
		[Call] c
		LEFT JOIN SourceCode sc ON sc.SourceCodeID = c.SourceCodeID
		LEFT JOIN #FilteredSourceCodes fsc ON fsc.SourceCodeID = c.SourceCodeID
		LEFT JOIN Referral r ON r.CallID = c.CallID
		LEFT JOIN [Message] m ON m.CallID = c.CallID
		LEFT JOIN TcssRecipientOfferInformation roi ON roi.CallID = c.CallID	
		LEFT JOIN fn_PhoneByPhoneID(null) phone ON r.ReferralCallerPhoneID = phone.PhoneID	
	WHERE	
		(	
			-- Give Statline employees access to all sourcecodes, otherwise show the filtered list
			@UserOrganizationId = @StatlineOrganizationId	
			OR fsc.SourceCodeID IS NOT NULL				
		)		
		AND (
					r.CallID IS NOT NULL	
				OR	(m.CallID IS NOT NULL AND (@OrganizationID IS NULL OR m.OrganizationID = @OrganizationID))
				OR	(roi.CallID IS NOT NULL AND (@OrganizationID IS NULL OR roi.ClientId = @OrganizationID))
			)
		AND (
				(
					@OrganizationID IS NULL 
					AND phone.Phone = @Phone
				)
				OR 
				(
					r.ReferralCallerOrganizationID = @OrganizationID
					OR r.ReferralCoronerOrgID = @OrganizationID
				)
			);	

	-- Populate CallTypeName, PhoneID & Name
	UPDATE 
		fc
	SET
		fc.CallTypeName = ct.CallTypeName,
		fc.PhoneID = callerPhone.PhoneID,
		fc.[Name] = se.StatEmployeeFirstName + ' ' + SUBSTRING(se.StatEmployeeLastName, 1, 1)
	FROM
		#FilteredCalls fc
		LEFT JOIN CallType ct ON ct.CallTypeID = fc.CallTypeID
		LEFT JOIN fn_PhoneByPhoneID(null) callerPhone ON callerPhone.PhoneID = fc.ReferralCallerPhoneID
		LEFT JOIN StatEmployee se ON se.StatEmployeeID = fc.StatEmployeeID;

	-- Populate Phone
	UPDATE 
		fc
	SET
		fc.PHONE = CASE WHEN fc.CallTypeID = 1						THEN callerPhone.Phone
						WHEN fc.CallTypeID = 2 OR fc.CallTypeID = 4	THEN m.MessageCallerPhone
						WHEN fc.CallTypeID = 6						THEN tcPhone.Phone
						ELSE '' END
	FROM
		#FilteredCalls fc
		LEFT JOIN fn_PhoneByPhoneID(null) callerPhone ON callerPhone.PhoneID = fc.ReferralCallerPhoneID		
		LEFT JOIN [Message] m ON m.CallID = fc.CallID
		LEFT JOIN TcssRecipientOfferInformation roi ON roi.CallID = fc.CallID								
		LEFT JOIN OrganizationPhone op ON op.OrganizationID = roi.ClientId AND op.SubLocationID = 60 --	Main			
		LEFT JOIN fn_PhoneByPhoneID(null) tcPhone ON tcPhone.PhoneID = op.PhoneID;

	-- Run final select
	SELECT 	 
		CallTypeName,
		PhoneID,
		PHONE,
		CallID,
		SourceCodeID,
		SourceCodeName,
		CallDateTime,
		[Name],
		DBInstance
	FROM 
		#FilteredCalls
	ORDER BY
		PhoneID,
		CallID;

	RETURN @@Error;	

	DROP TABLE IF EXISTS #FilteredSourceCodes;
	DROP TABLE IF EXISTS #FilteredCalls;
END
GO