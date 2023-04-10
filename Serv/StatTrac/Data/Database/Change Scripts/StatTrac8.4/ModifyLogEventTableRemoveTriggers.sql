PRINT 'DROP TRIGGER LogEvent' 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_LogEventInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_LogEventInsert'
	drop trigger [dbo].[tg_LogEventInsert]
END	
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_LogEventUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_LogEventUpdate'
	drop trigger [dbo].[tg_LogEventUpdate]
END
GO

 