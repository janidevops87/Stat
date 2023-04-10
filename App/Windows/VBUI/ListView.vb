Imports System.Windows.Forms
Namespace Stattrac
    Public Class ListView
        Inherits System.Windows.Forms.ListView

        Private order() As SortOrder
        Private columnList As Object
        Private currentRow As Integer
        Private nextRow As Integer
        Private rowComparer As ListViewItemComparer
        Private arrayIndex As Integer
        Private itemA As ListViewItem
        Private itemB As ListViewItem
        Private sorted As Boolean = False

        Public Overridable Sub Sort( _
         ByRef sortColumns As Object, _
         ByRef sortDirection() As SortOrder _
        )
            ListViewItemSorter = Nothing
            Sorting = SortOrder.None
            sorted = False

            For sortCount As Integer = 0 To Items.Count - 1

                order = sortDirection
                columnList = sortColumns
                currentRow = 0
                arrayIndex = 0
                Sort(arrayIndex)
            Next
        End Sub

        ''' <summary>
        ''' loops through a column based on array Index columnList.
        ''' If current and Next Row are equal checks to see if all columns have been sorted.
        ''' checks to see if all indexes have been evaluated in the sortColumns. If another column should be sorted
        ''' Method Calls itselft to sort multiple columns
        ''' </summary>
        ''' <remarks></remarks>
        Private Sub Sort(ByVal currentColumn As Integer)
            Dim compareValue As Integer
            Dim previousColumn As Integer
            Dim nextColumn As Integer
            Dim sorted As Boolean
            previousColumn = currentColumn - 1
            nextColumn = currentColumn + 1
            sorted = False

            For row As Integer = currentRow To Items.Count - 2
                currentRow = row
                nextRow = row + 1

                If (Items.Count > currentRow And Items.Count > nextRow) Then
                    compareValue = Compare(Items.Item(currentRow).SubItems(columnList(currentColumn)).Text, Items.Item(nextRow).SubItems(columnList(currentColumn)).Text, currentColumn)
                End If
                If compareValue > 0 Then
                    'string a is greater than string b
                    'itemA = Items.Item(currentRow)
                    itemB = Items.Item(nextRow)
                    itemB.Remove()
                    Items.Insert(currentRow, itemB)
                    sorted = False
                ElseIf compareValue = 0 Then
                    'string a and string b are equal
                    If (columnList.Length - 1 > currentColumn) Then
                        Dim sortedSave As Boolean = sorted
                        Sort(nextColumn)
                        sorted = sortedSave
                    End If
                End If
                If (currentColumn > 0) Then
                    compareValue = Compare(Items.Item(currentRow).SubItems(columnList(previousColumn)), Items.Item(nextRow).SubItems(columnList(previousColumn)), previousColumn)
                    If compareValue <> 0 Then
                        Return
                    End If
                End If
            Next
        End Sub
        ''' <summary>
        ''' Checks two strings if equal returns 0.
        ''' if not equal it returns 1 for ascending values
        ''' if not equal it returns -1 for descending values. 
        ''' </summary>
        ''' <param name="columnA"></param>
        ''' <param name="ColumnB"></param>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Private Function Compare(ByVal columnA As Object, ByVal ColumnB As Object, ByVal columnIndex As Integer) As Integer
            Dim result As Integer = 0

            result = [String].Compare(columnA.ToString(), ColumnB.ToString())

            If order(columnIndex) = SortOrder.Ascending Then
                result = result * 1
            ElseIf order(columnIndex) = SortOrder.Descending Then
                result = result * -1
            Else
                result = 0
            End If

            Return result

        End Function
    End Class
End Namespace
