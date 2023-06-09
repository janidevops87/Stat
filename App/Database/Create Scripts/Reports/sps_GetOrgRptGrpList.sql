SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_GetOrgRptGrpList]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'DROP PROCEDURE [dbo].[sps_GetOrgRptGrpList]';
	PRINT GETDATE();
	DROP PROCEDURE [dbo].[sps_GetOrgRptGrpList];
END

PRINT 'CREATE PROCEDURE sps_GetOrgRptGrpList';
GO


CREATE PROCEDURE sps_GetOrgRptGrpList

	@RptGrpID	INT	= NULL,
	@RefType	INT	= NULL

 /***************************************************************************************************
**	Name: OrganizationPhone
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
**	09/24/2020	Mike Berenson	Refactored to improve performance
***************************************************************************************************/
AS
BEGIN

	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	-- Handle default parameters for zOldOrganizationsByReportGroup
	IF @RptGrpID = 0
	BEGIN
		SET @RptGrpID = NULL;
	END
	IF @RefType = 0
	BEGIN
		SET @RefType = NULL;
	END

	--Main Query
	SELECT DISTINCT
		'(' + p.PhoneAreaCode + ') ' + p.PhonePrefix + '-' + p.PhoneNumber AS Phone,
		o.OrganizationName,
		o.OrganizationAddress1,
		o.OrganizationCity,
		c.CountyName,
		o.OrganizationZipCode,
		ot.OrganizationTypeName
	FROM 
		Organization o
		LEFT JOIN OrganizationPhone op ON o.OrganizationID = op.OrganizationID AND op.SubLocationID = 60 -- MAIN
		LEFT JOIN Phone p ON p.PhoneID = op.PhoneID
		JOIN County c ON c.CountyID = o.CountyID
		JOIN OrganizationType ot ON ot.OrganizationTypeID = o.OrganizationTypeID
		JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = o.OrganizationID
		JOIN WebReportGroup wrg ON wrg.WebReportGroupID = wrgo.WebReportGroupID
	WHERE
			(@RptGrpID IS NULL OR wrg.WebReportGroupID = @RptGrpID)
		AND (@RefType IS NULL OR ot.OrganizationTypeID = @RefType)
	ORDER BY 
		ot.OrganizationTypeName, 
		o.OrganizationName ASC;

END
GO

SET QUOTED_IDENTIFIER OFF; 
GO
SET ANSI_NULLS ON;
GO

