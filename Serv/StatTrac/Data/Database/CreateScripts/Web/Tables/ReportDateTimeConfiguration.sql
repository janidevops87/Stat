IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ReportDateTimeConfiguration')
	BEGIN
		PRINT 'Creating Table ReportDateTimeConfiguration'
		
		CREATE TABLE ReportDateTimeConfiguration
		(
			[ReportDateTimeConfigurationID] [int] IDENTITY (1, 1) NOT NULL ,
			[ReportID] [int] NULL ,
			[ReportDateTimeID] [int] NULL 
		) ON [PRIMARY]
		

		GRANT SELECT ON ReportDateTimeConfiguration TO PUBLIC

		
END
GO

/******************************************************************************
**		File: 
**		Name: ReportDateTimeConfiguration
**		Desc: 
**
**              
**
**		Auth: Bret Knoll
**		Date: 7/26/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/26/07	Bret Knoll			Initial WebSite
*******************************************************************************/


