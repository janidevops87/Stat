 /****************************************************************************
** 
** File:   
** Name: spi_Audit_TcssDonorAbg.sql  
** Desc:   
** 
** Date:    Author:    Description:  
** --------   --------   -------------------------------------------  
** 06/22/2011  Jim Hawkins  Insert Audit records for DBO.TcssDonorAbg
**   *******************************************************************************/
SET QUOTED_IDENTIFIER ON   
go
SET ANSI_NULLS ON     
go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_TcssDonorAbg]') and OBJECTPROPERTY(id,N'IsProcedure') = 1) 
 begin 
 drop procedure [dbo].[spi_Audit_TcssDonorAbg]
 PRINT 'Drop Sproc: spi_Audit_TcssDonorAbg'  
 END   
 go 
 PRINT 'Create Sproc: spi_Audit_TcssDonorAbg'  
 go
create procedure "spi_Audit_TcssDonorAbg"  
(   @TcssDonorAbgId int  
,@LastUpdateStatEmployeeId int  
,@LastUpdateDate datetime  
,@TcssDonorId int  
,@SampleDateTime smalldatetime  
,@Ph decimal  
,@Pco2 decimal  
,@Po2 decimal  
,@Hco3 decimal  
,@O2sat decimal  
,@TcssListVentSettingModeId int  
,@ModeOther varchar(50) 
,@Fio2 decimal  
,@Rate decimal  
,@Vt decimal  
,@Peep decimal  
,@Pip decimal   )  
AS  
 begin 
  insert into DBO.TcssDonorAbg  (   "TcssDonorAbgId" 
,"LastUpdateStatEmployeeId" 
,"LastUpdateDate" 
,"TcssDonorId" 
,"SampleDateTime" 
,"Ph" 
,"Pco2" 
,"Po2" 
,"Hco3" 
,"O2sat" 
,"TcssListVentSettingModeId" 
,"ModeOther" 
,"Fio2" 
,"Rate" 
,"Vt" 
,"Peep" 
,"Pip"  )  
VALUES   (    @TcssDonorAbgId  
,@LastUpdateStatEmployeeId  
,@LastUpdateDate  
,@TcssDonorId  
,@SampleDateTime  
,@Ph  
,@Pco2  
,@Po2  
,@Hco3  
,@O2sat  
,@TcssListVentSettingModeId  
,@ModeOther  
,@Fio2  
,@Rate  
,@Vt  
,@Peep  
,@Pip   )  
END    
 go 
 SET QUOTED_IDENTIFIER OFF   
 go 
 SET ANSI_NULLS ON   
 go  