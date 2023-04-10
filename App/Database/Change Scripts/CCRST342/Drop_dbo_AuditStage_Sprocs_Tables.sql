/******************************************************************************
**		File: Drop_dbo_AuditStage_Sprocs_Tables.sql
**		Name: Drop dbo AuditStage Sprocs and Tables
**		Desc: Drop dbo.AuditStage_ tables and the sprocs that reference them
**				because both tables and sprocs aren't used anymore
**
**		Auth: Mike Berenson
**		Date: 04/22/2021
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      04/22/2021	Mike Berenson		initial
*******************************************************************************/

-- Drop Sprocs

DROP PROCEDURE IF EXISTS [dbo].[AuditTrailStuff];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditSecondaryProcess];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditAlertProcess];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditAlertSave];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditBuildProcessQuery];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditLogEventDelete];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditLogEventProcess];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditLogEventSave];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditReferralDelete];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditReferralProcess];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditReferralSave];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditSecondaryDelete];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditSecondaryMedicationProcess];
GO

DROP PROCEDURE IF EXISTS [dbo].[spu_AuditSecondarySave];
GO

--Drop Tables

DROP TABLE IF EXISTS [dbo.[AuditStage_Alert];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_AlertOrganization];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_AlertSourceCode];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_LogEvent];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_Referral];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_Secondary];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_Secondary2];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_SecondaryApproach];
GO

DROP TABLE IF EXISTS [dbo.[AuditStage_SecondaryMedication];
GO
