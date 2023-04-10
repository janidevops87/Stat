<%
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

Function dbGetStateName(pvStateID)
	dim rsStates
	dim Conn
	dim vQuery
	
	dbGetStateName = null
	Set Conn = server.CreateObject("ADODB.Connection")
	
	vQuery = "SELECT * FROM State WHERE StateID = " & pvStateID
	'Response.Write vQuery
	Set rsStates = Conn.Execute(vQuery)
			
	If not rsStates.eof then
		rsStates.MoveFirst
		dbGetStateName = rsStates.Fields("StateName")
	End If
End Function

%>