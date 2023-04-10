declare @runDate datetime,
		@endDate datetime,
	@monthID int,
	@yearID int 

set @runDate = '1/1/2007'
set @endDate = dateadd(m, -13, @runDate )

while @runDate > @endDate
begin
	
	select @monthID = datepart(m, @rundate)
	select @yearID = datepart(yyyy, @rundate)
	exec spi_Referral_FSConversionRate @monthID, @yearID
	select @rundate = dateadd(m, -1, @rundate)
end
