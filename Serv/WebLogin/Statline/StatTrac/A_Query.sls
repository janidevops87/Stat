<%
Option Explicit

Dim Query
Dim QueryType
Dim Conn
Dim RS
Dim RSData
Dim i
Dim j

'Create a connection object
Set Conn = server.CreateObject("ADODB.Connection")

		
Query = Request.QueryString("Query")
QueryType = Request.QueryString("Type")

'Replace any pipe characters with a plus character
Query = Replace(Query, "|", "+")
'Replace any ~ characters with a % character
Query = Replace(Query, "~", "%")

'Response.Write(Query & "<BR>")

If QueryType = "0" Then
	
	Call Conn.Execute(Query)

	If Conn.Errors.Count > 0 Then
		Response.Write("<2>")
	Else	
		Response.Write("<0>")
	End If

ElseIf QueryType = "1" Then

	'Execute the query
	Set RS = Conn.Execute(Query)

	If Conn.Errors.Count > 0 Then
		Response.Write("<2>")
	Else	
		If RS.EOF = True Then
			Response.Write("<1>")
		Else
			Response.Write("<0>")

			'Return the field names first
			For i = 0 To RS.Fields.Count - 1
				Response.Write(RS.Fields(i).Name & "," & RS.Fields(i).Type & "," & RS.Fields(i).Precision & ",|")
			Next
			Response.Write("~")
			
			'Return the data
			RSData = RS.GetRows

			Set RS = Nothing

			For i = 0 To UBound(RSData, 2)
				For j = 0 To UBound(RSData, 1)
					Response.Write(RSData(j, i) & "|")
				Next
				Response.Write("~")
			Next

		End If

	End If

End If

Set Conn = Nothing
Set RS = Nothing
%>
