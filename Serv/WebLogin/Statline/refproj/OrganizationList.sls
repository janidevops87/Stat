<%@ LANGUAGE="VBSCRIPT"%>
<!--#include virtual="/loginstatline/refproj/checkerror.txt"-->
<!--#include virtual="/loginstatline/refproj/connection.txt"-->
<html>

<head>
<meta NAME="GENERATOR" Content="Microsoft FrontPage 3.0">
<meta HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="EXPIRES" content="0">
<title>Organization List</title>
</head>

<body>

<form name="formOrganization">
<%
	Set RS = Session("Conn").Execute("sps_Organizations")
	Call CheckError(Session("Conn").Errors.Count, "list1.sls")
%>
  <p><select name="listOrganization" size="1" onChange="getData(formOrganization)"
  tabindex="1">
    <option value selected></option>
<%Do While Not RS.EOF%>    <option value="<%=RS("OrganizationID")%>"><%=RS("OrganizationName")%></option>
<%RS.MoveNext%><%Loop%><%RS.Close%>  </select> </p>
</form>
</body>
</html>
<%Set Session("Conn")=Nothing%>
<script language="JavaScript">

	function getData(formOrganization)
	{

	var url = ""

	url = "PersonList.sls?OrgID=" + formOrganization.listOrganization.options[formOrganization.listOrganization.selectedIndex].value

	parent.frames[3].location.replace(url)

	return 0

	}

</script>
