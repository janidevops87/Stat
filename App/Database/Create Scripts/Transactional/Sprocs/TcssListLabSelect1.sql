

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TcssListLabSelect1')
	BEGIN
		PRINT 'Dropping Procedure TcssListLabSelect1'
		DROP Procedure TcssListLabSelect1
	END
GO

PRINT 'Creating Procedure TcssListLabSelect1'
GO
CREATE Procedure TcssListLabSelect1
(
		@TcssListLabId int = null output	
)
AS
/******************************************************************************
**	File: TcssListLabSelect1.sql
**	Name: TcssListLabSelect1
**	Desc: Selects multiple rows of TcssListLab Based on Id  fields 
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
	IF @TcssListLabId =0
		BEGIN
			/* Display All  */
			SET @TcssListLabId =null
		END
	SELECT
		TcssListLab.TcssListLabId,
		TcssListLab.LastUpdateStatEmployeeId,
		TcssListLab.LastUpdateDate,
		TcssListLab.SortOrder,
		TcssListLab.FieldValue,
		TcssListLab.IsActive,
		TcssListLab.ConfigVersion,
		TcssListLab.IsLiver,
		TcssListLab.IsKidney
	FROM 
		dbo.TcssListLab 
	
	WHERE 
		TcssListLab.TcssListLabId = ISNULL(@TcssListLabId, TcssListLab.TcssListLabId)
					
	ORDER BY 4
GO

GRANT EXEC ON TcssListLabSelect TO PUBLIC
GO
