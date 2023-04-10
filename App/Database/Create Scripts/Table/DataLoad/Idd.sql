 /***************************************************************************************************
**	Name: Idd
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM Idd) = 0)
BEGIN

	PRINT 'Loading Idd Data'
	
	SET NOCOUNT ON
	DECLARE @importIdd TABLE
	(
		ID INT IDENTITY(1, 1),
		Country varchar(50),
		Idd nvarchar(10)
	)
	INSERT @importIdd 
	VALUES
		('Algeria', '00'),
		('Argentina', '00'),
		('Australia', '0011'),
		('Austria', '00'),
		('Austria', '900'),
		('Bahrain', '0'),
		('Bangladesh', '00'),
		('Belgium', '00'),
		('Bermuda', '011'),
		('Brazil', '00'),
		('Brunei Darussalam', '00'),
		('Canada', '011'),
		('Chile', '00'),
		('China', '00'),
		('Colombia', '90'),
		('Cyprus', '00'),
		('Czech Republic', '00'),
		('Denmark', '00'),
		('Dominican Republic', '011'),
		('Ecuador', '02'),
		('Egypt', '002'),
		('Ethiopia', '-'),
		('Fiji', '-'),
		('Finland', '90'),
		('Finland', '994'),
		('Finland', '999'),
		('France', '19'),
		('Germany', '00'),
		('Gibraltar', '00'),
		('Greece', '00'),
		('Guam', '01'),
		('Hong Kong SAR', '001'),
		('Hungary', '00'),
		('Iceland', '00'),
		('India', '00'),
		('Indonesia', '001'),
		('Iran', '00'),
		('Iraq', '00'),
		('Ireland(Irish Republic)', '00'),
		('Israel', '00'),
		('Italy', '00'),
		('Japan', '001'),
		('Kenya', '000'),
		('Korea (South)', '001'),
		('Kuwait', '0022'),
		('Luxembourg', '00'),
		('Macau SAR', '00'),
		('Macau SAR', '01'),
		('Malaysia', '00'),
		('Malaysia', '007'),
		('Mexico', '98'),
		('Monaco', '19'),
		('Morocco', '00'),
		('Netherlands', '09'),
		('New Zealand', '00'),
		('Nigeria', '009'),
		('Norway', '095'),
		('Pakistan', '00'),
		('Panama', '00'),
		('Papua New Guinea', '31'),
		('Philippines', '00'),
		('Poland', '00'),
		('Portugal', '00'),
		('Qatar', '00'),
		('Romania', '-'),
		('Russian Federation (Moscow only)', '810'),
		('Saudi Arabia', '00'),
		('Seychelles', '0'),
		('Singapore', '005'),
		('Solomon Islands', '00'),
		('South Africa', '09'),
		('Spain', '07'),
		('Sri Lanka', '00'),
		('Sweden', '009'),
		('Switzerland', '00'),
		('Syria', '00'),
		('Taiwan', '002'),
		('Tanzania', '00'),
		('Thailand', '001'),
		('Tunisia', '00'),
		('Turkey', '99'),
		('Uganda', '-'),
		('United Arab Emirates', '00'),
		('United Kingdom', '00'),
		('United States', '011'),
		('Uruguay', '00'),
		('Yemen (Arab Republic)', '00'),
		('Zimbabwe', '110')	

	
	INSERT [Idd]
           ([Idd]
           ,[LastModified]
           ,[LastStatEmployeeId]
           ,[AuditLogTypeId]
           ,[CountryId])
           
     SELECT DISTINCT Idd, GETDATE(), 45, 1, Country.COUNTRYID
     FROM @importIdd icc
		JOIN Country ON Country.COUNTRYNAME = icc.Country      

END

