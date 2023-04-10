SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_TruncateImportOrganizationClean]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_TruncateImportOrganizationClean]
GO

CREATE PROCEDURE SPD_TruncateImportOrganizationClean AS

Truncate table dbo.Import_Organization_Clean
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

