/******************************************************************************
**		File: CreateTable_RegistryDlaResponseItem.sql
**		Name: RegistryDla
**		Desc: Create table: RegistryDlaResponseItem
**
**		Auth: Mike Berenson
**		Date: 09/29/2016 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      09/29/2016	Mike Berenson		Initial Table Creation
**		10/04/2016	Mike Berenson		Added RegistryDlaResponseID
*******************************************************************************/
  IF NOT EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'RegistryDlaResponseItem')
	BEGIN
	PRINT 'Creating Table: RegistryDlaResponseItem'
		CREATE TABLE [dbo].[RegistryDlaResponseItem](
			[RegistryDlaResponseItemID] [int] IDENTITY(1,1) NOT NULL,
			[RegistryDlaResponseID] [int],
			[SSN] [varchar](11) NULL,
			[DOB] [datetime] NULL,
			[FirstName] [varchar](50) NULL,
			[MiddleName] [varchar](50) NULL,
			[LastName] [varchar](50) NULL,
			[Suffix] [varchar](4) NULL,
			[Gender] [varchar](1) NULL,
			[Race] [int] NULL,
			[EyeColor] [varchar](5) NULL,
			[Addr1] [varchar](50) NULL,
			[Addr2] [varchar](50) NULL,
			[City] [varchar](25) NULL,
			[State] [varchar](2) NULL,
			[Zip] [varchar](10) NULL,
			[Phone] [varchar](10) NULL,
			[Email] [varchar](100) NULL,
			[Comment] [varchar](200) NULL,
			[Limitations] [varchar](1000) NULL,
			[LimitationsOther] [varchar](1000) NULL,
			[License] [varchar](20) NULL,
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
			[AuditLogTypeID] [int] NULL,
			[RegisteredByID] [int] NOT NULL,
		 CONSTRAINT [PK_RegistryDlaResponseItem] PRIMARY KEY NONCLUSTERED 
		(
			[RegistryDlaResponseItemID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
		) ON [PRIMARY];
	END
