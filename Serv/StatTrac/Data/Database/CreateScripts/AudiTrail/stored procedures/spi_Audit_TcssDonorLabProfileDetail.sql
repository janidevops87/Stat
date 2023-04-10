 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorLabProfileDetail.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorLabProfileDetail**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
   if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorLabProfileDetail]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) begin
 drop procedure [dbo].[spi_Audit_TcssDonorLabProfileDetail]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorLabProfileDetail'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorLabProfileDetail'  
 go
    create procedure "spi_Audit_TcssDonorLabProfileDetail"  (   @TcssDonorLabProfileDetailId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@TcssDonorLabProfileId int  
,@TcssListLabId int  
,@Answer varchar(50)  )  AS  begin
 insert into DBO.TcssDonorLabProfileDetail  
 (   "TcssDonorLabProfileDetailId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"TcssDonorLabProfileId" 
,"TcssListLabId" 
,"Answer"  )  
VALUES   
(    @TcssDonorLabProfileDetailId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@TcssDonorLabProfileId  
,@TcssListLabId  
,@Answer   ) 
 END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  