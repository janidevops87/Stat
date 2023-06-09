SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SecondaryDisposition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'drop procedure spu_SecondaryDisposition'
	drop procedure [dbo].[spu_SecondaryDisposition]
END
	PRINT 'CREATE procedure spu_SecondaryDisposition'	
GO



CREATE PROCEDURE spu_SecondaryDisposition 
	@CallID                          INT,
    @SubCriteriaID                   INT,
    @SecondaryDispositionAppropriate INT,
    @SecondaryDispositionApproach    INT,
    @SecondaryDispositionConsent     INT,
    @SecondaryDispositionConversion  INT,
    @SecondaryDispositionCRO		 INT,
    @LastStatEmployeeID				 INT 
  AS	--1/10/03 drh
SET NOCOUNT ON

IF ltrim(rtrim(@CallID))= '' OR @CallID = 0 
	SELECT @CallID = NULL
IF ltrim(rtrim(@SubCriteriaID)) = '' OR @SubCriteriaID = 0 
	SELECT @SubCriteriaID = NULL
IF ltrim(rtrim(@SecondaryDispositionAppropriate)) = '' OR @SecondaryDispositionAppropriate = 0 
	SELECT @SecondaryDispositionAppropriate = NULL
IF ltrim(rtrim(@SecondaryDispositionApproach))    = '' OR @SecondaryDispositionApproach    = 0 
	SELECT @SecondaryDispositionApproach    = NULL
IF ltrim(rtrim(@SecondaryDispositionConsent))     = '' OR @SecondaryDispositionConsent     = 0 
	SELECT @SecondaryDispositionConsent     = NULL
IF ltrim(rtrim(@SecondaryDispositionConversion))  = '' OR @SecondaryDispositionConversion  = 0 
	SELECT @SecondaryDispositionConversion  = NULL
IF ltrim(rtrim(@SecondaryDispositionCRO))  = '' OR @SecondaryDispositionCRO  = 0 
	SELECT @SecondaryDispositionCRO  = NULL	--1/10/03 drh

IF NOT (ISNULL(@CallID,0)=0 OR ISNULL(@SubCriteriaID,0)=0)
  BEGIN
    IF (ISNULL(@SecondaryDispositionAppropriate,0)=0 AND ISNULL(@SecondaryDispositionApproach,0)=0 AND ISNULL(@SecondaryDispositionConsent,0)=0 AND ISNULL(@SecondaryDispositionConversion,0)=0)
      BEGIN
        DELETE
        FROM SecondaryDisposition
        WHERE CallID      = @CallID
        AND SubCriteriaID = @SubCriteriaID
        PRINT 'DELETED ' + CONVERT(VARCHAR, @CallID) + ' | ' + CONVERT(VARCHAR, @SubCriteriaID)
      END
    ELSE
      BEGIN
        IF EXISTS (SELECT SecondaryDispositionID
                   FROM SecondaryDisposition
                   WHERE CallID      = @CallID
                   AND SubCriteriaID = @SubCriteriaID) 
          BEGIN
            EXEC UpdateSecondaryDisposition
				@SecondaryDispositionAppropriate = @SecondaryDispositionAppropriate,
                @SecondaryDispositionApproach    = @SecondaryDispositionApproach,
                @SecondaryDispositionConsent     = @SecondaryDispositionConsent,
                @SecondaryDispositionConversion  = @SecondaryDispositionConversion,
				@SecondaryDispositionCRO		 = @SecondaryDispositionCRO,	--1/10/03 drh
				@LastStatEmployeeID				 = @LastStatEmployeeID,
				@CallID							 = @CallID,
				@SubCriteriaID					 = @SubCriteriaID;
            PRINT 'UPDATED ' + CONVERT(VARCHAR, @CallID) + ' | ' + CONVERT(VARCHAR, @SubCriteriaID)
          END
        ELSE
          BEGIN
            EXEC InsertSecondaryDisposition
				@CallID = @CallID,  
				@SubCriteriaID = @SubCriteriaID,  
				@SecondaryDispositionAppropriate = @SecondaryDispositionAppropriate,  
				@SecondaryDispositionApproach = @SecondaryDispositionApproach,  
				@SecondaryDispositionConsent = @SecondaryDispositionConsent,  
				@SecondaryDispositionConversion = @SecondaryDispositionConversion, 
				@SecondaryDispositionCRO = @SecondaryDispositionCRO, 	--1/10/03 drh - Added SecondaryDispositionCRO field
				@LastStatEmployeeID				 = @LastStatEmployeeID;
            PRINT 'INSERTED ' + CONVERT(VARCHAR, @CallID) + ' | ' + CONVERT(VARCHAR, @SubCriteriaID)
          END
      END
  END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

