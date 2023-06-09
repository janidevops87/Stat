

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectPhoneTypesByPersonID')
	BEGIN
		PRINT 'Dropping Procedure SelectPhoneTypesByPersonID';
		PRINT GETDATE();
		DROP Procedure SelectPhoneTypesByPersonID;
	END
GO

PRINT 'Creating Procedure SelectPhoneTypesByPersonID';
PRINT GETDATE();
GO
CREATE Procedure SelectPhoneTypesByPersonID
(
		@PersonID int
)
AS
/******************************************************************************
**	File: SelectPhoneTypesByPersonID.sql
**	Name: SelectPhoneTypesByPersonID
**	Desc: Select phone types by PersonID
**	Auth: Mike Berenson
**	Date: 12/30/2019
**	Called By: StatQuery.QueryPersonPhone
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/30/2019		Mike Berenson			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT p.PhoneID, 
		CASE p.PhoneTypeId 
			WHEN 11 THEN pp.PhoneAlphaPagerEmail 
			ELSE '(' + ISNULL(p.PhoneAreaCode,'') + ') ' + ISNULL(p.PhonePrefix,'') + '-' + ISNULL(p.PhoneNumber,'') + '  ' + ISNULL(pp.PersonPhonePIN,'') END AS DispPhone, 
		pt.PhoneTypeName,
		pp.AutoResponse
	FROM Phone p, PersonPhone pp, PhoneType pt
	WHERE p.PhoneTypeID = pt.PhoneTypeID 
	AND p.PhoneID = pp.PhoneID 
	AND pp.PersonID = @PersonId;
	
GO

GRANT EXEC ON SelectPhoneTypesByPersonID TO PUBLIC;
GO
