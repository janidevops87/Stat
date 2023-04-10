SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[InsertTBI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping Procedure InsertTBI'
	drop procedure [dbo].[InsertTBI]
End
go


CREATE    PROCEDURE InsertTBI
		@CallID		int		,
		@TBIPrefix	varchar (4)	,
		@TBIDate	varchar (6)	,
		@TBIStatEmployeeID	int		
		
AS

/******************************************************************************
**		File: InsertTBI.sql
**		Name: InsertTBI
**		Desc: This procedure 
**		
**              
**		Return values: 
**		
**		Called by:
**              
**		Parameters:
**		Input							Output
**		----------						-----------
**		@CallID		int		Null,
**		@TBIPrefix	varchar (4) NOT Null,
**		@TBIDate	varchar (6) 	Null,
**		@TBIStatEmployeeID	int		Null
**
**		Auth: Christopher Carroll
**		Date: 05/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------
**		01/06/2010	ccarroll		Change to new format for CA
**									Old format: CL-200801-1
**									New format: CTDN-2010-0001
*******************************************************************************/

/* Rename CA to CTDN 
	Note: ServiceLevel setting TBIPrefix 'CA' will become 'CTDN'
*/

IF @TBIPrefix = 'CA'
BEGIN
	SET @TBIPrefix = 'CTDN'
END

/* TBI Unique Identifier */
DECLARE @TBIUID int
SET @TBIUID =  (SELECT Count (SecondaryTBI.CallID)
		 FROM  SecondaryTBI
		 WHERE SecondaryTBI.SecondaryTBIPrefixDate = (@TBIPrefix + '-' + LEFT(@TBIDate, 4))
		)


If @TBIUID < 1 
BEGIN
	SET @TBIUID = 0
END

	SET @TBIUID = @TBIUID + 1

	INSERT INTO SecondaryTBI
	  (
		CallID,
		SecondaryTBINumber,
		SecondaryTBIIssuedStatEmployeeID,
		SecondaryTBIPrefixDate,
		LastStatEmployeeID,
		CreateDate,
		LastModified,
		AuditLogTypeID
	  )
	VALUES
	  (
		@CallId,
		@TBIPrefix + '-' + LEFT(@TBIDate, 4) + '-' + REPLACE(STR(@TBIUID, 4), ' ', '0'),
		@TBIStatEmployeeID,
		@TBIPrefix + '-' + LEFT(@TBIDate, 4),
		@TBIStatEmployeeID,
		GetDate(),
		GetDate(),
		1
	  )

		SELECT 
				@CallID,
				@TBIPrefix + '-' + LEFT(@TBIDate, 4) + '-' + REPLACE(STR(@TBIUID, 4), ' ', '0'),
				@TBIPrefix
		 
	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/********************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - InsertTBI create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - InsertTBI procedure created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/

