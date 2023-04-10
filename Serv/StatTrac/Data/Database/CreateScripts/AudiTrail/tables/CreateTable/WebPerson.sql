IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'WebPerson')
	BEGIN
		PRINT 'Dropping Table WebPerson'
		DROP  Table WebPerson
	END
GO

/******************************************************************************
**		File: 
**		Name: WebPerson
**		Desc: 
**
**		This template can be customized:
**              
**
**		Auth: Bret Knoll	
**		Date: 11/12/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/12/2007	Bret Knoll			initial
**		06/22/2018	Ilya Osipov			Added SaltValue and HashedPassword
*******************************************************************************/

PRINT 'Creating Table WebPerson'
GO
CREATE TABLE WebPerson
(
	[WebPersonID] [int] NOT NULL ,
	[WebPersonUserName] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonID] [int] NULL ,
	[WebPersonPassword] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UnusedField1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[WebPersonSessionCounter] [int] NULL ,
	[UnusedField2] [int] NULL ,
	[WebPersonLastSessionAccess] [smalldatetime] NULL ,
	[WebPersonEmail] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[WebPersonUserAgent] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Access] [int] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL
) 
ON 
	[PRIMARY]
GO

  IF NOT EXISTS (select * from syscolumns where id=object_id('WebPerson') and name like 'SaltValue')
BEGIN
	PRINT 'Adding Column: SaltValue'
	--Add column  
	BEGIN TRANSACTION	
	ALTER TABLE dbo.WebPerson ADD
		SaltValue  varchar(100) NULL 
	
	COMMIT
END

 IF NOT EXISTS (select * from syscolumns where id=object_id('WebPerson') and name like 'HashedPassword')
BEGIN
	PRINT 'Adding Column: HashedPassword'
	--Add column  
	BEGIN TRANSACTION	
	ALTER TABLE dbo.WebPerson ADD
		HashedPassword  varchar(50) NULL 
	
	COMMIT
END

GRANT SELECT ON WebPerson TO PUBLIC

GO
