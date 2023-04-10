
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_CallUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_CallUpdate'
	drop trigger [dbo].[tg_CallUpdate]
END	
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_CallInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
PRINT 'DROP TRIGGER tg_CallInsert'
drop trigger [dbo].[tg_CallInsert]
END
GO 