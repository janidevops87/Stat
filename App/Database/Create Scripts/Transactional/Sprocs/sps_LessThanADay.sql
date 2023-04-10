SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_LessThanADay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_LessThanADay]
GO



CREATE PROCEDURE sps_LessThanADay 
	@first as datetime,
	@second as datetime



 AS


 

	
	
	 

--set @first = '05/19/06  11:14'
--set @second = '05/19/06  10:21'
select datediff(Minute,@second,@first)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

