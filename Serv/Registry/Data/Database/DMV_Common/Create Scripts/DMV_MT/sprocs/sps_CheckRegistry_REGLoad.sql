IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_CheckRegistry_REGLoad')
	BEGIN
		PRINT 'Dropping Procedure sps_CheckRegistry_REGLoad'
		DROP  Procedure  sps_CheckRegistry_REGLoad
	END

GO

PRINT 'Creating Procedure sps_CheckRegistry_REGLoad'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

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
/******************************************************************************
**		File: 
**		Name: sps_CheckRegistry_REGLoad
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**			This stored procedure is called by sps_CheckRegistry to query the Registry table
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    10/15/2007		ccarroll				added FirstName LastName to SELECT
*******************************************************************************/
SET NOCOUNT ON
Declare
@strproc varchar(8000)

set @strproc =  'Select Registry.FirstName, Registry.MIDDLENAME, Registry.LastName, registry.License as  License, '	
				set @strproc = @strproc + 'registryAddr.Addr1 as  Addr1, '
				set @strproc = @strproc   + 'registryAddr.city as   City, '
				set @strproc = @strproc   + 'registryAddr.State as  State, '
				set @strproc = @strproc   + 'registryAddr.zip as  Zip, '
				set @strproc = @strproc   + 'Registry.DateModified as  SearchDate, '
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
							if Left(@StreetAddress,1) = '*' or Right(@StreetAddress,1)  = '*'
							Begin
								set @StreetAddress = REPLACE(@StreetAddress,'*','%');
								Set @strproc = @strproc + '  registryAddr.Addr1  like ' + "'" + @StreetAddress + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' registryAddr.Addr1 = ' + "'" + @StreetAddress + "'" +  ' And '
							end
						 
					End
				If  @City is not null
					Begin						 
						if Left(@City,1) = '*' or Right(@City,1)  = '*'
							Begin
								set @City = REPLACE(@City,'*','%');
								Set @strproc = @strproc + '  registryAddr.City like ' + "'" + @City + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' registryAddr.City = ' + "'" + @City + "'" +  ' And '
							end
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





GO

GRANT EXEC ON sps_CheckRegistry_REGLoad TO PUBLIC

GO
