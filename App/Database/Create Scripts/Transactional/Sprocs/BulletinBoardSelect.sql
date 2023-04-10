

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'BulletinBoardSelect')
	BEGIN
		PRINT 'Dropping Procedure BulletinBoardSelect'
		DROP Procedure BulletinBoardSelect
	END
GO

PRINT 'Creating Procedure BulletinBoardSelect'
GO
CREATE Procedure BulletinBoardSelect
(
		@BulletinBoardID int = null,
		@OrganizationID int = null
)
AS
/******************************************************************************
**	File: BulletinBoardSelect.sql
**	Name: BulletinBoardSelect
**	Desc: Selects BulletinBoard Based on BulletinBoardID field 
**	Auth: ccarroll
**	Date: 9/13/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			----------------------------------
**	9/13/2010		ccarroll			Initial Sproc Creation
**  08/08/2011		ccarroll			Changed text for DateTimeStatus 
*******************************************************************************/

Select	TOP 5
	BulletinBoard.BulletinBoardID,
	CASE WHEN BulletinBoard.LastModified = BulletinBoard.CreateDate
		 THEN 'Created'
		 ELSE 'Updated'
	END AS DateTimeStatus,
	BulletinBoard.LastModified,
	BulletinBoard.Organization,
	BulletinBoard.Alert,
	BulletinBoard.CreateDate,
	BulletinBoard.OrganizationID,
	ISNull(Person.PersonFirst, '') + ' ' + ISNull(Person.PersonLast, '') AS SavedBy,
	BulletinBoard.LastStatEmployeeID,
	BulletinBoard.AuditLogTypeID
		
		
FROM BulletinBoard
	 JOIN StatEmployee ON StatEmployee.StatEmployeeID = BulletinBoard.LastStatEmployeeID
	 LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
WHERE BulletinBoardID = ISNull(@BulletinBoardID, BulletinBoard.BulletinBoardID)
	  AND BulletinBoard.OrganizationID = IsNull(@OrganizationID, BulletinBoard.OrganizationID)
	  ORDER BY ISNull(BulletinBoard.LastModified, BulletinBoard.CreateDate) --(LastModified, CreateDate)

GO

GRANT EXEC ON BulletinBoardSelect TO PUBLIC
GO
