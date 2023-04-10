/*
      Creates views for the AuditTrail DB
      1. Update the string @dbNameStringToReplace
      2. Update the string @dbNameNewText 
      3. Set the where statement for select sysobjects
*/
DECLARE 
      @loopCount int, 
      @loopMax int,
      @tableName nvarchar(100),
      @blank nvarchar(100),
      @dropSql nvarchar(4000),
      @sql nvarchar(4000),
      @testSQL nvarchar(4000),
      @testResult int, 
      @dbNameStringToReplace nvarchar(100),
      @dbNameNewText nvarchar(100),
      @vwname nvarchar(25)
      

DECLARE @tables TABLE
      (
            ID INT IDENTITY(1,1),
            tableName nvarchar(100),
            blank nvarchar(100)
            
      
      )

/* DT Test 
set @dbNameStringToReplace = '_AuditTrail'
set @dbNameNewText = '..'
set @vwName = 'vwAuditTrail'
*/
/* DT Production 
set @dbNameStringToReplace = '_AuditTrail'
set @dbNameNewText = '_Report..'
set @vwName = 'vwAuditTrail'
*/

/* StatTrac Production 
set @dbNameStringToReplace = 'AuditTrailProd'
set @dbNameNewText = 'ReferralProdReport..'
set @vwName = 'vwAuditTrail'
*/

if(@@SERVERNAME = 'st-devsql-2')
begin
      /* StatTrac DataWarehouse Test 
            do not forget to point the sysobjects to ReferralDev1
            */
      set @dbNameStringToReplace = '_ReferralProd_DataWarehouse'
      set @dbNameNewText = 'ReferralTest..'
      set @vwName = 'vwDataWarehouse'
end
else
begin

      /* StatTrac DataWarehouse Production */
      set @dbNameStringToReplace = '_ReferralProd_DataWarehouse'
      set @dbNameNewText = '_ReferralProdReport..'
      set @vwName = 'vwDataWarehouse'

end
/* StatTrac Test 
set @dbNameStringToReplace = 'AuditTrail'
set @dbNameNewText = '1..'
set @vwName = 'vwAuditTrail'
*/


--- test string 
select replace(db_name(), @dbNameStringToReplace, @dbNameNewText)

if(@@SERVERNAME = 'st-devsql-2')
begin 
      
      INSERT @tables 
      select name, '' from ReferralTest2..sysobjects 
      where 
      /* StatTrac Test */
      xtype = 'U' and name not like 'ms%' and name not like 'dt%' 
      order by 1
end
else
begin
      
      INSERT @tables 
      select name, '' from _ReferralProdReport..sysobjects 
      where 
      /* StatTrac Test */
      xtype = 'U' and name not like 'ms%' and name not like 'dt%' 
      order by 1

end
/* DT TEst
name in (
'ConfigurableListElement '
,'LookupListElement'
,'Users'
,'Contacts'
,'Organizations'
,'LleAnswerChoices'
,'LleAppearance'
,'LleBasicHygiene'
,'LleBasicProfile'
,'LleBodyDiagramIdentificationCategories'
,'LleCaseChecklistStatus'
,'LleColor'
,'LleDonorType'
,'LleFamilyConsentedToDonation'
,'LleFamilyInterestedInDonation'
,'LleGender'
,'LleGenderApplication'
,'LleHcg'
,'LleInterviewPertainsTo'
,'LleIntraOperativeOrgan'
,'LleOrganArea'
,'LlePhoneType'
,'LlePositiveNegative'
,'LleProtein'
,'LleSkinRecoveryMethod'
,'LleSkinThickness'
,'LleTypeOfInterview'
,'LleYesNo'
,'LleYesNoNa'
,'LleYesNoUnknown'
,'AppResource'
,'organization'
,'contact'
,'lookuplistlement'
)
*/


SELECT @loopCount = MIN(ID), @loopMax = MAX(ID) FROM @tables

WHILE (@loopCount <= @loopMax)
BEGIN

      SELECT 
            @tableName = tableName,
            @blank = blank
      FROM 
            @tables
      WHERE
            ID = @loopCount
print @vwName + @tableName
      select @dropSql = ' if exists(select * from sysobjects where name = ''' + @vwName + @tableName + ''')
      BEGIN
            DROP VIEW [' + @vwName + @tableName + ']
      END
      '
      SELECT @testSQL = '
      if exists(select * from ' +replace(db_name(), @dbNameStringToReplace, @dbNameNewText)+ 'sysobjects where name = ''' + @tableName +''' )
      BEGIN
            SET @testResult = 1
      END
      ELSE
      BEGIN
            SET @testResult = 0
      END'
      
      SET @sql = '
      CREATE VIEW [' + @vwName + @tableName + ']
      
      AS
      /******************************************************************************
      **          File: 
      **          Name: ' + @vwName +  @tableName + '
      **          Desc: view used to query data from Replicated Reporting DB
      **
      **              
      **          Return values: Table ' + @tableName + '
      ** 
      **          Called by:   AuditTrail Reports
      **              
      **
      **          Auth: Bret Knoll
      **          Date: ' + convert(varchar, getDate()) + '
      *******************************************************************************
      **          Change History
      *******************************************************************************
      **          Date:       Author:                       Description:
      **          --------    --------                -------------------------------------------
      **          10/15/2008  Bret Knoll              Create View
      **          10/28/2010  bret j knoll            fix to use new server/db names
      *******************************************************************************/    
      select * from ' + replace(db_name(), @dbNameStringToReplace, @dbNameNewText) + '[' + @tableName + ']
      '
      
      SET @testResult = 0
      EXEC sp_executesql @dropSql
      EXEC sp_executesql @testSQL, N'@testResult INT OUTPUT', @testResult= @testResult OUTPUT
--print @testResult 
      if (@testResult = 1)
      BEGIN
            EXEC sp_executesql @sql
      END 
      --if(@@error > 0)
      --begin
--          PRINT @DROPSQL
--          PRINT @testSQL
--          PRINT @sql
      --end

      SET @loopCount = @loopCount + 1
END

select 'select * from ' + name,  * from sysobjects where name like @vwName + '%'
