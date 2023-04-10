 /******************************************************************************
**		File: DropAuditTrailPublication.sql
**		Name: DropAuditTrailPublication
**		Desc: This Script will create the AuditTrail Publications
**		
**              
**		Auth: Bret Knoll
**		Date: 6/4/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		06/04/07	Bret Knoll			initial	
**    
*******************************************************************************/
 --use [_ReferralDev2]


-- Dropping the transactional articles
exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Call', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Call', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'CallCustomField', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'CallCustomField', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'DonorData', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'DonorData', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'FSCase', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'FSCase', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'LogEvent', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'LogEvent', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Message', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Message', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'NOK', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'NOK', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Organization', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Organization', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Person', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Person', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Referral', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Referral', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'ReferralSecondaryData', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'ReferralSecondaryData', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'RegistryStatus', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'RegistryStatus', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Secondary', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Secondary', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Secondary2', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'Secondary2', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryApproach', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryApproach', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryDisposition', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryDisposition', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryMedication', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryMedication', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryMedicationOther', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryMedicationOther', 
	
	
	@force_invalidate_snapshot = 1
GO

exec sp_dropsubscription 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryTBI', 
	
	
	@subscriber = N'all', 
	
	
	@destination_db = N'all'
exec sp_droparticle 
	
	
	@publication = N'AudiTrail', 
	
	
	@article = N'SecondaryTBI', 
	
	
	@force_invalidate_snapshot = 1
GO

-- Dropping the transactional publication
exec sp_droppublication 
	
	
	@publication = N'AudiTrail'
GO

