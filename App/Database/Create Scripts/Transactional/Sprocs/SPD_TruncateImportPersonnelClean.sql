SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_TruncateImportPersonnelClean]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_TruncateImportPersonnelClean]
GO

CREATE PROCEDURE SPD_TruncateImportPersonnelClean AS

Truncate table dbo.Import_Personnel_Clean
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

