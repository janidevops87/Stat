IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationDeleteSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[OrganizationDeleteSelect]
	PRINT 'Dropping Procedure: OrganizationDeleteSelect'
END
	PRINT 'Creating Procedure: OrganizationDeleteSelect'
GO

CREATE PROCEDURE [dbo].[OrganizationDeleteSelect]
(
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: OrganizationDeleteSelect.sql
**		Name: OrganizationDeleteSelect
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
**		6/19/2009	bret		initial
**      10/16/09    jth			need sourcecodeid for delete screen to populate organization drop down
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
				
	SELECT     
			CallType.CallTypeName,
			Call.CallID,
			SourceCode.SourceCodeID,
			SourceCode.SourceCodeName,
			Call.CallDateTime,
			StatEmployee.StatEmployeeFirstName + ' ' + SUBSTRING(StatEmployee.StatEmployeeLastName, 1, 1) Name
		FROM         
			Call 
		JOIN
			SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID 
		JOIN
			StatEmployee ON Call.StatEmployeeID = StatEmployee.StatEmployeeID 
		JOIN
			CallType ON Call.CallTypeID = CallType.CallTypeID
		
		LEFT OUTER JOIN 
			Referral ON Call.CallID = Referral.CallID
				AND
					(
						Referral.ReferralCallerOrganizationID = @OrganizationID
					OR
						Referral.ReferralCoronerOrgID = @OrganizationID
						)
		LEFT OUTER JOIN
			Message ON Call.CallID = Message.CallID AND Message.OrganizationID = @OrganizationID
		WHERE 
			Referral.ReferralID IS NOT NULL
		OR						
			Message.MessageID IS NOT NULL 
	
	RETURN @@Error
GO
