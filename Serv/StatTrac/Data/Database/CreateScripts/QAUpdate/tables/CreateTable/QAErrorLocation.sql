/******************************************************************************
**		File: CreateTable_QAErrorLocation.sql
**		Name: ErrorStatus
**		Desc: Create table: QAErrorLocation
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
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAErrorLocation')
	BEGIN
		PRINT 'Table Exists: QAErrorLocation,  updating..'
		/*** Add Table script changes here ***/
		
	END
 ELSE
	BEGIN
		PRINT 'Creating Table: QAErrorLocation'
		CREATE TABLE [QAErrorLocation] (
		 [QAErrorLocationID] [int] IDENTITY (1, 1) NOT NULL,
		 [OrganizationID] [int] NULL,
		 [QAErrorLocationDescription] [varchar](255) NULL,
		 [QAErrorLocationActive] [smallint] NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		 )
 END
