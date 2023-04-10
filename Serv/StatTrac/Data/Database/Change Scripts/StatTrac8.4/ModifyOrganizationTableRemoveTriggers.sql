



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_OrganizationInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_OrganizationInsert' 
	drop trigger [dbo].[tg_OrganizationInsert]
END	
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_OrganizationUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_OrganizationUpdate' 
	drop trigger [dbo].[tg_OrganizationUpdate]
END	
GO 