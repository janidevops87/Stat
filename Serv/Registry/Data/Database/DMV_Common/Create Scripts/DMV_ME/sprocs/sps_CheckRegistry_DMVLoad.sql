IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_CheckRegistry_DMVLoad]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping sps_CheckRegistry_DMVLoad';
	DROP PROCEDURE [dbo].[sps_CheckRegistry_DMVLoad];
END
	PRINT 'Creating sps_CheckRegistry_DMVLoad';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE sps_CheckRegistry_DMVLoad
(
 	@DOB			SMALLDATETIME   = NULL,
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
**		File: sps_CheckRegistry_DMVLoad.sql
**		Name: sps_CheckRegistry_DMVLoad
**		Desc: This sp searches for qualified donor using the FirstName, MiddleName, & LastName fields
**             
**		Return values: none
**
**		Called by:  FrmReferralDonorData.vb
**              
**		Parameters:
**
**		Auth: Unknown
**		Date: 3/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    10/15/2007	ccarroll			Added FirstName, and LastName to select
**	  10/17/2016	mberenson			Return DLA records from DMV_Common with results
**	  10/19/2016	mberenson			Changed source for dmv records to "State"
**	  11/16/2016	mberenson			Moved DLA logic to DMV_Common.sps_CheckRegistry_DLALoad.sql
**	  12/12/2016	mberenson			Return just the newest record
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;

	--Allow Wildcard Searching
	IF @FirstName IS NOT Null
	BEGIN
		SET @FirstName = '%' + @FirstName + '%';
	END
	IF @LastName IS NOT Null
	BEGIN
		SET @LastName = '%' + @LastName + '%';
	END

	--Look Up DMV Results
	SELECT TOP 1
			DMV.FirstName,
			DMV.MiddleName ,
			DMV.LastName,
			DMV.License,
			DMVAddr.Addr1,
			DMVAddr.City,
			DMVAddr.[State],
			DMVAddr.Zip,
			DMV.LastModified AS 'SearchDate',
			DMV.ID AS 'Loc',
			'State' AS [Source]
	FROM DMV
	LEFT JOIN DMVAddr ON DMVAddr.DMVID = DMV.ID
	WHERE		DMV.DOB = @DOB
		/* Search (wildcards permitted) - LastName */
			AND (@LastName IS NULL OR DMV.LastName IS NULL OR PATINDEX(@LastName, DMV.LastName) > 0)
		/* Search (wildcards permitted) - FirstName */
			AND (@FirstName IS NULL OR DMV.FirstName IS NULL OR PATINDEX(@FirstName, DMV.FirstName) > 0)
			AND (@MiddleName IS NULL OR DMV.MiddleName IS NULL OR PATINDEX(@MiddleName, DMV.MiddleName) > 0)
			AND (@License IS NULL OR DMV.License IS NULL OR PATINDEX(@License, DMV.License) > 0)
			AND (@StreetAddress IS NULL OR DMVADDR.Addr1 IS NULL OR PATINDEX(@StreetAddress, DMVADDR.Addr1) > 0)
			AND (@City IS NULL OR DMVADDR.City IS NULL OR PATINDEX(@City, DMVADDR.City) > 0)
			AND (@State IS NULL OR DMVADDR.State IS NULL OR PATINDEX(@State, DMVADDR.State) > 0)
			AND (@Zip IS NULL OR DMVADDR.Zip IS NULL OR PATINDEX(@Zip, DMVADDR.Zip) > 0)
	ORDER BY DMV.LastModified DESC;

GO