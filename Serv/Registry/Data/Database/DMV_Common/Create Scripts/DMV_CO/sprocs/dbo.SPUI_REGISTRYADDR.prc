SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.SPUI_REGISTRYADDR    Script Date: 5/14/2007 10:02:39 AM ******/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPUI_REGISTRYADDR]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPUI_REGISTRYADDR]
GO









CREATE  PROCEDURE SPUI_REGISTRYADDR
	@pvRegistryID	AS INT		=NULL,
	@pvADDRTYPE	AS INT		=NULL,
	@pvADDR		AS VARCHAR(40)	=NULL,
	@pvADDR2	AS VARCHAR(20)	=NULL,
	@pvCITY		AS VARCHAR(25)	=NULL,
	@pvSTATE	AS VARCHAR(2)	=NULL,
	@pvZIP		AS VARCHAR(10)	=NULL,
	@pvUserID	AS INT 		=NULL,
	@AddrResult 	AS VARCHAR(50)  =NULL OUTPUT


AS
/*

	Desigened AND Developed 01/2003

	Legal Information...
	 ©1996-2003 Statline, LLC. All rights reserved. 

	 Statline is a registered trademark of Statline, LLC in the U.S.A. 


	@pvRegistryID
	@pvADDRTYPE
	@pvADDR
	@pvCITY
	@pvSTATE
	@pvZIP
	 
*/
-- turn record counts off
SET NOCOUNT ON

DECLARE @CURRENTADDRID	AS INT
	


-- check for values execute sp if they exist
IF ISNULL(@pvADDR, '') + ISNULL(@pvADDR2, '') + ISNULL(@pvCITY,'') + ISNULL(@pvSTATE, '') + ISNULL(@pvZIP, '') <> ''
BEGIN -- execute sp

	SELECT 	@CURRENTADDRID = ID 
	FROM 	RegistryAddr 
	WHERE 	RegistryID = @pvRegistryID
	AND	AddrTypeID = @pvADDRTYPE
	
	IF @CURRENTADDRID > 0 
	BEGIN	-- update
	
		UPDATE [REGISTRYADDR] 
	
		SET  
			[Addr1]	 	= @pvADDR,
			[Addr2]	 	= @pvADDR2,
			[City]	 	= @pvCITY,
			[State]	 	= @pvSTATE,
			[Zip]	 	= @pvZIP,
			[UserID]	= @pvUserID
	
		WHERE	[ID] 		= @CURRENTADDRID

		-- create the return statment
		IF @@ERROR = 0
		BEGIN
			SELECT @AddrResult = CASE @pvADDRTYPE WHEN 1 THEN 'Residential' WHEN 2 THEN 'Mailing' END + ' address ' + CAST(@CURRENTADDRID AS VARCHAR(10)) + ' was updated'
		END
		ELSE
		BEGIN
			SELECT @AddrResult = 'An error occured while attempting to update ' + CASE @pvADDRTYPE WHEN 1 THEN 'Residential ' WHEN 2 THEN 'Mailing 'END + 'address ' + CAST(@CURRENTADDRID AS VARCHAR(10)) + ''

		END

	END -- update
	ELSE
	BEGIN 	-- insert
		INSERT INTO [REGISTRYADDR] 
			 ( 
			 [RegistryID],
			 [AddrTypeID],
			 [Addr1],			 
			 [Addr2],			 
			 [City],
			 [State],
			 [Zip],
			 [UserID],
			 [CreateDate]
			 ) 

		VALUES 
			( 
			 @pvRegistryID,
			 @pvADDRTYPE,
			 @pvADDR,
			 @pvADDR2,
			 @pvCITY,
			 @pvSTATE,
			 @pvZIP,
			 @pvUserID,
			 GETDATE()			 
			 )
		
		
		IF @@ERROR = 0
		BEGIN
			SELECT @CURRENTADDRID = @@IDENTITY
			SELECT @AddrResult = CASE @pvADDRTYPE WHEN 1 THEN 'Residential ' WHEN 2 THEN 'Mailing 'END + ' address ' + CAST(@CURRENTADDRID AS VARCHAR(10)) + ' was created'
		END
		ELSE
		BEGIN
			SELECT @CURRENTADDRID = @@IDENTITY
			SELECT @AddrResult = 'An error occured while attempting to update ' + CASE @pvADDRTYPE WHEN 1 THEN ' Residential ' WHEN 2 THEN ' Mailing 'END + 'address ' 

		END

	END -- insert
END -- execute sp





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

