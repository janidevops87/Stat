IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistryv2]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	PRINT 'Dropping Procedure: sps_CheckRegistryv2';
	DROP PROCEDURE [dbo].[sps_CheckRegistryv2];
END
	PRINT 'Creating Procedure: sps_CheckRegistryv2';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[sps_CheckRegistryv2]
(
	@DOB   			DATETIME    	= NULL,
	@LastName		VARCHAR(25) 	= NULL,
	@FirstName 		VARCHAR(25) 	= NULL,
	@NADD 			INT	       		= NULL, -- NADD = No Additional Donor Data	
	@MiddleName 	VARCHAR(25) 	= NULL,
	@SSN   			VARCHAR(11) 	= NULL,
	@LICENSE 		VARCHAR(15) 	= NULL,
	@StreetAddress 	VARCHAR(45) 	= NULL,
	@City 			VARCHAR(25) 	= NULL,
	@State 			VARCHAR(2) 		= NULL,
	@Zip 			VARCHAR(10) 	= NULL,
	@loc			INT				= NULL,
	@Found			VARCHAR(25)		= NULL
)
/******************************************************************************
**		File: sps_CheckRegistryv2.sql
**		Name: sps_CheckRegistryv2
**		Desc:  Returns dla registry data based on DOB, FirstName, & LastName
**		Paramameters
**			See above
**
**		Called by:  StatQuery.vb
**              
**		Auth: ccarroll
**		Date: 4/27/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    04/27/2009	ccarroll			initial for DMV_Common
**	  11/16/2016	mberenson			Added DLA logic
*******************************************************************************/
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	
	SET NOCOUNT ON;
	PRINT @loc;

	-- DECLARE VARIABLES
	DECLARE @DLAID INT,
		@DLADonor BIT,
		@DLADate SMALLDATETIME,
		@DLARecordsReturned INT;

	IF @Found = 'DLA' OR ISNULL(@Found,'') = '' 
	BEGIN			
		EXEC DMV_Common.dbo.sps_CheckRegistry_DLA	
			@DOB, 
			@LastName, 
			@FirstName, 
			@DLAID OUTPUT,
			@DLADonor OUTPUT,
			@DLADate OUTPUT,
			@DLARecordsReturned OUTPUT;
	END

	-- if @DLAID is null return a blank record set
	IF (@DLAID IS NULL)	
	-- no values were found
	-- return empty record set
	BEGIN
			
		SELECT
			'No Registration' AS 'Source',
			0 AS 'ID',
			'N' AS 'Donor' ,
			'1/1/1900' AS 'Date',
			0 AS 'RestrictionID',
			'R' AS 'Organization',
			@DLARecordsReturned AS 'RecordsReturned';
				
			RETURN;

	END	
	ELSE
	-- if we have a dla record
	BEGIN
		SELECT
			'DLA' AS 'Source',
			@DLAID AS 'ID',
			CASE @DLADonor WHEN 1 THEN 'Y' ELSE 'N' END AS 'Donor' ,
			@DLADate AS 'Date'	,
			CASE @DLADonor WHEN 1 THEN @DLAID ELSE 0 END AS 'RestrictionID';
		RETURN;		

	END

GO