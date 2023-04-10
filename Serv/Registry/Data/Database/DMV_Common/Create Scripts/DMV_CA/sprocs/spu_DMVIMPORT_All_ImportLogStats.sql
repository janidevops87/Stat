if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_DMVIMPORT_All_ImportLogStats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spu_DMVIMPORT_All_ImportLogStats'
	drop procedure [dbo].[spu_DMVIMPORT_All_ImportLogStats]
End
GO

	PRINT 'Creating spu_DMVIMPORT_All_ImportLogStats'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE spu_DMVIMPORT_All_ImportLogStats AS
/******************************************************************************
**		File: spu_DMVIMPORT_All_ImportLogStats.sql
**		Name: spu_DMVIMPORT_All_ImportLogStats
**		Desc: 
**
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 10/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/10/2007  ccarroll			initial
*******************************************************************************/
declare @@RDonorY             int
declare @@RDonorChange        int
declare @@RM                  int
declare @@RF                  int
declare @@RMDonorY            int
declare @@RFDonorY            int
declare @@RM18Total           int
declare @@RM18DonorY          int
declare @@RF18Total           int
declare @@RF18DonorY          int
declare @@RM17Total           int
declare @@RM17DonorY          int
declare @@RF17Total           int
declare @@RF17DonorY          int
select @@RDonorChange = count(DMVIMPORT.ID)
from DMVIMPORT, DMV
where DMVIMPORT.LICENSE      = DMV.LICENSE
and   upper(DMVIMPORT.DONOR) = 'Y'
and   DMV.DONOR           = 0
select @@RM = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "M"
select @@RF = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "F"
select @@RMDonorY = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
select @@RFDonorY = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
select @@RM18Total = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "M"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RF18Total = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "F"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RM18DonorY = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RF18DonorY = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) >= (getdate()-(18*365))
select @@RM17Total = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "M"
and   convert(datetime,DOB) < (getdate()-(18*365))
select @@RF17Total = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "F"
and   convert(datetime,DOB) < (getdate()-(18*365))
select @@RM17DonorY = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) < (getdate()-(18*365))
select @@RF17DonorY = count(DMVIMPORT.ID)
from DMVIMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
and   convert(datetime,DOB) < (getdate()-(18*365))
update DMVIMPORTLOGSTATS
set RDonorY          = @@RDonorY,
    RDonorChange     = @@RDonorChange,
    RM               = @@RM,
    RF               = @@RF,
    RMDonorY         = @@RMDonorY,
    RFDonorY         = @@RFDonorY,
    RM18Total        = @@RM18Total,
    RM18DonorY       = @@RM18DonorY,
    RF18Total        = @@RF18Total,
    RF18DonorY       = @@RF18DonorY,
    RM17Total        = @@RM17Total,
    RM17DonorY       = @@RM17DonorY,
    RF17Total        = @@RF17Total,
    RF17DonorY       = @@RF17DonorY
where RunStatus = 'LOADING'



GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

