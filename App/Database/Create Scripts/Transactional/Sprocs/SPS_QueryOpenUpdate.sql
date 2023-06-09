SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_QueryOpenUpdate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_QueryOpenUpdate]
GO


CREATE PROCEDURE SPS_QueryOpenUpdate
	@pvStartDate	AS	smalldatetime = NULL,
	@pvEndDate	AS	smalldatetime = NULL,
	@vTZ	VARCHAR(2),
	@vReturnLimit 		Int = 0

/*
  
   05/19/2006 ccarroll - StatTrac v. 8.0 Changes
   Updated select statement to return LogEvent.LastModified (was using call.LastModified)
   Added table join to accomodate above

*/

AS
/******************************************************************************
**		File: SPS_QueryOpenUpdate.sql
**		Name: SPS_QueryOpenUpdate
**		Desc: 
**
**              
**		Return values: Sproc retrieves list of updated referrals
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**  @CallID int,
**		Auth: Scott Plummer
**		Date: 5/24/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		5/24/2005	Scott Plummer		StatTrac v. 7.7.4
**		05/19/2006	ccarroll			StatTrac v. 8.0 Updated select statement to return 
**										LogEvent.LastModified (was using call.LastModified)
**										Added table join to accomodate above
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Replaced (nolock) with set transaction level
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	IF @vReturnLimit > 0
    BEGIN
		SET ROWCOUNT @vReturnLimit 

		-- Limit the date range to 10 days, since only 200 are coming back anyway
		IF DateDiff(d, @pvStartDate, @pvEndDate) > 10
		BEGIN
			SET @pvStartDate = DateAdd(d, -10, @pvEndDate)
		END

		SET ROWCOUNT @vReturnLimit
    END

	SELECT DISTINCT 
		Call.CallID, 
		Call.CallNumber, 
		LogEvent.LastModified AS 'CallDateTime', 
		Referral.ReferralDonorName, 
		Organization.OrganizationName, 
		PrevReferralType.ReferralTypeName AS PrevReferralTypeName,  -- Added 5/23/05 - SAP
		ReferralType.ReferralTypeName, 
		SourceCodeName, 
		StatEmployee.StatEmployeeFirstName + ' ' + StatEmployee.StatEmployeeLastName AS StatEmployeeName,
		--'' As Spacer, 
		--'' As Spacer, 
		Person.OrganizationID
	FROM 	Referral  
	LEFT 
	JOIN 	Call  ON Call.CallID = Referral.CallID
	LEFT 
	JOIN 	LogEvent  ON  LogEvent.CallID = Call.CallID  --	Added 05/19/2006 ccarroll 
	LEFT 
	JOIN 	Organization  ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT 
	JOIN 	State  ON State.StateID = Organization.StateID 
	LEFT 
	JOIN 	ReferralType  ON ReferralType.ReferralTypeID = Referral.CurrentReferralTypeID 
	LEFT
	JOIN	ReferralType PrevReferralType  ON PrevReferralType.ReferralTypeId = Referral.ReferralTypeID
	LEFT 
	JOIN 	SourceCode  ON SourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT 
	JOIN 	StatEmployee  ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT 
	JOIN 	Person  ON Person.PersonID = StatEmployee.PersonID 
	WHERE	LogEvent.LastModified >= @pvStartDate  --Changed 05/19/2006 ccarroll
	AND 	LogEvent.LastModified <= @pvEndDate    --Changed 05/19/2006 ccarroll
	ORDER 
	BY 	LogEvent.LastModified DESC;	       --Changed 05/19/2006 ccarroll


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

