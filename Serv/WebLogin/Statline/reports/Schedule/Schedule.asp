<%
' Due to an outdated reference in StatTrac, it attempts to print schedules using "Schedule.asp".
' This page redirects any calls there to "Schedule.sls".  11/17/04 - SAP
' Request.ServerVariables("QUERY_STRING")

Response.Redirect("Schedule.sls?" & Request.ServerVariables("QUERY_STRING"))
%>
