if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportParamConfiguration]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
 
		PRINT 'Creating Table ReportParamConfiguration'
		
		CREATE TABLE [dbo].[ReportParamConfiguration] (
			[ReportParamConfiguration] [int] IDENTITY (1, 1) NOT NULL ,
			[ReportID] [int] NULL ,
			[ReportControlID] [int] NULL 
		) ON [PRIMARY]
END

GO

