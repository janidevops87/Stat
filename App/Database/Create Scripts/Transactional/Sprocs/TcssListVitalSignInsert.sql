

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'TcssListVitalSignInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssListVitalSignInsert'
		DROP Procedure TcssListVitalSignInsert
	END
GO

PRINT 'Creating Procedure TcssListVitalSignInsert'
GO
CREATE Procedure TcssListVitalSignInsert
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
**	File: TcssListVitalSignInsert.sql
**	Name: TcssListVitalSignInsert
**	Desc: Inserts TcssListVitalSign Based on Id field 
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

INSERT	TcssListVitalSign
	(
		LastUpdateStatEmployeeId,
		LastUpdateDate,
		SortOrder,
		IsActive,
		FieldValue,
		ConfigVersion,
		IsLiver,
		IsKidney
	)
VALUES
	(
		@LastUpdateStatEmployeeId,
		@LastUpdateDate,
		@SortOrder,
		@IsActive,
		@FieldValue,
		@ConfigVersion,
		@IsLiver,
		@IsKidney
	)

SET @TcssListVitalSignID = SCOPE_IDENTITY()

EXEC TcssListVitalSignSelect @TcssListVitalSignID

GO

GRANT EXEC ON TcssListVitalSignInsert TO PUBLIC
GO
