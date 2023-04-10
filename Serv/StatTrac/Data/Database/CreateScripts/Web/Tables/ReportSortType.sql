
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportSortType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
		PRINT 'Creatint Table ReportSortType'
		
		CREATE TABLE [dbo].[ReportSortType] (
			[ReportSortTypeID] [int] IDENTITY (1, 1) NOT NULL ,
			[ReportSortTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
			[ReportSortTypeDisplayname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
		) ON [PRIMARY]
END

GO