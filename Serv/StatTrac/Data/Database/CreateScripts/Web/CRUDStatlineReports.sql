 -- ===============================================
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ReportRule_Roles]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[reportrules] DROP CONSTRAINT FK_ReportRule_Roles
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UserRoles_Role]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT FK_UserRoles_Role
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Profiles_WebLogin]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Profiles] DROP CONSTRAINT FK_Profiles_WebLogin
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UserRoles_WebLogin]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT FK_UserRoles_WebLogin
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddProfile]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AddUserToRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[AddUserToRoleByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteProfile]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteRoleByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DeleteUserByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[DeleteUserByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetProfile]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetRolesByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetRolesByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUserInRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetUserInRoleByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RemoveUserFromRoleByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[RemoveUserFromRoleByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ChangePasswordById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ChangePasswordById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ChangePasswordByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ChangePasswordByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetAllRoles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetAllRoles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetAllUsers]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetAllUsers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetPassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetPassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetRoleIdByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetRoleIdByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetUserIdByName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetUserIdByName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertRole]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[InsertRole]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[InsertUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateRoleById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateRoleById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateUserById]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[UpdateUserById]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetProfileColumnSize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GetProfileColumnSize]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Profiles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Profiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UserRoles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[UserRoles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Roles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Roles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Users]
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Roles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
CREATE TABLE [dbo].[Roles] (
	[RoleID] [int] IDENTITY (1, 1) NOT NULL ,
	[RoleName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
END

GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
CREATE TABLE [dbo].[Users] (
	[UserID] [int] IDENTITY (1, 1) NOT NULL ,
	[UserName] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Password] [varbinary] (64) NOT NULL 
) ON [PRIMARY]
END

GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Profiles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
CREATE TABLE [dbo].[Profiles] (
	[ProfileID] [int] IDENTITY (1, 1) NOT NULL ,
	[WebPersonID] [int] NOT NULL ,
	[Profile] [binary] (4096) NULL 
) ON [PRIMARY]
END

GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UserRoles]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
CREATE TABLE [dbo].[UserRoles] (
	[WebPersonID] [int] NOT NULL ,
	[RoleID] [int] NOT NULL 
) ON [PRIMARY]
END

GO

ALTER TABLE [dbo].[Roles] WITH NOCHECK ADD 
	CONSTRAINT [PK_Role] PRIMARY KEY  CLUSTERED 
	(
		[RoleID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Users] WITH NOCHECK ADD 
	CONSTRAINT [PK_Users] PRIMARY KEY  CLUSTERED 
	(
		[UserID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Profiles] WITH NOCHECK ADD 
	CONSTRAINT [PK_Profile] PRIMARY KEY  CLUSTERED 
	(
		[ProfileID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[UserRoles] WITH NOCHECK ADD 
	CONSTRAINT [PK_UserRoles] PRIMARY KEY  CLUSTERED 
	(
		[WebPersonID],
		[RoleID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Roles] WITH NOCHECK ADD 
	CONSTRAINT [IX_Role] UNIQUE  NONCLUSTERED 
	(
		[RoleName]
	)  ON [IDX] 
GO

ALTER TABLE [dbo].[Users] WITH NOCHECK ADD 
	CONSTRAINT [IX_Users_Name] UNIQUE  NONCLUSTERED 
	(
		[UserName]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Profiles] ADD 
	CONSTRAINT [FK_Profiles_WebLogin] FOREIGN KEY 
	(
		[WebPersonID]
	) REFERENCES [dbo].[WebPerson] (
		[WebPersonID]
	)
GO

ALTER TABLE [dbo].[UserRoles] ADD 
	CONSTRAINT [FK_UserRoles_Role] FOREIGN KEY 
	(
		[RoleID]
	) REFERENCES [dbo].[Roles] (
		[RoleID]
	),
	CONSTRAINT [FK_UserRoles_WebLogin] FOREIGN KEY 
	(
		[WebPersonID]
	) REFERENCES [dbo].[WebPerson] (
		[WebPersonID]
	)
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetProfileColumnSize
	@profileSize int OUT
AS

SELECT @profileSize = CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.Columns 
WHERE 
	TABLE_NAME = 'Profiles' AND
	COLUMN_NAME = 'Profile'




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.ChangePasswordById
	@userId	int,
	@password	varbinary(64)
AS

	UPDATE WebPerson
	SET WebPersonPassword = @password
	WHERE WebPersonID = @userId

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.ChangePasswordByName
	@name nvarchar(256),
	@password varbinary(64)
AS

	select @password = IsNull(@password, 0xFFFF)

	UPDATE WebPerson
	SET WebPersonPassword = @password
	WHERE WebPersonUserName = @name

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetAllRoles
AS

	SET NOCOUNT ON
	
	SELECT
		RoleID, 
		RoleName
	FROM 
		Roles
	ORDER BY
		RoleName





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetAllUsers
AS

	SET NOCOUNT ON
	
	SELECT WebPersonUserName AS UserName
	FROM WebPerson




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetPassword
	@name nvarchar(256)
AS
	SET NOCOUNT ON

	SELECT	
		CONVERT(VARBINARY(64),WebPersonPassword) AS Password
	FROM WebPerson
	WHERE WebPersonUserName = @name

	SET NOCOUNT OFF

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetRoleIdByName
	@name	nvarchar(256),
	@roleID int OUT
AS

	SELECT @roleID = RoleID 
	FROM Roles 
	WHERE RoleName = @name

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetUserIdByName
	@name nvarchar(256),
	@userId int OUT
AS

	SELECT @userId = WebPersonID
	FROM WebPerson
	WHERE WebPersonUserName = @name

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.InsertRole
	@name	nvarchar(256)
AS

	INSERT INTO Roles
		(RoleName)
	VALUES
		(@name)

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.InsertUser
	@name nvarchar(256),
	@password varbinary(64),
	@userExists tinyint out
AS

IF EXISTS (SELECT WebPersonUserName FROM WebPerson WHERE WebPersonUserName = @name)
BEGIN
	SELECT @userExists = 1
	RETURN
END

SELECT @userExists = 0

SELECT @password = IsNull(@password, 0x691B0FBEED8F399F7E12576B090B217E4AD88A09)

INSERT INTO WebPerson
	(WebPersonUserName, WebPersonPassword)
VALUES
	(@name, @password)

RETURN 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.UpdateRoleById
	@roleID int,
	@roleName nvarchar(256)
AS

	UPDATE Roles
	SET RoleName = @roleName
	WHERE RoleID = @roleID

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.UpdateUserById
	@userId int,
	@name nvarchar(256)
AS

	UPDATE WebPerson
	SET WebPersonUserName = @name
	WHERE WebPersonID = @userId

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.AddProfile
	@userName nvarchar(256),
	@profile binary(4096)
AS

	DECLARE @userId int 

	EXEC GetUserIdByName @userName, @userId OUT

	INSERT Profiles 
		(WebPersonID, [profile])
	VALUES
		(@userId, @profile)




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.AddUserToRoleByName
	@name nvarchar(256),
	@roleName nvarchar(256)
AS
DECLARE @userId int, @roleID int

EXEC GetUserIdByName @name, @userId OUT
EXEC GetRoleIdByName @roleName, @roleID OUT
IF (ISNULL(@userId, 0) <> 0 AND ISNULL(@roleID , 0) <> 0)
BEGIN
	INSERT INTO UserRoles
		(WebPersonID, RoleID)
	VALUES
		(@userId, @roleID)
END	



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





CREATE PROCEDURE dbo.DeleteProfile
	@userName nvarchar(256)
AS

	DECLARE @userId int 

	EXEC GetUserIdByName @userName, @userId OUT

	DELETE Profiles 
	WHERE WebPersonID = @userId





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.DeleteRoleByName
	@name nvarchar(256)
AS

	DECLARE @roleID int, @firstOpError tinyint

	EXEC GetRoleIdByName @name, @roleID OUT

	IF (@roleID IS NULL) RAISERROR('No Role with that name', 16, 99)

	BEGIN
		BEGIN TRANSACTION
		 
		DELETE FROM UserRoles 
		WHERE RoleID = @roleID
		select @firstOpError = @@ERROR
		
		DELETE FROM Roles 
		WHERE RoleID = @roleID

		IF (@@ERROR = 0) AND (@firstOpError = 0)
			COMMIT
		ELSE
			ROLLBACK
	END
	
RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.DeleteUserByName
	@name nvarchar(256)
AS

	DECLARE @userId int, @errorFound tinyint
	Select @errorFound = 0
	
	BEGIN TRANSACTION

	EXEC GetUserIdByName @name, @userId OUT
	IF @@ERROR > 0 SET @errorFound = 1
		
	DELETE UserRoles
	WHERE WebPersonID = @userId
	IF @@ERROR > 0 SET @errorFound = 1
	
	DELETE Profiles
	WHERE WebPersonID = @userId
	IF @@ERROR > 0 SET @errorFound = 1
		
	DELETE FROM WebPerson 
	WHERE WebPersonID = @userId

	IF (@@ERROR > 0) OR (@errorFound > 0)
		ROLLBACK
	ELSE
		COMMIT
	
RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetProfile
	@userName nvarchar(256),
	@profile binary(4096) OUT
AS

	DECLARE @userId int 

	EXEC GetUserIdByName @userName, @userId OUT

	SELECT 
		@profile = [Profile]
	FROM Profiles 
	WHERE WebPersonID = @userId




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetRolesByName
	@name nvarchar(256)
AS

	DECLARE @userId int

	EXEC GetUserIdByName @name, @userId OUT

	SELECT 
		Roles.RoleID, 
		Roles.RoleName
	FROM WebPerson
		JOIN UserRoles
		ON WebPerson.WebPersonID = UserRoles.WebPersonID
		JOIN Roles
		ON UserRoles.RoleID = Roles.RoleID
	WHERE WebPerson.WebPersonID = @userId

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.GetUserInRoleByName
	@roleName nvarchar(256)
AS

	DECLARE @roleID int

	EXEC GetRoleIdByName @roleName, @roleID OUT

	SELECT WebPerson.WebPersonID AS UserID, WebPerson.WebPersonUserName AS UserName
	FROM Roles 
		JOIN UserRoles
			ON Roles.RoleID = UserRoles.RoleID
		JOIN WebPerson
			ON UserRoles.WebPersonID = WebPerson.WebPersonID
	WHERE Roles.RoleID = @roleID

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE dbo.RemoveUserFromRoleByName
	@username nvarchar(256),
	@roleName nvarchar(256)
AS

	DECLARE @userId int
	DECLARE @roleID int

	EXEC GetUserIdByName @username, @userId OUT
	if ( @userId IS NULL ) RAISERROR(@username, 16, 99)
	
	EXEC GetRoleIdByName @roleName, @roleID OUT
	if (@roleID IS NULL) RAISERROR(@roleName, 16, 98);

	DELETE FROM UserRoles
	WHERE WebPersonID = @userId
	AND RoleID = @roleID

RETURN



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

-- =======================================================
-- Populate database with intial data
-- =======================================================

EXEC InsertRole "User"
GO
EXEC InsertRole "Administrator"
GO
EXEC InsertRole "AdminUser"
GO
EXEC InsertRole "ClientAdmin"
GO
EXEC InsertRole "ClientServices"
GO
