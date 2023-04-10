 /****************************************************************************
** 
** File:   
** Name: spi_Audit_TcssDonor.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/21/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonor
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
SET ANSI_NULLS ON     
go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonor]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
begin
	drop procedure [dbo].[spi_Audit_TcssDonor]
	PRINT 'Drop Sproc: spi_Audit_TcssDonor'  
END   
go
PRINT 'Create Sproc: spi_Audit_TcssDonor'  
go
create procedure "spi_Audit_TcssDonor"  (@TcssDonorId int  ,@LastUpdateStatEmployeeId int  ,@LastUpdateDate datetime  ,@OptnNumber varchar(20)  )  AS  
begin
	insert into DBO.TcssDonor  ("TcssDonorId" 
	,"LastUpdateStatEmployeeId" 
	,"LastUpdateDate" 
	,"OptnNumber"  )  
	VALUES   (    @TcssDonorId  ,@LastUpdateStatEmployeeId  ,@LastUpdateDate  ,@OptnNumber   )  
END    
 go
 SET QUOTED_IDENTIFIER OFF   
 go
 SET ANSI_NULLS ON   
 go
  