SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserUpSert    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserUpSert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserUpSert]
GO




/****** Object:  Stored Procedure dbo.sps_WebUserUpSert    Script Date: 5/30/03 ******/

/************************************************
	Email Error Codes

	1 --> New Email already exists
	2 --> Incorrect Login Password
	3 --> Login Email Address Incorrect

***********************************************/
CREATE PROCEDURE sps_WebUserUpSert
		@vEmail 		varchar(500)	= null,
		@vPwd			varchar(50)	= null,
		@vEmailOld 		varchar(500)	= null,
		@vPwdOld		varchar(50)	= null

AS

If @vEmailOld IS NOT NULL AND @vPwdOld IS NOT NULL
-- Update
BEGIN
	If NOT EXISTS (	SELECT WebUserID FROM WebUser WHERE Email = @vEmail)
	BEGIN
		If NOT EXISTS (	SELECT WebUserID FROM WebUser WHERE Email = @vEmailOld)
		BEGIN
			-- Print 'Email Address Incorrect'
			SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access', 3 as 'ErrorCode'
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT WebUserID FROM WebUser WHERE Email = @vEmailOld AND Pwd = @vPwdOld)
			BEGIN
				-- Update
				Update WebUser
				Set Email = @vEmail, Pwd = @vPwd
				WHERE WebUserID = 
				(
					SELECT	WebUserID
				        	FROM 		WebUser
					WHERE 	Email = @vEmailOld
					AND 		Pwd = @vPwdOld
				)
			
				SELECT 	WebUserID, RegistryID, Access, 0 as 'ErrorCode'
				FROM 		WebUser
				WHERE 	Email = @vEmail
				AND 		Pwd = @vPwd
			END
			ELSE
			BEGIN
				-- Print 'Incorrect Password'
				SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access',  2 as 'ErrorCode'
			END
		END
	END
	ELSE
	BEGIN
		--Print 'Email already exists'
		SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access', 1 as 'ErrorCode'
	END
END
ELSE
BEGIN
	If NOT EXISTS (	SELECT WebUserID FROM WebUser WHERE Email = @vEmail)
	BEGIN
		exec spi_WebUser @vEmail, @vPwd
		SELECT 	WebUserID, RegistryID, Access, 0 as 'ErrorCode'
		FROM 		WebUser
		WHERE 	Email = @vEmail
		AND 		Pwd = @vPwd		
	END
	ELSE
	BEGIN
		--Print 'New Email already exists'
		SELECT 0 as 'WebUserID', 0 as 'RegistryID', 0 as 'Access', 1 as 'ErrorCode'
	END
END








GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

