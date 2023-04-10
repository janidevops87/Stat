 declare @query table
	(
		id int identity(1,1),
		sql nvarchar(4000)
	)
declare 
	@loopcount int,
	@maxcount int,
	@sql nvarchar(4000)
use msdb
insert @query
 select 'EXEC msdb.dbo.sp_update_job @job_name  = [' + name + '], @enabled = 0'  from sysjobs 
where 
--- select * from sysjobs
category_id = 15
and enabled = 1

select
	@maxcount = max(ID),
	@loopcount = 1
from
	@query

select * from @query
while (@loopcount <= @maxcount)
begin
	select @sql = sql from @query where id = @loopcount
	exec sp_executesql @sql
	set @loopcount = @loopcount + 1
end

go
declare @query table
	(
		id int identity(1,1),
		sql nvarchar(4000)
	)
declare 
	@loopcount int,
	@maxcount int,
	@sql nvarchar(4000)
use msdb

insert @query (sql)
 select 'EXEC msdb.dbo.sp_start_job_serial [' + name + ']'  

from 
	sysjobs 
where 
	category_id = 15
and name like '%auditTrail%'

-- and		(name like '%ohlb%' )
/*
or
name like '%DMV_WY'
)
or
name like '%loop%'
)
*/
order by 
substring( name, 13, len(name))


select
	@maxcount = max(ID),
	@loopcount = 1
from
	@query

select * from @query
while (@loopcount <= @maxcount)
begin
	select @sql = sql from @query where id = @loopcount
	exec sp_executesql @sql
	set @loopcount = @loopcount + 1
end

