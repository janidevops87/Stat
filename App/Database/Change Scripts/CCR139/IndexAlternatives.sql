if (db_name() = '_ReferralProd' or db_name() = 'ReferralTest2' or db_name() like '%archive%')
BEGIN
/****** Object:  Index [LogEvent0]    Script Date: 12/03/2010 15:56:41 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_LogEventCallbackPending_LogEventTypeID')
BEGIN
	PRINT 'DROP INDEX [IDX_LogEvent_LogEventCallbackPending_LogEventTypeID] '
	PRINT GETDATE()
	DROP INDEX [IDX_LogEvent_LogEventCallbackPending_LogEventTypeID] ON [dbo].[LogEvent] WITH ( ONLINE = OFF )
END
PRINT 'CREATE NONCLUSTERED INDEX [IDX_LogEvent_LogEventCallbackPending_LogEventTypeID]'
PRINT GETDATE()



--/****** Object:  Index [LogEvent0]    Script Date: 12/03/2010 15:56:42 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_LogEventCallbackPending_LogEventTypeID')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_LogEvent_LogEventCallbackPending_LogEventTypeID]'
	PRINT GETDATE()
	CREATE NONCLUSTERED INDEX [IDX_LogEvent_LogEventCallbackPending_LogEventTypeID]
	ON [dbo].[LogEvent] 
	(
		[LogEventCallbackPending],
		[LogEventTypeID])
	INCLUDE ([LogEventID],[CallID],[LogEventDateTime],[LogEventName],[LogEventOrg],[StatEmployeeID],[LogEventCalloutDateTime])
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [IDX]
END 


/****** Object:  Index [IDX_LogEvent_LogEventTypeID]    Script Date: 12/03/2010 15:58:46 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_LogEventTypeID')
BEGIN
	PRINT 'DROP INDEX [IDX_LogEvent_LogEventTypeID]'
	PRINT GETDATE();
	DROP INDEX [IDX_LogEvent_LogEventTypeID] ON [dbo].[LogEvent] WITH ( ONLINE = OFF )
END




/****** Object:  Index [IDX_Call_CallTemp]    Script Date: 12/06/2010 08:17:00 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallTemp')
BEGIN
	PRINT 'DROP INDEX [IDX_Call_CallTemp]'
	PRINT GETDATE()
	DROP INDEX [IDX_Call_CallTemp] ON [dbo].[Call] WITH ( ONLINE = OFF )
END



/****** Object:  Index [IDX_Call_CallTemp]    Script Date: 12/06/2010 08:17:00 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallTemp')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_Call_CallTemp] ON [dbo].[Call]';
	PRINT GETDATE();

	CREATE NONCLUSTERED INDEX [IDX_Call_CallTemp] ON [dbo].[Call] 
	(
		[CallTemp] ASC
	)
	INCLUDE ( [CallID],
	[CallNumber],
	[CallDateTime],
	[CallTempExclusive],
	[SourceCodeID],
	[CallTempSavedByID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [IDX]
END



/****** Object:  Index [IDX_CallTempSavedByID_CallTemp]    Script Date: 12/06/2010 08:17:33 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_CallTempSavedByID_CallTemp')
BEGIN
	PRINT 'DROP INDEX [IDX_CallTempSavedByID_CallTemp]'
	PRINT GETDATE();
	DROP INDEX [IDX_CallTempSavedByID_CallTemp] ON [dbo].[Call] WITH ( ONLINE = OFF )
END


--/****** Object:  Index [IDX_CallTempSavedByID_CallTemp]    Script Date: 12/06/2010 08:17:34 ******/
--IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_CallTempSavedByID_CallTemp')
--BEGIN
--	PRINT 'CREATE NONCLUSTERED INDEX [IDX_CallTempSavedByID_CallTemp] '
--	PRINT GETDATE();
--	CREATE NONCLUSTERED INDEX [IDX_CallTempSavedByID_CallTemp] ON [dbo].[Call] 
--	(
--		[CallTempSavedByID] ASC,
--		[CallTemp] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
--END

/****** Object:  Index [IDX_Call_CallNumber]    Script Date: 12/06/2010 08:22:29 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallNumber')
BEGIN
	PRINT 'DROP INDEX [IDX_Call_CallNumber] ';
	PRINT GETDATE();
	DROP INDEX [IDX_Call_CallNumber] ON [dbo].[Call] WITH ( ONLINE = OFF )
END


--/****** Object:  Index [IDX_Call_CallNumber]    Script Date: 12/06/2010 08:22:29 ******/
--IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallNumber')
--BEGIN
--	PRINT 'CREATE NONCLUSTERED INDEX [IDX_Call_CallNumber] ';
--	PRINT GETDATE();
--	CREATE NONCLUSTERED INDEX [IDX_Call_CallNumber] ON [dbo].[Call] 
--	(
--		[CallNumber] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 75) ON [IDX]
--END


/****** Object:  Index [IDX_LogEvent_CallID_SchedulGroupID]    Script Date: 12/06/2010 15:33:21 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_CallID_SchedulGroupID')
BEGIN
	PRINT 'DROP INDEX [IDX_LogEvent_CallID_SchedulGroupID] ';
	PRINT GETDATE();
	DROP INDEX [IDX_LogEvent_CallID_SchedulGroupID] ON [dbo].[LogEvent] WITH ( ONLINE = OFF )
END

/****** Object:  Index [IDX_LogEvent_CallID_SchedulGroupID]    Script Date: 12/06/2010 15:33:22 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_CallID_SchedulGroupID')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID_SchedulGroupID] ';
	PRINT GETDATE();
	CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID_SchedulGroupID] ON [dbo].[LogEvent] 
	(
		[CallID] ASC,
		[ScheduleGroupID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [IDX]
END

/****** Object:  Index [IDX_LogEvent_CallID]    Script Date: 12/06/2010 15:39:36 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_CallID')
BEGIN
	PRINT 'DROP INDEX [IDX_LogEvent_CallID] ';
	PRINT GETDATE();
	DROP INDEX [IDX_LogEvent_CallID] ON [dbo].[LogEvent] WITH ( ONLINE = OFF )
END

/****** Object:  Index [IDX_LogEvent_CallID]    Script Date: 12/06/2010 15:39:36 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LogEvent]') AND name = N'IDX_LogEvent_CallID')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID]';
	PRINT GETDATE();
	CREATE NONCLUSTERED INDEX [IDX_LogEvent_CallID] ON [dbo].[LogEvent] 
	(
		[CallID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [IDX]
END

/****** Object:  Index [ScheduleItemEndTimeID]    Script Date: 12/07/2010 11:26:29 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItem]') AND name = N'ScheduleItemEndTimeID')
BEGIN
	PRINT 'DROP INDEX [ScheduleItemEndTimeID] ';
	PRINT GETDATE();
	DROP INDEX [ScheduleItemEndTimeID] ON [dbo].[ScheduleItem] WITH ( ONLINE = OFF )
END

/****** Object:  Index [ScheduleItemStartTimeID]    Script Date: 12/07/2010 11:26:29 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItem]') AND name = N'ScheduleItemStartTimeID')
BEGIN
	PRINT 'DROP INDEX [ScheduleItemStartTimeID]';
	PRINT GETDATE();
	DROP INDEX [ScheduleItemStartTimeID] ON [dbo].[ScheduleItem] WITH ( ONLINE = OFF )
END

/****** Object:  Index [IDX_Call_CallActive_CallDateTime_SourceCodeID]    Script Date: 12/07/2010 12:37:20 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallActive_CallDateTime_SourceCodeID')
BEGIN
	PRINT 'DROP INDEX [IDX_Call_CallActive_CallDateTime_SourceCodeID] '
	PRINT GETDATE();
	DROP INDEX [IDX_Call_CallActive_CallDateTime_SourceCodeID] ON [dbo].[Call] WITH ( ONLINE = OFF )
END

--/****** Object:  Index [IDX_Call_CallActive_CallDateTime_SourceCodeID]    Script Date: 12/07/2010 12:37:20 ******/
--IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallActive_CallDateTime_SourceCodeID')
--BEGIN
--	PRINT 'CREATE NONCLUSTERED INDEX [IDX_Call_CallActive_CallDateTime_SourceCodeID] ';
--	PRINT GETDATE();
	
--	CREATE NONCLUSTERED INDEX [IDX_Call_CallActive_CallDateTime_SourceCodeID] ON [dbo].[Call] 
--	(
--		[CallActive] ASC,
--		[CallDateTime] ASC,
--		[SourceCodeID] ASC
--	)
--	INCLUDE ( [CallID],
--	[CallNumber],
--	[StatEmployeeID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
--END

/****** Object:  Index [IDX_Call_CallDateTime]    Script Date: 12/07/2010 12:47:41 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallDateTime_CallID_CallActive')
	BEGIN
		PRINT 'DROP INDEX [IDX_Call_CallDateTime_CallID_CallActive] '
		DROP INDEX [IDX_Call_CallDateTime_CallID_CallActive] ON [dbo].[Call] WITH ( ONLINE = OFF )
	END	


/****** Object:  Index [IDX_Call_CallDateTime]    Script Date: 12/07/2010 12:47:41 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Call]') AND name = N'IDX_Call_CallDateTime_CallID_CallActive')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_Call_CallDateTime_CallID_CallActive]'
	CREATE NONCLUSTERED INDEX [IDX_Call_CallDateTime_CallID_CallActive] ON [dbo].[Call] 
	(
		[CallDateTime] ASC,
		[CallID] ASC,
		[CallActive]
		
	)
	INCLUDE ( 
	[CallNumber],
	[StatEmployeeID],
	[SourceCodeID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
END


--/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
--BEGIN TRANSACTION
--SET QUOTED_IDENTIFIER ON
--SET ARITHABORT ON
--SET NUMERIC_ROUNDABORT OFF
--SET CONCAT_NULL_YIELDS_NULL ON
--SET ANSI_NULLS ON
--SET ANSI_PADDING ON
--SET ANSI_WARNINGS ON
--COMMIT
--BEGIN TRANSACTION
--
--ALTER TABLE dbo.TcssRecipientOfferInformation
--	DROP CONSTRAINT FK_TcssRecipientOfferInformation_CallId_Call_CallId
--
--ALTER TABLE dbo.FsbCaseStatus
--	DROP CONSTRAINT FK_FsbCaseStatus_CallId_Call_CallId
--
--ALTER TABLE dbo.Call
--	DROP CONSTRAINT PK_Call
--
--ALTER TABLE dbo.Call ADD CONSTRAINT
--	PK_Call PRIMARY KEY CLUSTERED 
--	(
--	CallID
--	) WITH( PAD_INDEX = OFF, FILLFACTOR = 90, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

--
--ALTER TABLE dbo.Call SET (LOCK_ESCALATION = TABLE)
--
--COMMIT
--BEGIN TRANSACTION
--
--ALTER TABLE dbo.FsbCaseStatus ADD CONSTRAINT
--	FK_FsbCaseStatus_CallId_Call_CallId FOREIGN KEY
--	(
--	CallId
--	) REFERENCES dbo.Call
--	(
--	CallID
--	) ON UPDATE  NO ACTION 
--	 ON DELETE  NO ACTION 
	
--
--ALTER TABLE dbo.FsbCaseStatus SET (LOCK_ESCALATION = TABLE)
--
--COMMIT
--BEGIN TRANSACTION
--
--ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT
--	FK_TcssRecipientOfferInformation_CallId_Call_CallId FOREIGN KEY
--	(
--	CallId
--	) REFERENCES dbo.Call
--	(
--	CallID
--	) ON UPDATE  NO ACTION 
--	 ON DELETE  NO ACTION 
	
--
--ALTER TABLE dbo.TcssRecipientOfferInformation SET (LOCK_ESCALATION = TABLE)
--
--COMMIT


/****** Object:  Index [DonorLastName]    Script Date: 12/09/2010 12:34:34 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'DonorLastName')
BEGIN
	PRINT 'DROP INDEX [DonorLastName] ';
	PRINT GETDATE();
	DROP INDEX [DonorLastName] ON [dbo].[Referral] WITH ( ONLINE = OFF )
END


--/****** Object:  Index [DonorLastName]    Script Date: 12/09/2010 12:34:35 ******/
--IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'DonorLastName')
--BEGIN
--	PRINT 'CREATE NONCLUSTERED INDEX [DonorLastName] ';
--	PRINT GETDATE();

--	CREATE NONCLUSTERED INDEX [DonorLastName] ON [dbo].[Referral] 
--	(
--		[ReferralDonorLastName] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 60) ON [IDX]
--END

/****** Object:  Index [IDX_Callid_Orgid_DeathDateTime]    Script Date: 12/09/2010 12:40:12 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Callid_Orgid_DeathDateTime')
BEGIN
	PRINT 'DROP INDEX [IDX_Callid_Orgid_DeathDateTime] ';
	PRINT GETDATE();

	DROP INDEX [IDX_Callid_Orgid_DeathDateTime] ON [dbo].[Referral] WITH ( ONLINE = OFF )
END


/****** Object:  Index [IDX_Callid_Orgid_DeathDateTime]    Script Date: 12/09/2010 12:40:12 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Call_Callid')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_Call_Callid]  ';
	PRINT GETDATE();

	CREATE NONCLUSTERED INDEX [IDX_Call_Callid] ON [dbo].[Referral] 
	(
		[CallID] ASC
	)
	INCLUDE ( [ReferralCallerOrganizationID],
	[ReferralDonorDeathDate],
	[ReferralDonorDeathTime]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [IDX]
END


/****** Object:  Index [IDX_Referral_ReferralDonorLastName]    Script Date: 12/09/2010 12:42:41 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Referral_ReferralDonorLastName')
BEGIN
	PRINT 'DROP INDEX [IDX_Referral_ReferralDonorLastName] ';
	PRINT GETDATE();

	DROP INDEX [IDX_Referral_ReferralDonorLastName] ON [dbo].[Referral] WITH ( ONLINE = OFF )
END


/****** Object:  Index [IDX_Referral_ReferralDonorLastName]    Script Date: 12/09/2010 12:42:41 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Referral]') AND name = N'IDX_Referral_ReferralDonorLastName')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_Referral_ReferralDonorLastName] ';
	PRINT GETDATE();

	CREATE NONCLUSTERED INDEX [IDX_Referral_ReferralDonorLastName] ON [dbo].[Referral] 
	(
		[ReferralDonorLastName] ASC
	)
	INCLUDE ( [CallID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 85) ON [IDX]
END

END -- END FOR DB CHECK.

/*
	EXEC SP_HELP CALL
		IDX_Call_CallDateTime_CallID_CallActive	nonclustered located on IDX	CallDateTime, CallID, CallActive
		IDX_Call_CallTemp	nonclustered located on IDX	CallTemp
		IDX_CallDateTime_SourceCodeID	nonclustered located on IDX	CallDateTime, SourceCodeID
		PK_Call	clustered, unique, primary key located on PRIMARY	CallID
	EXEC SP_HELP REFERRAL
		IDX_Call_Callid	nonclustered located on IDX	CallID
		IDX_Referral_CallID_ReferralCallerOrganizationID	nonclustered located on IDX	CallID, ReferralCallerOrganizationID
		IDX_Referral_ReferralDonorLastName	nonclustered located on IDX	ReferralDonorLastName
		IDX_Referrall_ReferralDonorLastName	nonclustered located on IDX	ReferralDonorLastName
		PhoneID	nonclustered located on IDX	ReferralCallerPhoneID
		PK_Referral_1__24	nonclustered, unique, primary key located on IDX	ReferralID	
	EXEC SP_HELP LogEvent
		IDX_LogEvent_CallID	nonclustered located on IDX	CallID
		IDX_LogEvent_CallID_SchedulGroupID	nonclustered located on IDX	CallID, ScheduleGroupID
		IDX_LogEvent_LogEventCallbackPending_LogEventTypeID	nonclustered located on IDX	LogEventCallbackPending, LogEventTypeID
		IDX_LogEvent_StatEmployeeID_LastModified	nonclustered located on IDX	StatEmployeeID, LastModified
		PK_LogEvent_1__13	nonclustered, unique, primary key located on IDX	LogEventID	
*/

