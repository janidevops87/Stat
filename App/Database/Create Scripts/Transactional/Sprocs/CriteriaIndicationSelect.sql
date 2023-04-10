IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaIndicationSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaIndicationSelect'
		DROP Procedure CriteriaIndicationSelect
	END
GO

PRINT 'Creating Procedure CriteriaIndicationSelect'
GO
CREATE Procedure [dbo].[CriteriaIndicationSelect]
(		
		@CriteriaID int = null,
		@IndicationID int = null
)
AS
/******************************************************************************
**	File: CriteriaIndicationSelect.sql
**	Name: CriteriaIndicationSelect
**	Desc: Selects multiple rows of CriteriaIndication Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/22/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/22/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @TEMPCriteriaIndication TABLE
	(
		CriteriaIndicationID int NULL,
		CriteriaID int NULL,
		IndicationID int NULL,
		LastModified datetime NULL,
		IndicationHighRisk	smallint NULL,
		IndicationStandardMRO smallint NULL,
		UpdatedFlag	smallint NULL,		
		LastStatEmployeeID int NULL,
		AuditLogTypeID int NULL,
		IndicationName VARCHAR(80),
		IndicationResponseName  VARCHAR(50),
		Hidden BIT,
		IDCOLUMN INT IDENTITY(-1, -1)
	) 
	
	--- FIRST SELECT SELECTED VALUES INTO A TEMP TABLE
	INSERT @TEMPCriteriaIndication
	SELECT
		CriteriaIndication.CriteriaIndicationID,
		CriteriaIndication.CriteriaID,
		Indication.IndicationID,
		CriteriaIndication.LastModified,		
		CriteriaIndication.IndicationHighRisk,
		CriteriaIndication.IndicationStandardMRO,
		CriteriaIndication.UpdatedFlag,
		CriteriaIndication.LastStatEmployeeID,
		CriteriaIndication.AuditLogTypeID,
		Indication.IndicationName,
		IndicationResponse.IndicationResponseName,
		0 AS 'Hidden'		
	
	FROM 
		dbo.CriteriaIndication
	JOIN 
		Indication ON CriteriaIndication.IndicationID = Indication.IndicationID	 
	LEFT JOIN 
		IndicationResponse ON Indication.IndicationResponseID = IndicationResponse.IndicationResponseID
	WHERE 
		CriteriaIndication.CriteriaID = ISNULL(@CriteriaID, CriteriaIndication.CriteriaID)
		
		

-- NEXT ADD THE RECORDS NOT SELECTED
	IF (@CriteriaID IS NOT NULL)
	BEGIN
		INSERT 
			@TEMPCriteriaIndication
		SELECT
			CriteriaIndication.CriteriaIndicationID, 
			COALESCE(CriteriaIndication.CriteriaID, @CriteriaID),
			Indication.IndicationID,
			COALESCE(CriteriaIndication.LastModified, GETDATE()),		
			CriteriaIndication.IndicationHighRisk,
			CriteriaIndication.IndicationStandardMRO,
			CriteriaIndication.UpdatedFlag,
			COALESCE(CriteriaIndication.LastStatEmployeeID, -1),
			COALESCE(CriteriaIndication.AuditLogTypeID, 0),
			Indication.IndicationName,
			IndicationResponse.IndicationResponseName,
			1 AS 'Hidden'			
		FROM 
			Indication 
			
		LEFT JOIN 
			CriteriaIndication ON CriteriaIndication.IndicationID = Indication.IndicationID	
			AND CriteriaIndication.CriteriaID = @CriteriaID
		LEFT JOIN 
			IndicationResponse ON Indication.IndicationResponseID = IndicationResponse.IndicationResponseID
		WHERE 
			CriteriaIndication.CriteriaIndicationID IS NULL

							
	END
	-- finally select the values from the temp table note.
	SELECT
		COALESCE(CriteriaIndicationID, IDCOLUMN) AS CriteriaIndicationID,
		CriteriaID,
		IndicationID,
		LastModified,		
		IndicationHighRisk,
		IndicationStandardMRO,
		UpdatedFlag,		
		LastStatEmployeeID,
		AuditLogTypeID,
		IndicationName,
		IndicationResponseName,
		Hidden
	FROM 
		@TEMPCriteriaIndication
	ORDER BY
		IndicationName

GO


