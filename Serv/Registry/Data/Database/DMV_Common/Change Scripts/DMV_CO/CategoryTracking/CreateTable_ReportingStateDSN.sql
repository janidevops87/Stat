 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ReportingStateDSN')
	BEGIN
		PRINT 'Dropping Table ReportingStateDSN'
		DROP  Table ReportingStateDSN
	END
GO

/******************************************************************************
**		File: 
**		Name: ReportingStateDSN
**		Desc: 
**
**		This template can be customized:
**              
**
**		Auth: ccarroll
**		Date: 03/21/2008 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      03/21/2008		ccarroll				initial
*******************************************************************************/

PRINT 'Creating Table ReportingStateDSN'
GO
CREATE TABLE [ReportingStateDSN] (
 [ID] [int] IDENTITY (1, 1) NOT NULL,
 [StateName] [varchar](25),
 [StateAbbr] [varchar](2),
 [StateDSN] [varchar](25),
 [LastModified] [datetime] NULL,
 [CreateDate] [datetime] NULL,  
 CONSTRAINT [PK_ReportingStateDSN] PRIMARY KEY  NONCLUSTERED 
 (
	[ID]
 )  ON [IDX] 
) ON [PRIMARY]
GO
