PRINT 'DROP TRIGGER DonorData'

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_DonorDataUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_DonorDataUpdate'
	drop trigger [dbo].[tg_DonorDataUpdate]
END	
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tg_DonorDataInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
	PRINT 'DROP TRIGGER tg_DonorDataInsert'
	drop trigger [dbo].[tg_DonorDataInsert]
END	
GO 