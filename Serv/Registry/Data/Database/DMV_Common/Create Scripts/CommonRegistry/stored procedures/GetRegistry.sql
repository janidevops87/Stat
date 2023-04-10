IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistry]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistry]
	PRINT 'Dropping Procedure: GetRegistry'
END
	PRINT 'Creating Procedure: GetRegistry'
GO

CREATE PROCEDURE [dbo].[GetRegistry]
(
	@RegistryID int
)
/******************************************************************************
**		File: GetRegistry.sql
**		Name: GetRegistry
**		Desc:  National Web Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	ccarroll	initial
**		01/12/2011	ccarroll	added IsNull
**		02/28/2012	ccarroll	Added RegisteredByID
**		03/13/2012	ccarroll	Added for inclusion in release
**		08/05/2013	ccarroll	added coalesce to license and other fields
*******************************************************************************/
AS


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

	SELECT
		[RegistryID],
		[RegistryOwnerID],
		[SSN],
		[DOB],
		[FirstName],
		coalesce([MiddleName], '') AS MiddleName,
		[LastName],
		coalesce([Suffix], '') AS Suffix,
		[Gender],
		coalesce([Race], '') AS Race,
		coalesce([EyeColor], '') AS EyeColor,
		coalesce([Phone], '') AS Phone,
		coalesce([Email], '') AS Email,
		coalesce([Comment], '') AS Comment,
		coalesce([Limitations], '') AS Limitations,
		coalesce([LimitationsOther], '') AS LimitationsOther,
		coalesce([License], '') AS License,
		[Donor],
		[DonorConfirmed],
		[OnlineRegDate],
		[SignatureDate],
		[MailerDate],
		[DeleteFlag],
		coalesce([DeceaseDate], '') AS DeceaseDate,
		[PreviousDonor],
		[PreviousDonorConfirmed],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		[RegisteredByID]
	
	FROM
			[Registry]
	WHERE 
		[RegistryID] = coalesce(@RegistryID, RegistryID)


	RETURN @@Error
GO

