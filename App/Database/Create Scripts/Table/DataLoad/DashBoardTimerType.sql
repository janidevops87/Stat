 /***************************************************************************************************
**	Name: DashBoardTimerType
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM DashBoardTimerType) = 0)
BEGIN
	
	INSERT  [DashBoardTimerType]
           ([DashBoardTimerType]           
           ,[LastModified]
           ,[LastStatEmployeeId]
           ,[AuditLogTypeId])
     VALUES
           ('Expired', GETDATE(), 45, 1),
           ('Over Expiration (amount of time after expiration)', GETDATE(), 45, 1),
           ('Unlock Events', GETDATE(), 45, 1),
           ('Pending Expiration', GETDATE(), 45, 1),
           ('Secondary Pending', GETDATE(), 45, 1),
           ('Acknowledge to Evaluate Expiration', GETDATE(), 45, 1)

END