IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateReferralSecondaryData')
	BEGIN
		PRINT 'Dropping Procedure UpdateReferralSecondaryData'
		DROP  Procedure  UpdateReferralSecondaryData
	END

GO

PRINT 'Creating Procedure UpdateReferralSecondaryData'
GO
CREATE Procedure UpdateReferralSecondaryData
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
	@LastStatEmployeeID int, 
	@AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdateReferralSecondaryData.sql
**		Name: UpdateReferralSecondaryData
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
UPDATE 
	ReferralSecondaryData 
SET 
	ReferralSecondaryHistory = @ReferralSecondaryHistory, 
	LastModified = GetDate(), 
	hdBloodRecv48 = ISNULL(@hdBloodRecv48, hdBloodRecv48), 
	hdWholeBloodUnits = ISNULL(@hdWholeBloodUnits, hdWholeBloodUnits), 
	hdWholeBloodAmt = ISNULL(@hdWholeBloodAmt, hdWholeBloodAmt), 
	hdRedBloodUnits = ISNULL(@hdRedBloodUnits, hdRedBloodUnits), 
	hdRedBloodAmt = ISNULL(@hdRedBloodAmt, hdRedBloodAmt), 
	hdColloid_1 = ISNULL(@hdColloid_1, hdColloid_1), 
	hdColloid_2 = ISNULL(@hdColloid_2, hdColloid_2), 
	hdColloid_3 = ISNULL(@hdColloid_3, hdColloid_3), 
	hdColloid_4 = ISNULL(@hdColloid_4, hdColloid_4), 
	hdColloid_List = @hdColloid_List, 
	hdCrystalloid_1 = ISNULL(@hdCrystalloid_1, hdCrystalloid_1), 
	hdCrystalloid_2 = ISNULL(@hdCrystalloid_2, hdCrystalloid_2), 
	hdCrystalloid_3 = ISNULL(@hdCrystalloid_3, hdCrystalloid_3), 
	hdCrystalloid_4 = ISNULL(@hdCrystalloid_4, hdCrystalloid_4), 
	hdCrystalloid_List = @hdCrystalloid_List, 
	hdQuest1_1 = ISNULL(@hdQuest1_1, hdQuest1_1), 
	hdQuest2_1 = ISNULL(@hdQuest2_1, hdQuest2_1), 
	hdQuest2_2 = ISNULL(@hdQuest2_2, hdQuest2_2), 
	hdQuest2_3 = ISNULL(@hdQuest2_3, hdQuest2_3), 
	hdQuest2_4 = ISNULL(@hdQuest2_4, hdQuest2_4), 
	hdQuest3_1 = ISNULL(@hdQuest3_1, hdQuest3_1), 
	hdQuest3_2 = ISNULL(@hdQuest3_2, hdQuest3_2), 
	hdQuest3_3 = ISNULL(@hdQuest3_3, hdQuest3_3), 
	hdQuest3_4 = ISNULL(@hdQuest3_4, hdQuest3_4), 
	fscUserID = ISNULL(@fscUserID, fscUserID), 
	hdLastModified = ISNULL(@hdLastModified, hdLastModified), 
	hdQuest3_2a = @hdQuest3_2a, 
	hdQuest3_3a = @hdQuest3_3a, 
	hdQuest3_4a = @hdQuest3_4a, 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify	
WHERE 
	ReferralID = @ReferralID





GO

GRANT EXEC ON UpdateReferralSecondaryData TO PUBLIC

GO
