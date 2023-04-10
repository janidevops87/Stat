
<% 
	'LANGUAGE="VBScript" 
	'VBS ScriptName:	TimeZoneProcess
	'Created:			3/29/00
	'Author:			Bret Knoll
	'Purpose			TimeZoneProces provides a single source 
	'					for functions providing time zone names and
	'					number of hours to add to the Mountain Time Zone
	'					to provide appropriate times to customers on Statline's
	'					reporting site.
	'Functions:			ZoneName, ZoneDifference
	'Background:		TimeZoneProcess.vbs was created when it was determined
	'					Statline's  current reporting site does not consider regions 
	'					that do not recognize Daylight savings. With this change several 
	'					Time Zone identifiers were added:
	'					AT (Atlanta Time)				AS (Standard)
	'					ET (Eastern Time)				ES (Standard)
	'					CT (Central Time)				CS (Standard)
	'					MT (Mountain Time)				MS (Standard)
	'					PT (Pacific Time)				PS (Standard)
	'					KT (Alaskak-Klondike Time )		KS (Standard)
	'					HT (Hawaii Time)				HS (Standard)
	'					The functions account for Daylight savings by returning
	'					a differenc integer if Daylight savings is active or not
	'					Daylight savings is active if the date is between the first
	'					Sunday in April or the last Sunday in October. Only
	'					Standard time zones that do not recognize daylight savings
	'					will check to determine if daylight savings is active

	Function ZoneName(TimeZone)  'returns Time Zone Name
		
		Select Case TimeZone
			
			Case "AT", "AS"
				ZoneName = "Atlantic Time"
			Case "ET", "ES"
				ZoneName = "Eastern Time"
			Case "CT", "CS"
				ZoneName = "Central Time"
			Case "MT", "MS"
				ZoneName = "Mountain Time"
			Case "PT", "PS"
				ZoneName = "Pacific Time"
			Case "KT", "KS"
				ZoneName = "Alaska Time"							
			Case "HT", "HS"	
				ZoneName = "Hawaii Time"
			Case "ST", "SS"	
				ZoneName = "Samoa Time"
			Case Else
				ZoneName = "Mountain Time"	
			
		End Select			
	
	End Function
	
	Function ZoneDifference(pvDateTime, TimeZone)	'returns Time Zone integer, representing 
													'the number of time zone away from the Mountain Time
		Select Case TimeZone
    
		    Case "AT"
		        ZoneDifference = 3
		    Case "AS"
				If DayLightSavings(pvDateTime) Then
					ZoneDifference = 2
				Else	
					ZoneDifference = 3
				End If    
    
		    Case "ET"
		        ZoneDifference = 2
		    Case "ES"
				If DayLightSavings(pvDateTime) Then
					ZoneDifference = 1
				Else	
					ZoneDifference = 2
				End If
		        
		    Case "CT"
		        ZoneDifference = 1
		    Case "CS"
				If DayLightSavings(pvDateTime) Then
					ZoneDifference = 0
				Else	
					ZoneDifference = 1
				End If
				    
		    Case "MT"
		        ZoneDifference = 0
		        
		    Case "MS"     
		    	If DayLightSavings(pvDateTime) Then
					ZoneDifference = -1
				Else	
					ZoneDifference = 0
				End If

		    Case "PT"
		        ZoneDifference = -1
		    Case "PS"     
		    	If DayLightSavings(pvDateTime) Then
					ZoneDifference = -2
				Else	
					ZoneDifference = -1
				End If

		    Case "KT"
		        ZoneDifference = -2
		    Case "KS"     
		    	If DayLightSavings(pvDateTime) Then
					ZoneDifference = -3
				Else	
					ZoneDifference = -2
				End If
		    Case "HT"
		        ZoneDifference = -3
		    Case "HS"     
		    	If DayLightSavings(pvDateTime) Then
					ZoneDifference = -4
				Else	
					ZoneDifference = -3
				End If
		   
		    Case "ST"
		        ZoneDifference = -4
		    Case "SS"     
		    	If DayLightSavings(pvDateTime) Then
					ZoneDifference = -5
				Else	
					ZoneDifference = -4
				End If

		End Select
	
	End Function 
	
	
Function AdjustTimeZone(pvDateTime, TimeZone)

    Select Case TimeZone
    
        Case "AT"
            AdjustTimeZone = DateAdd("h", 3, pvDateTime)
        Case "AS"
			If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", 2, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 3, pvDateTime)
			End If    
    
        Case "ET"
            AdjustTimeZone = DateAdd("h", 2, pvDateTime)
        Case "ES"
			If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", 1, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 2, pvDateTime)
			End If
            
        Case "CT"
            AdjustTimeZone = DateAdd("h", 1, pvDateTime)
        Case "CS"
			If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", 0, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 1, pvDateTime)
			End If
			    
        Case "MT"
            AdjustTimeZone = DateAdd("h", 0, pvDateTime)
            
        Case "MS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -1, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", 0, pvDateTime)
			End If

        Case "PT"
            AdjustTimeZone = DateAdd("h", -1, pvDateTime)
        Case "PS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -2, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -1, pvDateTime)
			End If

        Case "KT"
            AdjustTimeZone = DateAdd("h", -2, pvDateTime)
        Case "KS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -3, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -2, pvDateTime)
			End If
        Case "HT"
            AdjustTimeZone = DateAdd("h", -3, pvDateTime)
        Case "HS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -4, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -3, pvDateTime)
			End If
       
        Case "ST"
            AdjustTimeZone = DateAdd("h", -4, pvDateTime)
        Case "SS"     
        	If DayLightSavings(pvDateTime) Then
				AdjustTimeZone = DateAdd("h", -5, pvDateTime)
			Else	
				AdjustTimeZone = DateAdd("h", -4, pvDateTime)
			End If

    End Select

End Function


Function DaylightSavings(LocalDate)
	If CDate(LocalDate) >= GetSunday(4,DatePart("yyyy", LocalDate),"First") _
	and CDate(LocalDate) <= GetSunday(10,DatePart("yyyy", LocalDate),"Last") Then
		DayLightSavings = True
		
	Else
		DayLightSavings = False
	End If	
			
End Function

Function GetSunday(Month,Year,FirstLast) ' GetSunday returns the Date of the day requested

	Dim ForLoopCounter
	Dim CurrentDate
		'if FirstLast = First loop through given month and year until reaching first sunday
	If FirstLast = "First" Then
		For ForLoopCounter = 1 to 31
			
			CurrentDate =  Month & "/" & ForLoopcounter & "/" & Year & " 02:00:00"
			
			If  IsDate(CurrentDate) Then	'if CurrentDate is not a date loop 
											'if CurrentDate is date check if it is Sunday.
				If WeekDay(CurrentDate) = 1 Then
					GetSunday = CDate(CurrentDate)
					Exit Function
				End If

			End If
		
		Next
		'if FirstLast = Last loop through given month and year starting with the last day of the month	
	ElseIf FirstLast = "Last" Then
		For ForLoopCounter = 31 to 1 Step -1
			CurrentDate = Month & "/" & ForLoopcounter & "/" & Year & " 02:00:00"
			
			If  IsDate(CurrentDate) Then	'if CurrentDate is not a date loop 
											'if CurrentDate is date check if it is Sunday.
				If WeekDay(CurrentDate) = 1 Then
					GetSunday = CDate(CurrentDate)
					Exit Function
				End If

			End If
		Next
	End If

End Function

%>

