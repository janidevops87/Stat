SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_updateStats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_updateStats]
GO





/****** Object:  Stored Procedure dbo.usp_updateStats    Script Date: 2/24/99 1:12:43 AM ******/
CREATE PROCEDURE usp_updateStats AS
	
	DECLARE	@tableName	varchar(30)
	DECLARE	idx_cursor	cursor
	for
		SELECT	distinct a.name
		FROM	sysobjects a,sysindexes b
		WHERE	a.type = 'U'
		AND	a.id = b.id
		AND	b.indid > 0
	open	idx_cursor
	fetch next from idx_cursor into @tableName
	while @@fetch_status = 0
	  begin
	    EXEC ("UPDATE STATISTICS " + @tableName)
	    fetch next from idx_cursor into @tableName
	  end
	deallocate idx_cursor



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

