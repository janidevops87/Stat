
''' <summary>
''' Implements the manual sorting of items by columns.
''' </summary>
''' <remarks>
''' Created 
''' by: Bret 
''' On: 01/12/2010
''' </remarks>
Public Class ListViewItemComparer
    Implements IComparer

    Private order As SortOrder
    Private col As Integer

    Public Sub New()
        col = 0
    End Sub

    Public Sub New(ByVal column As Integer, ByVal columnSortOrder As SortOrder)
        col = column
        order = columnSortOrder
    End Sub
    ''' <summary>
    ''' A 32-bit signed integer indicating the lexical relationship between the two comparands.  
    ''' Value Condition Less than zero strA is less than strB. Zero strA equals strB. 
    ''' Greater than zero strA is greater than strB.
    ''' </summary>
    ''' <param name="x"></param>
    ''' <param name="y"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function Compare(ByVal x As Object, ByVal y As Object) As Integer _
       Implements IComparer.Compare
        'Dim xValue As String = ""
        'Dim yValue As String = ""
        'Try
        '    xValue = CType(x, ListViewItem).SubItems(col).Text
        '    yValue = CType(y, ListViewItem).SubItems(col).Text

        'Catch
        Dim compareValue As Integer = 0
        If ((col < CType(x, ListViewItem).SubItems.Count) And (col < CType(y, ListViewItem).SubItems.Count)) Then

            compareValue = [String].Compare(CType(x, ListViewItem).SubItems(col).Text, CType(y, ListViewItem).SubItems(col).Text)
        End If

        If order = SortOrder.Ascending Then
            compareValue = compareValue * 1
        ElseIf order = SortOrder.Descending Then
            compareValue = compareValue * -1
        Else
            compareValue = 0
        End If

        Return compareValue

    End Function

End Class


