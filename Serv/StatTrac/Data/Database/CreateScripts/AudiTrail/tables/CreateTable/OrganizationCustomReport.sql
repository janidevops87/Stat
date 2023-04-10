/***************************************************************************************************
**	Name: OrganizationCustomReport
**	Desc: Creates new table OrganizationCustomReport
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/2010		jth				Initial Table Creation - used for reports to determine if image should appeard
***************************************************************************************************/ 

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationCustomReport')
BEGIN
	--DROP TABLE dbo.OrganizationCustomReport
	PRINT 'Creating table OrganizationCustomReport'
END
GO	
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'OrganizationCustomReport')
BEGIN
	CREATE TABLE [dbo].[OrganizationCustomReport](
		[OrganizationCustomReportID] [int]  NOT NULL,
		[OrganizationID] [int] NULL,
		[LastModified] [datetime] NULL
	) ON [PRIMARY]
END	

GRANT SELECT ON OrganizationCustomReport TO PUBLIC
GO
