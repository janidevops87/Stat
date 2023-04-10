/***************************************************************************************************
**	Name: LogEventLock
**	Desc: Creates new table LogEventLock
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**  09/10       jth             table for event lock
***************************************************************************************************/ 
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'LogEventLock')
Begin
	PRINT 'Creating table LogEventLock'
	SET ANSI_NULLS ON

CREATE TABLE [dbo].[LogEventLock](
	[CallID] [int] NOT NULL,
	[OrganizationID] [int] NULL,
	[LogEventOrg] nvarchar(80) NULL,
	[StatEmployeeID] [int] NULL,
	[LastModified] [datetime] NULL
 )
 
ALTER TABLE [dbo].[LogEventLock] ADD  CONSTRAINT [DF_LogEventLock_LastModified]  DEFAULT (getdate()) FOR [LastModified]
end
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'LogEventLock') AND name = 'LogEventID')
BEGIN
	ALTER TABLE dbo.LogEventLock ADD LogEventID int NULL
END


GO

