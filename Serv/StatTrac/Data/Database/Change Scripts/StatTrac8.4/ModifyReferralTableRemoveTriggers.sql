
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_ReferralUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN

	PRINT 'DROP TRIGGER tg_ReferralUpdate' 

	drop trigger [dbo].[tg_ReferralUpdate]
END	
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_ReferralInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_ReferralInsert' 
	drop trigger [dbo].[tg_ReferralInsert]
END	
GO
 