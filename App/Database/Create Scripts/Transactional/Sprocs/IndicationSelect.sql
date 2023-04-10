IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IndicationSelect')
	BEGIN
		PRINT 'Dropping Procedure IndicationSelect'
		DROP Procedure IndicationSelect
	END
GO

PRINT 'Creating Procedure IndicationSelect'
GO
CREATE Procedure IndicationSelect
(
		@IndicationID int = null output
)
AS
/******************************************************************************
**	File: IndicationSelect.sql
**	Name: IndicationSelect
**	Desc: Selects multiple rows of Indication Based on Id  fields 
**	Auth: ccarroll
**	Date: 11/20/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/20/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Indication.IndicationID,
		Indication.IndicationName,
		Indication.IndicationNote,
		Indication.Verified,
		IsNull(Indication.Inactive, 0) AS Inactive,
		Indication.LastModified,
		Indication.IndicationHighRisk,
		Indication.UpdatedFlag,
		Indication.IndicationResponseID,
		Indication.IndicationResponseName,
		Indication.IndicationQuestionAssociatedID,
		Indication.LastStatEmployeeID,
		Indication.AuditLogTypeID
	FROM 
		dbo.Indication 
	WHERE 
		Indication.IndicationID = ISNULL(@IndicationID, Indication.IndicationID)

	ORDER BY Indication.IndicationName

GRANT EXEC ON IndicationSelect TO PUBLIC
GO
