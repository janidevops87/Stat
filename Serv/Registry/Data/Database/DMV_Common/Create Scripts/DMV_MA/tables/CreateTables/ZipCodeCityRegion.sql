PRINT 'Creating Table ZipCodeCityRegion'
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ZipCodeCityRegion')
	BEGIN

/******************************************************************************
**		File: CreateTable_ZipCodeCityRegion.sql
**		Name: ZipCodeCityRegion
**		Desc: Script to create Zip Code lookup table for use with reports 
**
**              
**
**		Auth: ccarroll
**		Date: 02/29/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		04/18/2008		ccarroll				initial
*******************************************************************************/



CREATE TABLE [ZipCodeCityRegion] (
 [ID] [int] IDENTITY (1, 1) NOT NULL,
 [ZipCode] [varchar](10)NULL,
 [City] [varchar](255) NULL,
 [County] [varchar](255) NULL,
 [Region] [varchar](255) NULL,
 [Viewable] [bit] NULL,
 [Inactive] [bit] NULL,
 [LastModified] [datetime] NULL,
 [CreateDate] [datetime] NULL,  
 CONSTRAINT [PK_ZipCodeCityRegion] PRIMARY KEY  NONCLUSTERED 
 (
	[ID]
 )  ON [PRIMARY] 
) ON [PRIMARY]

END
