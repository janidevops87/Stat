
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>BAD DOG! ~ The SQL Server Job Report</title>
<STYLE>
UL {
   page-break-before: always
   }
a:link {
  color: #000000;
  text-decoration: none;
  }
a:visited { 
  color: #000000;
  text-decoration: none;
  }
a:hover { 
  color: #D13028;
  text-decoration: none;
  }
</STYLE>


</head>

<body bgcolor="#DDDDDD">
<!--#include virtual="/loginstatline/includes/DBConnection.sls"-->
<%'!--#include virtual="/loginstatline/includes/Authorize.sls"--%>

<%
Private Const FIELD_ID = 0
Private Const FIELD_TIME = 1
Private Const FIELD_SERVER = 2
Private Const FIELD_MSG = 3
Private Const FIELD_SUCCESS = 4
Private Const FIELD_ARCHIVE = 5


'Open Connection
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open WEBPROD, DBUSER, DBPWD


'Check QueryString for any items to be archived
If Len(Request.QueryString("ArchId")) > 0 And Len(Request.QueryString("Svr")) > 0 Then
	Select Case UCase(Request.QueryString("Svr"))
		Case "V"
			vArchiveServer = "Vizsla"
		Case "C"
			vArchiveServer = "Clifford"
		Case "P"
			vArchiveServer = "Pointer"
	End Select
	'If ALL job items are to be archived for a given server, pass -99 to the Sproc to designate that.
	If UCase(Request.QueryString("ArchId")) = "ALL" Then
		vArchiveItem = -99
	ElseIf IsNumeric(Request.QueryString("ArchId")) Then
		vArchiveItem = Request.QueryString("ArchId")
	Else
		vArchiveItem = 0
	End If
	vQuery = "EXEC spu_Archive_SQLJobResult '" & vArchiveServer & "', " & vArchiveItem
	Conn.Execute(vQuery)
	
	Set Conn = Nothing
	' Redirection eliminates QueryString variables after an Archiving
	Response.Redirect("BadDog.sls?")
End If

'Check to see if a Refresh command was set, re-running the import of data from Clifford or Pointer
If Len(Request.QueryString("Refresh")) > 0 Then
	Select Case UCase(Request.QueryString("Refresh"))
		Case "C"
			vQuery = "EXEC sp_UpdateSqlJobStatus 'SQLJobStatus Import Clifford'"
			Conn.Execute(vQuery)
		Case "P"
			vQuery = "EXEC sp_UpdateSqlJobStatus 'SQLJobStatus Import Pointer'"
			Conn.Execute(vQuery)
	End Select
	
	
	Set Conn = Nothing
	' Redirection eliminates QueryString variables after a refresh
	Response.Redirect("BadDog.sls?")
End If

' Get Vizsla Data ===============================
vQuery = "EXEC sps_SQLJobResult 'vizsla', 0"

Set RS = Conn.Execute(vQuery)

If Not RS.EOF Then
	arrVizsla = RS.GetRows
	bHideVizsla = False
	
	iVizslaRecFirst   = LBound(arrVizsla, 2)
	iVizslaRecLast    = UBound(arrVizsla, 2)
	
Else
	bHideVizsla = True
	bVizslaGood = True
End If

'''Do While Not RS.EOF 
	'''Response.Write RS("SQLJobMsg") & "<br>"
	'''RS.MoveNext
'''Loop
' END Get Vizsla Data ===========================

' Get Clifford Data ============================
vQuery = "EXEC sps_SQLJobResult 'clifford', 0"

Set RS = Conn.Execute(vQuery)

If Not RS.EOF Then
	arrClifford = RS.GetRows
	bHideClifford = False
	
	iCliffordRecFirst   = LBound(arrClifford, 2)
	iCliffordRecLast    = UBound(arrClifford, 2)
	
Else
	bHideClifford = True
	bCliffordGood = True
End If
' END Get Clifford Data =========================

' Get Pointer Data ============================
vQuery = "EXEC sps_SQLJobResult 'pointer', 0"

Set RS = Conn.Execute(vQuery)

If Not RS.EOF Then
	arrPointer = RS.GetRows
	bHidePointer = False
	
	iPointerRecFirst   = LBound(arrPointer, 2)
	iPointerRecLast    = UBound(arrPointer, 2)
	
Else
	bHidePointer = True
	bPointerGood = True
End If

' END Get Pointer Data =========================


' Display a table of the data in the array.
' We loop through the array displaying the values.
%>

<table border="0" width="100%"><%' Overall Table %>
	<tr>
<% 
' BEGIN VIZSLA ===============================================================
If bHideVizsla = False Then
	bVizslaGood = True
	' First, loop through the records (second dimension of the array)
	' to see if this is a good doggy or a bad doggy
	For Recno = iVizslaRecFirst To iVizslaRecLast
	'''Response.Write UCase(Cstr(arrVizsla(FIELD_SUCCESS, Recno))) & "<br>"
		If UCase(Cstr(arrVizsla(FIELD_SUCCESS, Recno))) = "FALSE" Then
			bVizslaGood = False
		End If	
	Next ' Recno	
End if ' If bHideVizsla = False
	%>	
		<td width="33%" valign=top><%
' VIZSLA TABLE =====================================================================%>
			<table border="1" width="100%">
				<tr>				
						<td align=center colspan=4 bgcolor="#993399"><h2>VIZSLA</h2></td>
				</tr>
				<tr>
	<% If bVizslaGood = True Then %>	
					<td align=center colspan=4><img src="SQLResultGood.jpg"></td>
	<% Else %>
					<td align=center colspan=4><img src="SQLResultBad.jpg"></td>	
	<% End If %>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td colspan=center><b>Message</b></td>
					<td colspan=center><b>Success</b></td>
					<td colspan=center><b>Time</b></td>
					<td colspan=center><b>Archive</b></td>
				</tr>
<%
If bHideVizsla = False Then
	' Loop through the records (second dimension of the array)
	For Recno = iVizslaRecFirst To iVizslaRecLast 
		' A table row for each record %>
				<tr>
					<td><%=arrVizsla(FIELD_MSG, Recno)%></td>
					<td><% If UCase(Cstr(arrVizsla(FIELD_SUCCESS, Recno))) = "TRUE" Then %>Succeeded<%Else%><b><font color=Red>FAILED</font></b><%End If%></td>
					<td><%=FormatDateTime(arrVizsla(FIELD_TIME, Recno), vbShortDate)%>&nbsp;<%=FormatDateTime(arrVizsla(FIELD_TIME, Recno), vbShortTime)%></td>
					<td><% If UCase(Cstr(arrVizsla(FIELD_ARCHIVE, Recno))) = "FALSE" Then %><a href="BadDog.sls?ArchId=<%=arrVizsla(FIELD_ID, Recno)%>&Svr=V">Archive</a><%Else%>&nbsp;<%End If%></td>
				</tr>
  <%	Next ' Recno %>
				<tr>
					<td align=center colspan=4><a href="BadDog.sls?ArchId=ALL&Svr=V">Archive All Vizsla</a></td>
				</tr>
<%				
Else  ' If bHideVizsla = False %>
				<tr>
					<td colspan=4 align=center><i>NO NEW RECORDS</i></td>
				</tr>
<%
End If  ' If bHideVizsla = False %>
			</table>
		</td><%'END VIZSLA TABLE 
' END VIZSLA ========================================================================


' BEGIN CLIFFORD ====================================================================
If bHideClifford = False Then
	bCliffordGood = True
	' First, loop through the records (second dimension of the array)
	' to see if this is a good doggy or a bad doggy
	For Recno = iCliffordRecFirst To iCliffordRecLast
	'''Response.Write UCase(Cstr(arrClifford(FIELD_SUCCESS, Recno))) & "<br>"
		If UCase(Cstr(arrClifford(FIELD_SUCCESS, Recno))) = "FALSE" Then
			bCliffordGood = False
		End If	
	Next ' Recno	
End if ' If bHideClifford = False
	%>	
		<td width="33%" valign=top><%
' CLIFFORD TABLE ===============================================================%>
			<table border="1" width="100%">
				<tr>				
						<td align=center colspan=4 bgcolor="#33CCCC"><h2>CLIFFORD</h2></td>
				</tr>
				<tr>
	<% If bCliffordGood = True Then %>	
					<td align=center colspan=4><img src="SQLResultGood.jpg"><br><a href="BadDog.sls?Refresh=C"><Font size=0>Refresh</font></a></td>
	<% Else %>
					<td align=center colspan=4><img src="SQLResultBad.jpg"><br><a href="BadDog.sls?Refresh=C"><Font size=0>Refresh</font></a></td>	
	<% End If %>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td colspan=center><b>Message</b></td>
					<td colspan=center><b>Success</b></td>
					<td colspan=center><b>Time</b></td>
					<td colspan=center><b>Archive</b></td>
				</tr>
<%
If bHideClifford = False Then
	' Loop through the records (second dimension of the array)
	For Recno = iCliffordRecFirst To iCliffordRecLast 
		' A table row for each record %>
				<tr>
					<td><%=arrClifford(FIELD_MSG, Recno)%></td>
					<td><% If UCase(Cstr(arrClifford(FIELD_SUCCESS, Recno))) = "TRUE" Then %>Succeeded<%Else%><b><font color=Red>FAILED</font></b><%End If%></td>
					<td><%=FormatDateTime(arrClifford(FIELD_TIME, Recno), vbShortDate)%>&nbsp;<%=FormatDateTime(arrClifford(FIELD_TIME, Recno), vbShortTime)%></td>
					<td><% If UCase(Cstr(arrClifford(FIELD_ARCHIVE, Recno))) = "FALSE" Then %><a href="BadDog.sls?ArchId=<%=arrClifford(FIELD_ID, Recno)%>&Svr=C">Archive</a><%Else%>&nbsp;<%End If%></td>
				</tr>
  <%	Next ' Recno %>
				<tr>
					<td align=center colspan=4><a href="BadDog.sls?ArchId=ALL&Svr=C">Archive All Clifford</a></td>
				</tr>
<%				
Else  ' If bHideClifford = False %>
				<tr>
					<td colspan=4 align=center><i>NO NEW RECORDS</i></td>
				</tr>
<%
End If  ' If bHideClifford = False %>
				<tr>
					<td align=center colspan=4><a href="AlphaPagerMonitor.sls">Alpha Pager Monitor</a></td>
				</tr>
			</table>

		</td><%'END CLIFFORD TABLE %>
<%' END CLIFFORD ========================================================================

' BEGIN POINTER =========================================================================
If bHidePointer = False Then
	bPointerGood = True
	' First, loop through the records (second dimension of the array)
	' to see if this is a good doggy or a bad doggy
	For Recno = iPointerRecFirst To iPointerRecLast
	'''Response.Write UCase(Cstr(arrPointer(FIELD_SUCCESS, Recno))) & "<br>"
		If UCase(Cstr(arrPointer(FIELD_SUCCESS, Recno))) = "FALSE" Then
			bPointerGood = False
		End If	
	Next ' Recno	
End if ' If bHidePointer = False
	%>	
		<td width="33%" valign=top><%
' POINTER TABLE =========================================================================%>
			<table border="1" width="100%">
				<tr>				
						<td align=center colspan=4 bgcolor="#66CC66"><h2>POINTER</h2></td>
				</tr>
				<tr>
	<% If bPointerGood = True Then %>	
					<td align=center colspan=4><img src="SQLResultGood.jpg"><br><a href="BadDog.sls?Refresh=P"><Font size=0>Refresh</font></a></td>
	<% Else %>
					<td align=center colspan=4><img src="SQLResultBad.jpg"><br><a href="BadDog.sls?Refresh=P"><Font size=0>Refresh</font></a></td>	
	<% End If %>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td colspan=center><b>Message</b></td>
					<td colspan=center><b>Success</b></td>
					<td colspan=center><b>Time</b></td>
					<td colspan=center><b>Archive</b></td>
				</tr>
<%
If bHidePointer = False Then
	' Loop through the records (second dimension of the array)
	For Recno = iPointerRecFirst To iPointerRecLast 
		' A table row for each record %>
				<tr>
					<td><%=arrPointer(FIELD_MSG, Recno)%></td>
					<td><% If UCase(Cstr(arrPointer(FIELD_SUCCESS, Recno))) = "TRUE" Then %>Succeeded<%Else%><b><font color=Red>FAILED</font></b><%End If%></td>
					<td><%=FormatDateTime(arrPointer(FIELD_TIME, Recno), vbShortDate)%>&nbsp;<%=FormatDateTime(arrPointer(FIELD_TIME, Recno), vbShortTime)%></td>
					<td><% If UCase(Cstr(arrPointer(FIELD_ARCHIVE, Recno))) = "FALSE" Then %><a href="BadDog.sls?ArchId=<%=arrPointer(FIELD_ID, Recno)%>&Svr=P">Archive</a><%Else%>&nbsp;<%End If%></td>
				</tr>
  <%	Next ' Recno %>
				<tr>
					<td align=center colspan=4><a href="BadDog.sls?ArchId=ALL&Svr=P">Archive All Pointer</a></td>
				</tr>
<%				
Else  ' If bHidePointer = False %>
				<tr>
					<td colspan=4 align=center><i>NO NEW RECORDS</i></td>
				</tr>
<%
End If  ' If bHidePointer = False %>
			</table>

		</td><%'END POINTER TABLE %>
<%' END POINTER ========================================================================%>		
	
		
	</tr>
	
</table><%'END OVERALL TABLE %>
</body>
</html>