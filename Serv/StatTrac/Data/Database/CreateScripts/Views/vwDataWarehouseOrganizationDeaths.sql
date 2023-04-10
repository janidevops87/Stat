IF EXISTS (SELECT NAME FROM Master.sys.databases WHERE NAME LIKE '_ReferralProd_DataWarehouse')
BEGIN
	DECLARE 
		@SQL VARCHAR(8000),
		@DROPSQL VARCHAR(8000)
	SET @DROPSQL =
	'	IF EXISTS (SELECT * FROM sysobjects WHERE type = ''V'' AND name = ''vwDataWarehouseOrganizationDeaths'')
			BEGIN
				PRINT ''DROPPING View  vwDataWarehouseOrganizationDeaths''
				
				DROP  View  vwDataWarehouseOrganizationDeaths
			END
			PRINT ''CREATING View  vwDataWarehouseOrganizationDeaths''
	'
	SET @SQL = 
	'
		CREATE View vwDataWarehouseOrganizationDeaths

		/******************************************************************************
		**		File: vwDataWarehouseOrganizationDeaths.sql
		**		Name: vwDataWarehouseOrganizationDeaths
		**		Desc: 
		**
		** 
		**		Called by:   
		**              
		**
		**		Auth: Bret Knoll
		**		Date: 12/8/2008
		*******************************************************************************
		**		Change History
		*******************************************************************************
		**		Date:		Author:				Description:
		**		--------	--------				-------------------------------------------
		**		12/8/2008			Bret Knoll			View of Organization Deahs in the Datawarehouse DB
		*******************************************************************************/
		AS
			SELECT * FROM _ReferralProd_DataWarehouse.dbo.OrganizationDeaths
	'		
	EXEC(@DROPSQL)
	EXEC(@SQL)
END