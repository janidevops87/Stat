IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'StatTracParameters')
	BEGIN
		PRINT 'Dropping Table StatTracParameters'
		DROP  Table StatTracParameters
	END
GO

/******************************************************************************
**		File: 
**		Name: StatTracParameters
**		Desc: 
**
**		This template can be customized:
**              
**
**		Auth: Thien Ta	
**		Date: 06/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/

PRINT 'Creating Table StatTracParameters'
GO
CREATE TABLE [dbo].[StatTracParameters] (
	[StatTracParametersID] [int] IDENTITY (1, 1) NOT NULL ,
	[ParameterName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ParameterValueString] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[parameterValueint] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[parameterValueDate] [datetime] NULL 
) ON [PRIMARY]

GRANT SELECT ON StatTracParameters TO PUBLIC

GO
