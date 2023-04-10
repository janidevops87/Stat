 
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportSortTypeConfiguration]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
		PRINT 'Creating Table ReportSortTypeConfiguration'
		
		CREATE TABLE [dbo].[ReportSortTypeConfiguration] (
			[ReportSortTypeConfigurationID] [int] IDENTITY (1, 1) NOT NULL ,
			[ReportID] [int] NULL ,
			[ReportSortTypeID] [int] NULL 
		) ON [PRIMARY]
END

GO

