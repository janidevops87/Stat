

/******************************************************************************
**		File: 
**		Name: ReportDateTime
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

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ReportDateTime')
	BEGIN
		PRINT 'Creating Table ReportDateTime'
		--GO
		CREATE TABLE ReportDateTime
		(
			[ReportDateTimeID] [int] IDENTITY (1, 1) NOT NULL ,
			[ReportDateTimeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
		) ON [PRIMARY]
		--GO

		GRANT SELECT ON ReportDateTime TO PUBLIC

		--GO
	END
GO
