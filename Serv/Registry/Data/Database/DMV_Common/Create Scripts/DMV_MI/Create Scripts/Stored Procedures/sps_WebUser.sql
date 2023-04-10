
CREATE PROCEDURE sps_WebUser
  @Access   INT = 0

/* Gets a list of users, given an access level, with that level of access or above */
/* Modified 2/17/05 - SAP */
AS

SET NOCOUNT ON

If @Access <> 0
	BEGIN
		-- Commented out previous logic allowing registry access. 2/17/05 - SAP
		-- SELECT * FROM WebUser, Registry
		-- WHERE Access & @Access <> 0 
 		-- AND WebUser.RegistryID *= Registry.ID

		SELECT * FROM WebUser WU
		WHERE WU.Access = @Access
		AND WU.pwd <> 'seeya'
		ORDER BY Email;
	END
GO
