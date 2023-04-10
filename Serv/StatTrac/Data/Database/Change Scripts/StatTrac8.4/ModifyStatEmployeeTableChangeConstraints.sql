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
 ALTER TABLE dbo.StatEmployee
	DROP CONSTRAINT DF__StatEmplo__Allow__5E775CDF
GO
ALTER TABLE dbo.StatEmployee ADD CONSTRAINT
	DF__StatEmplo__Allow__5E775CDF DEFAULT (0) FOR AllowRecycleCase
GO
ALTER TABLE dbo.StatEmployee ADD CONSTRAINT
	DF_StatEmployee_AllowViewDeletedLogEvents DEFAULT (0) FOR AllowViewDeletedLogEvents
GO
COMMIT