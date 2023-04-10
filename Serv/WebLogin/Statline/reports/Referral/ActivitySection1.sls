<html>

<head>
<title></title>
</head>

<body bgcolor="#F5EBDD">

<img src="/loginstatline/images/redline.jpg" height="2" width="100%">
<table border="0" width="100%" rules="NONE" frame="VOID">

<%
If Not vNoRecords Then

	Dim TypeCount
	Dim TotalCount
	Dim k

	TotalCount = Ubound(ResultArray,1) + 1

	k = 0
	TypeCount = 0
	TypeName = ResultArray(k,12)

	For k = 0 to TotalCount - 1

		If ResultArray(k,12) <> TypeName Then%>
			
			<tr>
				<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%=TypeName%></b></font></td>
				<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=TypeCount%></font></td>
			</tr>
			
			<%TypeName = ResultArray(k,12)
			TypeCount = 1

		Else

			TypeCount = TypeCount + 1

		End If

	Next%>

  <tr>
	<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%=TypeName%></b></font></td>
	<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=TypeCount%></font></td>
  </tr>

  <tr>
	<td colspan="2"><hr align="CENTER" color="#000000" noshade size="1" width="100%"></hr>
	</td>
  </tr>
  <tr>
	<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Total: </b></font></td>
	<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=TotalCount%></font></td>
  </tr>

<%Else%>

  <tr>
	<td colspan="2"><hr align="CENTER" color="#000000" noshade size="1" width="100%"></hr>
	</td>
  </tr>
  <tr>
	<td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Total: </b></font></td>
	<td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>">No activity for this period</font></td>
  </tr>

<%End If%>

</table>
</body>
</html>
