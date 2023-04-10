 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryDigitalCertificate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryDigitalCertificate]
	PRINT 'Dropping Procedure: GetRegistryDigitalCertificate'
END
	PRINT 'Creating Procedure: GetRegistryDigitalCertificate'
GO

CREATE PROCEDURE [dbo].[GetRegistryDigitalCertificate]
(
	@RegistryID int = NULL
)
/******************************************************************************
**		File: GetRegistryDigitalCertificate.sql
**		Name: GetRegistryDigitalCertificate
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

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[RegistryDigitalCertificateID],
		[RegistryID],
		[RegistryDigitalCertificateData],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[RegistryDigitalCertificate]
	WHERE 
		[RegistryID] = IsNull(@RegistryID, RegistryID)


	RETURN @@Error
GO