
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportDateType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN

	PRINT 'Creating Table  ReportDateType'
	
	CREATE TABLE [dbo].[ReportDateType] (
		[ReportDateTypeID] [int] IDENTITY (1, 1) NOT NULL ,
		[ReportDateTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[ReportDateTypeDisplayname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
	) ON [PRIMARY]
END

GO