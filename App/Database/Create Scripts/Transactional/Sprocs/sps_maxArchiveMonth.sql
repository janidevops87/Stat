SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_maxArchiveMonth]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_maxArchiveMonth]
GO

CREATE PROCEDURE sps_maxArchiveMonth AS

SELECT DATEADD(d,1,MAX(TableDate)) AS 'maxDate' FROM ArchiveStatus


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

