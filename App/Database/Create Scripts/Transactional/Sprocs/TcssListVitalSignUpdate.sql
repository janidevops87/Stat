

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'TcssListVitalSignUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssListVitalSignUpdate'
		DROP Procedure TcssListVitalSignUpdate
	END
GO

PRINT 'Creating Procedure TcssListVitalSignUpdate'
GO
CREATE Procedure TcssListVitalSignUpdate
(
		@TcssListVitalSignId int = null output,
		@LastUpdateStatEmployeeId int = null,
		@LastUpdateDate datetime = null,
		@SortOrder int = null,
		@IsActive bit = null,
		@FieldValue varchar(100) = null,
		@ConfigVersion bigint = null,
		@IsLiver bit = null,
		@IsKidney bit = null				
)
AS
/******************************************************************************
**	File: TcssListVitalSignUpdate.sql
**	Name: TcssListVitalSignUpdate
**	Desc: Updates TcssListVitalSign Based on Id field 
**	Auth: Bret Knoll
**	Date: 12/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/23/2009		Bret Knoll			Initial Sproc Creation
*******************************************************************************/

UPDATE
	dbo.TcssListVitalSign 	
SET 
		LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
		LastUpdateDate = @LastUpdateDate,
		SortOrder = @SortOrder,
		IsActive = @IsActive,
		FieldValue = @FieldValue,
		ConfigVersion = @ConfigVersion,
		IsLiver = @IsLiver,
		IsKidney = @IsKidney
WHERE 
	TcssListVitalSignId = @TcssListVitalSignId 				

GO

GRANT EXEC ON TcssListVitalSignUpdate TO PUBLIC
GO
