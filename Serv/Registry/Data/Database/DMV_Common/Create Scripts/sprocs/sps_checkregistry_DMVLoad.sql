if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CheckRegistry_DMVLoad]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure sps_CheckRegistry_DMVLoad'
		DROP  Procedure  sps_CheckRegistry_DMVLoad
	END
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

PRINT 'Creating Procedure sps_CheckRegistry_DMVLoad'
GO
CREATE PROCEDURE sps_checkregistry_DMVLoad
 
	@DOB   varchar(25)    = NULL,
	@LastName  VARCHAR(25) = NULL,
	@FirstName VARCHAR(25) = NULL, 
	@MiddleName VARCHAR(25) = NULL,
	@SSN   VARCHAR(11) = NULL,
	@LICENSE VARCHAR(15) = NULL,
	@StreetAddress VARCHAR(45) = NULL,
	@City VARCHAR(25) = NULL,
	@State VARCHAR(2) = NULL,
	@Zip VARCHAR(10) = NULL,
	@Loc  int = null
	
AS
/******************************************************************************
**		File: 
**		Name: sps_CheckRegistry_DMVLoad
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   FrmDonorData
**              
**		Parameters:
**
**		Auth: Unknown
**		Date: 3/2003
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**    10/15/2007	ccarroll			Added FirstName, and LastName to select
*******************************************************************************/
SET NOCOUNT ON
	declare
		@RecordsReturned int,
		@strproc	varchar(8000)
				set @strproc =  'Select DMV.FirstName, DMV.MiddleName, DMV.LastName, Dmv.License as  License, '	
				set @strproc = @strproc + 'DMVAddr.Addr1 as  Addr1, '
				set @strproc = @strproc   + 'DMVAddr.city as   City, '
				set @strproc = @strproc   + 'DMVAddr.State as  State, '
				set @strproc = @strproc   + 'DMVAddr.zip as  Zip, '
				
				set @strproc = @strproc   + 'DMV.LastModified as  SearchDate, '
				set @strproc = @strproc   + 'DMV.ID as Loc'
			
				
				set @strproc = @strproc   +  ' FROM DMV join DMVAddr On DMV.ID = DMVAddr.Dmvid '
				set @strproc = @strproc   +   ' WHERE	DMV.DOB = ' +"'" + @DOB  ++"'" + ' And'	
				--set @strproc = @strproc   +  'AND	'
				If  @MiddleName is not null
					Begin
						Set @strproc = @strproc + ' dmv.middleName = ' + "'" + @MiddleName + "'" +  ' And '
					End
				If  @License is not null
					Begin
						Set @strproc = @strproc + ' dmv.License = ' + "'" + @License + "'" +  ' And '
					End
				If  @StreetAddress is not null
					Begin
						if Left(@StreetAddress,1) = '*' or Right(@StreetAddress,1)  = '*'
							Begin
								set @StreetAddress = REPLACE(@StreetAddress,'*','%');
								Set @strproc = @strproc + '  DMVAddr.Addr1  like ' + "'" + @StreetAddress + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' DMVAddr.Addr1 = ' + "'" + @StreetAddress + "'" +  ' And '
							end
					End
				If  @City is not null
					Begin
						if Left(@City,1) = '*' or Right(@City,1)  = '*'
							Begin
								set @City = REPLACE(@City,'*','%');
								Set @strproc = @strproc + '  DMVAddr.City like ' + "'" + @City + "'" +  ' And '
							end
						else
							Begin
								Set @strproc = @strproc + ' DMVAddr.City = ' + "'" + @City + "'" +  ' And '
							end
					End
				If  @State is not null
					Begin
						Set @strproc = @strproc + ' DMVAddr.State = ' + "'" + @State+ "'" +  ' And '
					End
				If  @Zip is not null
					Begin
						Set @strproc = @strproc + ' DMVAddr.Zip = ' + "'" + @Zip + "'" +  ' And '
					End
				set @strproc = @strproc   +   ' dmv.FirstName           = '  +  "'" + @FirstName + "'"
				set @strproc = @strproc    + ' AND	dmv.LastName             = ' + "'" + @LastName	+"'" 
				set @strproc = @strproc   +  ' ORDER BY dmv.middleName,DMVAddr.Zip,DMVAddr.City,DMVAddr.Addr1 '


print @strproc
exec(@strproc)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

GRANT EXEC ON sps_CheckRegistry_DMVLoad TO PUBLIC

GO

