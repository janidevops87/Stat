/*** Add Medications
*
* Description: Add Medications (Antibiotics and Steroids) to StatTrac
*	
* 10/24/2011	ccarroll	Add Doribax - antibiotic HS 27130, wi 13932
*
*/

SET NoCount ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/* Create Medication Table Backup
		IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = '_Medication_Backup_ST134')
		BEGIN
			DROP TABLE _Medication_Backup_ST134
		END
		SELECT MedicationId,MedicationName, MedicationTypeUse
		INTO _Medication_Backup_ST134
		FROM Medication
*/


DECLARE @MedicationsAdd TABLE
(
      Id Int IDENTITY(1, 1) NOT NULL,
      MedicationName nvarchar(100) Null,
      MedicationTypeUse nvarchar(100) NULL
)

/****** Add Items Here ******/
/* Start Add Antibiotic */
INSERT @MedicationsAdd (MedicationName, MedicationTypeUse) VALUES ('Doribax', 'antibiotic')
/* Start Add Steroid */
--INSERT @MedicationsAdd (MedicationName, MedicationTypeUse) VALUES ('A Hydrocort', 'steroid')

--SELECT * FROM @MedicationsAdd


DECLARE @MedicationName AS nvarchar(100)
DECLARE @MedicationTypeUse nvarchar(100)
DECLARE @CurrentItem AS Int

/****** Begin Update ******/
WHILE (SELECT COUNT(*) FROM @MedicationsAdd) > 0
      BEGIN
		  SET @CurrentItem = (SELECT MIN(Id) FROM @MedicationsAdd)

		  SELECT	@MedicationName = t.MedicationName,
					@MedicationTypeUse = t.MedicationTypeUse
		  FROM (SELECT MedicationName, MedicationTypeUse FROM @MedicationsAdd WHERE Id = @CurrentItem)t

			IF (SELECT Count(*) FROM Medication WHERE LOWER(MedicationName) = LOWER(@MedicationName) AND LOWER(MedicationTypeUse) = LOWER(@MedicationTypeUse)) = 0
			BEGIN /* Add Medication */
				INSERT Medication(MedicationName, MedicationTypeUse) VALUES(@MedicationName, @MedicationTypeUse)
				PRINT 'Added: ' + Cast(@MedicationName AS Varchar) + ' - ' + Cast(@MedicationTypeUse AS Varchar)
			END

		  DELETE @MedicationsAdd WHERE Id = @CurrentItem

      END
PRINT 'Finished'
GO
/****** End Update ******/
/* End Script */
