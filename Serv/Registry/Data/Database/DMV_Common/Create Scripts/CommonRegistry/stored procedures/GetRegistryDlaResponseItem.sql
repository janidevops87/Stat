IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryDlaResponseItem]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryDlaResponseItem];
	PRINT 'Dropping Procedure: GetRegistryDlaResponseItem';
END
	PRINT 'Creating Procedure: GetRegistryDlaResponseItem';
GO

CREATE PROCEDURE [dbo].[GetRegistryDlaResponseItem]
(
	@RegistryDlaResponseItemID INT = NULL,
	@RegistryDlaResponseID INT = NULL
)
/******************************************************************************
**		File: GetRegistryDlaResponseItem.sql
**		Name: GetRegistryDlaResponseItem
**		Desc:  Donate Life America Registry
**
**		Called by:  
**              
**
**		Auth: Mike Berenson
**		Date: 09/29/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**		09/29/2016	Mike Berenson	Initial Stored Procedure Creation
**		10/04/2016	Mike Berenson	Added RegistryDlaResponseID
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	SET NOCOUNT ON;

	SELECT
		[RegistryDlaResponseItemID],
		[RegistryDlaResponseID],
		[SSN],
		[DOB],
		[FirstName],
		COALESCE([MiddleName], '') AS MiddleName,
		[LastName],
		COALESCE([Suffix], '') AS Suffix,
		[Gender],
		COALESCE([Race], '') AS Race,
		COALESCE([EyeColor], '') AS EyeColor,
		COALESCE([Addr1], '') AS Addr1,
		COALESCE([Addr2], '') AS Addr2,
		COALESCE([City], '') AS City,
		COALESCE([State], '') AS State,
		COALESCE([Zip], '') AS Zip,
		COALESCE([Phone], '') AS Phone,
		COALESCE([Email], '') AS Email,
		COALESCE([Comment], '') AS Comment,
		COALESCE([Limitations], '') AS Limitations,
		COALESCE([LimitationsOther], '') AS LimitationsOther,
		COALESCE([License], '') AS License,
		[Donor],
		[DonorConfirmed],
		[OnlineRegDate],
		[SignatureDate],
		[MailerDate],
		[DeleteFlag],
		COALESCE([DeceaseDate], '') AS DeceaseDate,
		[PreviousDonor],
		[PreviousDonorConfirmed],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		[RegisteredByID]
	
	FROM
			[RegistryDlaResponseItem]
	WHERE 
		[RegistryDlaResponseItemID] = COALESCE(@RegistryDlaResponseItemID, RegistryDlaResponseItemID)
	AND	
		[RegistryDlaResponseID] = COALESCE(@RegistryDlaResponseID, RegistryDlaResponseID);

	RETURN @@Error;
GO

