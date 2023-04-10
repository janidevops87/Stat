 select 
	ReportVirtualURl	
from 
	report 
where	
	ReportVirtualURl like '%stattrac%'


update 
	report
set 
	ReportVirtualURl = Replace(ReportVirtualURl, 'StatTrac', 'StatTrac Test')	
where 
	ReportVirtualURl like '%stattrac%'
and ReportVirtualURl not like '%stattrac test%'	

select 
	ReportVirtualURl	

from 
	report 
where	
	ReportVirtualURl like '%stattrac Test%'
	