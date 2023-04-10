Option Strict Off
Option Explicit On
Imports System.Text.RegularExpressions
Imports Statline.Stattrac.Framework

Module modUtility
    '*****GENERAL UTILITIES*****


    'Variables

    Dim mvWorkLevel As Short
    Dim mvStoreValues() As Object

    Public Function BuildPhone(ByRef pvParams As Object) As Object

        BuildPhone = "(" & pvParams(0, 1) & ") " & pvParams(0, 2) & "-" & pvParams(0, 3)

    End Function

    Public Sub CenterForm(Optional ByRef frmParent As Object = Nothing)

        If Application.OpenForms.Count = 0 Then Exit Sub

        If IsNothing(frmParent) Or Not TypeOf frmParent Is System.Windows.Forms.Form Then
            Application.OpenForms.Item(Application.OpenForms.Count - 1).StartPosition = FormStartPosition.CenterParent

        Else

            Application.OpenForms.Item(Application.OpenForms.Count - 1).StartPosition = FormStartPosition.CenterParent
            ' Added designation for form top.  6/10/2005 - SAP
            Application.OpenForms.Item(Application.OpenForms.Count - 1).Top = (frmParent.Top)

        End If


    End Sub

    Sub Done()

        System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.Default

    End Sub

    Sub Work()

        System.Windows.Forms.Cursor.Current = System.Windows.Forms.Cursors.WaitCursor

    End Sub

    Public Function ChkOpenForm(ByRef pvFormName As String, Optional ByRef NoMessage As Object = Nothing) As Boolean

        Dim Form As System.Windows.Forms.Form

        For Each Form In Application.OpenForms
            If Form.Name = pvFormName Then
                If IsNothing(NoMessage) Then
                    MsgBox("The form you are trying to open is already open.", MsgBoxStyle.Exclamation, "Open Form")
                End If
                ChkOpenForm = True
                Form.Activate()
                Exit Function
            End If
        Next Form

        ChkOpenForm = False

    End Function

    Public Function Increment(ByRef pvValue As Integer) As Object

        On Error Resume Next

        'Return as reference
        pvValue = pvValue + 1

        'Return as function result
        Increment = pvValue

    End Function

    Public Function DaylightSavings(ByRef pvDate As String) As Object
        'Determines if the date provided is in daylight savings or not
        If CDate(pvDate) >= GetSunday(3, DatePart(Microsoft.VisualBasic.DateInterval.Year, CDate(pvDate)), "Second") And CDate(pvDate) <= GetSunday(11, DatePart(Microsoft.VisualBasic.DateInterval.Year, CDate(pvDate)), "First") Then
            DaylightSavings = True

        Else
            DaylightSavings = False
        End If
    End Function
    'added BJK 06/24/01
    Function GetSunday(ByRef Month_Renamed As Object, ByRef Year_Renamed As Object, ByRef FirstLast As Object) As Object ' GetSunday returns the Date of the day requested
        Dim WeekDayCount As New Object
        Dim ForLoopCounter As New Object
        Dim CurrentDate As New Object


        WeekDayCount = 0
        'if FirstLast = First loop through given month and year until reaching first sunday
        If FirstLast = "First" Then
            For ForLoopCounter = 1 To 31

                CurrentDate = Month_Renamed & "/" & ForLoopCounter & "/" & Year_Renamed & " 02:00:00"

                If IsDate(CurrentDate) Then 'if CurrentDate is not a date loop
                    'if CurrentDate is date check if it is Sunday.
                    If WeekDay(CurrentDate) = 1 Then
                        GetSunday = CDate(CurrentDate)
                        Exit Function
                    End If

                End If

            Next
            'if FirstLast = Second loop through given month and year starting with the last day of the month
        ElseIf FirstLast = "Second" Then
            For ForLoopCounter = 1 To 31 Step -1
                CurrentDate = Month_Renamed & "/" & ForLoopCounter & "/" & Year_Renamed & " 02:00:00"

                If IsDate(CurrentDate) Then 'if CurrentDate is not a date loop
                    'if CurrentDate is date check if it is Sunday.
                    If WeekDay(CurrentDate) = 1 Then
                        WeekDayCount = WeekDayCount + 1
                    End If
                    If WeekDay(CurrentDate) = 1 And WeekDayCount = 2 Then
                        GetSunday = CDate(CurrentDate)
                        Exit Function
                    End If

                End If
            Next
            'if FirstLast = Last loop through given month and year starting with the last day of the month
        ElseIf FirstLast = "Last" Then
            For ForLoopCounter = 31 To 1 Step -1
                CurrentDate = Month_Renamed & "/" & ForLoopCounter & "/" & Year_Renamed & " 02:00:00"

                If IsDate(CurrentDate) Then 'if CurrentDate is not a date loop
                    'if CurrentDate is date check if it is Sunday.
                    If WeekDay(CurrentDate) = 1 Then
                        GetSunday = CDate(CurrentDate)
                        Exit Function
                    End If

                End If
            Next
        End If

    End Function

    Public Function IsLoaded(ByRef strFrmName As String) As Boolean

        On Error GoTo Err_IsLoaded

        '  Determines if a form is loaded.

        Dim intX As Short

        IsLoaded = False
        For intX = 0 To Application.OpenForms.Count - 1
            If Application.OpenForms.Item(intX).Name = strFrmName Then
                IsLoaded = True
                Exit Function ' Quit function once form has been found.
            End If
        Next

        Exit Function

Err_IsLoaded:
        modError.LogError("modutility.IsLoaded")
    End Function


    Public Function LessThanADay(ByRef First As String, ByRef Second_Renamed As String) As Boolean
        '************************************************************************************
        'Name: LessThanADay%
        'Date Created: 08/01/06                      Created by: B.K
        'Release: 8.0.01                             Task: None
        'Description: check to see if 2 dates are less than 24 hours old
        'Returns: Return false if the two dates are greater than 24 hours
        'Params: Date String = First, Date String = Second
        'Stored Procedures: None
        '====================================================================================
        On Error Resume Next


        Dim Res As Integer

        Res = DateDiff(Microsoft.VisualBasic.DateInterval.Minute, CDate(Second_Renamed), CDate(First))

        If Res > 1440 Then
            LessThanADay = False
        Else
            LessThanADay = True
        End If

    End Function
    Public Function RemoveInvalidChars(inputString As String) As String
        RemoveInvalidChars = Regex.Replace(inputString, "[^A-Za-z0-9]", "")
    End Function

    Public Function LogExceptionWithPrefix(currentMethod As Reflection.MethodBase, errObj As ErrObject, Optional detailString As String = "")
        Dim exceptionMessage As String

        If (currentMethod IsNot Nothing) Then
            exceptionMessage = currentMethod.ReflectedType.Name & "." & currentMethod.Name
        End If
        If (Not String.IsNullOrWhiteSpace(detailString)) Then
            exceptionMessage &= " - " & detailString
        End If
        If (errObj IsNot Nothing) Then
            If (errObj.Number > 0) Then
                exceptionMessage &= " - Err #" & errObj.Number
            End If
            If (Not String.IsNullOrWhiteSpace(errObj.Description)) Then
                exceptionMessage &= " - Err Description: " & errObj.Description
            End If
        End If

        StatTracLogger.CreateInstance().Write(New Exception(exceptionMessage))
    End Function

    ''' <summary>
    ''' Attempts to convert an input string to a double and compare against a value
    ''' </summary>
    ''' <param name="fromString">Input string to convert to double</param>
    ''' <param name="compareVal">Value to compare against</param>
    ''' <param name="compareOp">Optional. Controls comparison between fromString (post-conversion) and compareVal. Defaults to =</param>
    ''' <returns></returns>
    Public Function DoubleTryParseAndCompare(fromString As String, compareVal As Double, Optional compareOp As CompareOperationEnum = CompareOperationEnum.Equal) As Boolean
        Dim response As Boolean

        Try
            Dim tempDouble As Double

            Select Case compareOp
                Case CompareOperationEnum.Equal
                    response = Double.TryParse(fromString, tempDouble) AndAlso tempDouble = compareVal
                Case CompareOperationEnum.NotEqual
                    response = Double.TryParse(fromString, tempDouble) AndAlso tempDouble <> compareVal
                Case CompareOperationEnum.Greater
                    response = Double.TryParse(fromString, tempDouble) AndAlso tempDouble > compareVal
                Case CompareOperationEnum.GreaterOrEqual
                    response = Double.TryParse(fromString, tempDouble) AndAlso tempDouble >= compareVal
                Case CompareOperationEnum.Less
                    response = Double.TryParse(fromString, tempDouble) AndAlso tempDouble < compareVal
                Case CompareOperationEnum.LessOrEqual
                    response = Double.TryParse(fromString, tempDouble) AndAlso tempDouble <= compareVal
            End Select


        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Return response
    End Function

    ''' <summary>
    ''' Validates a string datetime using the supplied format string(s) or based on the length of the input string
    ''' </summary>
    ''' <param name="fromString">String to validate as datetime</param>
    ''' <param name="formatStrings">Optional. Array of format strings to apply when validating datetime. Only 1 match is required for validation to pass. If this is nothing, the length of fromString will be used to determine the formatting to apply</param>
    ''' <returns></returns>
    Public Function DateTimeTryParseExact(fromString As String, Optional formatStrings() As String = Nothing) As Boolean
        Try
            If (String.IsNullOrWhiteSpace(fromString)) Then
                Return True
            End If

            If (formatStrings Is Nothing) Then
                Select Case fromString.Length
                    Case 8
                        formatStrings = {"MM/dd/yy"}
                    Case 10
                        formatStrings = {"MM/dd/yyyy"}
                    Case Else
                        Throw New ArgumentException("Parameter " & NameOf(fromString) & " is an invalid length (length: " & fromString.Length & "). Valid lengths are 8 and 10. Pass a format string to validate this datetime string")
                End Select
            End If

            Dim tempDate As DateTime
            Return DateTime.TryParseExact(fromString, formatStrings, Globalization.CultureInfo.InvariantCulture, Globalization.DateTimeStyles.None, tempDate)
        Catch ex As Exception
            StatTracLogger.CreateInstance().Write(ex)
        End Try

        Return False
    End Function
End Module

Public Enum CompareOperationEnum
    Equal = 0
    NotEqual = 1
    Greater = 2
    GreaterOrEqual = 3
    Less = 4
    LessOrEqual = 5
End Enum