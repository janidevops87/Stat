
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportParamSection]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
 
		PRINT 'Creating Table ReportParamSection'
		
		CREATE TABLE [dbo].[ReportParamSection] (
			[ReportParamSectionID] [int] NULL ,
			[ReportParamSectionName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
		) ON [PRIMARY]
END

GO

