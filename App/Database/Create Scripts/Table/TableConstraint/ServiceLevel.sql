/***************************************************************************************************
**	Name: ServiceLevel
**	Desc: Add Primary keys, Unique keys, and Default Keys to Organization
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/24/2011	Bret Knoll	Initial Key Creation
**	09/13/2011  ccarroll added for CCRST151 release
***************************************************************************************************/

 


/****** Object:  Index [IX_ServiceLevel_ServiceLevelStatus]    Script Date: 06/24/2011 07:05:44 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevel]') AND name = N'IX_ServiceLevel_ServiceLevelStatus')
BEGIN
	DROP INDEX [IX_ServiceLevel_ServiceLevelStatus] ON [dbo].[ServiceLevel] WITH ( ONLINE = OFF )
END

IF  NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevel]') AND name = N'IX_ServiceLevel_ServiceLevelStatus')
BEGIN

	CREATE NONCLUSTERED INDEX [IX_ServiceLevel_ServiceLevelStatus] ON [dbo].[ServiceLevel] 
	(
		[ServiceLevelStatus] ASC
	)
	INCLUDE ( [ServiceLevelID],
	[ServiceLevelGroupName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
END
GO