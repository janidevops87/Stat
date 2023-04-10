/******************************************************************************
**		File: CreateTable_RegistryOwnerGrantedAccess.sql
**		Name: RegistryOwnerGrantedAccess
**		Desc: Create table: RegistryOwnerGrantedAccess
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	ccarroll			initial
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'RegistryOwnerGrantedAccess')
	BEGIN
		PRINT 'Table Exists: RegistryOwnerGrantedAccess updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: RegistryOwnerGrantedAccess'
		CREATE TABLE [dbo].[RegistryOwnerGrantedAccess](
		[RegistryOwnerGrantedAccessID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryOwnerID] [int] NOT NULL,
		[RegistryGrantedOwnerID] [int] NOT NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

