SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetPermission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetPermission]
GO


CREATE PROCEDURE sps_GetPermission 
	@StatEmployeeID			AS INT =NULL,
	@WebPersonID 			AS INT =NULL,
	@PersonID 			AS INT =NULL, 
	@SecurityPermissionsName	AS VARCHAR(255) =NULL

AS

DECLARE @SecurityPermissionsValue AS INT

SELECT @SecurityPermissionsValue = SecurityPermissionsValue  FROM securitypermissions WHERE SecurityPermissionsName = @SecurityPermissionsName

IF ISNULL(@StatEmployeeID, 0) > 0 
BEGIN	
	SELECT	CASE ISNULL(PersonSecurity,0) & @SecurityPermissionsValue
		WHEN @SecurityPermissionsValue
		THEN 	-1 
		ELSE 	0 
		END AS 'Permission'
	FROM Person P
	JOIN StatEmployee SE ON SE.PersonID = P.PersonID
	WHERE SE.StatEmployeeID = @StatEmployeeID
END
ELSE IF ISNULL(@WebPersonID, 0) > 0
BEGIN	
	SELECT	CASE ISNULL(PersonSecurity,0) & @SecurityPermissionsValue
		WHEN @SecurityPermissionsValue
		THEN 	-1 
		ELSE 	0 
		END AS 'Permission'
	FROM Person P
	JOIN WebPerson WP ON WP.PersonID = P.PersonID
	WHERE WP.WebPersonID = @WebPersonID
	
END
ELSE IF ISNULL(@PersonID, 0) > 0
BEGIN	
	SELECT	CASE ISNULL(PersonSecurity,0) & @SecurityPermissionsValue
		WHEN @SecurityPermissionsValue
		THEN 	-1 
		ELSE 	0 
		END AS 'Permission'
	FROM Person P
	WHERE P.PersonID = @PersonID
	
END
ELSE
BEGIN
	SELECT 0 AS 'Permission'
END

-- select * from securitypermissions
-- SELECT 5 & 2


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

