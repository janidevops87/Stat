/******************************************************************************
**		File: Modify WebPerson.sql
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
			WHERE     (so.name = N'WebPerson')
			and sc.name in ('LastStatEmployeeID', 'AuditLogTypeID')
	)
BEGIN
	PRINT 'modifying WebPerson'

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
	ALTER TABLE dbo.WebPerson ADD
		LastStatEmployeeID int NULL,
		AuditLogTypeID int NULL

	COMMIT
END


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_WebPersonInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tg_WebPersonInsert]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_WebPersonUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tg_WebPersonUpdate]
GO
