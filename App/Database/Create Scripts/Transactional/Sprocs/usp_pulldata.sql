SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_pulldata]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_pulldata]
GO





CREATE PROCEDURE usp_pulldata 

@queryTable varchar(30) 

 AS
	
	DECLARE	@tableName	varchar(30)
	DECLARE	@columnName 	varchar(30)
	DECLARE	@columnList 	varchar(8000)
	DECLARE	@argumentList 	varchar(8000)
	DECLARE	@updateList	varchar(8000)
	DECLARE	@countTables  	int

	SET NOCOUNT ON 

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

		/*SET @maxID = ""
		SET @maxDate = "" */
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
			set @argumentList = @argumentList + "DECLARE @maxID varchar(30)"
			set @argumentList = @argumentList + " SELECT "
			set @argumentList = @argumentList + "@maxID"
			set @argumentList = @argumentList + " = _ReferralReference.dbo.ColumnName.MaxID" 
			set @argumentList = @argumentList + " FROM _ReferralReference.dbo.ColumnName" 						
			set @argumentList = @argumentList + " WHERE _ReferralReference.dbo.ColumnName.TableName = '"
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + "' "
			set @argumentList = @argumentList + " UPDATE "
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + " SET "
			set @argumentList = @argumentList + @updateList
			set @argumentList = @argumentList + " FROM _ReferralReference.dbo."
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + " i WHERE i.UpdatedFlag = 1 AND "
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + "."
			if @tableName = 'ServiceLevel30Organization'
			begin
				set @argumentList = @argumentList + "ServiceLevelOrganization"
			end
			ELSE
			if @tableName = 'ServiceLevel30'
			begin
				set @argumentList = @argumentList + "ServiceLevel"
			end
			ELSE			if @tableName = 'CallCustomField'
			begin
				set @argumentList = @argumentList + "Call"
			end
			ELSE
			if @tableName <> 'ServiceLevel30Organization' and @tableName <> 'ServiceLevel30'  and @tableName <> 'CallCustomField' 
			begin
				set @argumentList = @argumentList + @tableName
			end
			set @argumentList = @argumentList + "ID = i."
			if @tableName = 'ServiceLevel30Organization'
			begin
				set @argumentList = @argumentList + "ServiceLevelOrganization"
			end
			ELSE
			if @tableName = 'ServiceLevel30'
			begin
				set @argumentList = @argumentList + "ServiceLevel"
			end
			ELSE			if @tableName = 'CallCustomField'
			begin
				set @argumentList = @argumentList + "Call"
			end
			ELSE
			if @tableName <> 'ServiceLevel30Organization' and @tableName <> 'ServiceLevel30'  and @tableName <> 'CallCustomField' 
			begin
				set @argumentList = @argumentList + @tableName
			end
			set @argumentList = @argumentList + "ID "

			select @tableName
			Execute(@argumentList)
						
			set @argumentList = ""
			set @argumentList = @argumentList + "DECLARE @maxID varchar(30)"
			set @argumentList = @argumentList + " SELECT "
			set @argumentList = @argumentList + "@maxID"
			set @argumentList = @argumentList + " = _ReferralReference.dbo.ColumnName.MaxID" 
			set @argumentList = @argumentList + " FROM _ReferralReference.dbo.ColumnName" 						
			set @argumentList = @argumentList + " WHERE _ReferralReference.dbo.ColumnName.TableName = '"
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + "' "
			
			if @tableName <> 'CallCustomField'
			begin
			set @argumentList = @argumentList + " SET IDENTITY_INSERT " 
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + " ON"
			END
	
			set @argumentList = @argumentList + " INSERT "
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + " ("
			set @argumentList = @argumentList + @columnList
			set @argumentList = @argumentList + ")"
			set @argumentList = @argumentList + " SELECT "
			set @argumentList = @argumentList + @columnList
			set @argumentList = @argumentList + " FROM _ReferralReference.dbo."
			set @argumentList = @argumentList + @tableName
			set @argumentList = @argumentList + " r WHERE r."
			if @tableName = 'ServiceLevel30Organization'
			begin
				set @argumentList = @argumentList + "ServiceLevelOrganization"
			end
			ELSE
			if @tableName = 'ServiceLevel30'
			begin
				set @argumentList = @argumentList + "ServiceLevel"
			end
			ELSE			if @tableName = 'CallCustomField'
			begin
				set @argumentList = @argumentList + "Call"
			end
			ELSE
			if @tableName <> 'ServiceLevel30Organication' and @tableName <> 'ServiceLevel30'  and @tableName <> 'CallCustomField' 
			begin
				set @argumentList = @argumentList + @tableName
			end
			set @argumentList = @argumentList + "ID > "
			set @argumentList = @argumentList + "@maxID"

			if @tableName <> 'CallCustomField'
			begin
				set @argumentList = @argumentList + " SET IDENTITY_INSERT " 
				set @argumentList = @argumentList + @tableName
				set @argumentList = @argumentList + " OFF"
			end		

			Execute(@argumentList)		
			select @tableName	
	
	    fetch next from idx_cursor into @tableName
	  end
	EXECUTE("sp_dboption  '_ReferralProd', 'dbo use only', 'FALSE'")
	deallocate idx_cursor





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

