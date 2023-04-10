Option Strict Off
Option Explicit On
Module modArray

    Private Sub PCopy1(ByRef pA As Object, ByRef pB As Object)

        Dim vA1 As Integer
        Dim I As Integer

        vA1 = UBound(pA, 1)

        ReDim pB(vA1)
        For I = 0 To vA1
            pB(I) = pA(I)
        Next I

    End Sub

    Public Sub Copy12(ByRef pA As Object, ByRef pB As Object, ByRef pvRow As Object)

        ' pA is a One-D array, we want to Copy it's values into the specified
        ' row of the 2-D array pB
        ' ASSUME: number of cols matches between A and B

        Dim vA1 As Integer
        Dim I As Integer

        vA1 = UBound(pA, 1)

        '    ReDim pB(vA1)
        For I = 0 To vA1
            pB(pvRow, I) = pA(I)
        Next I

    End Sub

    Public Sub Copy11(ByRef pA As Object, ByRef pB As Object, ByRef pvARow As Object, ByRef pvBRow As Object)

        ' pA is a 2-D array, we want to Copy it's values into the specified
        ' row of the 2-D array pB
        ' ASSUME: number of cols matches between A and B

        Dim vA1 As Integer
        Dim I As Integer

        vA1 = UBound(pA, 2)

        '    ReDim pB(vA1)
        For I = 0 To vA1
            pB(pvBRow, I) = pA(pvARow, I)
        Next I

    End Sub
    Public Sub Copy21(ByRef pA As Object, ByRef pB As Object, ByRef pvRow As Object)

        ' pA is 2-D array, we want to Copy values from the specifed row into
        ' the 1-D array pB
        ' ASSUME: number of cols matches between A and B

        Dim vA1 As Integer
        Dim I As Integer

        vA1 = UBound(pA, 2)

        ReDim pB(vA1)
        For I = 0 To vA1
            pB(I) = pA(pvRow, I)
        Next I

    End Sub

    Private Sub PCopy2(ByRef pA As Object, ByRef pB As Object)

        Dim vA1, vA2 As Integer
        Dim I, j As Integer

        vA1 = UBound(pA, 1)
        vA2 = UBound(pA, 2)

        ReDim pB(vA1, vA2)
        For I = 0 To vA1
            For j = 0 To vA2
                pB(I, j) = pA(I, j)
            Next j
        Next I

    End Sub

    Public Function Flip2(ByRef pA As Object, ByRef pB As Object) As Boolean

        On Error GoTo localError

        Dim vA1, vA2 As Integer


        vA1 = UBound(pA, 1)
        vA2 = UBound(pA, 2)


        ReDim pB(vA2, vA1)

        For j As Integer = 0 To vA1
            For I As Integer = 0 To vA2
                pB(I, j) = modConv.NullToText(pA(j, I))
                'MsgBox pB(i, j) & " " & i & " " & j
            Next I
        Next j


        'bret 10/07/10 tried to use a copy to replace the flip
        'Array.Copy(pA, pB, pA.length)
        Flip2 = True



        Exit Function

localError:

        Flip2 = False
        LogExceptionWithPrefix(Reflection.MethodBase.GetCurrentMethod(), Err())

    End Function

    Private Sub PJoinRow1(ByRef pA As Object, ByRef pB As Object, ByRef pC As Object)

        Dim vA1, vB1 As Integer
        Dim I, j As Integer

        vA1 = UBound(pA, 1)
        vB1 = UBound(pB, 1)

        ReDim pC(vA1 + vB1 + 1)
        For I = 0 To vA1
            pC(I) = pA(I)
        Next I
        For j = 0 To vB1
            pC(I) = pB(j)
            I = I + 1
        Next j

    End Sub

    Private Sub PJoinRow2(ByRef pA As Object, ByRef pB As Object, ByRef pC As Object)

        Dim vA2, vA1, vB1, vB2 As Integer
        Dim j, I, k As Integer

        vA1 = UBound(pA, 1)
        vB1 = UBound(pB, 1)
        vA2 = UBound(pA, 2)
        vB2 = UBound(pB, 2)

        k = 0

        If vA2 = vB2 Then
            ReDim pC(vA1 + vB1 + 1, vA2)

            For I = 0 To vA1
                For j = 0 To UBound(pC, 2)
                    pC(k, j) = pA(I, j)
                Next j
                k = k + 1
            Next I

            For I = 0 To vB1
                For j = 0 To UBound(pC, 2)
                    pC(k, j) = pB(I, j)
                Next j
                k = k + 1
            Next I
        End If

    End Sub



    Public Sub Copy(ByRef pA As Object, ByRef pC As Object)

        Dim vDimA As Integer

        vDimA = GetDimStr(pA)

        If vDimA = 1 Then
            Call PCopy1(pA, pC)
        End If
        If vDimA = 2 Then
            Call PCopy2(pA, pC)
        End If

    End Sub





    Public Function GetDimStr(ByRef pA As Object) As Integer

        Dim I, vTemp As Integer

        On Error GoTo GetDimStrEH

        I = 0
        Do While True 'exit on LBound() error
            I = I + 1
            vTemp = LBound(pA, I)
        Loop

GetDimStrEH:

        GetDimStr = I - 1
        Exit Function

    End Function


    Public Sub JoinRow(ByRef pA As Object, ByRef pB As Object, ByRef pC As Object)

        Dim vDimA, vDimB As Integer

        vDimA = GetDimStr(pA)
        vDimB = GetDimStr(pB)

        If Not TypeOf pB Is Array And TypeOf pA Is Array Then ' IsNothing(pB) And Not IsNothing(pA)
            pC = pA
        ElseIf TypeOf pB Is Array And Not TypeOf pA Is Array Then
            pC = pB
        End If

        If vDimA = 1 And vDimB = 1 Then
            Call PJoinRow1(pA, pB, pC)
        End If

        If vDimA = 2 And vDimB = 1 Then
            'Do Nothing
        End If

        If vDimA = 1 And vDimB = 2 Then
            'Do Nothing
        End If

        If vDimA = 2 And vDimB = 2 Then
            Call PJoinRow2(pA, pB, pC)
        End If

    End Sub
End Module