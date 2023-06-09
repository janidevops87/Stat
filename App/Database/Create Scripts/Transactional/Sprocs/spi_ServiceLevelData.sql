SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_ServiceLevelData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_ServiceLevelData]
GO

CREATE PROCEDURE spi_ServiceLevelData
			@ServiceLevelId	int,
			@ModelServiceLevelId int

AS

declare @OriginalId		 	int, 
	@ParentID 			int,
	@ControlName			varchar(100),
	@DisplayName			varchar(100),
	@DisplayOrder			int,
	@Visible			int,
	@X				int,
	@Y				int,
	@Height				int,
	@LeftPos			int,
	@MaxChar			int,
	
	@NewId				int
	

create table #ids(OriginalId	int,
                  NewId        	int)

declare cDATA cursor for 
  SELECT ServiceLevelSecondaryCtlsID,ParentID,ControlName,DisplayName,DisplayOrder,Visible,X,Y,Height,LeftPos,MaxChar
  From ServiceLevelSecondaryCtls
  Where ServiceLevelId = @ModelServiceLevelId
  order by parentid, displayorder asc

open cDATA
fetch next from cDATA into @OriginalId,@ParentID,@ControlName,@DisplayName,@DisplayOrder,@Visible,@X,@Y,@Height,@LeftPos,@MaxChar
while @@fetch_status = 0
  begin
    insert ServiceLevelSecondaryCtls(ServiceLevelID,ParentID,ControlName,DisplayName,DisplayOrder,Visible,X,Y,Height,LeftPos,MaxChar)
    values(@ServiceLevelId,@ParentID,@ControlName,@DisplayName,@DisplayOrder,@Visible,@X,@Y,@Height,@LeftPos,@MaxChar)

    select @NewId = Max(ServiceLevelSecondaryCtlsId) from ServiceLevelSecondaryCtls

    insert #ids(OriginalId,  NewId)
    values(@OriginalId, @NewId)

    fetch next from cDATA into @OriginalId,@ParentID,@ControlName,@DisplayName,@DisplayOrder,@Visible,@X,@Y,@Height,@LeftPos,@MaxChar
  end
close cDATA
deallocate cDATA

/*
declare cID cursor for 
  SELECT OriginalId,  NewId
  From #ids

open cID
fetch next from cID into @OriginalId, @NewId
while @@fetch_status = 0
  begin
    update ServiceLevelSecondaryCtls
    set ParentID = @NewId
    where ParentID = @OriginalId
    and ServiceLevelId = @ServiceLevelId

    fetch next from cID into @OriginalId, @NewId
  end
close cID
deallocate cID
*/
update ServiceLevelSecondaryCtls
set ParentID = NewId
from ServiceLevelSecondaryCtls SLS
inner join #ids  on #ids.OriginalId = SLS.ParentID
and ServiceLevelId = @ServiceLevelId


drop table #ids




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

