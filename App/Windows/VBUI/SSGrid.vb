Option Strict Off
Option Explicit On
Module modSSGrid

    Function SelectID(ByRef pcList As AxSSDataWidgets_B.AxSSDBDropDown, ByVal pvID As Object, Optional ByRef pvIDCol As Object = Nothing) As Object

        Dim I As Short

        On Error GoTo handleError

        If IsNothing(pvIDCol) Then
            pvIDCol = 0
        End If

        For I = 0 To pcList.Rows
            If pcList.Columns(pvIDCol).CellText(I) = CStr(pvID) Then
                pcList.Bookmark = I
                Exit Function
            End If
        Next I

        SelectID = True

handleError:

        SelectID = False

    End Function
	
    Function SetTextID(ByRef pvList As AxSSDataWidgets_B.AxSSDBDropDown, ByRef pvText As Object, Optional ByRef pvBlank As Object = Nothing, Optional ByRef pvUserItem As Object = Nothing) As Short

        Dim I, vItems As Short

        vItems = UBound(pvText, 1)

        On Error GoTo handleError

        'Add a blank item
        If pvBlank = True Then
            pvList.AddItem(-1 & Chr(9) & "")
        End If

        If Not IsNothing(pvUserItem) Then
            pvList.AddItem(0 & Chr(9) & pvUserItem)
        End If

        For I = 0 To vItems
            pvList.AddItem(pvText(I, 0) & Chr(9) & pvText(I, 1))
        Next I

        SetTextID = vItems + 1

        Exit Function

handleError:

        Exit Function

    End Function
	
	
    Sub InitGridCol(ByRef pvGrid As AxSSDataWidgets_B.AxSSDBGrid, ByVal pvCol As Short, ByVal pvWidth As Short, Optional ByRef pvText As Object = Nothing, Optional ByRef pvLocked As Object = Nothing, Optional ByRef pvVisible As Object = Nothing, Optional ByRef pvStyle As Object = Nothing, Optional ByRef pvSSList As Object = Nothing, Optional ByRef pvAlignment As Object = Nothing, Optional ByRef pvFormat As Object = Nothing)



        pvGrid.Columns.Add(pvCol)
        pvGrid.Columns(pvCol).Width = pvWidth
        pvGrid.Columns(pvCol).Caption = pvText
        pvGrid.Columns(pvCol).Style = pvStyle
        pvGrid.Columns(pvCol).Locked = pvLocked
        pvGrid.Columns(pvCol).Visible = pvVisible


        If Not IsNothing(pvAlignment) Then
            pvGrid.Columns(pvCol).Alignment = pvAlignment
        End If

        If Not IsNothing(pvFormat) Then
            pvGrid.Columns(pvCol).NumberFormat = pvFormat
        End If

        If Not IsNothing(pvSSList) Then
            pvGrid.Columns(pvCol).DropDownHwnd = pvSSList.hWnd
        End If


    End Sub
    Sub InitListCol(ByRef pvList As AxSSDataWidgets_B.AxSSDBDropDown, ByVal pvCol As Short, Optional ByRef pvText As Object = Nothing, Optional ByRef pvVisible As Object = Nothing, Optional ByRef pvShowHeaders As Object = Nothing)

        pvList.Columns.Add(pvCol)
        pvList.Columns(pvCol).Caption = pvText
        pvList.Columns(pvCol).Visible = pvVisible

        If IsNothing(pvShowHeaders) Then
            pvList.ColumnHeaders = False
        Else
            pvList.ColumnHeaders = pvShowHeaders
        End If

    End Sub
	
	
	
    Dim vReturn As New Object
    Public Function SetGrid(ByRef pvValues As Object, ByRef pvSSGrid As AxSSDataWidgets_B.AxSSDBGrid, Optional ByRef vStartCol As Object = Nothing, Optional ByRef vNumberCol As Object = Nothing) As Object

        Dim I As Short
        Dim j As Short
        Dim k As Short
        Dim vCols As Short
        Dim vRows As Short
        Dim vRowItems As String = ""

        On Error GoTo handleError

        vRows = UBound(pvValues, 1)
        vCols = UBound(pvValues, 2)

        vRowItems = ""

        'Build a row of data
        For I = 0 To vRows

            If Not IsNothing(vStartCol) Then
                'Fill the columns before the start column with blanks
                For k = 0 To vStartCol - 1
                    If Not IsNothing(vNumberCol) And vNumberCol = k Then
                        vRowItems = vRowItems & I + 1 & Chr(9)
                    Else
                        vRowItems = vRowItems & Chr(9)
                    End If
                Next k
            End If

            For j = 0 To vCols

                'Build the row of items
                vRowItems = vRowItems & pvValues(I, j) & Chr(9)

            Next j

            'Add the items to the grid
            pvSSGrid.AddItem(vRowItems)

            'Clear the items buffer
            vRowItems = ""

        Next I

        SetGrid = True

        Exit Function

handleError:

        SetGrid = False

    End Function

End Module