IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'Race')
BEGIN
	PRINT 'Creating Table Race'
/******************************************************************************
**		File: CreateTable_Race.sql
**		Name: CreateTable_Race
**		Desc: Create Race lookup table for DMV and registry. 
**
**		Auth: ccarroll
**		Date: 07/16/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		07/20/2009	ccarroll			initial
*******************************************************************************/
	CREATE TABLE [dbo].[Race](
		[RaceID] [int] Identity(1,1),
		[RaceDMVCode] [varchar](15) Null,
		[RaceName] [varchar](80) NULL,
		[SortOrder] [int] NOT NULL CONSTRAINT [DF_Race_SortOrder]  DEFAULT (1),
		[Verified] [smallint] NULL,
		[Inactive] [smallint] NULL,
		[CreateDate] [datetime] NULL,
		[LastModified] [datetime] NULL,
		[UpdatedFlag] [smallint] NULL
	)
	 ON [PRIMARY]
END