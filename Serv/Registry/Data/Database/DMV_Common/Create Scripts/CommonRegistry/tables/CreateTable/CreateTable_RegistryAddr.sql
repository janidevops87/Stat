/******************************************************************************
**		File: CreateTable_RegistryAddr.sql
**		Name: RegistryAddr
**		Desc: Create table: RegistryAddr
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
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'RegistryAddr')
	BEGIN
		PRINT 'Table Exists: RegistryAddr updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: RegistryAddr'
		CREATE TABLE [dbo].[RegistryAddr](
		[RegistryAddrID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryID] [int] NULL,
		[AddrTypeID] [int] NULL,
		[Addr1] [varchar](40) NULL,
		[Addr2] [varchar](20) NULL,
		[City] [varchar](25) NULL,
		[State] [varchar](2) NULL,
		[Zip] [varchar](10) NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END

