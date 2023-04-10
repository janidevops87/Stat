 /****************************************************************************** 
**  File:  
**  Name: spi_Audit_TcssDonorLabProfile.sql 
**  Desc:  
** 
**  Date:    Author:    Description: 
**  --------   --------   ------------------------------------------- 
**  06/23/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorLabProfile**   
*******************************************************************************/
SET QUOTED_IDENTIFIER ON   
 go
   SET ANSI_NULLS ON     
 go
 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorLabProfile]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
	 begin drop procedure [dbo].[spi_Audit_TcssDonorLabProfile]
	 PRINT 'Drop Sproc: spi_Audit_TcssDonorLabProfile'  
 END   
 go
 PRINT 'Create Sproc: spi_Audit_TcssDonorLabProfile'  
 go
 create procedure "spi_Audit_TcssDonorLabProfile" 
 (   @TcssDonorLabProfileId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime   )  
AS  
 begin 
 insert into DBO.TcssDonorLabProfile  
 (   "TcssDonorLabProfileId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime"  )  
VALUES   
(    @TcssDonorLabProfileId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@SampleDateTime   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  