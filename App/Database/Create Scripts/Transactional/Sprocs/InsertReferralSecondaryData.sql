IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertReferralSecondaryData')
	BEGIN
		PRINT 'Dropping Procedure InsertReferralSecondaryData'
		DROP  Procedure  InsertReferralSecondaryData
	END

GO

PRINT 'Creating Procedure InsertReferralSecondaryData'
GO
CREATE Procedure InsertReferralSecondaryData
	@ReferralID int , 
	@ReferralSecondaryHistory varchar(500) = NULL , 
	@hdBloodRecv48 smallint = NULL , 
	@hdWholeBloodUnits float = NULL , 
	@hdWholeBloodAmt float = NULL , 
	@hdRedBloodUnits float = NULL , 
	@hdRedBloodAmt float = NULL , 
	@hdColloid_1 float = NULL , 
	@hdColloid_2 float = NULL , 
	@hdColloid_3 float = NULL , 
	@hdColloid_4 float = NULL , 
	@hdColloid_List varchar(50) = NULL , 
	@hdCrystalloid_1 float = NULL , 
	@hdCrystalloid_2 float = NULL , 
	@hdCrystalloid_3 float = NULL , 
	@hdCrystalloid_4 float = NULL , 
	@hdCrystalloid_List varchar(50) = NULL , 
	@hdQuest1_1 smallint = NULL , 
	@hdQuest2_1 smallint = NULL , 
	@hdQuest2_2 smallint = NULL , 
	@hdQuest2_3 smallint = NULL , 
	@hdQuest2_4 smallint = NULL , 
	@hdQuest3_1 smallint = NULL , 
	@hdQuest3_2 smallint = NULL , 
	@hdQuest3_3 smallint = NULL , 
	@hdQuest3_4 smallint = NULL , 
	@fscUserID int = NULL , 
	@hdLastModified datetime = NULL , 
	@hdQuest3_2a varchar(50) = NULL , 
	@hdQuest3_3a varchar(50) = NULL , 
	@hdQuest3_4a varchar(50) = NULL , 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL 	
AS

/******************************************************************************
**		File: InsertReferralSecondaryData.sql
**		Name: InsertReferralSecondaryData
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**     see list above
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail
*******************************************************************************/
INSERT 
	ReferralSecondaryData 
	( 
	ReferralID,
	ReferralSecondaryHistory,
	LastModified,
	hdBloodRecv48,
	hdWholeBloodUnits,
	hdWholeBloodAmt,
	hdRedBloodUnits,
	hdRedBloodAmt,
	hdColloid_1,
	hdColloid_2,
	hdColloid_3,
	hdColloid_4,
	hdColloid_List,
	hdCrystalloid_1,
	hdCrystalloid_2,
	hdCrystalloid_3,
	hdCrystalloid_4,
	hdCrystalloid_List,
	hdQuest1_1,
	hdQuest2_1,
	hdQuest2_2,
	hdQuest2_3,
	hdQuest2_4,
	hdQuest3_1,
	hdQuest3_2,
	hdQuest3_3,
	hdQuest3_4,
	fscUserID,
	hdLastModified,
	hdQuest3_2a,
	hdQuest3_3a,
	hdQuest3_4a,
	LastStatEmployeeID,
	AuditLogTypeID	
	) 
VALUES 
	(
	@ReferralID, 
	@ReferralSecondaryHistory, 
	GetDate(), -- @LastModified, 
	@hdBloodRecv48, 
	@hdWholeBloodUnits, 
	@hdWholeBloodAmt, 
	@hdRedBloodUnits, 
	@hdRedBloodAmt, 
	@hdColloid_1, 
	@hdColloid_2, 
	@hdColloid_3, 
	@hdColloid_4, 
	@hdColloid_List, 
	@hdCrystalloid_1, 
	@hdCrystalloid_2, 
	@hdCrystalloid_3, 
	@hdCrystalloid_4, 
	@hdCrystalloid_List, 
	@hdQuest1_1, 
	@hdQuest2_1, 
	@hdQuest2_2, 
	@hdQuest2_3, 
	@hdQuest2_4, 
	@hdQuest3_1, 
	@hdQuest3_2, 
	@hdQuest3_3, 
	@hdQuest3_4, 
	@fscUserID, 
	@hdLastModified, 
	@hdQuest3_2a, 
	@hdQuest3_3a, 
	@hdQuest3_4a, 
	@LastStatEmployeeID, 
	1 --@AuditLogTypeID 1 = Create	
	) 

SELECT 
	ReferralID,
	ReferralSecondaryHistory,
	hdBloodRecv48,
	hdWholeBloodUnits,
	hdWholeBloodAmt,
	hdRedBloodUnits,
	hdRedBloodAmt,
	hdColloid_1,
	hdColloid_2,
	hdColloid_3,
	hdColloid_4,
	hdColloid_List,
	hdCrystalloid_1,
	hdCrystalloid_2,
	hdCrystalloid_3,
	hdCrystalloid_4,
	hdCrystalloid_List,
	hdQuest1_1,
	hdQuest2_1,
	hdQuest2_2,
	hdQuest2_3,
	hdQuest2_4,
	hdQuest3_1,
	hdQuest3_2,
	hdQuest3_3,
	hdQuest3_4,
	fscUserID,
	hdLastModified,
	hdQuest3_2a,
	hdQuest3_3a,
	hdQuest3_4a
FROM
	ReferralSecondaryData	
WHERE
	ReferralID = @ReferralID 



GO

GRANT EXEC ON InsertReferralSecondaryData TO PUBLIC

GO
