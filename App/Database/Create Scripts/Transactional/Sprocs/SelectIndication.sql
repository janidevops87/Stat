

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectIndication')
	BEGIN
		PRINT 'Dropping Procedure SelectIndication'
		PRINT GETDATE()
		DROP Procedure SelectIndication
	END
GO

PRINT 'Creating Procedure SelectIndication'
PRINT GETDATE()
GO
CREATE Procedure SelectIndication
(
		@IndicationID int = null output					
)
AS
/******************************************************************************
**	File: SelectIndication.sql
**	Name: SelectIndication
**	Desc: Selects multiple rows of Indication Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Indication.IndicationID,
		Indication.IndicationName,
		Indication.IndicationNote,
		Indication.Verified,
		Indication.Inactive,
		Indication.LastModified,
		Indication.IndicationHighRisk,
		Indication.UpdatedFlag
	FROM 
		dbo.Indication 

	WHERE 
		Indication.IndicationID = ISNULL(@IndicationID, Indication.IndicationID)				

GO

GRANT EXEC ON SelectIndication TO PUBLIC
GO
