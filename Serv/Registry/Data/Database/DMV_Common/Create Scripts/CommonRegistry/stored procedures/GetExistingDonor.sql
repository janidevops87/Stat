 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetExistingDonor]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetExistingDonor]
	PRINT 'Dropping Procedure: GetExistingDonor'
END
	PRINT 'Creating Procedure: GetExistingDonor'
GO


CREATE PROCEDURE [dbo].[GetExistingDonor]
	@RegistryID int,
	@RegistryOwnerID int,
	@FirstName varchar(40) = NULL,
	@LastName varchar(40) = NULL,
	@LastFourSSN varchar(4) = Null,
	@License nvarchar(10) = Null,
	@DOB	datetime = NULL,
	@City varchar(40) = NULL,
	@State varchar(2) = NULL,
	@Zip varchar(40) = NULL,
	@returnVal	int OUTPUT
AS
/******************************************************************************
**		File: GetExistingDonor.sql
**		Name: GetExistingDonor
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll	
**		Date: 03/24/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/24/2008	ccarroll	initial release
**		07/19/2013	ccarroll	Added @RegitryOwnerID and @License parameters
**		01/21/2014	ccarroll	Added check to avoid duplicates
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

DECLARE @DonorsFound int

/* Donor Matches - returned values in()
	Count Description Output()
	0 = New donor (-1)
	1 = Update donor (RegistryID)
	> 1 = Don't allow update (0)
*/

/* Strip Wildcards for patindex use
	wild cards permitted but not required.
	searches will return exact match only.
IF  PATINDEX('%*%', @FirstName) > 0
BEGIN 	SET @FirstName =  '*' + REPLACE(@FirstName, '*', '%') END ELSE
BEGIN 	SET @FirstName =  '%' + @FirstName END

IF  PATINDEX('%*%', @LastName) > 0
BEGIN 	SET @LastName =  '*' + REPLACE(@LastName, '*', '%') END ELSE
BEGIN 	SET @LastName =  '%' + @LastName END
*/


DECLARE @DonorTable Table
	(
		RegistryID			Int Null
	)

/* Find donor match and put IDs in table */
INSERT @DonorTable

	SELECT Registry.RegistryID

	FROM	Registry
	WHERE
			RegistryOwnerID = coalesce(@RegistryOwnerID, RegistryOwnerID) AND
			Registry.DOB = coalesce(@DOB, Registry.DOB) AND
			PATINDEX('%' + @FirstName +'%', Registry.FirstName) > 0 AND
			PATINDEX('%' + @LastName + '%', Registry.LastName) > 0 AND
			PATINDEX('%' + @LastFourSSN + '%', '-' + Registry.SSN) > 0 AND
			PATINDEX('%' + @License + '%', '-' + coalesce(Registry.License, '')) > 0 AND

			coalesce(Registry.DonorConfirmed, 0) = 1 AND 
			coalesce(Registry.DeleteFlag, 1) = 0

			 

/* */
SET @DonorsFound = (SELECT Count(*) FROM @DonorTable)

SET @ReturnVal =
(SELECT CASE WHEN @DonorsFound = 0 THEN -1 /* New Donor */
			WHEN @DonorsFound = 1 THEN (Select Top 1 RegistryID FROM @DonorTable) /* Return RegistryID */
			WHEN @DonorsFound > 1 THEN 0 /* Return 0 - Don't allow update */
		END AS 'RegistryID')

RETURN @ReturnVal
/* test
	SELECT * FROM @DonorTable
*/