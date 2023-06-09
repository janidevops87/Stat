SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_IMPORT_PersonnelImportLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_IMPORT_PersonnelImportLog]
GO

CREATE PROCEDURE spu_IMPORT_PersonnelImportLog AS

DECLARE @RecordsTotal Int, @CurrentLogId Int

-- Get the total of imported records
SET @RecordsTotal = (SELECT count(Import_Personnel.ID) FROM Import_Personnel)

-- Get the current ID of the Import_Personnel_Log_ID table
SET @CurrentLogId = (SELECT TOP 1 ID AS Import_Personnel_Log_ID FROM Import_Personnel_Log WHERE RunStatus = 'LOADING' ORDER BY ID Desc);

-- Update the log
UPDATE Import_Personnel_Log
	SET RecordsTotal = @RecordsTotal
	WHERE ID = @CurrentLogId;

-- Update the records currently in the Import_Personnel table with the LogId
UPDATE Import_Personnel
	SET Import_Personnel_Log_Id = @CurrentLogId;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

