SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_QueryOpenMessageParam]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
	PRINT 'Dropping sproc sps_QueryOpenMessageParam'
	drop procedure [dbo].[sps_QueryOpenMessageParam]
	END	

PRINT 'Creating sproc sps_QueryOpenMessageParam'	

GO

CREATE  PROCEDURE sps_QueryOpenMessageParam
		@vStartPeriod	datetime = null,
		@vEndPeriod		datetime = null,
		@vTimeZoneDif	int 	 = null,
		@vTCMessageID	int	 = null,
		@vLeaseOrg		int	 = null,
		@vAnd			varchar(1000)  = null 
AS
/******************************************************************************
**		File: sps_QueryOpenMessageParam.sql
**		Name: sps_QueryOpenMessageParam
**		Desc: Obtains list of LogEvents with a status of pending
**
**              
**		Return values: returns partial logevent records
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@vStartPeriod	datetime = null,
**		@vEndPeriod		datetime = null,
**		@vTimeZoneDif	int 	 = null,
**		@vTCMessageID	int	 = null,
**		@vLeaseOrg		int	 = null,
**		@vAnd			varchar(1000)  = null 
**
**		Auth: Christopher Carroll
**		Date: 12/18/2006
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/18/2006	Christopher Carroll	Notes: If vTCMessageID has a value the WHERE statment 
**										returns message ID of Value provided.
**										If not, ALL message IDs are included.
**		5/25/2007	Bret Knoll			StatTrac v. 8.4 requirement 8.4.3.3.2
**										Added comment block
**										Added set transaction level
**		01/25/2010	ccarroll			removed table prefix from Order By
*******************************************************************************/
	
	
	Declare @vQuery AS varchar(4000)

SET @vQuery = 		'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED '
SET @vQuery = @vQuery + ' SELECT DISTINCT '
SET @vQuery = @vQuery + 'Call.CallID, '
SET @vQuery = @vQuery + 'Call.CallNumber, '
SET @vQuery = @vQuery + 'DATEADD(hh, ' + CAST(@vTimeZoneDif AS varchar) + ', Call.CallDateTime) AS CallDateTime, '
SET @vQuery = @vQuery + 'Person.PersonFirst + RTRIM(' + ''' ''' + '+(ISNULL(Person.PersonMI,' + '''''' + ')))' + '+'' ''' + '+Person.PersonLast, '
SET @vQuery = @vQuery + 'Organization.OrganizationName, '
SET @vQuery = @vQuery + 'MessageType.MessageTypeName, '
SET @vQuery = @vQuery + 'SourceCodeName, '
SET @vQuery = @vQuery + 'CASE WHEN Message.MessageTypeID = 2 THEN ISNULL(MessageImportCenter,'+ '''''' +') + ' + ''' - ''' + ' + ISNULL(MessageImportPatient,' + '''''' +') + ' + ''' - ''' + ' + ISNULL(MessageImportUNOSID,' + '''''' +') '
SET @vQuery = @vQuery + 'ELSE ' 
SET @vQuery = @vQuery + 'ISNULL(MessageCallerOrganization, ' + '''''' + ') +' + ''' - ''' + '+ MessageCallerName '
SET @vQuery = @vQuery + 'END, ' 
SET @vQuery = @vQuery + '''''' + ' AS Spacer, ' 
SET @vQuery = @vQuery + 'PO.OrganizationID ' 
SET @vQuery = @vQuery + 'FROM Call ' 
SET @vQuery = @vQuery + 'JOIN Message ON Call.CallID = Message.CallID '
SET @vQuery = @vQuery + 'LEFT JOIN Person ON Person.PersonID = Message.PersonID ' 
SET @vQuery = @vQuery + 'LEFT JOIN Organization ON Organization.OrganizationID = Message.OrganizationID '
SET @vQuery = @vQuery + 'LEFT JOIN State ON State.StateID = Organization.StateID '
SET @vQuery = @vQuery + 'LEFT JOIN MessageType ON MessageType.MessageTypeID = Message.MessageTypeID ' 
SET @vQuery = @vQuery + 'LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID '
SET @vQuery = @vQuery + 'LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID ' 
SET @vQuery = @vQuery + 'LEFT JOIN Person PO ON PO.PersonID = StatEmployee.PersonID '

-- Include if this is a Lease Org.
IF @vLeaseOrg IS Not Null BEGIN
SET @vQuery = @vQuery + 'LEFT JOIN SourceCodeOrganization ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID ' 
END

SET @vQuery = @vQuery + 'WHERE CallDateTime <= ''' + CAST(@vEndPeriod AS varchar) + ''' ' 
SET @vQuery = @vQuery + 'AND CallDateTime >= ''' + CAST(@vStartPeriod AS varchar) + ''' ' + ISNULL(@vAnd, ' ') + ' '  
SET @vQuery = @vQuery + 'AND CallActive <> 0 '

-- Transplant Centers, 
IF @vTCMessageID = 2 BEGIN
SET @vQuery = @vQuery + 'AND Message.MessageTypeID = ' + CAST(@vTCMessageID AS varchar) + ' '
END

-- Include this is a Lease Organizations
IF @vLeaseOrg IS Not Null BEGIN
SET @vQuery = @vQuery + 'AND SourceCodeOrganization.OrganizationID = ' + CAST(@vLeaseOrg AS varchar)
END

SET @vQuery = @vQuery + ' ORDER BY CallDateTime DESC; '

EXEC(@vQuery)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

