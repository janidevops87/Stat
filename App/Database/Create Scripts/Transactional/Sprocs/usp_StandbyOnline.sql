SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_StandbyOnline]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_StandbyOnline]
GO



CREATE PROCEDURE [usp_StandbyOnline] AS
/* Restore Hooch _ReferralProd */	
	/* Declare variables */

		DECLARE	@tableName	varchar(30)
		DECLARE	@columnName 	varchar(30)
		DECLARE	@columnList 	varchar(8000)
		DECLARE	@QueryList 	varchar(8000)
		DECLARE	@updateList	varchar(8000)
	 	DECLARE @FileName 	varchar(255)
		DECLARE @QueryTable 	varchar(30)
		DECLARE @TableID 	varchar(30)
	
	/* Set quoted identifier off */
	SET QUOTED_IDENTIFIER OFF
	/* Intitalize @QueryTable - If testing only one table, replace none with the table name.  */	
		SET @QueryTable = 'none'
	/* SET NOCOUNT ON - NOCOUNT prevents SQL from printing row counts from each query */
		SET NOCOUNT ON 

	-- Pull Data From _ReferralProdReport
		--Create Cursor to loop through _ReferralProd Tables
		DECLARE	idx_cursor	cursor static
		FOR
			SELECT	distinct a.name
			FROM	sysobjects a,sysindexes b
			WHERE	a.type = 'U'
			AND	a.id = b.id
			AND	b.indid > 0
		OPEN	idx_cursor
		fetch next from idx_cursor into @tableName
		--Loop through list of tables
		while @@fetch_status = 0	
		  BEGIN
			-- If QueryTable is not none run script for a given table
			If @QueryTable <> 'none'
				BEGIN
					fetch last from idx_cursor into @tableName
					SET @tableName = @queryTable
					SELECT @TABLENAME
				END	
			-- Do not run script for ReportLog, dtproperties, and msreplication_subscription
			If @tableName = 'ReportLog' or @tableName = 'dtproperties' or @tableName = 'msreplication_subscriptions' 
				BEGIN
					fetch next from idx_cursor into @tableName
				END
		
			SET @columnList = ""
			SET @updateList = ""
			--Create cursor to create a column list and an update list of all columns in a given table.
			DECLARE col_cursor 	cursor
			FOR
				SELECT DISTINCT 
					b.name 
				FROM 	sysobjects a,
					syscolumns b
				WHERE 	a.id = b.id
				AND	a.name = @tableName
			OPEN	col_cursor
			fetch next from col_cursor into @columnName
			--Loop through list of columns 
			while @@fetch_status = 0
				BEGIN	
					Set @columnList =  @columnList + rtrim(@columnName)					
					--Do not include table ids in updatelist
					if rtrim(@columnName) <> @tableName + 'ID' and rtrim(@columnName) <> 'ServiceLevelOrganization' + 'ID' and rtrim(@columnName) <> 'ServiceLevel' + 'ID'  and rtrim(@columnName)<> 'Call' + 'ID'
						BEGIN
				
							SET @updateList = @updateList + rtrim(@columnName) 
							SET @updateList = @updateList +  " = " 
							SET @updateList = @updateList +  "i."
							SET @updateList = @updateList +  rtrim(@columnName)
						END
					fetch next from col_cursor into @columnName
					-- add a comma to the end of each column in the lists except the last.
					if @@fetch_status = 0						BEGIN
							SET @columnList = @columnList + ", "		
							if rtrim(@columnName) <> @tableName + 'ID' and rtrim(@columnName) <> 'ServiceLevelOrganization' + 'ID' and rtrim(@columnName) <> 'ServiceLevel' + 'ID'  and rtrim(@columnName) <> 'Call' + 'ID' and @updateList <> ' '
								BEGIN
									SET @updateList = @updateList + ', '		
								END
						END
				END
				deallocate col_cursor	

			--- GET TABLE ID
				SET @TableID = ' '
				if @tableName = 'ServiceLevel30Organization'
					BEGIN
						SET @TableID = 'ServiceLevelOrganization'
					END
				ELSE
				if @tableName = 'ServiceLevelCustomField'
					BEGIN
						SET @TableID = 'ServiceLevel'
					END
				ELSE
				if @tableName = 'ServiceLevel30'
					BEGIN
						SET @TableID = 'ServiceLevel'
					END
				ELSE				if @tableName = 'CallCustomField'
					BEGIN
						SET @TableID = 'Call'
					END
				ELSE
				if @tableName <> 'ServiceLevel30Organization' and @tableName <> 'ServiceLevel30'  and @tableName <> 'CallCustomField' 
					BEGIN
						SET @TableID = @tableName
					END
				SET @TableID = @TableID + 'ID'
	
			--- Build Query List
				SET @QueryList = ' ' 	
				SET @QueryList = @QueryList + " SELECT *"
				SET @QueryList = @QueryList + " INTO #_StandByServerUpdate"
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " FROM _ReferralProdReport.."
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " i WHERE	i.LastModified > (select max(LastModified)"
				SET @QueryList = @QueryList + " from _ReferralProd.."
				SET @QueryList = @QueryList + @tableName 
				SET @QueryList = @QueryList + " ) UPDATE "
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " SET "
				SET @QueryList = @QueryList + @updateList
				SET @QueryList = @QueryList + " FROM #_StandByServerUpdate"
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " i WHERE "
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + "."
				SET @QueryList = @QueryList + @TableID
				SET @QueryList = @QueryList + " = i."
				SET @QueryList = @QueryList + @TableID
				SET @QueryList = @QueryList + "  DROP TABLE #_StandByServerUpdate"
				SET @QueryList = @QueryList + @tableName
			--Execute first Query
				--select @tableName
				--select  @QueryList 
				EXEC(@QueryList)
	
			--Build Second Query --- Insert Query
				SET @QueryList = ' '		
				SET @QueryList = @QueryList + " SELECT *"
				SET @QueryList = @QueryList + " INTO #_StandByServerInsert"
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " FROM _ReferralProdReport.."
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " i WHERE	i."
				SET @QueryList = @QueryList + @TableID
				SET @QueryList = @QueryList + " > (select max("
				SET @QueryList = @QueryList + @TableID
				SET @QueryList = @QueryList + " ) from _ReferralProd.."
				SET @QueryList = @QueryList + @tableName 
				SET @QueryList = @QueryList + " ) " 
				if @tableName <> 'CallCustomField' and @tableName <> 'ServiceLevelCustomField'
					BEGIN
						SET @QueryList = @QueryList + " SET IDENTITY_INSERT _ReferralProd.." 
						SET @QueryList = @QueryList + @tableName
						SET @QueryList = @QueryList + " ON"
					END
		
				SET @QueryList = @QueryList + " INSERT "
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " ("
				SET @QueryList = @QueryList + @columnList
				SET @QueryList = @QueryList + " ) "
				SET @QueryList = @QueryList + " SELECT "
				SET @QueryList = @QueryList + @columnList
				SET @QueryList = @QueryList + " FROM #_StandByServerInsert"
				SET @QueryList = @QueryList + @tableName
				SET @QueryList = @QueryList + " r WHERE r."
				SET @QueryList = @QueryList + @TableID
				SET @QueryList = @QueryList + " > "
				SET @QueryList = @QueryList + "(SELECT max("
				SET @QueryList = @QueryList + @TableID
				SET @QueryList = @QueryList + " ) from _ReferralProd.."
				SET @QueryList = @QueryList + @tableName 
				SET @QueryList = @QueryList + " ) " 
				if @tableName <> 'CallCustomField' and @tableName <> 'ServiceLevelCustomField'
					BEGIN
						SET @QueryList = @QueryList + " SET IDENTITY_INSERT _ReferralProd.." 
						SET @QueryList = @QueryList + @tableName
						SET @QueryList = @QueryList + " OFF "
					END		
				SET @QueryList = @QueryList + " DROP TABLE #_StandByServerInsert"
				SET @QueryList = @QueryList + @tableName
		
			--Execute 
				--SET @QueryList
				Exec(@QueryList)

			fetch next from idx_cursor into @tableName
		END
	--turn dbo use only off
	--EXEC('sp_dboption @dbname='_ReferralProd', @optname='dbo use only', @optvalue='FALSE' ')
	deallocate idx_cursor
	

	/* Set quoted identifier off */
	SET QUOTED_IDENTIFIER ON





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

