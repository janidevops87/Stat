 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetZipCodeCityRegion]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetZipCodeCityRegion]
	PRINT 'Dropping Procedure: GetZipCodeCityRegion'
END
	PRINT 'Creating Procedure: GetZipCodeCityRegion'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetZipCodeCityRegion]
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