SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPU_Report]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPU_Report]
GO


--***************************************************************************
--    Procedure Name : SPU_Report
--
--
--    Description    : Update Report row
--
--    Author         : DOGGY\doborsh
--    Date Written   : 14/04/2004
--
--***************************************************************************

CREATE PROCEDURE  SPU_Report
                  @ReportID                   	int ,
                  @ReportDisplayName          	varchar(50) ,
                  @LastModified               	datetime,
                  @ReportLocalOnly            	int=0,
                  @ReportVirtualURL           	varchar(100)=NULL,
                  @ReportTypeID               	smallint =NULL,
                  @Unused                     	varbinary(50) =NULL,
                  @ReportDescFileName         	varchar(50)=NULL,
                  @UpdatedFlag                	smallint=NULL,
                  @ReportSortOrderID          	smallint =NULL,
                  @ReportInDevelopment        	smallint =NULL,
                  @ReportFromDate             	smallint=NULL,
                  @ReportToDate               	smallint =NULL,
                  @ReportGroup                	smallint=NULL,
                  @ReportOrganization         	smallint=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intError      int

    SELECT   @intRetCode = 0


    UPDATE        Report
    SET
                  ReportDisplayName          = @ReportDisplayName ,
                  LastModified               = @LastModified ,
                  ReportLocalOnly            = @ReportLocalOnly ,
                  ReportVirtualURL           = @ReportVirtualURL ,
                  ReportTypeID               = @ReportTypeID ,
                  Unused                     = @Unused ,
                  ReportDescFileName         = @ReportDescFileName ,
                  UpdatedFlag                = @UpdatedFlag ,
                  ReportSortOrderID          = @ReportSortOrderID ,
                  ReportInDevelopment        = @ReportInDevelopment ,
                  ReportFromDate             = @ReportFromDate ,
                  ReportToDate               = @ReportToDate ,
                  ReportGroup                = @ReportGroup ,
                  ReportOrganization         = @ReportOrganization
    WHERE         ReportID                   = @ReportID


    SELECT @intRowCount = @@rowcount, @intError = @@error
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

RETURN @intRetCode

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

