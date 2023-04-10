 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorVitalSignSummary.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorVitalSignSummary**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 GO
   SET ANSI_NULLS ON     
 GO
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorVitalSignSummary]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 BEGIN
	 drop procedure [dbo].[spi_Audit_TcssDonorVitalSignSummary]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorVitalSignSummary'  
 END   
 GO
 PRINT 'Create Sproc: spi_Audit_TcssDonorVitalSignSummary'  
 GO
    create procedure "spi_Audit_TcssDonorVitalSignSummary"  
	(   @TcssDonorVitalSignSummaryId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@Sao2Initial varchar(50) 
,@Sao2Peak varchar(50) 
,@Sao2Current varchar(50) 
,@Sao2InitialFromDate datetime  
,@Sao2InitialToDate datetime  
,@Sao2PeakFromDate datetime  
,@Sao2PeakToDate datetime  
,@Sao2CurrentFromDate datetime  
,@Sao2CurrentToDate datetime   ) 
 AS  
 BEGIN
 insert into DBO.TcssDonorVitalSignSummary  
 (   "TcssDonorVitalSignSummaryId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"Sao2Initial" 
,"Sao2Peak" 
,"Sao2Current" 
,"Sao2InitialFromDate" 
,"Sao2InitialToDate" 
,"Sao2PeakFromDate" 
,"Sao2PeakToDate" 
,"Sao2CurrentFromDate" 
,"Sao2CurrentToDate"  )  
VALUES   
(    @TcssDonorVitalSignSummaryId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@Sao2Initial  
,@Sao2Peak  
,@Sao2Current  
,@Sao2InitialFromDate  
,@Sao2InitialToDate  
,@Sao2PeakFromDate  
,@Sao2PeakToDate  
,@Sao2CurrentFromDate  
,@Sao2CurrentToDate   )  
END    
 GO
 SET QUOTED_IDENTIFIER OFF   
 GO
 SET ANSI_NULLS ON   
 GO
  