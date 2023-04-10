

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomFieldSelect')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelCustomFieldSelect'
		DROP Procedure ServiceLevelCustomFieldSelect
	END
GO

PRINT 'Creating Procedure ServiceLevelCustomFieldSelect'
GO
CREATE Procedure ServiceLevelCustomFieldSelect
(
		@ServiceLevelID int = null output					
)
AS
/******************************************************************************
**	File: ServiceLevelCustomFieldSelect.sql
**	Name: ServiceLevelCustomFieldSelect
**	Desc: Selects multiple rows of ServiceLevelCustomField Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/28/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/28/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		ServiceLevelCustomField.ServiceLevelID,
		ServiceLevelCustomField.ServiceLevelCustomOn,
		ServiceLevelCustomField.ServiceLevelCustomTextAlert,
		ServiceLevelCustomField.ServiceLevelCustomListAlert,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel1,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel2,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel3,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel4,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel5,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel6,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel7,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel8,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel9,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel10,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel11,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel12,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel13,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel14,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel15,
		ServiceLevelCustomField.ServiceLevelCustomFieldLabel16,
		ServiceLevelCustomField.LastModified
	FROM 
		dbo.ServiceLevelCustomField 
	JOIN
		ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevelCustomField.ServiceLevelID
	WHERE 
		ServiceLevelCustomField.ServiceLevelID = ISNULL(@ServiceLevelID, ServiceLevelCustomField.ServiceLevelID)				
	ORDER BY 1
GO

GRANT EXEC ON ServiceLevelCustomFieldSelect TO PUBLIC
GO
