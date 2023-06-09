﻿ /***************************************************************************************************
**	Name: CountryCode
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM CountryCode) = 0)
BEGIN
	PRINT 'Loading CountryCode Data'
	
	SET NOCOUNT ON
	DECLARE @importCountryCode TABLE
	(
		ID INT IDENTITY(1, 1),
		Country varchar(50),
		CountryCode nvarchar(10)
		

	)
	INSERT @importCountryCode VALUES('Afghanistan',93)
	INSERT @importCountryCode VALUES('Albania',355)
	INSERT @importCountryCode VALUES('Algeria',213)
	INSERT @importCountryCode VALUES('American Samoa',1)
	INSERT @importCountryCode VALUES('Andorra',376)
	INSERT @importCountryCode VALUES('Angola',244)
	INSERT @importCountryCode VALUES('Anguilla',1)
	INSERT @importCountryCode VALUES('Antigua',1)
	INSERT @importCountryCode VALUES('Barbuda',1)
	INSERT @importCountryCode VALUES('Argentina',54)
	INSERT @importCountryCode VALUES('Armenia',374)
	INSERT @importCountryCode VALUES('Aruba',297)
	INSERT @importCountryCode VALUES('Ascension',247)
	INSERT @importCountryCode VALUES('Australia',61)
	INSERT @importCountryCode VALUES('Austria',43)
	INSERT @importCountryCode VALUES('Azerbaijan',994)
	INSERT @importCountryCode VALUES('Bahamas',1)
	INSERT @importCountryCode VALUES('Bahrain',973)
	INSERT @importCountryCode VALUES('Bangladesh',880)
	INSERT @importCountryCode VALUES('Barbados',1)
	INSERT @importCountryCode VALUES('Belarus',375)
	INSERT @importCountryCode VALUES('Belgium',32)
	INSERT @importCountryCode VALUES('Belize',501)
	INSERT @importCountryCode VALUES('Benin',229)
	INSERT @importCountryCode VALUES('Bermuda',1)
	INSERT @importCountryCode VALUES('Bhutan',975)
	INSERT @importCountryCode VALUES('Bolivia',591)
	INSERT @importCountryCode VALUES('Bosnia',387)
	INSERT @importCountryCode VALUES('Herzegovina',387)
	INSERT @importCountryCode VALUES('Botswana',267)
	INSERT @importCountryCode VALUES('Brazil',55)
	INSERT @importCountryCode VALUES('British Virgin Islands',1)
	INSERT @importCountryCode VALUES('Brunei',673)
	INSERT @importCountryCode VALUES('Bulgaria',359)
	INSERT @importCountryCode VALUES('Burkina Faso',226)
	INSERT @importCountryCode VALUES('Burundi',257)
	INSERT @importCountryCode VALUES('Cambodia',855)
	INSERT @importCountryCode VALUES('Cameroon',237)
	INSERT @importCountryCode VALUES('Canada',1)
	INSERT @importCountryCode VALUES('Cape Verde',238)
	INSERT @importCountryCode VALUES('Cayman Islands',1)
	INSERT @importCountryCode VALUES('Central African Republic',236)
	INSERT @importCountryCode VALUES('Chad',235)
	INSERT @importCountryCode VALUES('Chile',56)
	INSERT @importCountryCode VALUES('China',86)
	INSERT @importCountryCode VALUES('Colombia',57)
	INSERT @importCountryCode VALUES('Comoros',269)
	INSERT @importCountryCode VALUES('Congo',242)
	INSERT @importCountryCode VALUES('Cook Islands',682)
	INSERT @importCountryCode VALUES('Costa Rica',506)
	INSERT @importCountryCode VALUES('Croatia',385)
	INSERT @importCountryCode VALUES('Cuba',53)
	INSERT @importCountryCode VALUES('Cyprus',357)
	INSERT @importCountryCode VALUES('Czech Republic',420)
	INSERT @importCountryCode VALUES('Democratic Republic of Congo',243)
	INSERT @importCountryCode VALUES('Denmark',45)
	INSERT @importCountryCode VALUES('Diego Garcia',246)
	INSERT @importCountryCode VALUES('Djibouti',253)
	INSERT @importCountryCode VALUES('Dominica',1)
	INSERT @importCountryCode VALUES('Dominican Republic',1)
	INSERT @importCountryCode VALUES('East Timor',670)
	INSERT @importCountryCode VALUES('Ecuador',593)
	INSERT @importCountryCode VALUES('Egypt',20)
	INSERT @importCountryCode VALUES('El Salvador',503)
	INSERT @importCountryCode VALUES('Equatorial Guinea',240)
	INSERT @importCountryCode VALUES('Eritrea',291)
	INSERT @importCountryCode VALUES('Estonia',372)
	INSERT @importCountryCode VALUES('Ethiopia',251)
	INSERT @importCountryCode VALUES('Falkland (Malvinas) Islands',500)
	INSERT @importCountryCode VALUES('Faroe Islands',298)
	INSERT @importCountryCode VALUES('Fiji',679)
	INSERT @importCountryCode VALUES('Finland',358)
	INSERT @importCountryCode VALUES('France',33)
	INSERT @importCountryCode VALUES('French Guiana',594)
	INSERT @importCountryCode VALUES('French Polynesia',689)
	INSERT @importCountryCode VALUES('Gabon',241)
	INSERT @importCountryCode VALUES('Gambia',220)
	INSERT @importCountryCode VALUES('Georgia',995)
	INSERT @importCountryCode VALUES('Germany',49)
	INSERT @importCountryCode VALUES('Ghana',233)
	INSERT @importCountryCode VALUES('Gibraltar',350)
	INSERT @importCountryCode VALUES('Greece',30)
	INSERT @importCountryCode VALUES('Greenland',299)
	INSERT @importCountryCode VALUES('Grenada',1)
	INSERT @importCountryCode VALUES('Guadeloupe',590)
	INSERT @importCountryCode VALUES('Guam',1)
	INSERT @importCountryCode VALUES('Guatemala',502)
	INSERT @importCountryCode VALUES('Guinea',224)
	INSERT @importCountryCode VALUES('Guinea-Bissau',245)
	INSERT @importCountryCode VALUES('Guyana',592)
	INSERT @importCountryCode VALUES('Haiti',509)
	INSERT @importCountryCode VALUES('Honduras',504)
	INSERT @importCountryCode VALUES('Hong Kong',852)
	INSERT @importCountryCode VALUES('Hungary',36)
	INSERT @importCountryCode VALUES('Iceland',354)
	INSERT @importCountryCode VALUES('India',91)
	INSERT @importCountryCode VALUES('Indonesia',62)
	INSERT @importCountryCode VALUES('Inmarsat Satellite',870)
	INSERT @importCountryCode VALUES('Iran',98)
	INSERT @importCountryCode VALUES('Iraq',964)
	INSERT @importCountryCode VALUES('Ireland',353)
	INSERT @importCountryCode VALUES('Iridium Satellite',8816)
	INSERT @importCountryCode VALUES('Iridium Satellite',8817)
	INSERT @importCountryCode VALUES('Israel',972)
	INSERT @importCountryCode VALUES('Italy',39)
	INSERT @importCountryCode VALUES('Ivory Coast',225)
	INSERT @importCountryCode VALUES('Jamaica',1)
	INSERT @importCountryCode VALUES('Japan',81)
	INSERT @importCountryCode VALUES('Jordan',962)
	INSERT @importCountryCode VALUES('Kazakhstan',7)
	INSERT @importCountryCode VALUES('Kenya',254)
	INSERT @importCountryCode VALUES('Kiribati',686)
	INSERT @importCountryCode VALUES('Kuwait',965)
	INSERT @importCountryCode VALUES('Kyrgyzstan',996)
	INSERT @importCountryCode VALUES('Laos',856)
	INSERT @importCountryCode VALUES('Latvia',371)
	INSERT @importCountryCode VALUES('Lebanon',961)
	INSERT @importCountryCode VALUES('Lesotho',266)
	INSERT @importCountryCode VALUES('Liberia',231)
	INSERT @importCountryCode VALUES('Libya',218)
	INSERT @importCountryCode VALUES('Liechtenstein',423)
	INSERT @importCountryCode VALUES('Lithuania',370)
	INSERT @importCountryCode VALUES('Luxembourg',352)
	INSERT @importCountryCode VALUES('Macau',853)
	INSERT @importCountryCode VALUES('Macedonia',389)
	INSERT @importCountryCode VALUES('Madagascar',261)
	INSERT @importCountryCode VALUES('Malawi',265)
	INSERT @importCountryCode VALUES('Malaysia',60)
	INSERT @importCountryCode VALUES('Maldives',960)
	INSERT @importCountryCode VALUES('Mali',223)
	INSERT @importCountryCode VALUES('Malta',356)
	INSERT @importCountryCode VALUES('Marshall Islands',692)
	INSERT @importCountryCode VALUES('Martinique',596)
	INSERT @importCountryCode VALUES('Mauritania',222)
	INSERT @importCountryCode VALUES('Mauritius',230)
	INSERT @importCountryCode VALUES('Mayotte',262)
	INSERT @importCountryCode VALUES('Mexico',52)
	INSERT @importCountryCode VALUES('Micronesia',691)
	INSERT @importCountryCode VALUES('Moldova',373)
	INSERT @importCountryCode VALUES('Monaco',377)
	INSERT @importCountryCode VALUES('Mongolia',976)
	INSERT @importCountryCode VALUES('Montenegro',382)
	INSERT @importCountryCode VALUES('Montserrat',1)
	INSERT @importCountryCode VALUES('Morocco',212)
	INSERT @importCountryCode VALUES('Mozambique',258)
	INSERT @importCountryCode VALUES('Myanmar',95)
	INSERT @importCountryCode VALUES('Namibia',264)
	INSERT @importCountryCode VALUES('Nauru',674)
	INSERT @importCountryCode VALUES('Nepal',977)
	INSERT @importCountryCode VALUES('Netherlands',31)
	INSERT @importCountryCode VALUES('New Caledonia',687)
	INSERT @importCountryCode VALUES('New Zealand',64)
	INSERT @importCountryCode VALUES('Nicaragua',505)
	INSERT @importCountryCode VALUES('Niger',227)
	INSERT @importCountryCode VALUES('Nigeria',234)
	INSERT @importCountryCode VALUES('Niue Island',683)
	INSERT @importCountryCode VALUES('North Korea',850)
	INSERT @importCountryCode VALUES('Northern Marianas',1)
	INSERT @importCountryCode VALUES('Norway',47)
	INSERT @importCountryCode VALUES('Oman',968)
	INSERT @importCountryCode VALUES('Pakistan',92)
	INSERT @importCountryCode VALUES('Palau',680)
	INSERT @importCountryCode VALUES('Panama',507)
	INSERT @importCountryCode VALUES('Papua New Guinea',675)
	INSERT @importCountryCode VALUES('Paraguay',595)
	INSERT @importCountryCode VALUES('Peru',51)
	INSERT @importCountryCode VALUES('Philippines',63)
	INSERT @importCountryCode VALUES('Poland',48)
	INSERT @importCountryCode VALUES('Portugal',351)
	INSERT @importCountryCode VALUES('Puerto Rico',1)
	INSERT @importCountryCode VALUES('Qatar',974)
	INSERT @importCountryCode VALUES('Reunion',262)
	INSERT @importCountryCode VALUES('Romania',40)
	INSERT @importCountryCode VALUES('Russian Federation',7)
	INSERT @importCountryCode VALUES('Rwanda',250)
	INSERT @importCountryCode VALUES('Saint Helena',290)
	INSERT @importCountryCode VALUES('Saint Kitts', 1)
		,('Nevis',1)
	INSERT @importCountryCode VALUES('Saint Lucia',1)
	INSERT @importCountryCode VALUES('Saint Pierre', 508),
		('Miquelon',508)
	INSERT @importCountryCode VALUES('Saint Vincent', 1),
		('Grenadines',1)
	INSERT @importCountryCode VALUES('Samoa',685)
	INSERT @importCountryCode VALUES('San Marino',378)
	INSERT @importCountryCode VALUES('Sao Tome', 239),
		('Principe',239)
	INSERT @importCountryCode VALUES('Saudi Arabia',966)
	INSERT @importCountryCode VALUES('Senegal',221)
	INSERT @importCountryCode VALUES('Serbia',381)
	INSERT @importCountryCode VALUES('Seychelles',248)
	INSERT @importCountryCode VALUES('Sierra Leone',232)
	INSERT @importCountryCode VALUES('Singapore',65)
	INSERT @importCountryCode VALUES('Slovakia',421)
	INSERT @importCountryCode VALUES('Slovenia',386)
	INSERT @importCountryCode VALUES('Solomon Islands',677)
	INSERT @importCountryCode VALUES('Somalia',252)
	INSERT @importCountryCode VALUES('South Africa',27)
	INSERT @importCountryCode VALUES('South Korea',82)
	INSERT @importCountryCode VALUES('Spain',34)
	INSERT @importCountryCode VALUES('Sri Lanka',94)
	INSERT @importCountryCode VALUES('Sudan',249)
	INSERT @importCountryCode VALUES('Suriname',597)
	INSERT @importCountryCode VALUES('Swaziland',268)
	INSERT @importCountryCode VALUES('Sweden',46)
	INSERT @importCountryCode VALUES('Switzerland',41)
	INSERT @importCountryCode VALUES('Syria',963)
	INSERT @importCountryCode VALUES('Taiwan',886)
	INSERT @importCountryCode VALUES('Tajikistan',992)
	INSERT @importCountryCode VALUES('Tanzania',255)
	INSERT @importCountryCode VALUES('Thailand',66)
	INSERT @importCountryCode VALUES('Thuraya Satellite',88216)
	INSERT @importCountryCode VALUES('Togo',228)
	INSERT @importCountryCode VALUES('Tokelau',690)
	INSERT @importCountryCode VALUES('Tonga',676)
	INSERT @importCountryCode VALUES('Trinidad and Tobago',1)
	INSERT @importCountryCode VALUES('Tunisia',216)
	INSERT @importCountryCode VALUES('Turkey',90)
	INSERT @importCountryCode VALUES('Turkmenistan',993)
	INSERT @importCountryCode VALUES('Turks and Caicos Islands',1)
	INSERT @importCountryCode VALUES('Tuvalu',688)
	INSERT @importCountryCode VALUES('U.S. Virgin Islands',1)
	INSERT @importCountryCode VALUES('Uganda',256)
	INSERT @importCountryCode VALUES('Ukraine',380)
	INSERT @importCountryCode VALUES('United Arab Emirates',971)
	INSERT @importCountryCode VALUES('United Kingdom',44)
	INSERT @importCountryCode VALUES('United States of America',1)
	INSERT @importCountryCode VALUES('Uruguay',598)
	INSERT @importCountryCode VALUES('Uzbekistan',998)
	INSERT @importCountryCode VALUES('Vanuatu',678)
	INSERT @importCountryCode VALUES('Vatican City',379)
	INSERT @importCountryCode VALUES('Vatican City',39)
	INSERT @importCountryCode VALUES('Venezuela',58)
	INSERT @importCountryCode VALUES('Vietnam',84)
	INSERT @importCountryCode VALUES('Wallis and Futuna',681)
	INSERT @importCountryCode VALUES('Yemen',967)
	INSERT @importCountryCode VALUES('Zambia',260)
	INSERT @importCountryCode VALUES('Zimbabwe',263)

	--MERGE CountryCode AS target
	--USING 
	--(
	--	SELECT DISTINCT CountryCode, CountryID, GETDATE() AS LastModified, 45 AS LastStatEmployeeID, 1 AS AuditLogTypeID
	--	FROM @importCountryCode icc
	--	JOIN Country ON Country.COUNTRYNAME = icc.Country
	--	UNION
	--	SELECT 1 , CountryID, GETDATE() AS LastModified, 45 AS StatEmployeeID, 1
	--	FROM Country
	--	where Country.COUNTRYNAME = 'United States' 
	--) AS source (CountryCode, CountryID, LastModified, LastStateEmployeeID, AuditLogTypeID)
	--ON (target.CountryCode = source.CountryCode AND target.CountryID = source.CountryID )
	--WHEN NOT MATCHED THEN
	--	INSERT (CountryCode.CountryCode, CountryCode.CountryId,  CountryCode.LastModified, CountryCode.LastStatEmployeeId, CountryCode.AuditLogTypeId)
	--	VALUES (CountryCode, CountryID, LastModified, LastStateEmployeeID, AuditLogTypeID);
		INSERT CountryCode (CountryCode.CountryCode, CountryCode.CountryId,  CountryCode.LastModified, CountryCode.LastStatEmployeeId, CountryCode.AuditLogTypeId)
		
		SELECT DISTINCT CountryCode, CountryID, GETDATE() AS LastModified, 45 AS LastStatEmployeeID, 1 AS AuditLogTypeID
		FROM @importCountryCode icc
		JOIN Country ON Country.COUNTRYNAME = icc.Country
		UNION
		SELECT 1 , CountryID, GETDATE() AS LastModified, 45 AS StatEmployeeID, 1
		FROM Country
		where Country.COUNTRYNAME = 'United States' 
END

