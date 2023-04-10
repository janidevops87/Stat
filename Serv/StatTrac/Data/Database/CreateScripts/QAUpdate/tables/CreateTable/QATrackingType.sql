/******************************************************************************
**		File: CreateTable_QATrackingType.sql
**		Name: QATrackingType
**		Desc: Create table: QATrackingType
**
**		Auth: ccarroll
**		Date: 01/19/2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      01/19/2009	ccarroll			initial
*******************************************************************************/
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QATrackingType')
	BEGIN
		PRINT 'Table Exists: QATrackingType updating..'
		/*** Add Table script changes here ***/
		
	END
  ELSE 
	BEGIN
		PRINT 'Creating Table: QATrackingType'
	CREATE TABLE [QATrackingType] (
	 [QATrackingTypeID] [int] IDENTITY (1, 1) NOT NULL,
	 [OrganizationID] [int] NULL,
	 [QATrackingTypeDescription] [varchar](255) NULL,
	 [LastModified] [datetime] NULL,
	 [LastStatEmployeeID] [int] NULL,
	 [AuditLogTypeID] [int] NULL
	)
	END

