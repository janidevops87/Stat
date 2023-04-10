

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TcssListVitalSignSelect1')
	BEGIN
		PRINT 'Dropping Procedure TcssListVitalSignSelect1'
		DROP Procedure TcssListVitalSignSelect1
	END
GO

PRINT 'Creating Procedure TcssListVitalSignSelect1'
GO
CREATE Procedure TcssListVitalSignSelect1
(
		@TcssListVitalSignId int = null output
)
AS
/******************************************************************************
**	File: TcssListVitalSignSelect1.sql
**	Name: TcssListVitalSignSelect1
**	Desc: Selects multiple rows of TcssListVitalSign Based on Id  fields 
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
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	IF @TcssListVitalSignId =0
		BEGIN
			/* Display All  */
			SET @TcssListVitalSignId =null
		END
	SELECT
		TcssListVitalSign.TcssListVitalSignId,
		TcssListVitalSign.LastUpdateStatEmployeeId,
		TcssListVitalSign.LastUpdateDate,
		TcssListVitalSign.SortOrder,
		TcssListVitalSign.FieldValue,
		TcssListVitalSign.IsActive,
		TcssListVitalSign.ConfigVersion,
		TcssListVitalSign.IsLiver,
		TcssListVitalSign.IsKidney
	FROM 
		dbo.TcssListVitalSign 
	
	WHERE 
		TcssListVitalSign.TcssListVitalSignId = ISNULL(@TcssListVitalSignId, TcssListVitalSign.TcssListVitalSignId)
				
	ORDER BY 4
GO

GRANT EXEC ON TcssListVitalSignSelect TO PUBLIC
GO
