/******************************************************************************
**		File: CreateTable_QAErrorLogHowIdentified.sql
**		Name: CreateTable_QAErrorLogHowIdentified
**		Desc: Create table: QAErrorLogHowIdentified
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
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'QAErrorLogHowIdentified')
	BEGIN
		PRINT 'Table Exists: QAErrorLogHowIdentified, updating..'
		/*** Add Table script changes here ***/

	END
  ELSE
	BEGIN
		PRINT 'Creating Table: QAErrorLogHowIdentified'

		CREATE TABLE [QAErrorLogHowIdentified] (
		 [QAErrorLogHowIdentifiedID] [int] IDENTITY (1, 1) NOT NULL,
		 [QAErrorLogHowIdentifiedDescription] [varchar](250) NULL,
		 [LastModified] [datetime] NULL,
		 [LastStatEmployeeID] [int] NULL,
		 [AuditLogTypeID] [int] NULL
		)

END
