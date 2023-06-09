/*	ccarroll 05/20/2009
	1.0 NEOB - Add values  
		ZipCodes RI Query Selection Data
		
*/
USE DMV_RI

PRINT 'Adding table values: ZipCodeCityRegion'
IF (SELECT COUNT(*) FROM ZipCodeCityRegion) = 0 
BEGIN



INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02801', 'Adamsville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02802', 'Albion', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02804', 'Ashaway', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02806', 'Barrington', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02807', 'Block Island', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02808', 'Bradford', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02809', 'Bristol', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02812', 'Carolina', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02813', 'Charlestown', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02814', 'Chepachet', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02815', 'Clayville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02816', 'Coventry', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02817', 'West Greenwich', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02818', 'East Greenwich', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02822', 'Exeter', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02823', 'Fiskeville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02824', 'Forestdale', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02825', 'Foster', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02826', 'Glendale', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02827', 'Greene', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02828', 'Greenville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02829', 'Harmony', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02830', 'Harrisville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02831', 'Hope', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02832', 'Hope Valley', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02833', 'Hopkinton', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02835', 'Jamestown', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02836', 'Kenyon', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02837', 'Little Compton', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02838', 'Manville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02839', 'Mapleville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02840', 'Newport', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02841', 'Newport', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02842', 'Middletown', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02852', 'North Kingstown', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02854', 'North Kingstown', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02857', 'North Scituate', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02858', 'Oakland', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02859', 'Pascoag', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02860', 'Pawtucket', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02861', 'Pawtucket', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02862', 'Pawtucket', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02863', 'Central Falls', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02864', 'Cumberland', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02865', 'Lincoln', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02871', 'Portsmouth', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02872', 'Prudence Island', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02873', 'Rockville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02874', 'Saunderstown', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02875', 'Shannock', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02876', 'Slatersville', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02877', 'Slocum', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02878', 'Tiverton', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02879', 'Wakefield', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02880', 'Wakefield', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02881', 'Kingston', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02882', 'Narragansett', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02883', 'Peace Dale', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02885', 'Warren', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02886', 'Warwick', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02887', 'Warwick', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02888', 'Warwick', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02889', 'Warwick', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02891', 'Westerly', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02892', 'West Kingston', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02893', 'West Warwick', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02894', 'Wood River Junction', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02895', 'Woonsocket', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02896', 'North Smithfield', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02898', 'Wyoming', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02901', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02902', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02903', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02904', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02905', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02906', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02907', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02908', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02909', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02910', 'Cranston', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02911', 'North Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02912', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02914', 'East Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02915', 'Riverside', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02916', 'Rumford', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02917', 'Smithfield', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02918', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02919', 'Johnston', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02920', 'Cranston', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02921', 'Cranston', 'Adams City', Null, Null, Null, GetDate(), GetDate())
INSERT ZipCodeCityRegion (ZipCode, City, County, Region, Viewable, Inactive, LastModified, CreateDate) VALUES('02940', 'Providence', 'Adams City', Null, Null, Null, GetDate(), GetDate())
END