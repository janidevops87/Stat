IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetInitialApproacherList')
	BEGIN
		PRINT 'Dropping Procedure GetInitialApproacherList'
		DROP  Procedure  GetInitialApproacherList
	END

GO

PRINT 'Creating Procedure GetInitialApproacherList'
GO   
CREATE Procedure GetInitialApproacherList

	
	@callID	int = Null
	
	
AS
/******************************************************************************
**		File: GetInitialApproacherList.sql
**		Name: GetInitialApproacherList
**		Desc: 
**
**		Called by:   
**              
**
**		Auth: jth
**		Date: 07/2008
*******************************************************************************
**		Change History
*******************************************************************************
**	  Date:		Author:		Description:
**	  --------	--------	-------------------------------------------
**    7/2008	jth			Initial
**    10/2008   jth         changed sql completely
*******************************************************************************/ 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 


SELECT 
Person.PersonID, 
Person.PersonFirst+RTRIM(' '+(ISNULL(PersonMI,'')))+' '+PersonLast approacher
FROM Person WHERE 

Person.OrganizationID in (
	(
	SELECT     ReferralCallerOrganizationID
							FROM         Referral
								WHERE     (CallID = @callID)
	)
	union
	SELECT  
		ScheduleGroup.OrganizationID
	FROM ScheduleGroup
	JOIN ScheduleGroupOrganization ON ScheduleGroupOrganization.ScheduleGroupID = ScheduleGroup.ScheduleGroupID 
	JOIN ScheduleGroupSourceCode ON ScheduleGroupSourceCode.ScheduleGroupID = ScheduleGroupOrganization.ScheduleGroupID 
	WHERE 
		ScheduleGroupOrganization.OrganizationID = 
							(
							SELECT     ReferralCallerOrganizationID
							FROM         Referral
							WHERE     (CallID = @callID))
	AND 
		ScheduleGroupSourceCode.SourceCodeID = (select SourceCodeID from call where callid = @callID )

)

 AND Person.Inactive <> 1 
order by 2


GO