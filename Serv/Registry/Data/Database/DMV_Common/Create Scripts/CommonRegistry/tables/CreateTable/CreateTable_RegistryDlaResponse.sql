/******************************************************************************
**		File: CreateTable_RegistryDlaResponse.sql
**		Name: RegistryDlaResponse
**		Desc: Create table: RegistryDlaResponse
**
**		Auth: Mike Berenson
**		Date: 10/04/2016 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      10/04/2016	Mike Berenson		Initial Table Creation
*******************************************************************************/
  IF NOT EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'RegistryDlaResponse')
	BEGIN
	PRINT 'Creating Table: RegistryDlaResponse'
		CREATE TABLE [dbo].[RegistryDlaResponse](
			[RegistryDlaResponseID] [INT] IDENTITY(1,1) NOT NULL,
			[RequestDOB] [DATETIME] NULL,
			[RequestFirstName] [VARCHAR](50) NULL,
			[RequestMiddleName] [VARCHAR](50) NULL,
			[RequestLastName] [VARCHAR](50) NULL,
			[RequestCity] [VARCHAR](25) NULL,
			[RequestState] [VARCHAR](2) NULL,
			[RequestZip] [VARCHAR](10) NULL,
			[RequestDateTime] [DATETIME] NULL,
			[ResponseDateTime] [DATETIME] NULL,
			[ItemCount] [INT] NULL,
			[ErrorCount] [INT] NULL,
			[CreateDate] [DATETIME] NULL,
			[LastModified] [DATETIME] NULL,
			[AuditLogTypeID] [INT] NULL,
		 CONSTRAINT [PK_RegistryDlaResponse] PRIMARY KEY NONCLUSTERED 
		(
			[RegistryDlaResponseID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
		) ON [PRIMARY];
	END
