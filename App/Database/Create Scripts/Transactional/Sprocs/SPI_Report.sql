SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_Report]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_Report]
GO


--***************************************************************************
--    Procedure Name : SPI_Report
--
--
--    Description    : Add Report row
--
--    Author         : DOGGY\doborsh
--    Date Written   : 14/04/2004
--
--***************************************************************************
CREATE PROCEDURE  SPI_Report
                  @ReportID                   int OUTPUT ,
                  @ReportDisplayName          varchar(50) ,
                  @LastModified               datetime ,
                  @ReportLocalOnly            int=0,
                  @ReportVirtualURL           varchar(100)=NULL,
                  @ReportTypeID               smallint=NULL,
                  @Unused                     varbinary(50)=NULL,
                  @ReportDescFileName         varchar(50)=NULL,
                  @UpdatedFlag                smallint=NULL,
                  @ReportSortOrderID          smallint=NULL,
                  @ReportInDevelopment        smallint=NULL,
                  @ReportFromDate             smallint=NULL,
                  @ReportToDate               smallint=NULL,
                  @ReportGroup                smallint=NULL,
                  @ReportOrganization         smallint=NULL
AS

/* $Revision $ */

    DECLARE  @intRetCode    int,
             @intRowcount   int,
             @intIdentity   int,
             @intError      int

    SELECT   @intRetCode    = 0


    INSERT        Report (
                  ReportDisplayName ,
                  LastModified ,
                  ReportLocalOnly ,
                  ReportVirtualURL ,
                  ReportTypeID ,
                  Unused ,
                  ReportDescFileName ,
                  UpdatedFlag ,
                  ReportSortOrderID ,
                  ReportInDevelopment ,
                  ReportFromDate ,
                  ReportToDate ,
                  ReportGroup ,
                  ReportOrganization
                  )
    SELECT
                  @ReportDisplayName ,
                  @LastModified ,
                  @ReportLocalOnly ,
                  @ReportVirtualURL ,
                  @ReportTypeID ,
                  @Unused ,
                  @ReportDescFileName ,
                  @UpdatedFlag ,
                  @ReportSortOrderID ,
                  @ReportInDevelopment ,
                  @ReportFromDate ,
                  @ReportToDate ,
                  @ReportGroup ,
                  @ReportOrganization


    SELECT @intRowCount = @@rowcount, @intError = @@error, @intIdentity = @@identity
    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
--      Insert error handling
        SELECT @intRetcode = 6
        RETURN -(@intRetcode)
    END

SELECT @ReportID = @intIdentity

RETURN @intRetCode

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

