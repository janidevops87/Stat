
PRINT 'DROP TRIGGER ReferralSecondaryData' 

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_ReferralSecondaryDataUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tg_ReferralSecondaryDataUpdate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_ReferralSecondaryDataInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tg_ReferralSecondaryDataInsert]
GO 