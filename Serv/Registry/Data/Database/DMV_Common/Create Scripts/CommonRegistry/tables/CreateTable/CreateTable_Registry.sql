/******************************************************************************
**		File: CreateTable_Registry.sql
**		Name: Registry
**		Desc: Create table: Registry
**
**		Auth: ccarroll
**		Date: 02/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      02/19/2009	ccarroll			initial
**		02/28/2012	ccarroll			Added RegisteredByID
**		03/13/2012  ccarroll			Added for inclusion in release
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'Registry')
	BEGIN
		PRINT 'Table Exists: Registry updating..'
		/*** Add Table script changes here ***/
			-- check if RegisteredByMobile
		IF NOT EXISTS (
			select * from syscolumns where id = OBJECT_ID(N'[dbo].[Registry]')
			AND syscolumns.name = 'RegisteredByID'
			)
		BEGIN
			PRINT 'ALTERING TABLE Registry Adding Column RegisteredByID'
			ALTER TABLE Registry
				ADD RegisteredByID int NOT NULL Default(1)
		END

		
	END
  ELSE 
	BEGIN
	PRINT 'Creating Table: Registry'
		CREATE TABLE [dbo].[Registry](
		[RegistryID] [int] IDENTITY(1,1) NOT NULL,
		[RegistryOwnerID] [int] NULL,
		[SSN] [varchar](11) NULL,
		[DOB] [datetime] NULL,
		[FirstName] [varchar](20) NULL,
		[MiddleName] [varchar](20) NULL,
		[LastName] [varchar](25) NULL,
		[Suffix] [varchar](4) NULL,
		[Gender] [varchar](1) NULL,
		[Race] [int] NULL,
		[EyeColor] [varchar](5) NULL,
		[Phone] [varchar](10) NULL,
		[Email] [varchar](100) NULL,
		[Comment] [varchar](200) NULL,
		[Limitations] [varchar](1000) NULL,
		[LimitationsOther] [varchar](1000) NULL,
		[License] [varchar](9) NULL,
		[Donor] [bit] NOT NULL,
		[DonorConfirmed] [bit] NOT NULL,
		[OnlineRegDate] [datetime] NULL,
		[SignatureDate] [datetime] NULL,
		[MailerDate] [datetime] NULL,
		[DeleteFlag] [bit] NOT NULL,
		[DeceaseDate] [datetime] NULL,
		[PreviousDonor] [bit] NULL,
		[PreviousDonorConfirmed] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeID] [int] NULL,
		[AuditLogTypeID] [int] NULL
		)
	END
