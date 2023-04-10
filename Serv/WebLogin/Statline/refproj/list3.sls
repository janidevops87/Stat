<%@ LANGUAGE="VBSCRIPT"%>

<!--#include virtual="/loginstatline/refproj/checkerror.txt"-->
<!--#include virtual="/loginstatline/refproj/connection.txt"-->

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual InterDev 1.0">
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<TITLE>Person List</TITLE>
</HEAD>
<BODY>

<!-- Insert HTML here -->

<%
	OrganizationID = Request.QueryString("OrgID")

	If OrganizationID = "" Then
%>

	<select name="list2" size="1">
        <option value>Select Organization</option>
	</select>

<%	
	Else

		Set RS = Session("Conn").Execute("sps_Person " & OrganizationID)
		Call CheckError(Session("Conn").Errors.Count, "list2.sls")

%>
	
	<select name="list2" size="1">
        
		<option value selected></option>

		<%Do While Not RS.EOF%>
			<option value="<%=RS("PersonID")%>"><%=(RS("PersonFirst") & " " & RS("PersonLast"))%></option>
			<%RS.MoveNext%>

		<%Loop%>
		<%RS.Close%>

	</select>

<%
	End If
%>

</BODY>
</HTML>

<%Set Session("Conn")=Nothing%>