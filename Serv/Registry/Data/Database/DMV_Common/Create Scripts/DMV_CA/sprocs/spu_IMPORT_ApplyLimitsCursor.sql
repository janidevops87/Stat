  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spu_IMPORT_ApplyLimitsCursor')
	BEGIN
		PRINT 'Dropping Procedure spu_IMPORT_ApplyLimitsCursor'
		DROP  Procedure  spu_IMPORT_ApplyLimitsCursor
	END

GO

PRINT 'Creating Procedure spu_IMPORT_ApplyLimitsCursor'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE Procedure spu_IMPORT_ApplyLimitsCursor

AS

/******************************************************************************
**		File: spu_IMPORT_ApplyLimitsCursor.sql
**		Name: spu_IMPORT_ApplyLimitsCursor
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		NA
**
**		Auth: ccarroll						01/09/2008
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     05/22/2008		ccarroll				Initial
*******************************************************************************/

--SET NOCOUNT ON

DECLARE @primary_key int, @RegID int, @Limits varchar (1000), @LimitsOther varchar (1000), 
	@CAIDnum int, @CAIDnumNew int, @Description varchar(250),@Type varchar(35),@count int,@Limitcon varchar(25)

DECLARE Limits_Cursor CURSOR
 FOR
	SELECT ID FROM Import_UserLimitations
	-- WHERE CAID = 392295


SET @Limits = ''
SET @LimitsOther = ''


OPEN Limits_Cursor

FETCH NEXT FROM Limits_Cursor
INTO @Primary_key

WHILE (@@FETCH_STATUS = 0)

BEGIN
	SELECT   @CAIDnum = ul.CAID, @Description = l.Description, @Type = l.Type FROM  Import_UserLimitations ul
		JOIN CA_Limitations l ON ul.LimitationsID  = l.LimitID where ul.ID = @Primary_key
		--Print @CAIDnum
		--Print @Description

		
		SELECT   @CAIDnumNew = ul.CAID, @Description = l.Description, @Type = l.Type FROM  Import_UserLimitations ul
		JOIN CA_Limitations l ON ul.LimitationsID  = l.LimitID
		WHERE ul.ID = @Primary_key +1

		SELECT @count = count(CAID) from Import_UserLimitations where CAID = @CAIDnum
			-- print @Description
		if @count > 1
		Begin
			Begin
				--Print 'Type'
				--Print @Type
				if @Type = 'Other'
					Begin
						--Print 'Other'
						SET @LimitsOther = @Description  + '. ' + @LimitsOther
						--Print 'LimitsOther'
						--Print @LimitsOther
					end	

			If @Type <> 'Other' AND @Description = 'For Research*'
					Begin
						set @Limits =  @Type + ' ' + @Description +  ', ' + @Limits
					End
		
			If @Type <> 'Other' AND @Description <> 'For Research*'
					Begin
						set @Limits =  @Description +  ', ' + @Limits
					End

				End
			End

		if @count = 1
		Begin
			if @Type = 'Other'
					Begin
						Set @LimitsOther =  @Description  + '. ' + @LimitsOther
					end	

			If @Type <> 'Other' AND @Description = 'For Research*'
					Begin
						set @Limits =  @Type + ' ' + @Description +  ', ' + @Limits
					End
		
			If @Type <> 'Other' AND @Description <> 'For Research*'
					Begin
						set @Limits =  @Description +  ', ' + @Limits
					End


		End



		if @CAIDnum <> @CAIDnumNew
			Begin

				--SET @LimitsOther = LEFT(@LimitsOther, LEN(@LimitsOther)-1)
				--SET @Limits = LEFT(@Limits, LEN(@Limits)-1)
				--print @LimitsOther
				--print LEN(@LimitsOther)-1
				--print @limits

				SET @Limits = LEFT(@Limits, LEN(@Limits) -1) + '.' --Remove Last char, added .

				UPDATE Import SET Limitations = @Limits, LimitationsOther = @LimitsOther
				WHERE CAID = @CAIDNum

				set @LimitsOther = ''
				set @Limits = ''
			End
 
	FETCH NEXT FROM Limits_Cursor
	INTO @Primary_key

END

CLOSE Limits_Cursor

DEALLOCATE Limits_Cursor



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
