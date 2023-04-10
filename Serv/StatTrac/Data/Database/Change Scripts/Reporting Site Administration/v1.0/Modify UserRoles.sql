/******************************************************************************
**		File: Modify UserRoles.sql
**		Desc: 
**
**		Auth: Bret Knoll
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------	
**		11/12/07	Bret Knoll			initial
**    
*******************************************************************************/ 

IF NOT EXISTS(
			SELECT     so.*

			FROM         sysobjects so
			join syscolumns sc on sc.id = so.id
			WHERE     (so.name = N'UserRoles')
			and sc.name in ('LastStatEmployeeID', 'AuditLogTypeID', 'LastModified', 'Inactive')
	)
BEGIN
	BEGIN TRANSACTION
	SET QUOTED_IDENTIFIER ON
	SET ARITHABORT ON
	SET NUMERIC_ROUNDABORT OFF
	SET CONCAT_NULL_YIELDS_NULL ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	COMMIT
	BEGIN TRANSACTION
	ALTER TABLE dbo.UserRoles ADD
		LastStatEmployeeID int NULL,
		AuditLogTypeID int NULL,
		LastModified datetime	
	COMMIT
 END