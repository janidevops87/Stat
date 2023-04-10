/******************************************************************************
**		File: Add_TimeZone.IanaTimeZoneId_Column.sql
**		Name: Add TimeZone.IanaTimeZoneId Column
**		Desc: Adds new IanaTimeZoneId column to TimeZone table to provide mapping between 
**		American and world-wide time zone names.
**
**		Auth: Andrey Savin
**		Date: 08/18/2022
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      08/18/2022	Andrey Savin		initial
*******************************************************************************/

-- It's hard to find accurate information about maximum IANA time zone id length.
-- To be sure we'll always fit, using nvarchar(MAX). Also, to be sure
-- that possible non-ansi characters are supported, using nvarchar.
-- This table is small, so no worries.
ALTER TABLE dbo.TimeZone ADD IanaTimeZoneId nvarchar(MAX) NOT NULL DEFAULT '';
GO

UPDATE tz
SET IanaTimeZoneId = ianaTz.IanaTimeZoneId
FROM dbo.TimeZone AS tz 
JOIN ( 
   VALUES
		(8, 'Pacific/Honolulu'		), -- (UTC-10:00) Hawaii, Hawaiian Standard Time
		(7, 'America/Anchorage'		), -- (UTC-09:00) Alaska, Alaskan Standard Time
		(6, 'America/Los_Angeles'	), -- (UTC-08:00) Pacific Time (US & Canada), Pacific Standard Time
		(5, 'America/Phoenix'		), -- (UTC-07:00) Arizona, US Mountain Standard Time
		(4, 'America/Denver'		), -- (UTC-07:00) Mountain Time (US & Canada), Mountain Standard Time
		(3, 'America/Chicago'		), -- (UTC-06:00) Central Time (US & Canada), Central Standard Time
		(2, 'America/New_York'		), -- (UTC-05:00) Eastern Time (US & Canada), Eastern Standard Time
		(1, 'America/Halifax'		)  -- (UTC-04:00) Atlantic Time (Canada), Atlantic Standard Time
)
AS ianaTz(TimeZoneID, IanaTimeZoneId)
ON tz.TimeZoneID = ianaTz.TimeZoneID;

GO