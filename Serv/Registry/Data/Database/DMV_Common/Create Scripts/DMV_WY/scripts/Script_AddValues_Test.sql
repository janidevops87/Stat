/* Test for Sprocs
exec sps_EventCategory NULL, NULL
exec sps_EventSubCategory NULL, NULL, NULL
exec spui_EventSubCategory 17, 3, 'New Donor Web Site', 'T01CT4', 0, 0, 1111
SELECT * FROM EventSubCategory 

truncate table EventCategory;
truncate table EventSubCategory;

*/


/* 1.0 Add values */
PRINT 'Adding table values: EventCategory'
IF (SELECT COUNT(*) FROM EventCategory) = 0 
BEGIN
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Event', 1, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Media Outlet', 1, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Online', 1, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Other (Specify)', 1, 1)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Place of Business', 1, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Place of Worship', 0, 0)
		INSERT EventCategory(EventCategoryName, EventCategoryActive, EventCategorySpecifyText)VALUES('Through a Friend', 1, 0)

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
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(1,'MADD 5K Run/Walk 2007', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(1,'Rich Maez Benefit Concert', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(1,'Donate Life Day - University of Wyoming', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(1,'Sky Ridge Health Fair', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(1,'National Donor Day 2007', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(1,'St.Anthony Central Health Fair 2007', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(1,'Other (Specify)', 1, 1)
		
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(2,'9News Health Fair 2007', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(2,'Channel 7 Health Fair 2007', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(2,'TV Advertisment December 2007', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(3,'Statline Web site', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(3,'Other (specify', 1, 1)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(3,'Donor Alliance Web Site', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(4,'Other (Specify)', 1, 1)
		
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(5,'Lockheed Martin Health Fair - Colorado Springs', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(5,'Mile High Frozen Foods', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(5,'PharmaCare General Distribution', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(5,'Hughes Law Firm for Will Packets', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(5,'Comcast', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(5,'BRONCOS 2004', 0, 0)
		
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'National Donor Sabbath', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'First United Methodist Church Pres. - C. Bradham', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'St. Gabriel Parish Presentation', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'St. Anthony Central General Distribution', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'St. Andrews United Methodist Church Registry Drive', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'Lowry Christian Community Church', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'First Christian Reform Church Presentation', 1, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'Presbyterian/St. Luke''s 2005', 0, 0)
		INSERT EventSubCategory(EventCategoryID, EventSubCategoryName, EventSubCategoryActive, EventSubCategorySpecifyText)VALUES(6,'Other (specify)', 1, 1)

		PRINT '  -Insert row(s) added'
	END
ELSE
	BEGIN
		PRINT '  -0 rows added - data already exists'
	END
		--SET IDENTITY_INSERT EventSubCategory OFF
	--GO 