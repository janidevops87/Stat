Print 'Modify Table ReferralSecondaryData' 
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
ALTER TABLE dbo.ReferralSecondaryData ADD
	LastStatEmployeeID int NULL,
	AuditLogTypeID int NULL
GO
COMMIT

GO



