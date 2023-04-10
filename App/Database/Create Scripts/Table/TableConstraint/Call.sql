/***************************************************************************************************
**	Name: Call
**	Desc: Add Primary keys, Unique keys, and Default Keys to BillTo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	2009		Bret Knoll		Initial Key Creation
***************************************************************************************************/

--use this script to determine if callid exists in fsbcaseStatus but not in call
--select replace('delete FsbCaseStatus where CallId = <CallId>', '<CallId>', FsbCaseStatus.CallId) from FsbCaseStatus where CallId not in (select CallId from Call)
--and 4 = (select top 1 AuditLogTypeID from _ReferralAuditTrail..Call where CallID = FsbCaseStatus.CallId order by LastModified desc)
delete FsbCaseStatus where CallId = 8060432
delete FsbCaseStatus where CallId = 8060432
delete FsbCaseStatus where CallId = 7957275
delete FsbCaseStatus where CallId = 7903355
delete FsbCaseStatus where CallId = 7903355
delete FsbCaseStatus where CallId = 7903355
delete FsbCaseStatus where CallId = 7934250
delete FsbCaseStatus where CallId = 7934250
delete FsbCaseStatus where CallId = 7934250
delete FsbCaseStatus where CallId = 7856950
delete FsbCaseStatus where CallId = 7856950
delete FsbCaseStatus where CallId = 7856950
delete FsbCaseStatus where CallId = 7930320
delete FsbCaseStatus where CallId = 7930320
delete FsbCaseStatus where CallId = 7930320
delete FsbCaseStatus where CallId = 7957275
delete FsbCaseStatus where CallId = 7957275
delete FsbCaseStatus where CallId = 7926776
delete FsbCaseStatus where CallId = 7926776
delete FsbCaseStatus where CallId = 7926776
delete FsbCaseStatus where CallId = 7965519
delete FsbCaseStatus where CallId = 7934250
delete FsbCaseStatus where CallId = 7934250
delete FsbCaseStatus where CallId = 7903355
delete FsbCaseStatus where CallId = 7903355
 /****** Object:  Index [CallDateTime]    Script Date: 02/28/2010 15:01:12 ******/
IF  EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_CallDateTime_SourceCodeID')
DROP INDEX [dbo].[Call].[IDX_CallDateTime_SourceCodeID]
GO


GO
CREATE NONCLUSTERED INDEX [IDX_CallDateTime_SourceCodeID] ON [dbo].[Call] 
(
	[CallDateTime] ASC,
	[SourceCodeID] ASC
)
INCLUDE ( CallID, CallNumber) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 85) ON [IDX]
GO


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_CloseCaseQueue_Call]') AND type = 'F')
ALTER TABLE [dbo].[CloseCaseQueue] DROP CONSTRAINT [FK_CloseCaseQueue_Call]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_TcssDonor_CallId_Call_CallId]') AND type = 'F')
ALTER TABLE [dbo].[TcssDonor] DROP CONSTRAINT [FK_TcssDonor_CallId_Call_CallId]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_FsbCaseStatus_CallId_Call_CallId]') AND type = 'F')
ALTER TABLE [dbo].[FsbCaseStatus] DROP CONSTRAINT [FK_FsbCaseStatus_CallId_Call_CallId]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_TcssRecipientOfferInformation_CallId_Call_CallId]') AND type = 'F')
ALTER TABLE [dbo].[TcssRecipientOfferInformation] DROP CONSTRAINT [FK_TcssRecipientOfferInformation_CallId_Call_CallId]
GO


/****** Object:  Index [PK_Call_1__13]    Script Date: 02/28/2010 14:36:56 ******/
IF  EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[Call]') AND name = N'PK_Call_1__13')
ALTER TABLE [dbo].[Call] DROP CONSTRAINT [PK_Call_1__13]
GO
IF  not EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[Call]') AND name = N'PK_Call')
BEGIN
/****** Object:  Index [PK_Call_1__13]    Script Date: 02/28/2010 14:36:57 ******/
ALTER TABLE [dbo].[Call] ADD  CONSTRAINT [PK_Call] PRIMARY KEY NONCLUSTERED 
(
	[CallID] ASC
)WITH FILLFACTOR = 90 ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_TcssRecipientOfferInformation_CallId_Call_CallId]') AND type = 'F')
ALTER TABLE [dbo].[TcssRecipientOfferInformation]  WITH CHECK ADD  CONSTRAINT [FK_TcssRecipientOfferInformation_CallId_Call_CallId] FOREIGN KEY([CallId])
REFERENCES [dbo].[Call] ([CallID])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_TcssRecipientOfferInformation_CallId_Call_CallId]') AND type = 'F')
ALTER TABLE [dbo].[TcssRecipientOfferInformation] CHECK CONSTRAINT [FK_TcssRecipientOfferInformation_CallId_Call_CallId]
GO


IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_FsbCaseStatus_CallId_Call_CallId]') AND type = 'F')
ALTER TABLE [dbo].[FsbCaseStatus]  WITH CHECK ADD  CONSTRAINT [FK_FsbCaseStatus_CallId_Call_CallId] FOREIGN KEY([CallId])
REFERENCES [dbo].[Call] ([CallID])
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[FK_FsbCaseStatus_CallId_Call_CallId]') AND type = 'F')
ALTER TABLE [dbo].[FsbCaseStatus] CHECK CONSTRAINT [FK_FsbCaseStatus_CallId_Call_CallId]
GO


/****** Object:  Index [CallTemp]    Script Date: 02/28/2010 15:00:11 ******/
IF  EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[Call]') AND name = N'CallTemp')
BEGIN
	PRINT 'DROP INDEX [dbo].[Call].[CallTemp]'
	PRINT GETDATE()
	DROP INDEX [dbo].[Call].[CallTemp]
END
GO

/****** Object:  Index [CallTempSavedByID]    Script Date: 02/28/2010 15:00:35 ******/
IF  EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[Call]') AND name = N'CallTempSavedByID')
DROP INDEX [dbo].[Call].[CallTempSavedByID]
GO
/****** Object:  Index [CallTempSavedByID]    Script Date: 02/28/2010 15:00:35 ******/
IF  EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_CallTempSavedByID_CallTemp')
BEGIN
	PRINT 'DROP INDEX [dbo].[Call].[IDX_CallTempSavedByID_CallTemp]'
	PRINT GETDATE()
	DROP INDEX [dbo].[Call].[IDX_CallTempSavedByID_CallTemp]
END
	PRINT 'CREATE INDEX [dbo].[Call].[IDX_CallTempSavedByID_CallTemp]'
	PRINT GETDATE()

GO

CREATE NONCLUSTERED INDEX [IDX_CallTempSavedByID_CallTemp] ON [dbo].[Call] 
(
	[CallTempSavedByID] ASC,
	[CallTemp] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
GO



/****** Object:  Index [IDX_CallDateTime_SourceCodeID]    Script Date: 04/01/2011 16:59:38 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_CallDateTime_SourceCodeID')
BEGIN
	PRINT 'DROP INDEX [IDX_CallDateTime_SourceCodeID] '
	PRINT GETDATE()
	DROP INDEX [IDX_CallDateTime_SourceCodeID] ON [dbo].[Call] WITH ( ONLINE = OFF )
END

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_SourceCodeID_CallDateTime')
BEGIN
	PRINT 'DROP INDEX [IDX_SourceCodeID_CallDateTime] '
	PRINT GETDATE()
	DROP INDEX [IDX_SourceCodeID_CallDateTime] ON [dbo].[Call] WITH ( ONLINE = OFF )
END
PRINT 'CREATE NONCLUSTERED INDEX [IDX_SourceCodeID_CallDateTime] ON [dbo].[Call]'
PRINT GETDATE()
GO

CREATE NONCLUSTERED INDEX [IDX_SourceCodeID_CallDateTime] ON [dbo].[Call] 
(
	[SourceCodeID] ASC,
	[CallDateTime] ASC
)
INCLUDE ( [CallID],
[CallNumber]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
GO
