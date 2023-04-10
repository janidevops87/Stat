 /* Script to replicate WebUsers from another NEOB site
	ccarroll 06/08/2009
*/
USE DMV_VT
GO


SET IDENTITY_INSERT WebUser ON
GO

IF (SELECT Count(*) FROM WebUser) = 0
BEGIN
	INSERT INTO WebUser (WebUserID, Email, Pwd, RegistryID,Access)
	SELECT WebUserID, Email, Pwd, RegistryID, Access FROM DMV_ME.dbo.WebUser ORDER By WebUserID
END

SET IDENTITY_INSERT WebUser OFF 
GO

SELECT * FROM WebUser

