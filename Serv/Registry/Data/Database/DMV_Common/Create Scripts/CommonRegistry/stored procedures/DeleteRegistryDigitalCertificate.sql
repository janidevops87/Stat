 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteRegistryDigitalCertificate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteRegistryDigitalCertificate]
	PRINT 'Dropping Procedure: DeleteRegistryDigitalCertificate'
END
	PRINT 'Creating Procedure: DeleteRegistryDigitalCertificate'
GO

CREATE PROCEDURE [dbo].[DeleteRegistryDigitalCertificate]
(
	@RegistryID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteRegistryDigitalCertificate.sql
**		Name: DeleteRegistryDigitalCertificate
**		Desc:  Common Registry: NEOB
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 02/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/25/2008	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	UPDATE
			[RegistryDigitalCertificate]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[RegistryID] = @RegistryID

	DELETE 
	FROM   [RegistryDigitalCertificate]
	WHERE  
		[RegistryID] = @RegistryID

	RETURN @@Error
GO
