IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spi_Import_ImportApply_A')
	BEGIN
		PRINT 'Dropping Procedure spi_Import_ImportApply_A'
		DROP  Procedure  spi_Import_ImportApply_A
	END

GO

PRINT 'Creating Procedure spi_Import_ImportApply_A'
GO
CREATE Procedure spi_Import_ImportApply_A
	
AS

/******************************************************************************
**		File: 
**		Name: spi_Import_ImportApply_A
**		Desc: This stored procedure moves records from the staging table in Import_A to the Import table
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**      							-----------
**
**
**		Auth: unknown
**		Date: unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		09/05/2007  Thien Ta 			Added code for PreviousDonorStatus	 
**		01/17/2014	Moonray Schepart	Integration Into Common Registry  
**		02/25/2015	Bret Knoll			Modified code to update the previous donorstatus  
**	
*******************************************************************************/

print 'Update import'
update IMPORT
set DECEASEDDATE = a.DECEASEDDATE,
    CSORSTATE    = a.CSORSTATE,
    CSORLICENSE  = a.CSORLICENSE
from IMPORT i, IMPORT_A a
where i.LICENSE = a.LICENSE;

insert IMPORT(IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE)
select        IMPORTLOGID, LAST, FIRST, MIDDLE, SUFFIX, AADDR1, ACITY, ASTATE, AZIP, BADDR1, BCITY, BSTATE, BZIP, DOB, GENDER, LICENSE, DONOR, RENEWALDATE, DECEASEDDATE, CSORSTATE, CSORLICENSE
from IMPORT_A
where LICENSE NOT IN (select LICENSE
                      from IMPORT);


-- update the previous donorstatus
-- based on the latest renewaldate/onlinedate 
-- if the dmv date is the latest set the previousdonorstatus to the dmv donor status
-- if the registry date is the latest set the previousodnorstatus tot he registry donor status
-- default to the dmv donor stauts
declare @RegistryOwnerId int
SELECT @RegistryOwnerId = RegistryOwnerID
FROM DMV_Common.dbo.RegistryOwner
WHERE RegistryOwnerName = 'CODA';


UPDATE IMPORT
SET PreviousDonorState = CASE WHEN COALESCE(D.RenewalDate, D.LastModified)		> COALESCE(R.OnlineRegDate, R.LastModified) THEN D.DONOR 
							  WHEN COALESCE(R.OnlineRegDate, R.LastModified)	> COALESCE(D.RenewalDate, D.LastModified)  THEN R.DONOR 
							ELSE D.Donor END
FROM IMPORT A
INNER JOIN DMV D ON D.License = A.LICENSE	
LEFT JOIN DMV_Common.dbo.Registry R on A.LICENSE = R.License 
WHERE	R.License is not null 
and		R.RegistryOwnerID = @RegistryOwnerId 
AND		R.DeleteFlag = 0

GO



GRANT EXEC ON spi_Import_ImportApply_A TO PUBLIC

GO
