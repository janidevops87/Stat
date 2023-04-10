Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Module modConv
	
	
	
	Function Age(ByRef varBirthDate As Object) As Short
		
		'*************************************************************
		' FUNCTION NAME: Age()
		' PURPOSE:
		'    Calculates age in years from a given date to today's date.
		' INPUT PARAMETERS
		'    StartDate: The beginning date (for example, a birth date).
		' RETURN
		'    Age in years.
		'*************************************************************
		
		On Error Resume Next
		
        Dim varAge As New Object
		
		If IsDbNull(varBirthDate) Then
			Age = 0
			Exit Function
		End If
		
		varAge = DateDiff(Microsoft.VisualBasic.DateInterval.Year, varBirthDate, Now)
		
		If Today < DateSerial(Year(Now), Month(varBirthDate), VB.Day(varBirthDate)) Then
			varAge = varAge - 1
		End If
		
		Age = CShort(varAge)
		
	End Function
	Function AgeMonths(ByVal StartDate As String) As Short
		
		'*************************************************************
		' FUNCTION NAME: AgeMonths()
		' PURPOSE:
		'  Compliments the Age() function by calculating the number of months
		'  that have expired since the last month supplied by the given date.
		'  If the given date is a birthday, the function returns the number of
		'  months since the last birthday.
		' INPUT PARAMETERS:
		'    StartDate: The beginning date (for example, a birthday).
		' RETURN
		'    Months since the last birthday.
		'*************************************************************
		
		On Error Resume Next
		
		Dim tAge As Double
		
		tAge = (DateDiff(Microsoft.VisualBasic.DateInterval.Month, CDate(StartDate), Now))
		
		If (DatePart(Microsoft.VisualBasic.DateInterval.Day, CDate(StartDate)) > DatePart(Microsoft.VisualBasic.DateInterval.Day, Now)) Then
			tAge = tAge - 1
		End If
		
		If tAge < 0 Then
			tAge = tAge + 1
		End If
		
		AgeMonths = CShort(tAge)
		
	End Function
	Function AgeMonthsToYears(ByVal Age As Short) As Double
		'************************************************************************************
		'Name: AgeMonthsToYears
		'Date Created: 10/29/07                         Created by: Bret Knoll
		'Release: 8.4.4                                 Task: Empirix 7015
		'Description: Convert Age from Months to Years
		'Returns: Double of value
		'Params: Age in Months
		'
		'====================================================================================
		
		AgeMonthsToYears = Age / 12
		
	End Function
	Function AgeDaysToYears(ByVal Age As Short) As Double
		'************************************************************************************
		'Name: AgeDaysToYears
		'Date Created: 10/29/07                         Created by: Bret Knoll
		'Release: 8.4.4                                 Task: Empirix 7015
		'Description: Convert Age from Days to Years
		'Returns: Double of value
		'Params: Age in Months
		'
		'====================================================================================
		
		AgeDaysToYears = Age / 365
		
	End Function
	
	Function BoolToInt(ByVal pBool As Boolean, ByVal pTrueInt As Short, ByVal pFalseInt As Short) As Short
		
		If pBool = False Then
			BoolToInt = pFalseInt
		Else
			BoolToInt = pTrueInt
		End If
		
	End Function
	
	Function DblToText(ByVal pDbl As Double) As String
		
		If pDbl = 0 Then
			DblToText = "0"
		Else
			DblToText = LTrim(Str(pDbl))
		End If
		
	End Function

    Function IntToBool(ByVal pInt As Short, ByVal pTrueInt As Short) As Boolean

        If pInt = pTrueInt Then
            IntToBool = True
        Else
            IntToBool = False
        End If

    End Function

    Function IntToText(ByVal pInt As Short) As String

        If pInt = 0 Then
            IntToText = "0"
        Else
            IntToText = CStr(pInt)
        End If

    End Function

    Function TextToDbl(ByVal pText As String) As Double
        Dim doubleValue As Double = 0

        If IsNothing(pText) Then
            Return doubleValue
        End If
        If Not IsNumeric(pText) Then
            Return doubleValue
        End If

        doubleValue = Val(pText)

        Return doubleValue

    End Function

    Function TextToInt(ByVal pText As String) As Short
        Dim shortValue As Short = 0

        If IsDBNull(pText) Then
            Return shortValue
        End If
        If IsNothing(pText) Then
            Return shortValue
        End If
        If (pText.Length < 1) Then
            Return shortValue
        End If
        If pText = Boolean.TrueString Or pText = Boolean.FalseString Then
            shortValue = CShort(CBool(pText))
            Return shortValue
        End If
        If IsNumeric(pText) Then
            Dim isShort As Boolean = Short.TryParse(pText, shortValue)
        End If

        Return shortValue

    End Function

    Function TextToDate(ByVal pText As String) As Date

        On Error GoTo TextToDateEH

        TextToDate = CDate(pText)
        Exit Function

TextToDateEH:

        TextToDate = System.Date.FromOADate(0)
        Exit Function

    End Function

    Function TextToLng(ByVal pText As Object) As Integer

        On Error GoTo TextToLngEH

        TextToLng = CInt(pText)
        Exit Function

TextToLngEH:

        TextToLng = 0
        Exit Function

    End Function


    Public Function NullToText(ByVal pvValue As Object) As String

        Dim textString As String = ""

        If IsDBNull(pvValue) Then
            Return textString
        End If
        textString = pvValue
        Return textString

    End Function

    Public Function NullToZero(ByVal pvValue As Object) As String

        On Error GoTo localError

        If IsDbNull(pvValue) Then
            NullToZero = CStr(0)
        Else
            NullToZero = pvValue
        End If

        Exit Function

localError:

        NullToZero = ""

    End Function

    Public Function ChkValueToDBTrueValue(ByVal pvValue As Short) As Object

        If pvValue = 1 Then
            ChkValueToDBTrueValue = -1
        Else
            ChkValueToDBTrueValue = pvValue
        End If

    End Function

    Public Function DBTrueValueToChkValue(ByVal pvValue As Object) As Object

        On Error Resume Next

        pvValue = modConv.TextToInt(pvValue)

        If pvValue = -1 Then
            DBTrueValueToChkValue = 1
        Else
            DBTrueValueToChkValue = pvValue
        End If

    End Function

    'Add BJK 06/25/01
    Public Function DateToOrganizationDate(ByRef pvTimeZone As String) As String
        'DateToOrganizationDate calculates the current date and time for a given TimeZone and the current time.
        Select Case pvTimeZone
            Case "AT"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 3, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Exit Function
            Case "AS"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 2, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 3, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If

            Case "ET"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 2, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
            Case "ES"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 1, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 2, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If

            Case "CT"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 1, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
            Case "CS"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 0, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 1, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If

            Case "MT"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 0, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))

            Case "MS"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -1, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, 0, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If

            Case "PT"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -1, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
            Case "PS"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -2, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -1, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If

            Case "KT"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -2, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
            Case "KS"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -3, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -2, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If
            Case "HT"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -3, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
            Case "HS"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -4, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -3, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If

            Case "ST"
                DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -4, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
            Case "SS"
                If DaylightSavings(CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))) Then
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -5, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                Else
                    DateToOrganizationDate = CStr(DateAdd(Microsoft.VisualBasic.DateInterval.Hour, -4, System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate)))
                End If
            Case Else
                DateToOrganizationDate = CStr(System.Date.FromOADate(Today.ToOADate + TimeOfDay.ToOADate))
        End Select


    End Function

    Function StripCharacters(ByRef strTarget As String) As String
        '********************************************************
        'Created: T.T 09/22/04
        'modConv.StripCharacters
        '                           -This Function will take a string and
        '                           Strip the string of all characters that are not letters
        'Parameters:
        'strTarget  - The string to be manipulated.
        'Returns    - The manipulated string stripped of everything but letters
        'Stored proces: N/A
        '********************************************************
        On Error Resume Next
        Const strNumbers As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        Dim N As Short
        Dim strTemp As String = ""

        For N = 1 To Len(strTarget)
            If InStr(1, strNumbers, Mid(strTarget, N, 1)) > 0 Then
                strTemp = strTemp & Mid(strTarget, N, 1)
            End If
        Next N

        StripCharacters = strTemp

    End Function
    Function StripNumbers(ByRef strTarget As String) As String
        '********************************************************
        'Created: T.T 09/22/04
        'modConv.StripNumbers
        '                           -This Function will take a string and
        '                           Strip the string of all characters that are not numbers
        'Parameters:
        'strTarget  - The string to be manipulated.
        'Returns    - The manipulated string stripped of everything but letters
        'Stored proces: N/A
        '********************************************************
        On Error Resume Next
        Const strNumbers As String = "1234567890"
        Dim N As Short
        Dim strTemp As String = ""

        For N = 1 To Len(strTarget)
            If InStr(1, strNumbers, Mid(strTarget, N, 1)) > 0 Then
                strTemp = strTemp & Mid(strTarget, N, 1)
            End If
        Next N

        StripNumbers = strTemp

    End Function
End Module