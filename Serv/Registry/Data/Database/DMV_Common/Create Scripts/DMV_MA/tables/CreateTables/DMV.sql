/* Add Column: PreviousDonorState DMV */
IF Not Exists(select * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DMV' AND COLUMN_NAME = 'PreviousDonorState')
	BEGIN
			PRINT 'DMV Adding column: PreviousDonorState'
			ALTER TABLE DMV
				ADD PreviousDonorState varchar(50) NULL
	END
ELSE
	BEGIN
			PRINT 'DMV PreviousDonorState column already exists'
	END


