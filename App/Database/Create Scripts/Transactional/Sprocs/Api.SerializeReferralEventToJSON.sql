IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE   schema_name = 'Api' ) 
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Api'
END
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SerializeReferralEventToJSON')
	BEGIN
		PRINT 'Dropping Procedure SerializeReferralEventToJSON'
		DROP Procedure [Api].[SerializeReferralEventToJSON]
	END
GO

PRINT 'Creating Procedure SerializeReferralEventToJSON'
GO

CREATE PROCEDURE [Api].[SerializeReferralEventToJSON] (@XML AS VARCHAR(MAX),  @JSONOUTPUT VARCHAR(MAX) OUTPUT)
AS
		/******************************************************************************
		**	File: Api.SerializeReferralEventToJSON.sql 
		**	Name: SerializeReferralEventToJSON
		**	Desc: Generate Json 
		**	Auth: Ilya Osipov
		**	Date: 9/28/2017
		*******************************************************************************/

BEGIN
    DECLARE 
			@JSON VARCHAR(MAX),			
			@XML_DATA xml;

	IF OBJECT_ID('tempdb.dbo.#tmpRows') IS NOT NULL
	DROP TABLE #tmpRows;
			 	 
	SELECT @XML_DATA = CAST(CAST(@XML AS varchar(MAX)) AS XML); 
		
	SELECT result=  '{' 
		+ '"CallNumber" : "'+ x.RowRef.query('./CallNumber').value('.', 'nvarchar(15)')  + '",'
		+ '"LastModified" : "'+ x.RowRef.query('./LastModified').value('.', 'nvarchar(25)')  + '",'
		+ '"LogEventCreatedBy" : "'+ x.RowRef.query('./LogEventCreatedBy').value('.', 'nvarchar(105)')  + '",'
		+ '"LogEventDateTime" : "'+ x.RowRef.query('./LogEventDateTime').value('.', 'nvarchar(25)')  + '",'
		+ '"LogEventDesc" : "'+ x.RowRef.query('./LogEventDesc').value('.', 'nvarchar(1000)')  + '",'
		+ '"LogEventId" : '+ x.RowRef.query('./LogEventID').value('.', 'nvarchar(10)')  + ','
		+ '"LogEventName" : "'+ x.RowRef.query('./LogEventName').value('.', 'nvarchar(50)')  + '",'
		+ '"LogEventOrg" : "'+ x.RowRef.query('./LogEventOrg').value('.', 'nvarchar(80)')  + '",'
		+ '"LogEventPhone" : "'+ x.RowRef.query('./LogEventPhone').value('.', 'nvarchar(100)')  + '",'
		+ '"LogEventTypeId" : '+ CASE WHEN  LEN( x.RowRef.query('./LogEventTypeID').value('.', 'nvarchar(20)')) = 0 then 'null' else  x.RowRef.query('./LogEventTypeID').value('.', 'nvarchar(20)') END  + ','
		+ '"LogEventTypeName" : "'+ x.RowRef.query('./LogEventTypeName').value('.', 'nvarchar(50)')  + '",'
		+ '"OrganizationId" : '+ CASE WHEN  LEN( x.RowRef.query('./OrganizationID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./OrganizationID').value('.', 'nvarchar(10)') END  + ','
		+ '"PersonId" : ' + CASE WHEN  LEN( x.RowRef.query('./PersonID').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./PersonID').value('.', 'nvarchar(10)') END  + ','
		+ '"ReferralEventAttnTo" : "'+ x.RowRef.query('./ReferralEventAttnTo').value('.', 'nvarchar(50)')  + '",'
		+ '"ReferralEventCalloutAfter" : "'+ x.RowRef.query('./ReferralEventCalloutAfter').value('.', 'nvarchar(20)')  + '",'
		+ '"ReferralEventCalloutMin" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEventCalloutMin').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEventCalloutMin').value('.', 'nvarchar(10)') END  + ','
		+ '"ReferralEventContactConfirm" : '+ CASE WHEN  LEN( x.RowRef.query('./ReferralEventContactConfirm').value('.', 'nvarchar(10)')) = 0 then 'null' else  x.RowRef.query('./ReferralEventContactConfirm').value('.', 'nvarchar(10)') END  + ','
		+ '"ReferralEventDocName" : "'+ x.RowRef.query('./ReferralEventDocName').value('.', 'nvarchar(50)')  + '",'
		+ '"ReferralEventFaxNbr" : "'+ x.RowRef.query('./ReferralEventFaxNbr').value('.', 'nvarchar(11)')  + '",'
		+ '"ReferralId" : '+ x.RowRef.query('./ReferralID').value('.', 'nvarchar(10)')  
		+ '},'	 
	INTO #tmpRows	 
	FROM @XML_DATA.nodes('/referralevents/row') as x(RowRef);   
  
    SET @JSON = '';
  
   IF EXISTS(SELECT * FROM #tmpRows)
	BEGIN
		WHILE EXISTS (SELECT * FROM #tmpRows) 
			BEGIN 			
				SELECT @JSON = (@JSON + result) FROM #tmpRows;

				DELETE TOP(1) FROM #tmpRows
			END
	END


    IF LEN(@JSON) > 0
        SET @JSON = SubString(@JSON, 0, LEN(@JSON));
    SET @JSON = '[' + @JSON + ']';
 
    DROP TABLE #tmpRows;

    SELECT @JSONOUTPUT = @JSON;
END
