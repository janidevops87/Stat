/******************************************************************************
**		File: CreateTable_QAErrorType.sql
**		Name: CreateTable_QAErrorType
**		Desc: Create table: QAErrorType
**
**		Auth: ccarroll
**		Date: 01/14/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/14/2009	ccarroll			initial
*******************************************************************************/
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAErrorType')
	BEGIN
		PRINT 'Table Exists: QAErrorType, updating..'
		/*** Add Table script changes here ***/

	END
 ELSE
	BEGIN
		PRINT 'Creating Table: QAErrorType'

		CREATE TABLE [QAErrorType] (
		 [QAErrorTypeID] [int] IDENTITY (1, 1) NOT NULL,
		 [OrganizationID] [int] NULL,
		 [QATrackingTypeID] [int] NULL,
		 [QAErrorLocationID] [int] NULL,
		 [QAErrorTypeDescription] [varchar](255) NULL,
		 [QAErrorRequireReview] [smallint] NULL,
		 [QAErrorTypeActive] [smallint] NULL,
		 [QAErrorTypeInactiveComments] [varchar](1000) NULL,
		 [QAErrorTypeAssignedPoints] [int] NULL,
		 [QAErrorTypeAutomaticZeroScore] [smallint] NULL,
		 [QAErrorTypeDisplayNA] [smallint] NULL,
		 [QAErrorTypeDisplayComments] [smallint] NULL,
		 [QAErrorTypeGenerateLogIfNo] [smallint] NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)
	END
