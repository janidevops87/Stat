IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'ListSourceCodeSelect')
	BEGIN
		PRINT 'Dropping Procedure ListSourceCodeSelect'
		DROP Procedure ListSourceCodeSelect
	END
GO

PRINT 'Creating Procedure ListSourceCodeSelect'
GO

CREATE PROCEDURE dbo.ListSourceCodeSelect
AS
/***************************************************************************************************
**	Name: ListSourceCodeSelect
**	Desc: Select Data from table ListSourceCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
**	04/19/2011	ccarroll		Added Oasis SourceCode Call Type
***************************************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
	
SELECT
	sc.SourceCodeId AS ListId,
	sc.SourceCodeName AS FieldValue
FROM dbo.SourceCode sc
JOIN CallType ON CallType.CallTypeID = sc.SourceCodeCallTypeID AND (SourceCodeCallTypeID = 6) 
WHERE sc.SourceCodeName is not null
ORDER BY FieldValue
GO

GRANT EXEC ON ListSourceCodeSelect TO PUBLIC
GO
