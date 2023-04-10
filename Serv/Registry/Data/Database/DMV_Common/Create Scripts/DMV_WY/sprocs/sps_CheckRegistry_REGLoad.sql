IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_CheckRegistry_REGLoad')
BEGIN
	PRINT 'Dropping Procedure sps_CheckRegistry_REGLoad';
	DROP PROCEDURE sps_CheckRegistry_REGLoad;
END
	PRINT 'Creating Procedure sps_CheckRegistry_REGLoad';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistry_REGLoad]
(
	@DOB			VARCHAR(255) = NULL,
	@LastName		VARCHAR(25) = NULL,
	@FirstName		VARCHAR(25) = NULL,
	@MiddleName		VARCHAR(25) = NULL,
	@SSN			VARCHAR(11) = NULL,
	@LICENSE		VARCHAR(15) = NULL,
	@StreetAddress	VARCHAR(45) = NULL,
	@City			VARCHAR(25) = NULL,
	@State			VARCHAR(2) = NULL,
	@Zip			VARCHAR(10) = NULL,
	@Loc			INT = NULL
)
/******************************************************************************
**		File: sps_CheckRegistry_REGLoad.sql
**		Name: sps_CheckRegistry_REGLoad
**		Desc: Returns matching donors from the web registry based on input fields
**
**		Return values: none
** 
**		Called by: StatTrac FrmReferralDonorData.vb
**
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		10/15/2007	ccarroll	added FirstName, LastName to select
**		01/23/2014	ccarroll	Changed Registry location to DMV_Common	
**		10/19/2016	mberenson	Added to source control
**		10/19/2016	mberenson	Added source column
**		12/22/2016	mberenson	Added source column (apparently not added earlier)
**		12/22/2016	mberenson	Limited row count to the top 1
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
	SET NOCOUNT ON;

	DECLARE @RegistryOwnerId INT = 2, -- CODA
			@RegistryState NVARCHAR(10) = 'WY'; -- Web Donor State 
			
	SELECT TOP(1)
		r.FirstName,
		r.MIDDLENAME,
		r.LastName,
		r.License,
		ra.Addr1,
		ra.city AS [City],
		ra.[State] AS [State],
		ra.zip AS [Zip],
		r.LastModified AS [SearchDate],
		r.RegistryID AS [loc],
		'Web' AS [Source]

	FROM DMV_Common.dbo.Registry r
	JOIN DMV_Common.dbo.RegistryAddr ra ON r.RegistryID = ra.RegistryID

	WHERE RegistryOwnerID = @RegistryOwnerID
	AND ra.[State] = @RegistryState
	AND r.DeleteFlag = 0
	AND	r.DOB = @DOB
	AND (@FirstName IS NULL OR r.FirstName IS NULL OR PATINDEX(@FirstName, r.FirstName) > 0)
	AND (@MiddleName IS NULL OR r.MiddleName IS NULL OR PATINDEX(@MiddleName, r.MiddleName) > 0)
	AND (@LastName IS NULL OR r.LastName IS NULL OR PATINDEX(@LastName, r.LastName) > 0)
	AND (@LICENSE IS NULL OR r.License IS NULL OR PATINDEX(@License, r.License) > 0)
	AND (@StreetAddress IS NULL OR ra.Addr1 IS NULL OR PATINDEX(@StreetAddress, ra.Addr1) > 0)
	AND (@City IS NULL OR ra.City IS NULL OR PATINDEX(@City, ra.City) > 0)
	AND (@State IS NULL OR ra.State IS NULL OR PATINDEX(@State, ra.State) > 0)
	AND (@Zip IS NULL OR ra.Zip IS NULL OR PATINDEX(@Zip, ra.Zip) > 0 )

	ORDER BY r.LastModified DESC;

GO