/******************************************************************************
**		File: CreateTable_RegistryOwnerUserOrg.sql
**		Name: RegistryOwnerStateConfig
**		Desc: Create table: RegistryOwnerUserOrg
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      05/19/2009	ccarroll			initial
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'RegistryOwnerUserOrg')
	BEGIN
		PRINT 'Table Exists: RegistryOwnerUserOrg updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: RegistryOwnerUserOrg'
		CREATE TABLE [dbo].[RegistryOwnerUserOrg](
		[RegistryOwnerUserOrgID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryOwnerID] [int] NULL,
		[UserOrgID] [int] NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

