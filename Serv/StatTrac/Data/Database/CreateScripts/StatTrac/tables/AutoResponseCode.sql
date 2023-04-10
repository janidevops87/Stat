IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'AutoResponseCode')
	BEGIN
		PRINT 'Dropping Table AutoResponseCode'
		DROP  Table AutoResponseCode
	END
GO

/******************************************************************************
**		File: 
**		Name: AutoResponseCode
**		Desc: Stores LogEvenCode value which used to be stored in the LogEvenNumber field
**
**              
**
**		Auth: Bret Knoll
**		Date: 07/16/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/16/07	Bret Knoll			StatTrac 8.4.3.9 LogEvent
*******************************************************************************/

PRINT 'Creating Table AutoResponseCode'
GO
CREATE TABLE [dbo].[AutoResponseCode] (
	[AutoResponseCodeID] [int] IDENTITY(1,1),
	[CallID] [int] NULL ,
	[AutoResponseCode] [int] NULL ,
	[LogeventID] [int] NULL 
) ON [PRIMARY]
GO

GRANT SELECT ON AutoResponseCode TO PUBLIC

GO


