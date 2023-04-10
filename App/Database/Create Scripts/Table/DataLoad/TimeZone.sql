 /***************************************************************************************************
**	Name: TimeZone
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
**  07/14/10	Bret Knoll		Adding to release 
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM TimeZone) = 0)
BEGIN
	SET IDENTITY_INSERT TimeZone ON
	INSERT TimeZone (TimeZoneID, TimeZoneName, TimeZoneAbbreviation, ObservesDaylightSavings, DayLightSavingsStartTime, LastModified, LastStatEmployeeId, AuditLogTypeId)
	VALUES
		(8, 'Hawaii-Aleutian', 'HT', 0, '02:00', GetDate(), 45, 1),
		(7, 'Alaska', 'AK', 1, '02:00', GetDate(), 45, 1),
		(6, 'Pacific', 'PT', 1, '02:00', GetDate(), 45, 1),
		(5, 'Arizona', 'AZ', 0, '02:00', GetDate(), 45, 1),
		(4, 'Mountain', 'MT', 1, '02:00', GetDate(), 45, 1),
		(3, 'Central', 'CT', 1, '02:00', GetDate(), 45, 1),
		(2, 'Eastern', 'ET', 1, '02:00', GetDate(), 45, 1),
		(1, 'Atlantic', 'AT', 1, '02:00', GetDate(), 45, 1)


	SET IDENTITY_INSERT TimeZone OFF
END

