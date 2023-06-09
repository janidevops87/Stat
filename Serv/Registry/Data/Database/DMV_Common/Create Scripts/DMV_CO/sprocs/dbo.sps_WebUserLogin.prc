SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.sps_WebUserLogin    Script Date: 5/14/2007 10:02:43 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_WebUserLogin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_WebUserLogin]
GO




/****** Object:  Stored Procedure dbo.sps_WebUserLogin    Script Date: 5/30/03 ******/
/************************************************
	Email Error Codes

	1 --> New Email already exists
	2 --> Incorrect Login Password
	3 --> Login Email Address Incorrect

***********************************************/

CREATE PROCEDURE sps_WebUserLogin
		@vEmail 		varchar(500)	= null,
		@vPwd			varchar(50)	= null

AS
SET NOCOUNT ON
If @vEmail IS NOT NULL AND @vPwd IS NOT NULL
BEGIN
	If NOT EXISTS (	SELECT * FROM WebUser WHERE Email = @vEmail)
		BEGIN
			-- Insert
			select 0 AS 'WebUserID' , 0 AS 'RegistryID', 0 AS 'Access', 3 as 'ErrorCode'
		END
	ELSE
		BEGIN
		IF EXISTS (SELECT * FROM WebUser WHERE Email = @vEmail AND Pwd = @vPwd)
			BEGIN
				-- Login
				SELECT	WebUserID, RegistryID, Access, 0 as 'ErrorCode'
			        	FROM 		WebUser
				WHERE 	Email = @vEmail
				AND 		Pwd = @vPwd
			END
		ELSE
			BEGIN
				-- Password Error
				select 0 AS 'WebUserID' , 0 AS 'RegistryID', 0 AS 'Access', 2 as 'ErrorCode'
			END
		END
END
ELSE
BEGIN
	select NULL AS 'WebUserID' , NULL AS 'RegistryID', NULL AS 'Access'
END

















GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

