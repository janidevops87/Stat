
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportControl]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
		PRINT 'Creating Table ReportControl'
		
		CREATE TABLE [dbo].[ReportControl] (
			[ReportControlID] [int] IDENTITY (1, 1) NOT NULL ,
			[ReportControlName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
			[ReportParamSectionID] [int] NULL 
		) ON [PRIMARY]
END

GO

