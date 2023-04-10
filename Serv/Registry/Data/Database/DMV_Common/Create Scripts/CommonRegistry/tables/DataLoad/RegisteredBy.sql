/******************************************************************************
**		File: RegisteredBy.sql
**		Name: RegisteredBy
**		Desc: Data load for RegisteredBy
**
**		Auth: ccarroll
**		Date: 02/28/2012 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**      02/28/2012	ccarroll	initial
**		03/13/2012	ccarroll	Added for inclusion in release
*******************************************************************************/

DECLARE @RegisteredByID int,
		@Name nvarchar(100)

SET IDENTITY_INSERT RegisteredBY ON

SET @RegisteredByID = 1
SET @Name = 'Web'
 IF (SELECT COUNT(*) FROM RegisteredBy WHERE RegisteredByID = @RegisteredByID) < 1
	BEGIN
		PRINT 'Adding ' + @Name + ' to RegisteredBy table'
		INSERT RegisteredBy
		(
			RegisteredByID,
			Name,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		) VALUES
		(
			@RegisteredByID,
			@Name,
			GETDATE(), -- CreateDate,
			GETDATE(), --LastModified,
			1100, --LastStatEmployeeID,
			1 --AuditLogTypeID = Create
		)
	END

SET @RegisteredByID = 2
SET @Name = 'Mobile'
 IF (SELECT COUNT(*) FROM RegisteredBy WHERE RegisteredByID = @RegisteredByID) < 1
	BEGIN
		PRINT 'Adding ' + @Name + ' to RegisteredBy table'
		INSERT RegisteredBy
		(
			RegisteredByID,
			Name,
			CreateDate,
			LastModified,
			LastStatEmployeeID,
			AuditLogTypeID
		) VALUES
		(
			@RegisteredByID,
			@Name,
			GETDATE(), -- CreateDate,
			GETDATE(), --LastModified,
			1100, --LastStatEmployeeID,
			1 --AuditLogTypeID = Create
		)
	END
SET IDENTITY_INSERT RegisteredBY OFF
	