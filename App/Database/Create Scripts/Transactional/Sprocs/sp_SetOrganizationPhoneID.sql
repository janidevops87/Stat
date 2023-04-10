IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_SetOrganizationPhoneID')
	BEGIN
		PRINT 'Dropping Procedure sp_SetOrganizationPhoneID';
		DROP Procedure sp_SetOrganizationPhoneID;
	END
GO

PRINT 'Creating Procedure sp_SetOrganizationPhoneID';
GO
CREATE Procedure sp_SetOrganizationPhoneID
AS
/******************************************************************************
**	File: sp_SetOrganizationPhoneID.sql
**	Name: sp_SetOrganizationPhoneID
**	Desc: Updates old Organization.PhoneID with the new field. 
**			This is required for backwards compatability.
**	Auth: Bret Knoll
**	Date: 9/18/2019
**	Called By: SQL Job
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/18/2019		Bret Knoll		Initial Sproc Creation (9376)
*******************************************************************************/

	update Organization 
	set Organization.PhoneID = OrganizationPhone.PhoneID
	from OrganizationPhone  
	join Phone on OrganizationPhone.PhoneID = Phone.PhoneID
	join Organization on OrganizationPhone.OrganizationID = Organization.OrganizationID
	where  Organization.PhoneID is null;

GO
GRANT EXEC ON sp_SetOrganizationPhoneID TO PUBLIC;
GO