/* Test for Sprocs
exec sps_EventCategory NULL, NULL
exec sps_EventSubCategory NULL, NULL, NULL
exec spui_EventSubCategory 17, 3, 'New Donor Web Site', 'T01CT4', 0, 0, 1111
SELECT * FROM EventSubCategory 



*/
truncate table EventCategory;
truncate table EventSubCategory;

/* 1.0 Add values */
PRINT 'Adding table values: EventCategory'
IF (SELECT COUNT(*) FROM EventCategory) = 0 
BEGIN
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Blood Drive', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Church/Place of Worship', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Club/Civic Organization', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Convention/Seminar', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Department of Motor Vehicles', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Event', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Health Fair', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Living Will', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Other', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Place of Business', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Presentation', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('School', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('School/University', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Tax Booklet', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Willmaker Legal Seminar', 0, 0)

		PRINT '  -Insert row(s) added'
END
ELSE
BEGIN
		PRINT '  -0 rows added - data already exists'
END

/* 2.0 Add values EventSubCategory*/
PRINT 'Adding table values: EventSubCategory'
		--SET IDENTITY_INSERT EventSubCategory ON
		--GO

IF (SELECT Count(*) FROM EventSubCategory) = 0  
	BEGIN
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Aurora CDC', 'BOAURO', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Bonfils - not specified', 'BONFIL', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Bonfils Drive for life', 'BBCDFL06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Bonfils Specialized Donations', 'BOSPEC', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Boulder CDC', 'BOBLDR', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Denver West CDC', 'BODENW', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Highlands Ranch CDC', 'BOHIGH', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lakewood CDC', 'BOLKWD', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lowry CDC', 'BOLOWR', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lowry Flex Team 8', 'BOLOW8', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lowry Mobile Team 2', 'BOLOW2', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lowry Mobile Team 4', 'BOLOW4', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lowry Mobile Team 5', 'BOLOW5', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lowry Mobile Team 6', 'BOLOW6', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Lowry Mobile Team 7', 'BOLOW7', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Pueblo Mobile Team 1', 'BOPUE1', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Pueblo Mobile Team 2', 'BOPUE2', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Sterling CDC', 'BOSTER', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Westminster CDC', 'BOWCDC', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Westminster Mobile Team 1', 'BOWES1', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Westminster Mobile Team 2', 'BOWES2', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Westminster Mobile Team 3', 'BOWES3', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Westminster Mobile Team 4', 'BOWES4', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(1, 'Westminster mobile Team 6', 'BOWES6', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Andrew Fisher Mormon Chruch Concert', 'AFMC04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Augustana Lutheran Church - NDS Adult Ed.', 'DA-AUGUSTANA NDS', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'First Christian Reform Church Presentation', '20', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'First United Methodist Church Pres. - C. Bradham', 'DA - FUMC PRES (11/15)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Gospel on the Green 2006', 'GG 06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Grace Methodist Church', 'Grace Methodist Church', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Heritage Christian Center 2005', 'HCC05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Lowry Christian Community Church', 'Lowry (4/28)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'National Donor Sabbath', 'DAC-NDS05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'National Donor Sabbath 2007', 'NDS 07', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Our Lady of the Woods Table - Carole Restle', 'DA-OLW TABLE (11/11)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'Religious Advisory Committee Forms, DAC 2007', 'RAC 07 ', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'St. Andrews United Methodist Church Registry Drive', 'St. Andrews 4/15', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(2, 'St. Gabriel Parish Presentation', 'St. Gabriel RD 3/25', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(3, 'Englewood Lions Club - Amy Johnson', '11', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(3, 'Golden Rotary Club Presentation (Eden Fike)', 'DA - GOLDEN ROTARY CLUB (12/4)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(3, 'Rotary 4/04', 'RC0404', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(3, 'Rotary 7/04', 'R04', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(4, 'Colorado Hospital Association Meeting', '9', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(4, 'Colorado Science Convention', 'CSC04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(4, 'Critical Care RN (CCRN)', 'DA-CCRN 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(4, 'Memorial Trauma Symposium', '5', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(4, 'Mile High Miracles Tissue Collaborative', 'DA-MHM COLLAB', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(5, 'CO Driver License "Carrier" form', 'DAC-LC', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, '2nd Creek Raceway', '2ndCreek', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, '3rd Creek Raceway', '3rdCreek', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'American Transplant Association 2005', 'ATA05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'American Transplant Foundation', 'DA/ATF', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Amputee Open - Arthur Stone', 'Amputee Open', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'B', 'Amputee Open', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Blair Caldwell Registry Drive', 'DA-Registry #3 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Breat Cancer Walk', 'Breast Cancer Walk', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'BRONCOS 2004', 'BRONCO04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Capitol Registry Drive', 'DA-Registry #2 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Celebra La Vida Con Salud', 'Celebra (6/9)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Child Safety Day Event', 'Child Safety (5/12)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Children''s Hospital Golf Tournament', 'From the Heart (TCH)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Chippin'' for Life', 'Chippin for Life 2007', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Cinco de Mayo', 'CINCO', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'City Cty 04', 'CC04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Colfax Marathon Expo', 'Colfax Expo (May 07)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Combined Federal Campaign 2005', 'CFC05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Combined Federal Campaign 2006', 'CFC06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Convoy of Hope 2005', 'COH05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Culture Fest 2004', 'CF04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Diabetes Expo', 'DIABETES-EXPO', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Dillion Event - Loveland', 'DA-Dillon06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Donate Life Day - University of Wyoming', 'UWYO 4/07', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Donation Day - Springfield, CO', '18', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Donor Awareness Council SCO', 'DAC-SCO', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Fighting the Good Fight (Rich Maez)', 'DA-FTGF (11/4)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Frontier Days/Wyoming', 'DA-FDWY 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Georgetown to Idaho Springs Half Marathon', 'GIHM 06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Hike for Hospice Event/Bags', 'Hike for Hospice', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Hollydot Golf Tournament', '6', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Lamar Registry Drive', 'Lamar RD (Aug)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Larimer Square Registry Drive', 'DA-Registry #1 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Little Hearts', 'DA-Little Hearts 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Little Hearts Luncheon 2007', 'LHL 4/13', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'MADD Strides for Change 5K Run/Walk', '1', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Montrose Donate Life Day', 'Montrose DL 4/18', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'National Western Stock Show 2004', 'SS04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'NDLM Outreach 2005', 'NDLM05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'PHIL LESH 2004', 'LESH04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Rich Maez Benefit Concert', 'MAEZ CONCERT', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Ride of Your Life ATF Event', 'Ride of Your Life', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Rio''s Run', 'Rio''s Run 2007', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Roger Simmons'' Benefit 2005', 'RSB05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Saturn Donor Drive 2005 ', 'SDD05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Scrummy Health Fair', 'Scrummy 5/5', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'Senator Ken Salazar', 'Registry #3 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(6, 'String Cheese Incident - Red Rocks Concert', '3', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 Health Fair - Westcliffe', 'DA-9HealthFair Westclife06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 HEALTH FAIR 2005', '9HF05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 HEALTH FAIRS IN THE CLASSROOM 2005', '9HFC05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9Health 4/04', '9HF04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9Health Fair 2007', '9HF 07', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9Health Fair-College America', 'DA-9HF College America06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9Health Fair-St. Anthony''s North', 'DA-9Health Fair-SAN06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 News St. Anthony North', 'St. Anthony N 4/15', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 News Health Fair 2006', '9HF06', 0, 0)
		
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 News Health Fair 2002', '9H0402', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 News Health Fair 2001', '9HEALTH', 0, 0)
		
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, '9 News Health Fair 2003', '9HF03', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'BeaconFest', 'BeaconFest 4/18', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Beacon Fest Community Fair', 'DA-BEACONF', 0, 0)
		
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Blue Envelope Health Fair', 'Blue Envelope 3/24', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Cheyenne Regional Medical Center', 'WPFL-CRMC', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Children''s Hospital Foundation', 'DA-Children''s Hospital Foundaiton 06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Crested Butte Health Fair', 'Crested Butte 3/24', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Current Health Fair', 'Current HF 3/21', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Delta County Memorial Hospital', 'Dela County 6-11', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Equity Residential Health Fair ', 'ERHF05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Gail''s Hospitals', 'DA-Gail 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Golden Health Fair - St. Joseph''s Church', '19', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Gunnison Valley Health Fair', 'Gunnison HF 4/7', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Hunter Douglas Health Fair 2004', 'HD04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Kaiser Permanente 2004', 'KP04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Kaiser Permanente Hispanic 2004', 'KPH04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Kaiser Permanente Neighbors in Health', '2', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Lake City Health Fair', 'Lake City HF 4/28', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Lockheed Martin Health Fair - Colorado Springs', 'LMHF 10-24', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Lowry Women''s Health Fair', 'DA-Lowry CommHF06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'McKee Hospital', 'DA-McKee 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Mile High Frozen Foods', 'MH Foods (6/22)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'National Jewish Med/Employee Health Fair', 'NJC06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'NDLM Porter Registry Drive', 'DA-Porter 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'NDLM UCH Registry Drive', 'DA-UCH 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'P/SL Donor Drive', 'P/SLDD', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Poudre Valley Hospital', 'PVH', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Powell Valley Donate Life Day', 'Powell DL 4/24', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Presbyterian/St. Luke''s 2005', 'PSL05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Presbyterian/St. Luke''s Ch.9 2004', 'PSL/CH904', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'Sky Ridge Health Fair', 'Sky Ridge HF', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'The Childrens Hospital 2005', 'TCH05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'The Childrens Hospital Drive 04/04', 'TCH04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(7, 'USPS Health Fair 2005', 'USPSHF05', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(8, 'Hughes Law Firm for Will Packets', 'DAHughes06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(8, 'Hughes Law Firm for Will Packets', 'DA-HUGHES LAW', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Adolescent Medicine - Cassandra Johnson', '23', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'African American Brochure', 'DACAA04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Catherine', 'DA-Catherine 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Christina', 'DA-Christina 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Community Hospital GJ General Distirbution', 'DA - COMMUNITY HOSPITAL GJ (GU)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'DA-NDLM (DOUGLAS)', 'NDLM Outreach', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Debi', 'DA-Debi 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Designated Requestor Workshops', '16', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Diana', 'DA-Diana 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Diane', 'DA-Diane 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Donor Alliance', 'DA', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Donor Alliance Coroner Program ', 'Sundee', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Donor Alliance Public Education', 'DAPE', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Donor Alliance Wyoming', 'DAWYO', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Donor Awareness Council', 'DAC', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Douglas County Sheriffs Dept. Victim Assistance Program', 'Douglas Sheriff 4/9', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Douglas County Sheriffs Dept. Victims Panel', '22', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Dr. Collette', 'DA-Dr. Collette 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Girl Scouts Presentation - WPFL', 'Girl Scouts 07', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Laura', 'DA-Laura 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Marsha', 'DA-Marsha 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Materials for funeral - B. Davis request', 'DA - FUNERAL - 1/11/08', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Nadine Broder''s Insurance Packets', '13', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Cassandra Johnson', 'NDLM (Johnson)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Christine Musso', 'NDLM (Musso)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Community Hospital', 'Community Hosp', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Debi Wilson', 'NDLM (Wilson)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Diane Bacino', 'NDLM (Bacino)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Gail Douglas', 'NDLM (Douglas)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Julia Payne', 'NDLM (Payne)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Peggy Marshall', 'NDLM (Marshall)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Penrose Main', 'Penrose Main', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Powell Valley', 'Powell Valley', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Pueblo, Colorado', 'NDLM (Pueblo)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'NDLM Distribution - Wyoming', 'NDLM (Loghry)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'PharmaCare General Distribution', 'PharmaCare', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Rangely District Hospital General Distribution', 'DA - Rangely District Hospital', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Rose Medical Center Pamphlets', '21', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Scout Show', 'SS07', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'St. Anthony Central General Distribution', 'St. Anthony Cent', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'St. Anthony Central General Distribution', 'SAC (General)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'Sundee', 'DA-Sundee 2006', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(9, 'VA Medical Center Packets', '15', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'AlloSource 2005', 'ALLO05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'AlloSource Registry Drive', 'WPL-ALLO', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Colorado Rail Car', 'CRC', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Comcast', 'WPFL-COMCAST', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Governor Owens', 'Registry #2 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Judy Schweitzer''s Company Bake Sale', '14', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Mayor Hickenlooper', 'Registry #1 4.06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'SAC Reigstry Drive - WPFL', 'SAC - WPFL', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Work Place Partnership for Life', 'WPL', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Work Place Partnership for Life 2005', 'WPL05', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Work Place Partnership for Life Level 3', 'WPL/LEVEL3', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'Workplace Partnership For Life, Mary Kay 2007', 'WPFL-MK07', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'WPFL - Lunnon & Associates', '7', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(10, 'WPFL 12 Weeks of Giving- Zamar Screen Printing', 'WPFL- ZAMAR', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(11, 'Anissa''s speaking event', 'DAOptimists06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(11, 'Auxillary Board Presentation at Boulder Community Hospital', 'Auxillary Board', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(11, 'Chic Chicana Youth Leadership', 'Chicana', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(11, 'Mountain States Employers Council  - Gary Flanders', 'DA - MSEC (12/5)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(11, 'National Jewish Presentation', 'NJ Presentation 4/16', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(11, 'Sue Dunn Speaking to NKF BOD', 'DANKF06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(11, 'Women of PEO - Jennifer Moe Speaking Event', 'PEO', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(12, 'College Connection CSU', 'CCCSU04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(12, 'March Madness 03/04', 'MM04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(12, 'Pickens Tech High School Awareness', 'PTHSA', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(12, 'UNIVERSITY OF NORHTERN COLORADO', 'UNC04', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(12, 'WEST H.S. 2004', 'WHS04', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'Colorado State University', 'CSUNODAC06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'Cu Boulder Registry Event', 'CU BOULDER', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'CU Boulder vs. Kansas Tailgate', 'CU TAILGATE', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'DPS School Works Program', 'DPSSW06', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'I.G.S School Presentation', 'IGS School (6/13)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'Monarch K-8 School T-Science', 'Monarch (5/23)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'Platte Canyon Awareness Week', 'PCHS (4/9)', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(13, 'Regis University', 'Regis06', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(14, 'Tax Booklet', 'DAC-TXF', 0, 0)

		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(15, 'Willmaker Legal Seminars 09/04', 'WILLSEM', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(15, 'Willmaker Legal Seminars 10/02', 'WS1002', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategorySourceCode, EventSubCategoryActive, EventSubCategorySpecifyText) VALUES(15, 'Willmaker legal seminars 2005', 'WILL SEM', 0, 0)

		PRINT '  -Insert row(s) added'
	END
ELSE
	BEGIN
		PRINT '  -0 rows added - data already exists'
	END
		--SET IDENTITY_INSERT EventSubCategory OFF
	--GO 

/* Turn All Active
UPDATE EventCategory
	SET	EventCategoryActive = 1,
	LastModified = GetDate()

UPDATE EventSubCategory
	SET EventSubCategoryActive = 1,
		LastModified = GetDate()
*/