  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[sps_CheckRegistry_RegLoad]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].sps_CheckRegistry_RegLoad
	PRINT 'Dropping Procedure: sps_CheckRegistry_RegLoad'
END
	PRINT 'Creating Procedure: sps_CheckRegistry_RegLoad'
	SET ANSI_NULLS OFF
	SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[sps_CheckRegistry_RegLoad]
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
**              
**		Parameters:
**
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    04/27/2009	ccarroll			initial for DMV_Common
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	SET NOCOUNT ON
Declare
@strproc varchar(8000)
set @strproc =  'Select Registry.FirstName, Registry.MIDDLENAME, Registry.LastName, registry.License as  License, '	
				set @strproc = @strproc + 'registryAddr.Addr1 as  Addr1, '
				set @strproc = @strproc   + 'registryAddr.city as   City, '
				set @strproc = @strproc   + 'registryAddr.State as  State, '
				set @strproc = @strproc   + 'registryAddr.zip as  Zip, '
				set @strproc = @strproc   + 'Registry.LastModified as  SearchDate, '
				set @strproc = @strproc   + 'registry.RegistryID as loc'
				
				set @strproc = @strproc   +  ' FROM registry  join registryAddr On registry.RegistryID = registryAddr.registryid '
				set @strproc = @strproc   +   ' WHERE	registry.DOB = ' +"'" + @DOB  ++"'" + ' And'	
				set @strproc = @strproc   +  ' IsNull(registry.DeleteFlag, 0) = 0 And'

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
				set @strproc = @strproc   +  ' ORDER BY registry.middleName,registryAddr.Zip,registryAddr.City,registryAddr.Addr1  DESC'


print @strproc
exec(@strproc)
