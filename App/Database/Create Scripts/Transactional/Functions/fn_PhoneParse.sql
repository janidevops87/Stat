 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'TF' AND name = 'fn_PhoneParse')
	BEGIN
		PRINT 'Dropping Function fn_PhoneParse'
		DROP Function fn_PhoneParse
	END
GO

PRINT 'Creating Function fn_PhoneParse' 
GO 

CREATE FUNCTION dbo.fn_PhoneParse
(
	@Phone varchar(20) = ''
)  

RETURNS @PhoneTable TABLE
	(
		PhoneAreaCode varchar(3),
		PhonePrefix varchar(3),
		PhoneNumber varchar(4)
	) 		
AS
/******************************************************************************
**	File: fn_PhoneParse.sql
**	Name: fn_PhoneParse
**	Desc: Get all the calls that this employee has access to 
**	Auth: Tanvir Ather
**	Date: 03/02/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		----------------------------------
**	03/02/2009	Tanvir Ather	Initial Function Creation
**	11/12/2010	Bret Knoll		Add to Release
*******************************************************************************/
BEGIN
	SELECT @Phone = REPLACE(@Phone, '(', '')
	SELECT @Phone = REPLACE(@Phone, ')', '')
	SELECT @Phone = REPLACE(@Phone, '-', '')
	SELECT @Phone = REPLACE(@Phone, ' ', '')
	
	IF(LEN(@Phone) = 10)
	BEGIN
		INSERT @PhoneTable
		SELECT
			PhoneAreaCode = SUBSTRING(@Phone, 1, 3),
			PhonePrefix = SUBSTRING(@Phone, 4, 3),
			PhoneNumber = SUBSTRING(@Phone, 7, 4)
	END	
	RETURN
END
GO