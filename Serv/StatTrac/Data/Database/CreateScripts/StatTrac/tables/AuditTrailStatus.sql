IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'AuditTrailStatus')
	BEGIN
		PRINT 'Dropping Table AuditTrailStatus'
		DROP  Table AuditTrailStatus
	END
GO

/******************************************************************************
**		File: AuditTrailStatus.sql
**		Name: AuditTrailStatus
**		Desc: This table will be used to set the Max CallID for AuditTrail
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

PRINT 'Creating Table AuditTrailStatus'
GO
CREATE TABLE AuditTrailStatus
(
   MaxID int,
   AuditTrailTableID int

)
GO

GRANT SELECT ON AuditTrailStatus TO PUBLIC

GO
