if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditTrailTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AuditTrailTable]
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditTrailTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
 BEGIN
 /******************************************************************************
**		File: AuditTrailTable.sql
**		Name: AuditTrailTable
**		Desc: This table will be used to identify AudiTrailTables and will have a relationship to the AudiTrailStatus table
**
**		
**              
**
**		Auth: Bret Knoll
**		Date: 5/16/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		5/16/2007		Bret Knoll				initial
*******************************************************************************/

PRINT 'Creating Table AuditTrailTable'
CREATE TABLE [dbo].[AuditTrailTable] (
	[AuditTrailTableID] [int] IDENTITY (1, 1) NOT NULL ,
	[AuditTrailTableName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
END

GO

 