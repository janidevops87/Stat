  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetFormVerification]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetFormVerification]
	PRINT 'Dropping Procedure: GetFormVerification'
END
	PRINT 'Creating Procedure: GetFormVerification'
GO


CREATE PROCEDURE [dbo].[GetFormVerification]
	@SourceID int = NULL,
	@Source varchar(10) = NULL, /* Web, DMV, DMV_MI, Web_MI */
	@State varchar(2) = NULL
AS
/******************************************************************************
**		File: GetFormVerification.sql
**		Name: GetFormVerification
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
**		Auth: Chris Carroll	
**		Date: 04/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		04/02/2008		Chris Carroll			initial release
**		06/03/2014		Moonray Schepart		Integration of MI Web Portal
**		01/03/2017		Michael Maitan			Added VerificationComment to #TempVerificationResultTable to fix verification form errors
*******************************************************************************/
DECLARE @StateID int
DECLARE @StateDSN varchar(25)
DECLARE @SQLString varchar(500)



DECLARE @StateTable Table
	(
		ID					int IDENTITY (1, 1) NOT NULL,
		State				varchar(25) Null,
		DSN					varchar(25) Null
	)


CREATE TABLE #TempVerificationResultTable
	(
		VerificationFullName					varchar(150) Null,
		VerificationDOB							varchar(50) Null,
		VerificationResidentialAddress			varchar(150) Null,
		VerificationCityStateZip				varchar(100)	Null,
		VerificationLimitations					varchar(1000) Null,
		VerificationSignatureDate				varchar(50) Null,
		VerificationForm						varchar(50) Null,
		VerificationStateID						varchar(100) Null,
		VerificationComment						varchar(1000) Null

	)
	
IF IsNull(@Source, '') = 'DMV' OR IsNull(@Source, '') = 'DMV_MI'
BEGIN
	
	/* Get State data for report*/
	Insert @StateTable
			SELECT RegistryOwnerStateAbbrv, RegistryOwnerStateDMVDSN
			FROM RegistryOwnerStateConfig 
			WHERE RegistryOwnerStateAbbrv IN(SELECT * FROM dbo.ParseVarcharValueString(@State))


	/* Build report data for DMVs selected */
	SET @StateID = 1

		WHILE (Select Count(*) FROM @StateTable WHERE ID = @StateID) > 0
		BEGIN

				SET @StateDSN = (Select DSN FROM @StateTable WHERE ID = @StateID)

				SET @SQLString = 'GetDMVVerification_Select ' +  CAST(@SourceID AS varchar) + ';'

				--PRINT @SQLString
				INSERT #TempVerificationResultTable
							EXEC (@StateDSN + '..' + @SQLString)

		SET @StateID = (@StateID + 1)
		END --DMV State Loop 		

END --DMV Search

IF IsNull(@Source, '') = 'Web'
BEGIN
		SET @SQLString = 'GetWebVerification_Select ' +  CAST(@SourceID AS varchar) + ';'
							
		--PRINT @SQLString
		INSERT #TempVerificationResultTable
					EXEC (@SQLString)

END

IF IsNull(@Source, '') = 'Web_MI'
BEGIN
	
	SET @StateDSN = 'DMV_MI';

	SET @SQLString = 'GetWebVerification_Select ' +  CAST(@SourceID AS varchar) + ';'

	--PRINT @StateDSN + '..' + @SQLString;
	INSERT #TempVerificationResultTable
				EXEC (@StateDSN + '..' + @SQLString)	

END --Web MI Search

UPDATE #TempVerificationResultTable
SET VerificationDOB = COALESCE(VerificationDOB,'');

/* Finial Select */
SELECT * FROM #TempVerificationResultTable

