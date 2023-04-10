SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPI_NewRotation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPI_NewRotation]
GO










CREATE PROCEDURE SPI_NewRotation
	@RotationGroupName as char(255)
	


 AS

Declare
@NumScope  int

Insert into RotationGroupName
	(RotationGroupName)
	Values (@RotationGroupName)

SELECT   @NumScope=SCOPE_IDENTITY()  

Insert into Rotation (RotationID,RotationGroupID,RotationName,RotationSequence,CurrentRotation,RotationRemediate) values (1,@NumScope,'RotationOne',1,-1,0)
Insert into Rotation (RotationID,RotationGroupID,RotationName,RotationSequence,CurrentRotation,RotationRemediate) values (2,@NumScope,'RotationTwo',2,0,-1)



Print Scope_identity()


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

