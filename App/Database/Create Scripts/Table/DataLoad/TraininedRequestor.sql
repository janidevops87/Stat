
		/******************************************************************************
		**	File: TrainedRequestor(DataLoad).sql
		**	Name: TrainedRequestor
		**	Desc: Create table and add default columns for the table TrainedRequestor
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:		Author:			Description:
		**	--------	--------		----------------------------------
		**  07/14/10	Bret Knoll		Adding to release 
		*******************************************************************************/
DECLARE @requestorCount INT = (SELECT COUNT(*) FROM TrainedRequestor) 
IF(@requestorCount = 0)
BEGIN
	INSERT TrainedRequestor (TrainedRequestor, AuditLogTypeID, LastModified, LastStatEmployeeID)
	VALUES('Yes', 1, GETDATE(), 45)
	, ('No', 1, GETDATE(), 45)
END