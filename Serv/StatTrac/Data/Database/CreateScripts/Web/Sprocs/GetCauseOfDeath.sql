IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetCauseOfDeath')
	BEGIN
		PRINT 'Dropping Procedure GetCauseOfDeath'
		DROP  Procedure  GetCauseOfDeath
	END

GO

PRINT 'Creating Procedure GetCauseOfDeath'
GO
CREATE Procedure GetCauseOfDeath
	
AS

/******************************************************************************
**		File: GetCauseOfDeath.sql
**		Name: GetCauseOfDeath
**		Desc: get the Cause of Death List from the CauseOfDeath table
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 09/10/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		09/10/2007	Bret Knoll			Referral Summary Release
*******************************************************************************/


SELECT 
	CauseOfDeathID,
	CauseOfDeathName

FROM 
	CauseofDeath
WHERE
	Inactive = 0

GO

GRANT EXEC ON GetCauseOfDeath TO PUBLIC

GO
