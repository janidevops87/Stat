 

PRINT 'DROP TRIGGER NOK' 
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_NOKInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'drop trigger tg_NOKInsert'
	drop trigger [dbo].[tg_NOKInsert]
END	
GO