 /******************************************************************************
		**	File: WI 8615 Add Doripenem antibiotic.sql
		**	Name: WI 8615 Add Doripenem antibiotic
		**	Desc: Add Antibiotic to FS LIst
		**	Auth: Bret Knoll
		**	Date: 12/9/2010
		**	
		*******************************************************************************/
		
 
 IF NOT EXISTS( SELECT * FROM Medication WHERE MedicationName like 'Doripenem')
 BEGIN
	PRINT ' Add Doripenem antibiotic to the FS Antibiotic list.'
	PRINT GETDATE()
	INSERT Medication
	VALUES('Doripenem', 'antibiotic')
 END
 
 
 IF EXISTS(SELECT * FROM Medication WHERE MedicationName like 'Ceclor ' AND MedicationTypeUse = 'anitbiotic')
 BEGIN
	PRINT 'Fixing spelling of Ceclor 	anitbiotic'
	PRINT GETDATE()
	UPDATE Medication
	SET MedicationTypeUse = 'antibiotic'
	WHERE 
		MedicationName like 'Ceclor ' 
	AND 
		MedicationTypeUse = 'anitbiotic'
 
 END
 
 