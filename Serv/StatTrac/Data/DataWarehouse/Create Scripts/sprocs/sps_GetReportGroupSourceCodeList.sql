SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GetReportGroupSourceCodeList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GetReportGroupSourceCodeList]
GO


CREATE PROCEDURE sps_GetReportGroupSourceCodeList 
	@ReportGroupID int,
	@SourceCodeList varchar(200) output

AS

DECLARE @SourceCodeID int

 /* SOURCECODES ******************************************************************************************************************************/
   declare cSOURCECODE cursor for 
      select SourceCodeID from vwDataWarehouseWebReportGroupSourceCode where WebReportGroupID = @ReportGroupID order by SourceCodeID asc

    open cSOURCECODE
    fetch next from cSOURCECODE into @SourceCodeID
    
    while @@fetch_status = 0
    begin
    
      Select @SourceCodeList = CASE ISNULL(@SourceCodeList, '')
				WHEN '' THEN CAST(@SourceCodeID AS varchar)
				ELSE @SourceCodeList + ',' + CAST(@SourceCodeID AS varchar)
			          END
    
      fetch next from cSOURCECODE into @SourceCodeID
    end

    close cSOURCECODE
    deallocate cSOURCECODE

--select @SourceCodeList













GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

