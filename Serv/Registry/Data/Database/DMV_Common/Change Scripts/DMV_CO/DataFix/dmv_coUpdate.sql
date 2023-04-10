declare @runUpdate int
set @runUpdate = 1
use dmv_co

declare @lastmodified datetime

set @lastmodified =  '11/06/2007' --- make this 11/6 to capture all changes from 11/5

select @lastmodified , dateadd(d, -1, @lastmodified )
if (@runUpdate <> 1)
 begin
select 
	dmv_co..dmv.lastmodified,
	dmv_co2007..dmv.lastmodified,
	--convert(char(10),dmv_co2007.dbo.dmv.lastmodified,101),
	dmv_co..dmv.lastmodified,
	convert(datetime, @lastmodified )
from   dmv_co..dmv, dmv_co2007.dbo.dmv
where
     --       convert(char(10),dmv_co2007.dbo.dmv.lastmodified,101) < convert(datetime, @lastmodified )
	dmv_co..dmv.lastmodified between dateadd(d, -1, @lastmodified ) and @lastmodified 
and
            dmv_co2007.dbo.dmv.license = dmv_co.dbo.dmv.license   
end
else
begin

	alter database dmv_co set recovery simple
	alter table dmv_co.dbo.dmv disable trigger u_dmv

	--- fix the lastmodified date in the dmv table to the original date unless it changed after the 11/5/07 date

	update
				dmv_co..dmv
	set
				dmv_co..dmv.lastmodified = dmv_co2007..dmv.lastmodified
	from 
		dmv_co..dmv, dmv_co2007.dbo.dmv
	where
	--			convert(char(10),dmv_co2007.dbo.dmv.lastmodified,101) < convert(datetime, @lastmodified )
	dmv_co..dmv.lastmodified between dateadd(d, -1, @lastmodified ) and @lastmodified 
	and
				dmv_co2007.dbo.dmv.license = dmv_co.dbo.dmv.license   

	alter table dmv_co.dbo.dmv enable trigger u_dmv
	alter database dmv_co set recovery full 
end