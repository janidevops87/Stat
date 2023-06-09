SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_getdata]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_getdata]
GO





/****** Object:  Stored Procedure dbo.usp_getdata    Script Date: 2/24/99 1:12:43 AM ******/
/****** Object:  Stored Procedure dbo.usp_getdata Script Date: 2/8/99 5:25:46 PM ******/
CREATE PROCEDURE usp_getdata 

@queryTable varchar(30) = null

 AS
	
	DECLARE	@tableName	varchar(30)
	DECLARE	@countTables  	int
	DECLARE	@argumentList	varchar(255)
	DECLARE @argumentList2	varchar(255)
	/* DECLARE	@timeOfConversion varchar(30) */
	
	/*SELECT @timeOfConversion = "'" + @timeOfConversion + "'" '02/05/99 08:01:03 AM' */
	SELECT @countTables = 0
	
	DECLARE	idx_cursor scroll cursor 
	for
		SELECT	distinct a.name
		FROM	sysobjects a,sysindexes b
		WHERE	a.type = 'U'
		AND	a.id = b.id
		AND	b.indid > 0
	open	idx_cursor
	fetch next from idx_cursor into @tableName
	
/* 	EXECUTE("sp_dboption  '_ReferralProd', 'dbo use only', 'TRUE' ") */
	 while @@fetch_status = 0	
	  begin
		if @queryTable <> null
			begin
				fetch last from idx_cursor into @tableName
				SELECT @tableName = @queryTable
			end
	
		SELECT @countTables = @countTables + 1
			

			SELECT @argumentList = ""
			SELECT @argumentList = @argumentList + "DECLARE @maxID int"
			SELECT @argumentList = @argumentList + " DECLARE @maxDate varchar(30)"
			SELECT @argumentList = @argumentList + " SELECT "
			SELECT @argumentList = @argumentList + "@maxDate "
			SELECT @argumentList = @argumentList + " = MAX(LastModified) FROM _ReferralProd.dbo." 
			SELECT @argumentList = @argumentList + @tableName
			SELECT @argumentList = @argumentList + " SELECT "
			SELECT @argumentList = @argumentList + "@maxID"
			SELECT @argumentList = @argumentList + "  = MAX(" 
			if @tableName = 'ServiceLevel30Organization'
			begin
				SELECT @argumentList = @argumentList + "ServiceLevelOrganization"
			end
			ELSE
			if @tableName = 'ServiceLevel30'
			begin
				SELECT @argumentList = @argumentList + "ServiceLevel"
			end
			ELSE			if @tableName = 'CallCustomField'
			begin
				SELECT @argumentList = @argumentList + "Call"
			end
			ELSE
			if @tableName <> 'ServiceLevel30Organication' and @tableName <> 'ServiceLevel30'  and @tableName <> 'CallCustomField' 
			begin
				SELECT @argumentList = @argumentList + @tableName
			end


			SELECT @argumentList = @argumentList + "ID) FROM _ReferralProd.dbo."
			SELECT @argumentList = @argumentList + @tableName 

			SELECT @argumentList2 = ""		
			SELECT @argumentList2 = @argumentList2 + " UPDATE _ReferralReference.dbo.ColumnName SET MaxID = @maxID, MaxDate = @maxDate"
			SELECT @argumentList2 = @argumentList2 + "  WHERE "
			SELECT @argumentList2 = @argumentList2 + "TableName =  '"
			SELECT @argumentList2 = @argumentList2 + @tableName	
			SELECT @argumentList2 = @argumentList2 + "'"				

			/* SELECT @argumentList
			SELECT @argumentList2			*/
			Set NOCOUNT ON
			EXEC(@argumentList + @argumentList2)  
	
	    fetch next from idx_cursor into @tableName
	  end
	/* EXECUTE("sp_dboption  '_ReferralProd', 'dbo use only', 'FALSE' ") */
	deallocate idx_cursor



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

