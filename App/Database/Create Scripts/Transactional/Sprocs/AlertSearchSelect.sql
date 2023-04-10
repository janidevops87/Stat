

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertSearchSelect')
	BEGIN
		PRINT 'Dropping Procedure AlertSearchSelect'
		DROP Procedure AlertSearchSelect
	END
GO

PRINT 'Creating Procedure AlertSearchSelect'
GO
CREATE Procedure AlertSearchSelect 
(
		@OrganizationID int,
		@SourceCodeID int
)
AS
/******************************************************************************
**	File: AlertSearchSelect.sql
**	Name: AlertSearchSelect
**	Desc: Selects multiple rows of Alert Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
**  06/14/2011		ccarroll			Added AlertTypeID to only search referrals
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	DECLARE @AlertID int = 0
	DECLARE @AlertTable Table
	(
		AlertID int
	)
	
	INSERT @AlertTable
	SELECT AlertOrganization.AlertID
	FROM AlertOrganization 
	JOIN AlertSourceCode ON AlertSourceCode.AlertID = AlertOrganization.AlertID 
	JOIN Alert ON AlertOrganization.AlertId = Alert.AlertId 
	WHERE AlertOrganization.OrganizationID = @OrganizationID 
	AND AlertSourceCode.SourceCodeID = @SourceCodeID

	-- take the first
	SELECT TOP 1 @AlertID = AlertID FROM @AlertTable
	
	IF (@AlertID > 0 )
	BEGIN
		EXEC AlertSelectDataSet @AlertID = @AlertID
	END

	
GO

GRANT EXEC ON AlertSearchSelect TO PUBLIC
GO
