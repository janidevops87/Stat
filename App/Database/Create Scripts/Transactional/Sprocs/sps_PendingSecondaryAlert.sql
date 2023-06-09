SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingSecondaryAlert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'DROP PROCEDURE sps_PendingSecondaryAlert'
	drop procedure [dbo].[sps_PendingSecondaryAlert]
END
	PRINT 'CREATE PROCEDURE sps_PendingSecondaryAlert'
GO




CREATE PROCEDURE sps_PendingSecondaryAlert
	@LeaseOrg	INT =0,
	@timeZone	VARCHAR(2)
AS
/******************************************************************************
**		File: sps_PendingSecondaryAlert.sql
**		Name: sps_PendingSecondaryAlert
**		Desc: 
**
**              
**		Return values: returns pending secondary alert
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@LeaseOrg	INT =0,
**		@vTZ		VARCHAR(2)
**
**		Auth: Dave Hoffmann
**		Date: 09/01/2001
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/14/2006	ccarroll			Added Join to display SourceCode Name
**										Used by Secondary Activity grid in frmOpenAll
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Added set transaction level
**
**		09/24/2007	ccarroll			Empirix 6849 Change sort order. Was DESC 
**		01/25/2010  ccarroll			Ambiguous column name 'FSCaseCreateDateTime'
**										changed Order By to ordinal :SQL2008 upgrade
**		03/13/2010 Bret Knoll			Resaving for inclusion in releae
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT DISTINCT
		
		Call.CallID, 
		0, 
		Call.CallNumber,
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCaseCreateDateTime
					),
				FSCaseCreateDateTime
			) AS 'FSCaseCreateDateTime', 
		Organization.OrganizationName, 
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1),
		sc.SourceCodeName,
		DATEADD
			(
				hh,
				dbo.fn_TimeZoneDifference
					(
						@timeZone, 
						FSCaseCreateDateTime
					),
				FSCaseCreateDateTime
			) AS 'FSCaseCreateDateTime',
		'' AS Spacer,
		'' AS Spacer,
		PO.OrganizationID,
		Organization.OrganizationID,
		Call.SourceCodeID
	
	FROM 	
		Call
	JOIN 	
		FSCase ON FSCase.CallID = Call.CallID
	JOIN 	
		Referral ON Referral.CallID = Call.CallID
	JOIN	
		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	LEFT
	JOIN	
		SourceCode sc ON Call.SourceCodeID = sc.SourceCodeID
	LEFT 
	JOIN 	
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID
	LEFT 
	JOIN 	
		Person ON Person.PersonID = StatEmployee.PersonID

	-- added join to join Person that took the call to their organization 
	LEFT 
	JOIN 	
		Organization PO ON PO.OrganizationID = Person.OrganizationID
	LEFT 
	JOIN 	
		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	
		WebReportGroup PC ON PC.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE 	
		FSCaseOpenUserId = 0 
	AND 	
		FSCase.FSCaseFinalUserId = 0 
	-- add to where for LO
	AND	
		PO.OrganizationLOFSEnabled = 
			Case 
				when 
					@LeaseOrg > 0 
				Then 
					PO.OrganizationLOFSEnabled 
				else 
					0 
			end -- Added for LO
	
	AND     
		PC.OrgHierarchyParentID = 
			Case 
				when 
					@LeaseOrg > 0 
				Then 
					@LeaseOrg 
				Else 
					PC.OrgHierarchyParentID 
			END -- Added for LO

	ORDER BY 
		4 --FSCaseCreateDateTime



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

