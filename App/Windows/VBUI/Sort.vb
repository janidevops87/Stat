Option Strict Off
Option Explicit On
Option Compare Binary
Module modSort
	
	Public Const ZERO As Short = 0
	Public Const ASCENDING_ORDER As Short = 0
	Public Const DESCENDING_ORDER As Short = 1
	
    Dim gIterations As New Object

    Sub BubbleSort(ByRef pvArray() As Object, ByVal nOrder As Short)
        Dim Index As New Object
        Dim TEMP As New Object
        Dim NextElement As New Object

        NextElement = ZERO
        Do While (NextElement < UBound(pvArray))
            Index = UBound(pvArray)
            Do While (Index > NextElement)
                If nOrder = ASCENDING_ORDER Then
                    If pvArray(Index) < pvArray(Index - 1) Then
                        TEMP = pvArray(Index)
                        pvArray(Index) = pvArray(Index - 1)
                        pvArray(Index - 1) = TEMP
                    End If
                ElseIf nOrder = DESCENDING_ORDER Then
                    If pvArray(Index) >= pvArray(Index - 1) Then
                        TEMP = New Object() {Index}
                        pvArray(Index) = pvArray(Index - 1)
                        pvArray(Index - 1) = TEMP
                    End If
                End If
                Index = Index - 1
                gIterations = gIterations + 1
            Loop
            NextElement = NextElement + 1
            gIterations = gIterations + 1
        Loop

    End Sub

    Sub Bucket(ByRef pvArray() As Object, ByVal nOrder As Short)
        Dim Index As New Object
        Dim NextElement As New Object
        Dim TheBucket As New Object

        NextElement = LBound(pvArray) + 1
        While (NextElement <= UBound(pvArray))
            TheBucket = New Object() {NextElement}
            Index = NextElement
            Do
                If Index > LBound(pvArray) Then
                    If nOrder = ASCENDING_ORDER Then
                        If TheBucket < pvArray(Index - 1) Then
                            pvArray(Index) = pvArray(Index - 1)
                            Index = Index - 1
                        Else
                            Exit Do
                        End If
                    ElseIf nOrder = DESCENDING_ORDER Then
                        If TheBucket >= pvArray(Index - 1) Then
                            pvArray(Index) = pvArray(Index - 1)
                            Index = Index - 1
                        Else
                            Exit Do
                        End If
                    End If
                Else
                    Exit Do
                End If
                gIterations = gIterations + 1
            Loop
            pvArray(Index) = TheBucket
            NextElement = NextElement + 1
            gIterations = gIterations + 1
        End While

    End Sub

    Sub Heap(ByRef pvArray() As Object)
        Dim Index As New Object
        Dim Size As New Object
        Dim TEMP As New Object

        Size = UBound(pvArray)

        Index = 1
        While (Index <= Size)
            Call HeapSiftup(pvArray, Index)
            Index = Index + 1
            gIterations = gIterations + 1
        End While

        Index = Size
        While (Index > 0)
            TEMP = pvArray(0)
            pvArray(0) = pvArray(Index)
            pvArray(Index) = TEMP
            Call HeapSiftdown(pvArray, Index - 1)
            Index = Index - 1
            gIterations = gIterations + 1
        End While

    End Sub


    Sub HeapSiftdown(ByRef pvArray() As Object, ByRef m As Object)
        Dim Index As New Object
        Dim Parent As New Object
        Dim TEMP As New Object

        Index = 0
        Parent = 2 * Index

        Do While (Parent <= m)

            If (Parent < m And pvArray(Parent) < pvArray(Parent + 1)) Then
                Parent = Parent + 1
            End If

            If pvArray(Index) >= pvArray(Parent) Then
                Exit Do
            End If

            TEMP = pvArray(Index)
            pvArray(Index) = pvArray(Parent)
            pvArray(Parent) = TEMP

            Index = Parent
            Parent = 2 * Index

            gIterations = gIterations + 1
        Loop
    End Sub

    Sub HeapSiftup(ByRef pvArray() As Object, ByRef m As Object)
        Dim Index As New Object
        Dim Parent As New Object
        Dim TEMP As New Object

        Index = m
        Do While (Index > 0)
            Parent = Int(Index / 2)

            If pvArray(Parent) >= pvArray(Index) Then
                Exit Do
            End If

            TEMP = pvArray(Index)
            pvArray(Index) = pvArray(Parent)
            pvArray(Parent) = TEMP

            Index = Parent
            gIterations = gIterations + 1
        Loop

    End Sub

    Sub Insertion(ByRef pvArray() As Object, ByVal nOrder As Short)
        Dim Index As New Object
        Dim TEMP As New Object
        Dim NextElement As New Object

        NextElement = LBound(pvArray) + 1
        While (NextElement <= UBound(pvArray))
            Index = NextElement
            Do
                If Index > LBound(pvArray) Then
                    If nOrder = ASCENDING_ORDER Then
                        If pvArray(Index) < pvArray(Index - 1) Then
                            TEMP = pvArray(Index)
                            pvArray(Index) = pvArray(Index - 1)
                            pvArray(Index - 1) = TEMP
                            Index = Index - 1
                        Else
                            Exit Do
                        End If
                    ElseIf nOrder = DESCENDING_ORDER Then
                        If pvArray(Index) >= pvArray(Index - 1) Then
                            TEMP = pvArray(Index)
                            pvArray(Index) = pvArray(Index - 1)
                            pvArray(Index - 1) = TEMP
                            Index = Index - 1
                        Else
                            Exit Do
                        End If
                    End If
                Else
                    Exit Do
                End If
                gIterations = gIterations + 1
            Loop
            NextElement = NextElement + 1
            gIterations = gIterations + 1
        End While

    End Sub

    Sub QuickSort(ByRef pvArray() As Object, ByRef l As Object, ByRef R As Object)
        Dim x, I, j, y As Object

        I = l
        j = R
        x = pvArray((l + R) / 2)

        While (I <= j)
            While (pvArray(I) < x And I < R)
                I = I + 1
            End While
            While (x < pvArray(j) And j > l)
                j = j - 1
            End While
            If (I <= j) Then
                y = pvArray(I)
                pvArray(I) = pvArray(j)
                pvArray(j) = y
                I = I + 1
                j = j - 1
            End If
            gIterations = gIterations + 1
        End While

        If (l < j) Then Call QuickSort(pvArray, l, j)
        If (I < R) Then Call QuickSort(pvArray, I, R)

    End Sub

    Sub Selection(ByRef pvArray() As Object, ByVal nOrder As Short)
        Dim Index As New Object
        Dim Min As New Object
        Dim NextElement As New Object
        Dim TEMP As New Object

        NextElement = 0
        While (NextElement < UBound(pvArray))
            Min = UBound(pvArray)
            Index = Min - 1
            While (Index >= NextElement)
                If nOrder = ASCENDING_ORDER Then
                    If pvArray(Index) < pvArray(Min) Then
                        Min = Index
                    End If
                ElseIf nOrder = DESCENDING_ORDER Then
                    If pvArray(Index) >= pvArray(Min) Then
                        Min = Index
                    End If
                End If
                Index = Index - 1
                gIterations = gIterations + 1
            End While
            TEMP = pvArray(Min)
            pvArray(Min) = pvArray(NextElement)
            pvArray(NextElement) = TEMP
            NextElement = NextElement + 1
            gIterations = gIterations - 1
        End While

    End Sub

    Sub ShellSort(ByRef pvArray As Object, ByVal pvCol As Short, ByVal pvOrder As Short)

        Dim Distance As New Object
        Dim Size As New Object
        Dim Index As New Object
        Dim NextElement As New Object
        Dim TEMP As New Object

        On Error GoTo handleError

        Size = UBound(pvArray, 1) - LBound(pvArray, 1) + 1
        Distance = 1

        While (Distance <= Size)
            Distance = 2 * Distance
        End While

        Distance = (Distance / 2) - 1

        While (Distance > 0)

            NextElement = LBound(pvArray, 1) + Distance

            While (NextElement <= UBound(pvArray, 1))
                Index = NextElement
                Do
                    If Index >= (LBound(pvArray, 1) + Distance) Then
                        If pvOrder = ASCENDING_ORDER Then
                            If pvArray(Index, pvCol) < pvArray(Index - Distance, pvCol) Then

                                Call modArray.Copy21(pvArray, TEMP, Index)
                                Call modArray.Copy11(pvArray, pvArray, Index - Distance, Index)
                                Call modArray.Copy12(TEMP, pvArray, Index - Distance)

                                Index = Index - Distance
                                gIterations = gIterations + 1

                            Else
                                Exit Do
                            End If
                        ElseIf pvOrder = DESCENDING_ORDER Then
                            If pvArray(Index, pvCol) >= pvArray(Index - Distance, pvCol) Then

                                Call modArray.Copy21(pvArray, TEMP, Index)
                                Call modArray.Copy11(pvArray, pvArray, Index - Distance, Index)
                                Call modArray.Copy12(TEMP, pvArray, Index - Distance)

                                Index = Index - Distance
                                gIterations = gIterations + 1
                            Else
                                Exit Do
                            End If
                        End If
                    Else
                        Exit Do
                    End If
                Loop
                NextElement = NextElement + 1
                gIterations = gIterations + 1
            End While
            Distance = (Distance - 1) / 2
            gIterations = gIterations + 1
        End While

        Exit Sub

handleError:

        Exit Sub

    End Sub
End Module