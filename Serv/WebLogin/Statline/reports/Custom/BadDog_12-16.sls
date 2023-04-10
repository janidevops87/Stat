
<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>Conditions of Participation Report</title>
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

vQuery = "EXEC sps_SQLJobResult 'vizsla', 0"

Set RS = Conn.Execute("EXEC sps_SQLJobResult 'vizsla', 0")

If Not RS.EOF Then
	arrVizsla = RS.GetRows
End If

Do While Not RS.EOF 
	Response.Write RS("SQLJobMsg") & "<br>"
	RS.MoveNext
Loop



iRecFirst   = LBound(arrVizsla, 2)
iRecLast    = UBound(arrVizsla, 2)
iFieldFirst = LBound(arrVizsla, 1)
iFieldLast  = UBound(arrVizsla, 1)

' Display a table of the data in the array.
' We loop through the array displaying the values.
%>

<table border="3"><%' Overall Table %>
	<tr>
<% ' BEGIN VIZSLA
bVizslaGood = True
' First, loop through the records (second dimension of the array)
' to see if this is a good doggy or a bad doggy
For Recno = iRecFirst To iRecLast
'''Response.Write UCase(Cstr(arrVizsla(FIELD_SUCCESS, Recno))) & "<br>"
	If UCase(Cstr(arrVizsla(FIELD_SUCCESS, Recno))) = "FALSE" Then
		bVizslaGood = False
	End If	
Next ' Recno	
%>	
		<td width="33%"><%' VIZSLA TABLE %>
			<table border="1">
				<tr>				
					<td align=center colspan=4><h2>VIZSLA</h2></td>
				</tr>
				<tr>
	<% If bVizslaGood = True Then %>	
					<td align=center colspan=4><img src="!SQLResultGood.jpg"></td>
	<% Else %>
					<td align=center colspan=4><img src="!SQLResultBad.jpg"></td>	
	<% End If %>
				</tr>
				<tr bgcolor="#CCCCCC">
					<td colspan=center><b>Message</b></td>
					<td colspan=center><b>Success</b></td>
					<td colspan=center><b>Time</b></td>
					<td colspan=center><b>Archive</b></td>
				</tr>
<%

' Loop through the records (second dimension of the array)
For Recno = iRecFirst To iRecLast 
	' A table row for each record %>
				<tr>
					<td><%=arrVizsla(FIELD_MSG, Recno)%></td>
					<td><% If UCase(Cstr(arrVizsla(FIELD_SUCCESS, Recno))) = "TRUE" Then %>Succeeded<%Else%><b><font color=Red>FAILED</font></b><%End If%></td>
					<td><%=FormatDateTime(arrVizsla(FIELD_TIME, Recno), vbShortDate)%>&nbsp;<%=FormatDateTime(arrVizsla(FIELD_TIME, Recno), vbShortTime)%></td>
					<td><% If UCase(Cstr(arrVizsla(FIELD_ARCHIVE, Recno))) = "FALSE" Then %><a href="BadDog.sls?ArchId=<%=arrVizsla(FIELD_ID, Recno)%>">Archive</a><%Else%>&nbsp;<%End If%></td>
				</tr>
<%				
Next ' Recno %>
				<tr>
					<td align=center colspan=4><a href="BadDog.sls?ArchId=ALL">Archive All Vizsla</a></td>
				</tr>
		</td><%'END VIZSLA TABLE %>
	</tr>
<%' END VIZSLA %>
	
	
	<tr>
		<td><%' CLIFFORD TABLE %>

		</td><%'END VIZSLA TABLE %>
	</tr>
	<tr>
		<td><%' POINTER TABLE %>

		</td><%'END POINTER TABLE %>
	</tr>
	
</table><%'END OVERALL TABLE %>
</body>
</html>