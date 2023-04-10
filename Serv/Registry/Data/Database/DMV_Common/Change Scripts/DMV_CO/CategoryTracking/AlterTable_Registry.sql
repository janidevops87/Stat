/*	ccarroll 03/25/2008 
	Alter DonorConfirmed to allow Nulls. This is required
	to track New Yes'.
	
	 Full regression testing required.
		- Entering new Donors (Admin and online interfaces)
		- Searching for Online donors
		- Confirming new donors
		- Searching Confirmed donors  
*/

 ALTER TABLE Registry
	ALTER COLUMN DonorConfirmed Bit Null 
 GO
 