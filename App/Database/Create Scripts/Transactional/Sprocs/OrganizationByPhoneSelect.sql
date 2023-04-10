 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationByPhoneSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationByPhoneSelect'
		DROP Procedure OrganizationByPhoneSelect
	END
GO

PRINT 'Creating Procedure OrganizationByPhoneSelect'
GO
CREATE Procedure OrganizationByPhoneSelect
(		
		@PhoneAreaCode NVARCHAR(3),
		@PhonePrefix NVARCHAR(3),
		@PhoneNumber NVARCHAR(4),
		@PhonePin NVARCHAR(10) = NULL
) 
AS
/******************************************************************************
**	File: OrganizationByPhoneSelect.sql
**	Name: OrganizationByPhoneSelect
**	Desc: Searches OrganizationPhone and ReferralCallerPhoneID for associated numbers.
**	Auth: Bret Knoll
**	Date: 6/2/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	6/2/2011		Bret Knoll			    Initial Sproc Creation WI 11667
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	IF LEN(@PhonePin) = 0 
	BEGIN
		SET @PhonePin = NULL
	END;

	DECLARE @OrgPhone TABLE
	(
			OrganizationID INT,
			OrganizationName NVARCHAR(80),
			SubLocationID INT,
			SubLocationLevel VARCHAR(5), 
			PhoneID INT,
			Inactive BIT
	)
	INSERT @OrgPhone	
		SELECT 
			Organization.OrganizationID,
			Organization.OrganizationName,
			COALESCE(OrganizationPhone.SubLocationID, 0),
			OrganizationPhone.SubLocationLevel, 
			OrgsPhone.PhoneID,
			Case 
				WHEN COALESCE(OrganizationPhone.Inactive, 0) = 1 OR COALESCE(OrgsPhone.Inactive, 0) = 1 
				THEN 1
				ELSE 0
			END
		FROM 
			Organization (nolock)
		JOIN OrganizationPhone  (nolock) ON Organization.OrganizationID = OrganizationPhone.OrganizationID
		JOIN Phone OrgsPhone (nolock) ON OrganizationPhone.PhoneID = OrgsPhone.PhoneID
		WHERE 
		(
			OrgsPhone.PhoneAreaCode = @PhoneAreaCode 
		AND OrgsPhone.PhonePrefix = @PhonePrefix 
		AND OrgsPhone.PhoneNumber = @PhoneNumber
		AND COALESCE(OrgsPhone.PhonePin, 0) = COALESCE(@PhonePin, COALESCE(OrgsPhone.PhonePin, 0) )
		)	
		

	SELECT 
		OrgPhone.OrganizationID, 
		OrgPhone.OrganizationName, 
		OrgPhone.SubLocationID, 
		OrgPhone.SubLocationLevel,
		OrgPhone.PhoneID,
		OrgPhone.Inactive
	FROM 
		@OrgPhone OrgPhone;
	
	GO

GRANT EXEC ON OrganizationByPhoneSelect TO PUBLIC
GO
