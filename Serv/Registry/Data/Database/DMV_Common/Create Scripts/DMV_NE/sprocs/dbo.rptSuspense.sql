create procedure dbo.rptSuspense 
	@importlogid int = null
as


/******************************************************************************
**		File: dbo.rptSuspense.sql
**		Name: rptSuspense
**		Desc: This stored procedure returns a  on latest import log statistics
**				and the latest suspense records.
**
**		This template can be customized:
**              
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		----------	------------------	---------------------------------------
**		10/20/2016	Kirill Leontovich	Initial
*******************************************************************************/
	set nocount on;
	declare @RunStatus nvarchar(100);
-- determine the latest importlogid	
	if (@importlogid is null)
	begin
		select top(1) 
			@importlogid = IMPORTLOG.ID,
			@RunStatus = RunStatus
			from IMPORTLOG 			
			order by IMPORTLOG.id desc;

			if @RunStatus = 'Loading'
			begin
				set @importlogid = null;
			end
	end 	

if @importlogid is null
begin
	--the count is greater than zero,  throw an error 
	RAISERROR (N'The import is not complete with a status of Loading. The report cannot run until the process has completed. ', -- Message text.
           11, -- Severity,
           1 -- State
		   ); -- Second argument.
	return;	
end

	
-- query the statistics of the latest import
	declare @importStatusTable table (
		Importlogid			int,
		LastModified		smalldatetime,
		RunStatus			nvarchar(12),
		RecordsTotal		int,	
		RecordsSuspended	int,	
		RecordsAdded		int,	
		RecordsUpdated		int	
	);


	insert @importStatusTable
	select i.id ImportLogId,  
	Convert(nvarchar(10), i.LastModified,101) + ' ' + Convert(nVarChar(5), i.LastModified, 8) 'LastModified',	i.RunStatus, i.RecordsTotal, i.RecordsSuspended, i.RecordsAdded, i.RecordsUpdated 
	from IMPORTLOG i 
	where i.ID = @importlogid;

--- query suspense files from suspense_a

	with Suspense As (

	select 'Suspense_a' SuspensTable, a.Id	,a.ImportLogId	,a.Last	,a.First	,a.Middle	,a.Suffix	,a.AADDR1 'AAddress'	, a.ACity	,a.AState	,a.AZip ,a.BADDR1 'BAddress'	,a.BCity	,a.BState	,a.BZip	,a.DOB	,a.Gender	,a.License	,a.Donor	,a.RenewalDate	,a.DeceasedDate	,a.CsorState	,a.CsorLicense	,/*a.PriorDonorStatus	,a.First_Display FirstName_Display	,a.Middle_Display MiddleName_Display, a.Last_Display LastName_Display	,*/a.Ok	,a.Reason
	from Suspense_a a where a.importlogid = @importlogid

	)

-- return the final restults
	 select *
	 from @importStatusTable i	 
	 left join Suspense s on s.importlogid = i.importlogid;
GO