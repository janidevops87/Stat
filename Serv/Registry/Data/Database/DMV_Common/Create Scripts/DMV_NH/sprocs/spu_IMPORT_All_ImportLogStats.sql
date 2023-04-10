    IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spu_IMPORT_All_ImportLogStats]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spu_IMPORT_All_ImportLogStats]
	PRINT 'Dropping Procedure: spu_IMPORT_All_ImportLogStats'
END
	PRINT 'Creating Procedure: spu_IMPORT_All_ImportLogStats'
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spu_IMPORT_All_ImportLogStats] AS
/******************************************************************************
**		File: sps_IMPORT_All_ImportDonorFull.sql
**		Name: sps_IMPORT_All_ImportDonorFull
**		Desc:  
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 11/09/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		11/09/2009	ccarroll	initial
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
select @@RDonorChange = count(IMPORT.ID)
from IMPORT, DMV
where IMPORT.LICENSE      = DMV.LICENSE
and   upper(IMPORT.DONOR) = 'Y'
and   DMV.DONOR           = 0
select @@RM = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
select @@RF = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
select @@RMDonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
select @@RFDonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
select @@RM18Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   convert(datetime,LEFT(DOB, 10)) >= (getdate()-(18*365))
select @@RF18Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   convert(datetime,LEFT(DOB, 10)) >= (getdate()-(18*365))
select @@RM18DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
and   convert(datetime,LEFT(DOB, 10)) >= (getdate()-(18*365))
select @@RF18DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
and   convert(datetime,LEFT(DOB, 10)) >= (getdate()-(18*365))
select @@RM17Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   convert(datetime,LEFT(DOB, 10)) < (getdate()-(18*365))
select @@RF17Total = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   convert(datetime,LEFT(DOB, 10)) < (getdate()-(18*365))
select @@RM17DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "M"
and   upper(DONOR)  = "Y"
and   convert(datetime,LEFT(DOB, 10)) < (getdate()-(18*365))
select @@RF17DonorY = count(IMPORT.ID)
from IMPORT
where upper(Gender) = "F"
and   upper(DONOR)  = "Y"
and   convert(datetime,LEFT(DOB, 10)) < (getdate()-(18*365))
update IMPORTLOGSTATS
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
