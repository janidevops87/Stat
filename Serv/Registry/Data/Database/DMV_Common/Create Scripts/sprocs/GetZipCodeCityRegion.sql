IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetZipCodeCityRegion')
	BEGIN
		PRINT 'Dropping Procedure GetZipCodeCityRegion'
		DROP  Procedure  GetZipCodeCityRegion
	END

GO

PRINT 'Creating Procedure GetZipCodeCityRegion'
GO
CREATE Procedure GetZipCodeCityRegion
	@State VARCHAR(2)
AS

/******************************************************************************
**		File: GetZipCodeCityRegion.SQL
**		Name: GetZipCodeCityRegion
**		Desc: Queries list of Zip Code, Cities and Regions
**
** 
**		Called by:   
**			Statline.Registry.Data.GetZipCodeCityRegion 
**			sps_Common_GetZipCodeCityRegion
**              
**
**		Auth: Bret Knoll
**		Date: 4/22/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**    04/22/08		Bret Knoll		Initial
*******************************************************************************/


SELECT
	0 'checked',     
	ZipCode, 
	City, 
	@State AS State
FROM         
	ZipCodeCityRegion

ORDER BY ZipCode



GO

GRANT EXEC ON GetZipCodeCityRegion TO PUBLIC

GO
