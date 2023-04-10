<html>

<head>
<title></title>
</head>

<body bgcolor="#F5EBDD">

<img src="/loginstatline/images/redline.jpg" height="2" width="100%">

<table border="0" width="100%" rules="NONE" frame="VOID">
  <tr>
    <td colspan="4"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>#<%=j+1%></b></font></td>
  </tr>
  <tr>
    <td colspan="4"><hr align="CENTER" color="#000000" noshade size="1" width="100%">
    </td>
  </tr>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>For: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Section1(2,j)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Call Number: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Section1(3,j)%></font></td>
  </tr>
<% DateTime = Mid(Section1(5,j),6,2) + "/" + Mid(Section1(5,j),9,2) + "/" + Mid(Section1(5,j),3,2) + " " + Mid(Section1(5,j), 12, 5) %>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Caller Name: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Section1(4,j)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Call Date/Time:
    </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Section1(5,j)%></font></td>
<!--    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=DateTime%></font></td> -->
  </tr>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Of: </b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Section1(6,j)%></font></td>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Message By:</b></font></td>
    <td width="30%"><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Section1(7,j)%></font></td>
  </tr>
  <tr>
    <td width="20%"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Number:</b></font></td>
    <td><font size="<%=FontSizeData%>" face="<%=FontNameData%>"><%=Section1(8,j)%></font></td>
    <td width="20%"></td>
    <td width="30%"></td>
  </tr>
  <tr>
    <td width="20%" valign="Top"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Message:</b></font></td>
    <td colspan="3" valign="TOP" width="70%"><font size="<%=FontSizeData%>"
    face="<%=FontNameData%>"><%=Section1(9,j)%></font></td>
  </tr>
</table>
</body>
</html>
