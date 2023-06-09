SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_createtable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_createtable]
GO





CREATE PROCEDURE usp_createtable 

@queryTable varchar(30) 

 AS
	
	DECLARE	@tableName	varchar(30)
	DECLARE	@columnName 	varchar(30)
	DECLARE	@columnList 	varchar(8000)
	DECLARE	@argumentList 	varchar(8000)
	DECLARE	@updateList	varchar(8000)
	DECLARE	@countTables  	int

	SET @countTables = 0
	
	DECLARE	idx_cursor	cursor static
	for
		SELECT	distinct a.name
		FROM	sysobjects a,sysindexes b
		WHERE	a.type = 'U'
		AND	a.id = b.id
		AND	b.indid > 0
	open	idx_cursor
	fetch next from idx_cursor into @tableName
	
	EXECUTE("sp_dboption  '_ReferralProd', 'dbo use only', 'TRUE' ")
	EXECUTE("sp_dboption  '_ReferralReference', 'select into', 'TRUE' ")
	 while @@fetch_status = 0	
	  begin
		if @queryTable <> 'none'
			begin
				fetch last from idx_cursor into @tableName
				set @tableName = @queryTable
			end
	
		SET @countTables = @countTables + 1
		SET @columnList = ""
		SET @updateList = ""

		DECLARE col_cursor 	cursor
		for
		  	SELECT	ColumnName
			From	_ReferralReference.dbo.ColumnName
			Where	TableName = @tableName
		open	col_cursor
		fetch next from col_cursor into @columnName

		while @@fetch_status = 0
		begin	

			Set @columnList =  @columnList + rtrim(@columnName)					

			if rtrim(@columnName) <> @tableName + "ID" and rtrim(@columnName) <> 'ServiceLevelOrganization' + "ID" and rtrim(@columnName) <> 'ServiceLevel' + "ID"  and rtrim(@columnName)<> 'Call' + "ID"
			begin
				
				SET @updateList = @updateList + rtrim(@columnName) 
				SET @updateList = @updateList +  " = " 
				SET @updateList = @updateList +  "i."
				SET @updateList = @updateList +  rtrim(@columnName)
			end
			fetch next from col_cursor into @columnName
			if @@fetch_status = 0				begin
					SET @columnList = @columnList + ", "		
					if rtrim(@columnName) <> @tableName + "ID" and rtrim(@columnName) <> 'ServiceLevelOrganization' + "ID" and rtrim(@columnName) <> 'ServiceLevel' + "ID"  and rtrim(@columnName)<> 'Call' + "ID" and @updateList <>""					begin
						SET @updateList = @updateList + ", "		
					end
				end
		end
		deallocate col_cursor	

			set @argumentList = ""
			set @argumentList = @argumentList + "use _ReferralReference if exists (select * from sysobjects where id = object_id(N'[dbo].["
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)drop table [dbo].["
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + "]"


			EXEC(@argumentList)

			set @argumentList = ""
			set @argumentList = @argumentList + "SELECT "
			set @argumentList = @argumentList + @columnList
			set @argumentList = @argumentList + " INTO _ReferralReference.dbo."
			set @argumentList = @argumentList + @tableName 												
			set @argumentList = @argumentList + " FROM Remote_SQL._ReferralProd.dbo."
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + " WHERE UPDATEDFLAG = 1" 				

			select @tableName
			Execute(@argumentList)
	
	    fetch next from idx_cursor into @tableName
	  end
	EXECUTE("sp_dboption  '_ReferralReference', 'select into', 'FALSE' ")
	EXECUTE("sp_dboption  '_ReferralProd', 'dbo use only', 'FALSE'")
	deallocate idx_cursor





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

