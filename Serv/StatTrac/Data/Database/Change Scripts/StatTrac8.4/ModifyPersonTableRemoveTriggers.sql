 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_PersonInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_PersonInsert' 

	drop trigger [dbo].[tg_PersonInsert]
END
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_PersonUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_PersonUpdate' 

	drop trigger [dbo].[tg_PersonUpdate]
END
GO
