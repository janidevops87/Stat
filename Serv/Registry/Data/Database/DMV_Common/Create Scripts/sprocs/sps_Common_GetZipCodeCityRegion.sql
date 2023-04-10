IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_Common_GetZipCodeCityRegion')
	BEGIN
		PRINT 'Dropping Procedure sps_Common_GetZipCodeCityRegion'
		DROP  Procedure  sps_Common_GetZipCodeCityRegion
	END

GO

PRINT 'Creating Procedure sps_Common_GetZipCodeCityRegion'
GO
CREATE Procedure sps_Common_GetZipCodeCityRegion
	@State			varchar(25) = NULL
AS

/******************************************************************************
**		File: sps_Common_GetZipCodeCityRegion
**		Name: sps_Common_GetZipCodeCityRegion
**		Desc: Cals the sproc GetZipCodeCityRegion
**
**		Called by:   
**			Statline.Registry.Data.GetZipCodeCityRegion 
** 
**              
**
**		Auth: Bret Knoll
**		Date: 4/22/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      4/23/08		Bret Knoll			Initial
*******************************************************************************/
DECLARE @StateDSN varchar(25)
DECLARE @SQLString varchar(500)

/* Get StateDSN */
SET @StateDSN = (SELECT DSN FROM StateDSNLookup WHERE State = @State)

SET @SQLString = 'GetZipCodeCityRegion ''' +  
						 @State + ''';'

--PRINT @SQLString
IF(LEN(@STATEDSN)>0)
BEGIN
EXEC (@StateDSN + '..' + @SQLString)
END




GO

GRANT EXEC ON sps_Common_GetZipCodeCityRegion TO PUBLIC

GO
