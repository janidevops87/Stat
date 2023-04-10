 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ArchiveSecondaryTBI')
	BEGIN
		PRINT 'Dropping Table ArchiveSecondaryTBI'
		DROP  Table ArchiveSecondaryTBI
	END
GO

/******************************************************************************
**		File: ArchiveSecondaryTBI.sql
**		Name: ArchiveSecondaryTBI
**		Desc: Records secondary TBI information 
**
**	
**              
**
**		Auth: ccarroll  
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:		Author:				Description:
**	--------	--------		-------------------------------------------
**  10/10/2007	Bret Knoll		Arcive of 2006  
*******************************************************************************/

PRINT 'Creating Table ArchiveSecondaryTBI'
GO
CREATE TABLE [ArchiveSecondaryTBI] (
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
	[AuditLogTypeID] [int] Null
	
) ON [PRIMARY]
GO

  
--GRANT SELECT ON Table_Name TO PUBLIC
--GO
