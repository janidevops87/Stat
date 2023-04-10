/***************************************************************************************************
**	Name: County
**	Desc: Add Primary keys, Unique keys, and Default Keys to Organization
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/24/2011	Bret Knoll	Initial Key Creation 
***************************************************************************************************/


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[County]') AND name = N'IX_County_CountyName')
BEGIN
	PRINT 'DROP INDEX [IX_County_CountyName]'
	DROP INDEX [IX_County_CountyName] ON [dbo].[County] WITH ( ONLINE = OFF )
END
GO

IF  NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[County]') AND name = N'IX_County_CountyName')
BEGIN
	/****** Object:  Index [IX_County_CountyName]    Script Date: 06/24/2011 07:57:06 ******/
	CREATE NONCLUSTERED INDEX [IX_County_CountyName] ON [dbo].[County] 
	(
		[CountyName] ASC
	)
	INCLUDE ( [CountyID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [IDX]
END
GO



/****** Object:  Index [CountyID_CountyName]    Script Date: 06/24/2011 07:56:11 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[County]') AND name = N'CountyID_CountyName')
BEGIN
	DROP INDEX [CountyID_CountyName] ON [dbo].[County] WITH ( ONLINE = OFF )
END


