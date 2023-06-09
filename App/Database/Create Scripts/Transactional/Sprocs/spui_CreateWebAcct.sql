SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spui_CreateWebAcct]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spui_CreateWebAcct]
GO


CREATE PROCEDURE spui_CreateWebAcct  
	(@personId int = 0,
	@webPersonId int = 0,
	@webPersonName varchar(15) = NULL,
	@webPersonPwd varchar(20) = NULL,
	@orgId int = 0,
	@personTypeId int = 0,
	@personFirst varchar(50) = NULL,
	@personLast varchar(50) = NULL,
	@webAccess int = 0,
	@adminId int = 0)
/*
  Stored proc called by CreateAcctAdmin.sls to update an existing Person/WebPerson set of records,
  or to create new ones, depending on the parameters sent.
  Created 3/18/05 by Scott Plummer

*/
AS

SET NOCOUNT ON

DECLARE @existingPermissions int

-- If a PersonId was sent, this is updating an existing profile
IF @personId > 0 
     BEGIN
	UPDATE Person SET PersonFirst = @personFirst, PersonLast = @personLast, OrganizationId = @orgId, PersonTypeId = @personTypeId, LastModified = GetDate() WHERE PersonId = @personId;
	-- If no WebPersonId was sent, check for an existing WebPerson record
	IF @webPersonId = 0 
	     BEGIN
		SET @webPersonId = (SELECT TOP 1 WebPersonId FROM WebPerson WHERE PersonId = @personId ORDER BY WebPersonLastSessionAccess);
		Print 'AAA WebPersonId: ' + Cast(@webPersonId as varchar)
		-- If an existing match was found, update that record
		IF @webPersonId > 0 --
		     BEGIN
			-- If no change of password was sent, update everything but the password
			IF UPPER(@webPersonPwd) = 'NO_CHANGE'
			     BEGIN
				UPDATE WebPerson SET WebPersonUserName = @webPersonName, LastModified = GetDate(), Access = @webAccess WHERE WebPersonId = @webPersonId;
			     END
			ELSE  -- Update the password, too.
			     BEGIN
				UPDATE WebPerson SET WebPersonUserName = @webPersonName, WebPersonPassword = @webPersonPwd, LastModified = GetDate(), Access = @webAccess WHERE WebPersonId = @webPersonId;
			     END
		     END
		ELSE  -- No existing WebPerson record existed, create a new one
		     BEGIN
			INSERT INTO WebPerson (WebPersonUserName, PersonID, WebPersonPassword, LastModified, Access)
				VALUES (@webPersonName, @personId, @webPersonPwd, GetDate(), @webAccess);
		     END
	     END

	ELSE -- A WebPersonId was sent, update that record
	     BEGIN
		UPDATE WebPerson SET WebPersonUserName = @webPersonName, WebPersonPassword = @webPersonPwd, LastModified = GetDate(), Access = @webAccess WHERE WebPersonId = @webPersonId;
	     END
     END

ELSE  -- No existing PersonId was sent, create new records
     BEGIN
	INSERT INTO Person (PersonFirst, PersonLast, PersonTypeID, OrganizationID, LastModified)
		VALUES (@personFirst, @personLast, @personTypeId, @orgId, GetDate());
	-- Get the PersonId of the newly inserted record
	SET @personId = SCOPE_IDENTITY();
	-- Now create a WebPerson record to match
	INSERT INTO WebPerson (WebPersonUserName, PersonID, WebPersonPassword, LastModified, Access)
		VALUES (@webPersonName, @personId, @webPersonPwd, GetDate(), @webAccess);
	SET @webPersonId = SCOPE_IDENTITY();

     END

-- Now, add website permissions of the @adminId, including the Create Acct Admin, if @webAccess is an Adminstrator.
-- Note: check first to see if permissions were already established for this user.  If so, do not alter permissions.
SET @existingPermissions = (SELECT Count(*) FROM WebPersonPermission WHERE WebPersonId = @webPersonId)

IF @existingPermissions = 0
   BEGIN
	INSERT INTO WebPersonPermission (PermissionId, WebPersonId)
		SELECT WP.PermissionId, @webPersonId AS WebPersonId
		FROM WebPersonPermission WP
		JOIN Permission PE
		ON WP.PermissionId = PE.PermissionId  
		WHERE WP.WebPersonId = @adminId  -- Editor's ID
		AND (PermissionName NOT LIKE '%Admin%' 
			AND PermissionName NOT LIKE '%Intranet%' 
			AND PermissionName NOT LIKE '%Audit%')
		AND WP.PermissionId NOT IN
		(SELECT PermissionId FROM WebPersonPermission WHERE WebPersonId = @webPersonId);

             IF @webAccess = 511  -- If the user was created as an administrator, add "Create Account Admin" permissions
	    BEGIN
		INSERT INTO WebPersonPermission (PermissionId, WebPersonId)
			SELECT PermissionId, @webPersonId AS WebPersonId
			FROM Permission
			WHERE PermissionName = 'Navigation: Create Account Admin'
			OR PermissionName = 'Navigation: Web Person Admin' 
			OR PermissionName = 'Navigation: Administration';

	    END

   END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

