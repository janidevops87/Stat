Print 'Modify Table ServiceLevel' 
 
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON

/*	ccarroll 09/19/2007 - changed ServiceLevelBillMedSocManualEnableDflt DEFAULT -1
						-1 indicates the default is set to manual bill.
						 See Empirix ticket 6950 

	ccarroll 09/21/2007 - changed DEFAULT Values (-1) for:
						- ServiceLevelAlwaysPopRegistry
						- ServiceLevelVerifyWeightEnable
						- ServiceLevelVerifySexEnable
*/
	

COMMIT
BEGIN TRANSACTION

ALTER TABLE ServiceLevel ADD
  ServiceLevelAlwaysPopRegistry	smallint NULL CONSTRAINT ServiceLevelAlwaysPopRegistry DEFAULT -1 WITH VALUES,
  ServiceLevelBillSecondaryManualEnable smallint NULL CONSTRAINT ServiceLevelBillSecondaryManualEnableDflt DEFAULT 0 WITH VALUES,
  ServiceLevelBillFamilyApproachManualEnable smallint NULL CONSTRAINT ServiceLevelBillFamilyApproachManualEnableDflt DEFAULT 0 WITH VALUES,
  ServiceLevelBillMedSocManualEnable smallint NULL CONSTRAINT ServiceLevelBillMedSocManualEnableDflt DEFAULT -1 WITH VALUES,
  ServiceLevelVerifyWeight smallint NULL CONSTRAINT ServiceLevelVerifyWeightEnable DEFAULT -1 WITH VALUES,
  ServiceLevelVerifySex	smallint NULL CONSTRAINT ServiceLevelVerifySexEnable DEFAULT -1 WITH VALUES
  
GO
COMMIT
