IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_checkStatFileDelay')
	BEGIN
		PRINT 'Dropping Procedure sp_checkStatFileDelay';
		DROP Procedure sp_checkStatFileDelay;
	END
GO
PRINT 'Creating Procedure sp_checkStatFileDelay';
GO
CREATE Procedure sp_checkStatFileDelay
AS
/******************************************************************************
**	File: sp_checkStatFileDelay.sql
**	Name: sp_checkStatFileDelay
**	Desc: Checks the _ReferralProdReport database for exportFile table where the run dates should haved changed.
**	Auth: Bret Knoll
**	Date: 9/29/2019
**	Called By: SQL Job 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	09/29/2019		Bret Knoll		Initial Sproc Creation
**	03/11/2021		Mike Berenson	Replaced Bret's email with dtplustest@statline.org
*******************************************************************************/

SET QUOTED_IDENTIFIER ON;

declare @sql nvarchar(max),
		@emailString nvarchar(max);


set @sql = 
'select OrganizationName + ''   '' + convert(nvarchar, WebReportGroupID) + ''   '' +  ExportFileDirectoryPath + '' '' + convert(nvarchar, datediff(minute, exportfile.Lastmodified, getdate())) as ''ExportFileClient'' 
from ExportFile 
join Organization on exportFile.organizationId = organization.organizationid
where exportfileon = 1 and ExportFileFrequency = 5
and datediff(minute, exportfile.Lastmodified, getdate()) > ExportFileFrequencyQuantity * 5
';
exec( @sql);
declare @BuildString table ( ExportFileClient nvarchar(max));
insert @BuildString
	exec( @sql);

SELECT @emailString = replace(
       STUFF((SELECT distinct ','+ a.ExportFileClient
               FROM  (select distinct ExportFileClient from @BuildString ) a
            FOR XML PATH(''), TYPE).value('.','VARCHAR(max)'), 1, 1, ''), '*', '');

if exists (select * from @BuildString)
begin
	print @emailString;

	exec msdb..sp_send_dbmail
	@profile_name = 'st-exchange' , 
	@subject = 'StatFile Delay',
	@body = @emailString,
	@importance='High',
	@query= @sql,
	@execute_query_database='_ReferralProdReport',
	@body_format = 'text',
	@recipients = 'it_devoncall@mtf.org; '
end