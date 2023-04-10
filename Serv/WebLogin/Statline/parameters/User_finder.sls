


<html>
<body bgcolor=orange>

<%
Dim vThisUser

vThisUser = Request.ServerVariables("REMOTE_USER")

%>
Request.ServerVariables("REMOTE_USER") = <%=vThisUser%><br><br>

<%
vThisUser = Request.ServerVariables("AUTH_USER")

%>
Request.ServerVariables("AUTH_USER") = <%=vThisUser%><br><br>

<%
vThisUser = Request.ServerVariables("LOGON_USER")

%>
Request.ServerVariables("LOGON_USER") = <%=vThisUser%><br><br>

<br>
<%
for each x in Request.ServerVariables
  response.write("<i>" & x & "</i> = " & " " & Request.ServerVariables(x) & "<br><br>")
next
 %>

</body>
</html>


