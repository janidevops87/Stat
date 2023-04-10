/******************************************************************************
**		File: CreateTable_QATracking.sql
**		Name: CreateTable_QATracking
**		Desc: Create table: QATracking
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/14/2009	ccarroll			initial
**      04/09       jth                 moved detail fields to QATrackingForm
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QATracking')
	BEGIN
		PRINT 'Table Exists: QATracking, updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
		PRINT 'Creating Table: QATracking'

		CREATE TABLE [QATracking] (
		 [QATrackingID] [int] IDENTITY (1, 1) NOT NULL,
		 [OrganizationID] [int] NULL,
		 [QATrackingTypeID] [int] NULL,
		 [QATrackingNumber] [varchar](20) NULL,
		 [QATrackingNotes] [varchar](1000) NULL,
		 [QATrackingSourceCode] [varchar](15) NULL,
		 [QATrackingReferralDateTime] [datetime] NULL,
		 [QATrackingReferralTypeID] [int] NULL,
		 [QATrackingStatusID] [int] NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
	END
