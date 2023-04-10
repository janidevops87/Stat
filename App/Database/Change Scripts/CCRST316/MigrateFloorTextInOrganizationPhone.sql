/******************************************************************************
**		File: MigrateFloorTextInOrganizationPhone.sql
**		Name: Add MigrateFloorTextInOrganizationPhone
**		Desc: Text field now held in table

		TODO:  At some point, we will need to remove the sublocationlevelId
**
**		Auth: Pam Scheichenost
**		Date: 09/24/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      09/24/2020	Pam Scheichenost	initial
*******************************************************************************/
DECLARE
@MinId int,
@RowId int,
@MaxId int

SELECT @MinId = IsNull(MIN(OrganizationPhoneId),0), @MaxId = IsNull(Max(OrganizationPhoneId),0)
FROM organizationPhone
WHERE OrganizationPhone.SubLocationLevelId IS NOT NULL
AND OrganizationPhone.SubLocationLevel IS NULL;

IF (@MaxId > 0)
BEGIN
	SET @RowId = @MinId + 10000;
	WHILE (@MinId < @MaxId)
	BEGIN
		UPDATE organizationPhone
		SET SubLocationLevel = SubLocationLevel.SubLocationLevelName,
			LastModified = GETDate(),
			LastStatEmployeeId =1564
		FROM organizationPhone
		JOIN SubLocationLevel ON OrganizationPhone.SubLocationLevelID = SubLocationLevel.SubLocationLevelID
		WHERE  OrganizationPhoneId >= @MinId AND OrganizationPHoneId <= @RowId
		AND OrganizationPhone.SubLocationLevelId IS NOT NULL
		AND OrganizationPhone.SubLocationLevel IS NULL;

		IF (@RowId > @MaxId)
		BEGIN
			SET @MinId = @MaxId
		END
		ELSE
		BEGIN
			SET @MinId = @RowId;
			SET @RowId = @RowId +  10000;
		END
		
	END
END


GO
