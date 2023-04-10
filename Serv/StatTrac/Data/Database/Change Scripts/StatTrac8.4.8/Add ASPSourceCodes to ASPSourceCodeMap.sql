 PRINT 'ADD CLEV OHCL SOURCE CODE MAP'
 declare @sourceCodeID1 int,
		@sourceCodeID2 int,
		@sourceCodeName1 varchar(100),
		@sourceCodeName2 varchar(100)
set @sourceCodeName1 = 'clev'
set @sourceCodeName2 = 'ohcl'

select @sourceCodeID1 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName1
select @sourceCodeID2 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName2

if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID1)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID1, @sourceCodeID2)
end  
if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID2)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID2, @sourceCodeID1)

end  

GO
PRINT 'ADD LOOPASP LOOP SOURCE CODE MAP'
declare @sourceCodeID1 int,
		@sourceCodeID2 int,
		@sourceCodeName1 varchar(100),
		@sourceCodeName2 varchar(100)
set @sourceCodeName1 = 'LOOPASP'
set @sourceCodeName2 = 'LOOP'

select @sourceCodeID1 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName1
select @sourceCodeID2 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName2

if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID1)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID1, @sourceCodeID2)
end  
if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID2)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID2, @sourceCodeID1)

end  

GO
PRINT 'ADD TXLG LGASP SOURCE CODE MAP'
declare @sourceCodeID1 int,
		@sourceCodeID2 int,
		@sourceCodeName1 varchar(100),
		@sourceCodeName2 varchar(100)
set @sourceCodeName1 = 'TXLG'
set @sourceCodeName2 = 'LGASP'

select @sourceCodeID1 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName1
select @sourceCodeID2 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName2

if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID1)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID1, @sourceCodeID2)
end  
if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID2)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID2, @sourceCodeID1)

end  
GO
PRINT 'ADD GOLM MIGL SOURCE CODE MAP'
declare @sourceCodeID1 int,
		@sourceCodeID2 int,
		@sourceCodeName1 varchar(100),
		@sourceCodeName2 varchar(100)
set @sourceCodeName1 = 'GOLM'
set @sourceCodeName2 = 'MIGL'

select @sourceCodeID1 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName1
select @sourceCodeID2 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName2

if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID1)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID1, @sourceCodeID2)
end  
if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID2)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID2, @sourceCodeID1)

end  
GO
PRINT 'ADD CTS OHDA SOURCE CODE MAP'
declare @sourceCodeID1 int,
		@sourceCodeID2 int,
		@sourceCodeName1 varchar(100),
		@sourceCodeName2 varchar(100)
set @sourceCodeName1 = 'CTS'
set @sourceCodeName2 = 'OHDA'

select @sourceCodeID1 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName1
select @sourceCodeID2 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName2

if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID1)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID1, @sourceCodeID2)
end  
if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID2)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID2, @sourceCodeID1)

end  

GO
PRINT 'ADD INR INOP SOURCE CODE MAP'
declare @sourceCodeID1 int,
		@sourceCodeID2 int,
		@sourceCodeName1 varchar(100),
		@sourceCodeName2 varchar(100)
set @sourceCodeName1 = 'INR'
set @sourceCodeName2 = 'INOP'

select @sourceCodeID1 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName1
select @sourceCodeID2 = sourcecodeid from sourceCode where SourceCodeType = 1 and SourceCodeName = @sourceCodeName2

if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID1)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID1, @sourceCodeID2)
end  
if not exists(select * from aspSourceCodeMap where SourceCodeID = @sourceCodeID2)
begin
	INSERT aspSourceCodeMap
	VALUES (@sourceCodeID2, @sourceCodeID1)

end  