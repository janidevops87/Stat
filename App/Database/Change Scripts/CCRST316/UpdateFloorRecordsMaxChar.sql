/******************************************************************************
**		File: UpdateFloorRecordsMaxChar.sql
**		Name: Update Max Char to 4 characters for the control 'SecondaryPatientHospitalFloor'
**		Desc: Update Max Char to 4 characters for the control 'SecondaryPatientHospitalFloor' for  all service levels
**
**		Auth: Pam Scheichenost
**		Date: 09/15/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      09/15/2020	Pam Scheichenost	initial
*******************************************************************************/
UPDATE ServiceLevelSecondaryCtls
SET MaxChar = 4
WHERE ControlName = 'SecondaryPatientHospitalFloor'
GO