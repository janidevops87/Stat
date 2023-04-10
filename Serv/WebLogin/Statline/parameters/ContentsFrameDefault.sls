<%
Option Explicit
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
DIM cmd
Dim RSNAV
Dim nRowCount
Dim bNoButtons

Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<!--#include virtual="/loginstatline/includes/VerifyRefType.vbs"-->
<%
bNoButtons = False  ' Initialize

'Verify Access
If AuthorizeMain Then
   Set RSNAV = Server.CreateObject("ADODB.Recordset")
   RSNAV.ActiveConnection = "DSN=" & REPORTINGDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
   RSNAV.Source = "{call dbo.SPS_NavigationPermission (" & UserID & ", 1)}"
   RSNAV.CursorType = 0
   RSNAV.CursorLocation = 2
   RSNAV.LockType = 1
   RSNAV.Open()


%>
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<base target="main">
<title>Contents Frame Default</title>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_nbGroup(event, grpName) { //v6.0
  var i,img,nbArr,args=MM_nbGroup.arguments;
  if (event == "init" && args.length > 2) {
    if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
      img.MM_init = true; img.MM_up = args[3]; img.MM_dn = img.src;
      if ((nbArr = document[grpName]) == null) nbArr = document[grpName] = new Array();
      nbArr[nbArr.length] = img;
      for (i=4; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
        if (!img.MM_up) img.MM_up = img.src;
        img.src = img.MM_dn = args[i+1];
        nbArr[nbArr.length] = img;
    } }
  } else if (event == "over") {
    document.MM_nbOver = nbArr = new Array();
    for (i=1; i < args.length-1; i+=3) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = (img.MM_dn && args[i+2]) ? args[i+2] : ((args[i+1])? args[i+1] : img.MM_up);
      nbArr[nbArr.length] = img;
    }
  } else if (event == "out" ) {
    for (i=0; i < document.MM_nbOver.length; i++) {
      img = document.MM_nbOver[i]; img.src = (img.MM_dn) ? img.MM_dn : img.MM_up; }
  } else if (event == "down") {
    nbArr = document[grpName];
    if (nbArr)
      for (i=0; i < nbArr.length; i++) { img=nbArr[i]; img.src = img.MM_up; img.MM_dn = 0; }
    document[grpName] = nbArr = new Array();
    for (i=2; i < args.length-1; i+=2) if ((img = MM_findObj(args[i])) != null) {
      if (!img.MM_up) img.MM_up = img.src;
      img.src = img.MM_dn = (args[i+1])? args[i+1] : img.MM_up;
      nbArr[nbArr.length] = img;
  } }
}
//-->
</script>
</head>
<body bgcolor="#F5EBDD" onLoad="MM_preloadImages(
<%
nRowCount=0
    If RSNAV.EOF Then 
    	bNoButtons = True 
        response.write("'")
    Else  ' If RSNAV.EOF 
	DO WHILE NOT RSNAV.EOF
   	    IF nRowCount = 0 then
       		response.write("'")
            Else
       		response.write("', '")
   	    End if
            response.write(RSNAV("IMAGEOVER"))
	    nRowCount = nRowCount + 1
	    RSNAV.MOVENEXT
	Loop
    End If  ' If RSNAV.EOF
%>')">

<TABLE border=0 cellpadding=0 cellspacing=0>
<%

    If bNoButtons = True Then 
	' Added error message to make troubleshooting easier and eliminate ugly error message %>
    <TR>
	<TD>User '<%=UserID%>' has no navigational permissions.</TD>
    </TR>
<%  Else  ' If RSNAV.EOF
	RSNAV.MOVEFIRST
	DO WHILE NOT RSNAV.EOF  %>
    <TR height='28' valign='top'>
	<TD>
	<A HREF="<%=RSNAV("href")%>?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" TARGET="<%=RSNAV("target")%>"
	onClick="MM_nbGroup('down','group1','<%=replace(RSNAV("hreftext"), " ", "")%>','<%=RSNAV("IMAGEOVER")%>',1)"
	onMouseOver="MM_nbGroup('over','<%=replace(RSNAV("hreftext"), " ", "")%>','<%=RSNAV("IMAGEOVER")%>','<%=RSNAV("IMAGEOVER")%>',1)"
	onMouseOut="MM_nbGroup('out')"><IMG SRC="<%=RSNAV("image")%>" ALT="<%=RSNAV("hreftext")%>" name="<%=replace(RSNAV("hreftext"), " ", "")%>" BORDER='0'></A>
	</TD>
    </TR>
<%	     RSNAV.MOVENEXT
	Loop
    End If  ' If RSNAV.EOF

End if  ' If AuthorizeMain
%>
</TABLE>
<p>
</p>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->

</body>
</html>




