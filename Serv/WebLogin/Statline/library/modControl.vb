Module modControl
    Function SetTextID%(ByVal pcList As DropDownList, ByVal pText As DataSet, ByVal pClear As Boolean, ByVal pvAddAllItem As Boolean, ByVal pvAddBlankItem As Boolean)

        Dim vItems%

        On Error GoTo SetTextIDEH

        If pClear Then
            pcList.Items.Clear()
        End If

        'Populate the Dropdown
        'Set the data
        Dim vTable As DataTable
        Dim vRow As DataRow
        Dim vListItem As ListItem

        vItems = pText.Tables(0).Rows.Count

        For Each vTable In pText.Tables
            For Each vRow In vTable.Rows
                vListItem = New ListItem(vRow(vTable.Columns(1)), vRow(vTable.Columns(0)))
                pcList.Items.Add(vListItem)
            Next
        Next

        SetTextID = vItems + 1

        If pvAddAllItem = True Then
            vListItem = New ListItem("*All", 0)
            pcList.Items.Insert(0, vListItem)
        End If

        If pvAddBlankItem = True Then
            vListItem = New ListItem("", -1)
            pcList.Items.Insert(0, vListItem)
        End If

        Exit Function

SetTextIDEH:

        pcList.Items.Clear()
        SetTextID = -1
        Exit Function


        '02/27/03 drh - KEEP FOR DATASET LOOPING EXAMPLE
        ''Populate the Test String
        'Dim vTable As DataTable
        'Dim vRow As DataRow
        'Dim vColumn As DataColumn
        'Dim vListItem As ListItem
        'Dim vTest$ = ""
        'For Each vTable In vresults.Tables
        '    For Each vRow In vTable.Rows
        '        vListItem = New ListItem(vRow(vTable.Columns(1)), vRow(vTable.Columns(0)))
        '        Me.cboContactEventType.Items.Add(vListItem)
        '        vTest = vTest & vbCrLf
        '        For Each vColumn In vTable.Columns
        '            vTest = vTest & vbTab & vRow(vColumn)
        '        Next
        '    Next
        'Next
        'Me.txtContactDesc.Text = vTest

    End Function

    Function SelectID(ByVal pcList As DropDownList, ByVal pID&) As Boolean

        On Error Resume Next

        Dim i%

        SelectID = True

        For i = 0 To pcList.Items.Count - 1
            If pcList.Items(i).Value = pID Then
                pcList.SelectedIndex = i
                SelectID = True
                Exit Function
            End If
        Next i

        pcList.SelectedIndex = -1
        SelectID = False

    End Function

    Function SelectText(ByVal pcList As DropDownList, ByVal pText$) As Boolean

        Dim i%

        If TypeOf pcList Is DropDownList Then
            'Select Case pcList.Style

            '    Case 0, 1

            '        pcList.Text = pText$
            '        SelectText = True
            '        Exit Function

            '    Case 2

            'If pText$ = "" Then
            '    pcList.SelectedIndex = -1
            '    SelectText = True
            '    Exit Function
            'End If

            For i = 0 To pcList.Items.Count - 1
                If pcList.Items(i).Text = pText$ Then
                    pcList.SelectedIndex = i
                    SelectText = True
                    Exit Function
                End If
            Next i

            'End Select

            pcList.SelectedIndex = -1
            SelectText = False

        Else
            For i = 0 To pcList.Items.Count - 1
                If pcList.Items(i).Text = pText$ Then
                    pcList.SelectedIndex = i
                    pcList.Items(i).Selected = True
                    SelectText = True
                    Exit Function
                End If
            Next i

            pcList.SelectedIndex = -1
            SelectText = False

        End If

    End Function

    Function GetID&(ByVal pcList As DropDownList)

        On Error GoTo handleError

        If pcList.SelectedIndex <> -1 Then
            GetID = pcList.Items(pcList.SelectedIndex).Value
        Else
            GetID = -1
        End If

        Exit Function

handleError:

        GetID = -1

    End Function

    Function RemoveID(ByRef pcList As DropDownList, ByVal pvID%) As Boolean

        On Error GoTo handleError

        Dim i%
        For i = 0 To pcList.Items.Count - 1
            If pcList.Items(i).Value = pvID Then
                pcList.Items.RemoveAt(i)
                RemoveID = True
                Exit Function
            End If
        Next

handleError:

        RemoveID = False

    End Function

End Module
