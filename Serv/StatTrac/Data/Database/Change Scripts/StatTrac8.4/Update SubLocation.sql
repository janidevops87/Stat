 /* Hospital Unit - SubLocationName addition
	ccarroll 09/20/2007
 */


DECLARE @AddValue varchar(50)

SET @AddValue = 'Adult Critical Care'

IF NOT EXISTS  ( SELECT * 
		  FROM Sublocation 
		  WHERE SublocationName = @AddValue
		)	

	BEGIN
		INSERT INTO SubLocation
				(SubLocationName, Verified, Inactive, LastModified)
			VALUES	(@AddValue, 0, 0, GetDate())

		Print 'Adding record: ' + @AddValue

	END

Else
	BEGIN
		Print '..Record already exists'

	END
GO

