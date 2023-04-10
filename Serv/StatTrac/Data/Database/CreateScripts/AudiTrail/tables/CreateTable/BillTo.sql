 /***************************************************************************************************
**	Name: BillTo
**	Desc: Creates new table BillTo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/09	Bret Knoll		Initial Table Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
	
IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'BillTo')
BEGIN
	-- DROP TABLE dbo.BillTo
	PRINT 'Creating table BillTo'
	CREATE TABLE BillTo
		(
		BillToID int NOT NULL ,
		OrganizationID int NULL, 
		Name nvarchar(100) NULL,
		Address1  nvarchar(80) NULL,
		Address2  nvarchar(80) NULL,
		City nvarchar(30) NULL,
		StateID int NULL,
		PostalCode nvarchar(10) NULL,
		CountryID int NULL,
		LastModified datetime NULL,
		LastStatEmployeeId int NULL,
		AuditLogTypeId int NULL
		)  ON [PRIMARY]
	
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE BillTo SET (LOCK_ESCALATION = TABLE) END

	
END	

GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[BillTo]') AND name = N'PK_BillTo')
BEGIN
	PRINT 'DROP INDEX [PK_BillTo_CallId] '
	CREATE NONCLUSTERED INDEX [PK_BillTo] ON [dbo].[BillTo] 
	(
		[BillToID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
	
END	
GO
ALTER TABLE dbo.BillTo SET (LOCK_ESCALATION = TABLE)


SET ANSI_PADDING OFF
GO

 