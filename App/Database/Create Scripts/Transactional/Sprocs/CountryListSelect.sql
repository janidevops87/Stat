 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[CountryListSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[CountryListSelect]
	PRINT 'Dropping Procedure: CountryListSelect'
END
	PRINT 'Creating Procedure: CountryListSelect'
GO

CREATE PROCEDURE [dbo].[CountryListSelect]
(
	@COUNTRYID int = NULL
)
/******************************************************************************
**		File: CountryListSelect.sql
**		Name: CountryListSelect
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 7/6/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/6/2009	bret	initial
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[COUNTRYID] AS ListId,
		COUNTRYNAME AS FieldValue
	
	FROM
		[Country]	
	ORDER BY 2


	RETURN @@Error
GO
