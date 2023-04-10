IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ArchiveAppropriateCounts')
	BEGIN
		PRINT 'Dropping Table ArchiveAppropriateCounts'
		DROP  Table ArchiveAppropriateCounts
	END
GO

/******************************************************************************
**		File: 
**		Name: ArchiveAppropriateCounts
**		Desc: 
**
**              
**
**		Auth: Bret Knoll
**		Date: 10/15/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**    10/15/2007	Bret Knoll		Archive of 2006 Data
*******************************************************************************/

PRINT 'Creating Table ArchiveAppropriateCounts'
GO
CREATE TABLE ArchiveAppropriateCounts
(
	[CallID] [int] NULL ,
	[appropriateType] [int] NULL ,
	[IndicationID] [int] NULL ,
	[DynamicCategory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
)
GO

GRANT SELECT ON ArchiveAppropriateCounts TO PUBLIC

GO
