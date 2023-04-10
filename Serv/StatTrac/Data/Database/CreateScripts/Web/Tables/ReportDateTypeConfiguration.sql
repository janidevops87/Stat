if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportDateTypeConfiguration]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN

		PRINT 'Creating Table ReportDateTypeConfiguration'
		
		CREATE TABLE [dbo].[ReportDateTypeConfiguration] (
			[ReportDateTypeConfigurationID] [int] IDENTITY (1, 1) NOT NULL ,
			[ReportID] [int] NULL ,
			[ReportDateTypeID] [int] NULL 
		) ON [PRIMARY]
END

GO

