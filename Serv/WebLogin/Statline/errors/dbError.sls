<%@ LANGUAGE="VBSCRIPT" %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual InterDev 1.0">
<META HTTP-EQUIV="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>Document Title</TITLE>
</HEAD>
<BODY BGCOLOR = "#F5EBDD">


<FONT SIZE=4 FACE=Arial FONT COLOR = Red>
There has been a database error.<BR>
Please click back and try your request again. <BR> <BR>
If the problem continues, <BR>
please contact Statline at (888) 881-7828 for assistance. <BR> <BR> <BR> 
</FONT>

<FONT SIZE=1 FACE=Arial FONT COLOR = Black>
Error: <BR>
<%
Response.Write(Session("ErrorLocation") & "<BR>") 
Response.Write(Session("ErrorNumber") & ", " & Session("ErrorDescription"))
%>
</FONT>


</BODY>
</HTML>
