/***************************************************************************************************
**	Name: CallIncompleteDate
**	Desc: Creates new table CallIncompleteDate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**  09/10       jth             table for dates of date when call was saved as incomplete
***************************************************************************************************/ 
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'CallIncompleteDate')
Begin
	PRINT 'Creating table CallIncompleteDate'
	SET ANSI_NULLS ON

CREATE TABLE [dbo].[CallIncompleteDate](
	[CallID] [int] NOT NULL,
	[StatEmployeeID] [int] NULL,
	[LastModified] [datetime] NULL
 )
 
 ALTER TABLE [dbo].[CallIncompleteDate] ADD  CONSTRAINT [DF_CallIncompleteDate_LastModified]  DEFAULT (getdate()) FOR [LastModified]

end
GO

