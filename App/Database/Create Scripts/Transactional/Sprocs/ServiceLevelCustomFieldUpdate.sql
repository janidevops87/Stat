

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomFieldUpdate')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelCustomFieldUpdate'
		DROP Procedure ServiceLevelCustomFieldUpdate
	END
GO

PRINT 'Creating Procedure ServiceLevelCustomFieldUpdate'
GO
CREATE Procedure ServiceLevelCustomFieldUpdate
(
		@ServiceLevelID int = null output,
		@ServiceLevelCustomOn smallint = null,
		@ServiceLevelCustomTextAlert varchar(255) = null,
		@ServiceLevelCustomListAlert varchar(255) = null,
		@ServiceLevelCustomFieldLabel1 varchar(40) = null,
		@ServiceLevelCustomFieldLabel2 varchar(40) = null,
		@ServiceLevelCustomFieldLabel3 varchar(40) = null,
		@ServiceLevelCustomFieldLabel4 varchar(40) = null,
		@ServiceLevelCustomFieldLabel5 varchar(40) = null,
		@ServiceLevelCustomFieldLabel6 varchar(40) = null,
		@ServiceLevelCustomFieldLabel7 varchar(40) = null,
		@ServiceLevelCustomFieldLabel8 varchar(40) = null,
		@ServiceLevelCustomFieldLabel9 varchar(40) = null,
		@ServiceLevelCustomFieldLabel10 varchar(40) = null,
		@ServiceLevelCustomFieldLabel11 varchar(40) = null,
		@ServiceLevelCustomFieldLabel12 varchar(40) = null,
		@ServiceLevelCustomFieldLabel13 varchar(40) = null,
		@ServiceLevelCustomFieldLabel14 varchar(40) = null,
		@ServiceLevelCustomFieldLabel15 varchar(40) = null,
		@ServiceLevelCustomFieldLabel16 varchar(40) = null,
		@LastModified datetime = null					
)
AS
/******************************************************************************
**	File: ServiceLevelCustomFieldUpdate.sql
**	Name: ServiceLevelCustomFieldUpdate
**	Desc: Updates ServiceLevelCustomField Based on Id field 
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

UPDATE
	dbo.ServiceLevelCustomField 	
SET 
		ServiceLevelCustomOn = @ServiceLevelCustomOn,
		ServiceLevelCustomTextAlert = @ServiceLevelCustomTextAlert,
		ServiceLevelCustomListAlert = @ServiceLevelCustomListAlert,
		ServiceLevelCustomFieldLabel1 = @ServiceLevelCustomFieldLabel1,
		ServiceLevelCustomFieldLabel2 = @ServiceLevelCustomFieldLabel2,
		ServiceLevelCustomFieldLabel3 = @ServiceLevelCustomFieldLabel3,
		ServiceLevelCustomFieldLabel4 = @ServiceLevelCustomFieldLabel4,
		ServiceLevelCustomFieldLabel5 = @ServiceLevelCustomFieldLabel5,
		ServiceLevelCustomFieldLabel6 = @ServiceLevelCustomFieldLabel6,
		ServiceLevelCustomFieldLabel7 = @ServiceLevelCustomFieldLabel7,
		ServiceLevelCustomFieldLabel8 = @ServiceLevelCustomFieldLabel8,
		ServiceLevelCustomFieldLabel9 = @ServiceLevelCustomFieldLabel9,
		ServiceLevelCustomFieldLabel10 = @ServiceLevelCustomFieldLabel10,
		ServiceLevelCustomFieldLabel11 = @ServiceLevelCustomFieldLabel11,
		ServiceLevelCustomFieldLabel12 = @ServiceLevelCustomFieldLabel12,
		ServiceLevelCustomFieldLabel13 = @ServiceLevelCustomFieldLabel13,
		ServiceLevelCustomFieldLabel14 = @ServiceLevelCustomFieldLabel14,
		ServiceLevelCustomFieldLabel15 = @ServiceLevelCustomFieldLabel15,
		ServiceLevelCustomFieldLabel16 = @ServiceLevelCustomFieldLabel16,
		LastModified = GetDate()
WHERE 
	ServiceLevelID = @ServiceLevelID 				

GO

GRANT EXEC ON ServiceLevelCustomFieldUpdate TO PUBLIC
GO
