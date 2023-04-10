IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'FN' AND name = 'RemoveSpecialChars')
	BEGIN
		PRINT 'Dropping Function RemoveSpecialChars'
		DROP Function RemoveSpecialChars
	END
GO

PRINT 'Creating Function RemoveSpecialChars' 
GO 

/******************************************************************************
**		File: RemoveSpecialChars.sql
**		Name: Remove Special (Non-Alpha-Numeric) Characters
**		Desc: Strips special (non-alpha-numeric) characters
**
**		Auth: Mike Berenson
**		Date: 6/18/2019
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      6/18/2019	Mike Berenson		initial
*******************************************************************************/

CREATE FUNCTION [dbo].[RemoveSpecialChars](@stringToStrip VARCHAR(256)) RETURNS VARCHAR(256) WITH SCHEMABINDING
AS
BEGIN
	--Make sure @stringToStrip isn't null
	IF @stringToStrip IS NULL
		RETURN NULL;

	--Initialize Variables
	DECLARE @stringToReturn VARCHAR(256) = '';
	DECLARE @stringToStripLength INT = LEN(@stringToStrip);
	DECLARE @characterPosition INT = 1;

	--Look at each character to make sure it's valid
	WHILE @characterPosition <= @stringToStripLength BEGIN
		DECLARE @characterAsciiCode INT = ASCII(SUBSTRING(@stringToStrip, @characterPosition, 1))
		IF @characterAsciiCode BETWEEN 48 AND 57 OR @characterAsciiCode BETWEEN 65 AND 90 OR @characterAsciiCode BETWEEN 97 and 122
			SET @stringToReturn = @stringToReturn + CHAR(@characterAsciiCode)
		SET @characterPosition = @characterPosition + 1
    END
   
	--Make sure @stringToReturn isn't null
	IF LEN(@stringToReturn) = 0
		RETURN NULL;

   RETURN @stringToReturn
END