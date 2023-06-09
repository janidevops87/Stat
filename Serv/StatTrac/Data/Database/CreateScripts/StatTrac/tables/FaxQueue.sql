IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[FaxQueue]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

CREATE TABLE [dbo].[FaxQueue] (
	[FaxQueueID] [int] IDENTITY (1, 1) NOT NULL ,
	[FaxQueueCallId] [int] NULL ,
	[FaxQueueById] [int] NULL ,
	[FaxQueueTo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FaxQueueOrg] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FaxQueueOrgId] [int] NULL ,
	[FaxQueueFaxNo] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FaxQueueSubmitDate] [datetime] NULL ,
	[FaxQueueSentDate] [datetime] NULL ,
	[FaxQueueJobId] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FaxQueueConfirmedDate] [datetime] NULL ,
	[FaxQueueDeleteDate] [datetime] NULL ,
	[FaxQueueDmvTable] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FaxQueueDmvId] [int] NULL ,
	[FaxQueueRegId] [int] NULL ,
	[FaxQueueFormName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[FaxQueueDSNID] [smallint] NULL 
) ON [PRIMARY]
END


IF NOT EXISTS (select * from syscolumns where name like 'FaxQueueJobId' and id in (select id from sysobjects where name like 'faxqueue') and length = 50)
BEGIN
	PRINT 'ALTERING TABLE FaxQueue - Column FaxQueueJobId'
	ALTER TABLE
		FaxQueue
	ALTER COLUMN 
		FaxQueueJobId VARCHAR(50)
END



