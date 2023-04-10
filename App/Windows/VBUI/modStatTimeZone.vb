Option Strict Off
Option Explicit On
Module modStatTimeZone
	'02/21/03 bjk added modStatTimeZone to obtain a system time zone.
	
	'**********************************
	'**  Type Definitions:
	
	'bret 01/08/10 this if statment is not longer needed
	'#If Win32 Then
	Private Structure SYSTEMTIME
		Dim wYear As Short
		Dim wMonth As Short
		Dim wDayOfWeek As Short
		Dim wDay As Short
		Dim wHour As Short
		Dim wMinute As Short
		Dim wSecond As Short
		Dim wMilliseconds As Short
	End Structure
	
	Private Structure TIME_ZONE_INFORMATION
		Dim Bias As Integer
		<VBFixedString(64),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=64)> Public StandardName() As Char
		Dim StandardDate As SYSTEMTIME
		Dim StandardBias As Integer
		<VBFixedString(64),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=64)> Public DaylightName() As Char
		Dim DaylightDate As SYSTEMTIME
		Dim DaylightBias As Integer
	End Structure
	
	'**********************************
	'**  Function Declarations:
	
	Public Function GetSystemTimeZone() As Object
        GetSystemTimeZone = ConvertToStatTimeZone(TimeZone.CurrentTimeZone.StandardName)

    End Function
	
	Private Function ConvertToStatTimeZone(ByRef TZName As Object) As Object
		Select Case TZName
			Case "Atlantic Standard Time"
				ConvertToStatTimeZone = "AT"
				
			Case "Eastern Standard Time"
				ConvertToStatTimeZone = "ET"
				
			Case "Central Standard Time"
				ConvertToStatTimeZone = "CT"
				
			Case "Mountain Standard Time"
				ConvertToStatTimeZone = "MT"
				
			Case "US Mountain Standard Time"
				ConvertToStatTimeZone = "MS"
				
			Case "Pacific Standard Time"
				ConvertToStatTimeZone = "PT"
				
			Case "Alaskan Standard Time"
				ConvertToStatTimeZone = "KT"
				
			Case "Hawaiian Standard Time"
				ConvertToStatTimeZone = "HT"
			Case Else
				
		End Select
		
	End Function
End Module