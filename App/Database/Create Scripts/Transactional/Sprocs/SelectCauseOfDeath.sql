

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectCauseOfDeath')
	BEGIN
		PRINT 'Dropping Procedure SelectCauseOfDeath'
		PRINT GETDATE()
		DROP Procedure SelectCauseOfDeath
	END
GO

PRINT 'Creating Procedure SelectCauseOfDeath'
PRINT GETDATE()
GO
CREATE Procedure SelectCauseOfDeath
(
		@CauseOfDeathID int = null output					
)
AS
/******************************************************************************
**	File: SelectCauseOfDeath.sql
**	Name: SelectCauseOfDeath
**	Desc: Selects multiple rows of CauseOfDeath Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CauseOfDeath.CauseOfDeathID,
		CauseOfDeath.CauseOfDeathName,
		CauseOfDeath.CauseOfDeathOrganPotential,
		CauseOfDeath.CauseOfDeathCoronerCase,
		CauseOfDeath.Verified,
		CauseOfDeath.Inactive,
		CauseOfDeath.LastModified,
		CauseOfDeath.UpdatedFlag
	FROM 
		dbo.CauseOfDeath 

	WHERE 
		CauseOfDeath.CauseOfDeathID = ISNULL(@CauseOfDeathID, CauseOfDeath.CauseOfDeathID)				

GO

GRANT EXEC ON SelectCauseOfDeath TO PUBLIC
GO
