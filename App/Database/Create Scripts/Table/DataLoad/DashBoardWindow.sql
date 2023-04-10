 /***************************************************************************************************
**	Name: DashBoardWindow
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM DashBoardWindow) = 0)
BEGIN
	PRINT 'Loading DashBoardWindow Data'
	INSERT [DashBoardWindow]
           ([DashBoardWindow]
           ,[LastModified]
           ,[LastStatEmployeeId]
           ,[AuditLogTypeId])
     VALUES
           ('Incompletes', GETDATE(), 45, 1),
           ('Pending', GETDATE(), 45, 1),
           ('Parking Lot', GETDATE(), 45, 1),
           ('OASIS Active Cases', GETDATE(), 45, 1),
           ('FS Active Cases', GETDATE(), 45, 1)
END
