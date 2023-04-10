
PRINT 'DROP TRIGGER Message' 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_MessageInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_MessageUpdate'
	drop trigger [dbo].[tg_MessageInsert]
END	
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_MessageUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_MessageUpdate'
	drop trigger [dbo].[tg_MessageUpdate]
END	
GO 