SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

/****** Object:  Stored Procedure dbo.SPS_CheckRegistry_REGLoad    Script Date: 5/14/2007 10:02:39 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CheckRegistry_REGLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CheckRegistry_REGLoad]
GO



--This stored proc is for the registry lookup for mulitple records

/*

Desigened AND Developed 09/2004

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 

Paramameters
	@DOB   varchar(25)    = NULL,	Date of Birth
	@LastName  VARCHAR(25) = NULL,	last name
	@FirstName VARCHAR(25) = NULL, 	first name
	@MiddleName VARCHAR(25) = NULL,	middle name
	@SSN   VARCHAR(11) = NULL,		ssn
	@LICENSE VARCHAR(15) = NULL,	license
	@StreetAddress VARCHAR(45) = NULL,	address
	@City VARCHAR(25) = NULL,		city
	@State VARCHAR(2) = NULL,		state
	@Zip VARCHAR(10) = NULL,		zip	
	@Loc  int = null				locator field

-- SP_HELP DMV
*/


CREATE Procedure SPS_CheckRegistry_REGLoad
	@DOB   varchar(255)    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL,
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@Loc int = null
	--@DonorConfirmed BIT = NULL
	--@REGID INT OUTPUT,
	--@REGDonor BIT OUTPUT,
	--@REGDate smalldatetime OUTPUT,
	--@RecordsReturned INT OUTPUT 

AS
SET NOCOUNT ON
/*
This stored procedure is called by sps_CheckRegistry to query the Registry table

Desigened AND Developed 03/2003

Legal Information...
 ©1996-2003 Statline, LLC. All rights reserved. 

 Statline is a registered trademark of Statline, LLC in the U.S.A. 


 7555 East Hampden Avenue, Ste. 104, 
 Denver, CO 80231. 
 1-888-881-7828. 


*/
Declare
@strproc varchar(8000)
	-- get values for REG
	--IF	ISNULL(@MiddleName, '') +  
	--ISNULL(@SSN, '') +
	--ISNULL(@LICENSE, '') +
	--ISNULL(@StreetAddress, '') +
	--ISNULL(@City, '') +		
	--ISNULL(@Zip, '') = '' 
	--BEGIN	
--PRINT 'REG: QUERY WITH DOB, LAST AND FIRST'
		--SELECT  	Registry.MiddleName as 'Middle',
				--Registry.License as 'License',
				--RegistryAddr.Addr1 as 'Addr',  
				--RegistryAddr.City as 'City',  
				--RegistryAddr.State as 'State',  
				--RegistryAddr.Zip as 'Zip'--TOP 1
			--@REGID = D.ID ,
			--@REGDonor = D.Donor ,
			--@REGDate =  D.DateModified
		--FROM Registry   join RegistryAddr On Registry.ID = RegistryAddr.RegistryID
		--WHERE	Registry.DOB		= @DOB			
		--AND	Registry.FirstName       = @FirstName			
		--AND	Registry.LastName	= @LastName		 			
		--AND   (Registry.DonorConfirmed	  = @DonorConfirmed OR ISNULL(@DonorConfirmed, 	'')='')
		--ORDER BY Registry.LASTMODIFIED DESC 
	--End
		

		
		

		-- get the number of records returned
		--SELECT @RecordsReturned = @@RowCount
		--print @RecordsReturned 
		--Print @DonorConfirmed 
		--print @FirstName
		--Print @LastName
		--Print @RegID
		--Print @RegDonor
		--Print @RegDate
		-- Note: No record count is used in the registry query. The registry tables could have a duplicate
		---      records of the same person. The registration form allows donors to register as often as they want.
		
	--END


set @strproc =  'Select Registry.MIDDLENAME ,  registry.License as  License, '	
				set @strproc = @strproc + 'registryAddr.Addr1 as  Addr1, '
				set @strproc = @strproc   + 'registryAddr.city as   City, '
				set @strproc = @strproc   + 'registryAddr.State as  State, '
				set @strproc = @strproc   + 'registryAddr.zip as  Zip, '
				set @strproc = @strproc   + 'registry.LastModified as  SearchDate, '
				set @strproc = @strproc   + 'registry.ID as loc'
				
				
			
				
				set @strproc = @strproc   +  ' FROM registry  join registryAddr On registry.ID = registryAddr.registryid '
				set @strproc = @strproc   +   ' WHERE	registry.DOB = ' +"'" + @DOB  ++"'" + ' And'	
				--set @strproc = @strproc   +  'AND	'
				If  @MiddleName is not null
					Begin
						Set @strproc = @strproc + ' registry.middleName = ' + "'" + @MiddleName + "'" +  ' And '
					End
				If  @License is not null
					Begin
						Set @strproc = @strproc + ' registry.License = ' + "'" + @License + "'" +  ' And '
					End
				If  @StreetAddress is not null
					Begin
						Set @strproc = @strproc + ' registryAddr.Addr1 = ' + "'" + @StreetAddress + "'" +  ' And '
					End
				If  @City is not null
					Begin
						Set @strproc = @strproc + ' registryAddr.City = ' + "'" + @City + "'" +  ' And '
					End
				If  @State is not null
					Begin
						Set @strproc = @strproc + ' registryAddr.State = ' + "'" + @State+ "'" +  ' And '
					End
				If  @Zip is not null
					Begin
						Set @strproc = @strproc + ' registryAddr.Zip = ' + "'" + @Zip + "'" +  ' And '
					End
				set @strproc = @strproc   +   ' registry.FirstName           = '  +  "'" + @FirstName + "'"
				set @strproc = @strproc    + ' AND	registry.LastName             = ' + "'" + @LastName	+"'" 
				set @strproc = @strproc   +  ' ORDER BY registry.LASTMODIFIED DESC'


print @strproc
exec(@strproc)
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

