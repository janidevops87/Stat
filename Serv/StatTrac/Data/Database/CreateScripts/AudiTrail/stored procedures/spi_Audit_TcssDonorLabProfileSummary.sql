 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorLabProfileSummary.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorLabProfileSummary**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorLabProfileSummary]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorLabProfileSummary]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorLabProfileSummary'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorLabProfileSummary'  
 GO
    create procedure "spi_Audit_TcssDonorLabProfileSummary"  
	(   @TcssDonorLabProfileSummaryId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@AlcHbalcInitial varchar(50) 
,@AlcHbalcPeak varchar(50) 
,@AlcHbalcCurrent varchar(50) 
,@AlcHbalcInitialFromDate datetime  
,@AlcHbalcInitialToDate datetime  
,@AlcHbalcPeakFromDate datetime  
,@AlcHbalcPeakToDate datetime  
,@AlcHbalcCurrentFromDate datetime  
,@AlcHbalcCurrentToDate datetime   ) 
 AS  
 BEGIN
 
 insert into DBO.TcssDonorLabProfileSummary  
 (   "TcssDonorLabProfileSummaryId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"AlcHbalcInitial" 
,"AlcHbalcPeak" 
,"AlcHbalcCurrent" 
,"AlcHbalcInitialFromDate" 
,"AlcHbalcInitialToDate" 
,"AlcHbalcPeakFromDate" 
,"AlcHbalcPeakToDate" 
,"AlcHbalcCurrentFromDate" 
,"AlcHbalcCurrentToDate"  )  
VALUES   
(    @TcssDonorLabProfileSummaryId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@AlcHbalcInitial  
,@AlcHbalcPeak  
,@AlcHbalcCurrent  
,@AlcHbalcInitialFromDate  
,@AlcHbalcInitialToDate  
,@AlcHbalcPeakFromDate  
,@AlcHbalcPeakToDate  
,@AlcHbalcCurrentFromDate  
,@AlcHbalcCurrentToDate   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  