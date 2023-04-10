IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetValidTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure GetValidTrackingNumber'
		DROP  Procedure  GetValidTrackingNumber
	END

GO

PRINT 'Creating Procedure GetValidTrackingNumber'
GO  
CREATE PROCEDURE GetValidTrackingNumber
	@CallID						int = Null,
	@ReportGroupID				int = Null,
	@returnVal int OUTPUT
	
	

AS
/******************************************************************************
	
**		File: GetValidTrackingNumber.sql
**		Name: GetValidTrackingNumber
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: QA
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: jth
**		Date: 3/2009
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**     03/2009      jth             initial
**     02/10        jth             added report group id
**	   04/2010		bret			updating to include in release
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
set @returnval = 0


SELECT  @returnVal=count(*) FROM Call INNER JOIN
Referral ON Call.CallID = Referral.CallID
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
WHERE     (Call.CallID = @CallID)    
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)


RETURN @returnVal
GO 