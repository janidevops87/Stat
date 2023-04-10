IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'SecondaryTBI')
	BEGIN
		PRINT 'Dropping Table SecondaryTBI'
		DROP  Table SecondaryTBI
	END
GO

/******************************************************************************
**		File: SecondaryTBI.sql
**		Name: SecondaryTBI
**		Desc: Records secondary TBI information 
**
**	
**              
**
**		Auth: ccarroll  
**		Date: 05/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/

PRINT 'Creating Table SecondaryTBI'
GO
CREATE TABLE [SecondaryTBI] (
	[CallID] [int] NOT NULL ,
	[SecondaryTBINumber] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryTBIIssuedStatEmployeeID] [int] Null,
	[SecondaryTBIPrefixDate] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryTBIAssignmentNotNeeded] [smallint] Null,
	[SecondaryTBIAssignmentNotNeededStatEmployeeID] [int] Null,
	[LastStatEmployeeID] [int] Null,
	[SecondaryTBIComment] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CreateDate] [smalldatetime] Null,
	[LastModified] [smalldatetime] Null,
	[AuditLogTypeID] [int] Null,
	
	CONSTRAINT [PK_SecondaryTBI] PRIMARY KEY  NONCLUSTERED 
	(
		[CallID]
	) WITH  FILLFACTOR = 90  ON [IDX] 
) ON [PRIMARY]
GO

  
--GRANT SELECT ON Table_Name TO PUBLIC
--GO
