<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim WebConn
Dim WebDataSourceName
DIM PreAnnounceID
Dim Temp
Dim ServerDB	'10/28/02 drh

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
'Verify Access
If AuthorizeMain Then

	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

	'Get the user name
	vQuery = "sps_WebPerson " & UserID
	Set RS = Conn.Execute(vQuery)
	UserName = RS("PersonFirst") & " " & RS("PersonLast")
	
	'10/28/02 drh - Get Server/DB
	Set RS = Conn.Execute("EXEC sps_GetServerDB")
	ServerDB = RS("Server_Name") & " - " & RS("DB_Name")
	
	Set RS = Nothing	
	Set Conn = Nothing

'Execute the main page generating routine
	
	WebDataSourceName = "WebProd"
	
	Set WebConn = server.CreateObject("ADODB.Connection")
	WebConn.Open WebDataSourceName, DBUSER, DBPWD
	
%>


<html>

<head>
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<meta name="Microsoft Border" content="none">
<meta http-equiv="EXPIRES" content="0">
<META HTTP-EQUIV="REFRESH" CONTENT=300>
<title>AnnouncementList</title>
</head>

<body bgcolor="#f5ebdd">

<%

vQuery = "Execute sps_MainAnnouncement"
Set RS = WebConn.Execute(vQuery)


%>

<table align="left" border="1" cellPadding="5" cellSpacing="0" style="WIDTH: 550px"
 width="550">
 <%'10/28/02 drh - Add announcement to identify server/database
 	if request.servervariables("SERVER_NAME") <> "griffon" AND request.servervariables("SERVER_NAME") <> "222.133.178.102" then%>
 <tr>
   <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong><%=FormatDateTime(now(),vbShortDate)%></strong></font></td>
   <td width="452"><font face="Times New Roman" size="2"><B>Database:</B>&nbsp;&nbsp;<%=ServerDB%></B></font></td>
</tr>
<%end if%>

<%

If RS.EOF Then

	%>
	
		<tr>
	   <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong>
			<%=FormatDateTime(now(),vbShortDate)%></strong></font>
		</td>
	
		<td width="452"><font face="Times New Roman" size="2"><B>There are no current announcements.</B></font>
		</td>
	<%

Else

PreAnnounceID = RS("AnnouncementID")

Do While Not RS.EOF

%>

<%
if RS("AnnouncementEndDate") > Now() Then
Temp = RS("AnnouncementMessage")
Temp = Replace(Temp, Chr(10), "<BR>", 1)
%>

	<tr>
	   <td checked = "false" valign="top" align="left" width="50"><font face="Arial" size="2"><strong>
			<%=RS("AnnouncementStartDate")%></strong></font>
		</td>
	   <td width="452"><font face="Times New Roman" size="2"><B><%=RS("AnnouncementTitle")%></B><BR>
	   
			<%=Temp%><P>
			<%If left(RS("LinksURL"),7)="mailto:" Then %>
				<a href="<%=RS("LinksURL")%>" >
			<%Else
			'Use the ? Symbol at end of URL to indicate a Statline link
				If right(RS("LinksURL"),1)="?" then%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" target="main">
			<%	Else%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>" target="_blank">
			<%	End If
			End If%>
			<%=RS("LinksName")%></a>
			<%
			RS.MoveNext
			
	IF RS.EOF Then
	%>
			</font>
		</td>
	</tr>
	<%
		
		Exit DO	
	End  IF

	Do While NOT RS.EOF 
		If PreAnnounceID =  RS("AnnouncementID")Then
	%>
			
			, &nbsp; 
			<%If left(RS("LinksURL"),7)="mailto:" Then %>
				<a href="<%=RS("LinksURL")%>" >
			<%Else
			'Use the ? Symbol at end of URL to indicate a Statline link
				If right(RS("LinksURL"),1)="?" then%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" target="main">
			<%	Else%>
					<a href="<%=strHttpHeader & RS("LinksURL")%>" target="_blank">
			<%	End If
			End If%>
			<%=RS("LinksName")%></a>
		
		<%	
		PreAnnounceID =  RS("AnnouncementID")
		RS.MoveNext	
		Else 
			PreAnnounceID =  RS("AnnouncementID")
			Exit Do
		End IF
		Loop
		
		%>
		</font>
	</td>
 </tr>

<%
			
Else

	RS.MoveNext
End If
				
Loop

End If

Set RS = Nothing
Set Conn = Nothing
Set WebConn = Nothing



%>

</table> 
<DIV></DIV>
<!-- Halloween routine
<div id=ghost1 style="position: absolute; left: 690; top: 240; visibility: visible;">
<img border=0 src=/loginstatline/images/bat.gif></div>
<div id=ghost2 style="position: absolute; left: 640; top: 325; visibility: visible;">
<img border=0 src=/loginstatline/images/ghost.gif></div>
<div id=ghost3 style="position: absolute; left: 760; top: 350; visibility: visible;">
<img border=0 src=/loginstatline/images/ghost2.gif></div>
<script language=JavaScript>
var isIE = navigator.appName.indexOf("Netscape") == -1;
if (isIE) {
var Tall = document.body.clientHeight/4;
var Wide = document.body.clientWidth/3;
var step = .3;
var Next = 0;
var Xpos = 290;
var Ypos = 175;
var HomX = 75;
var HomY = 100;
}
var Hovering;
function hoverGhosts(X,Y) {
xx = HomX + ((X -HomX) /1.05);
yy = HomY + ((Y -HomY) /1.05);
Xpos = parseInt(xx);
Ypos = parseInt(yy);
if ((55 < xx < 45) && (160 < yy < 140))
Hovering = setTimeout('hoverGhosts(' + xx + ',' + yy + ');',90);
}
function ghostsFly() {
if (isIE) {
for (var xx = 1 ; xx < 4 ; xx++ ) {
var ghst = 'ghost' + xx;
document.all[ghst].style.top = Ypos + Math.cos((20*Math.sin(Next/(30+xx)))+xx*70)*Tall*(Math.sin(10+Next/10)+0.2)*Math.cos((Next + xx*55)/10);
document.all[ghst].style.left =Xpos + Math.sin((20*Math.sin(Next/30))+xx*70)*Wide*(Math.sin(10+Next/(10+xx))+0.2)*Math.cos((Next + xx*55)/10);
}
Next += step;
setTimeout("ghostsFly()", 100) ;
}
}
var whichGhost = 0;
function stopGhosts() {
if (whichGhost!=3) whichGhost++;
if (isIE)
document.onmousemove = null;
else
window.onMouseMove = null;
if (isIE) {
var ghst = 'ghost' + whichGhost;
document.all[ghst].style.visibility = 'hidden';
}
else
document.layers[whichGhost].visibility = 'hide';
}
ghostsFly();
setTimeout(stopGhosts,11000);
setTimeout(stopGhosts,13000);
setTimeout(stopGhosts,15000);
</script>
-->
<!-- Snow Flakes 
<div id=L1 style="position:absolute; width:30px; height:39px; z-index:1; left: 27px; top: -45px">
<img src=/loginstatline/images/flake-sm.gif width=24 height=25 border=0></div>
<div id=L2 style="position:absolute; left:389px; top:-44px; width:48px; height:60px; z-index:2">
<img src=/loginstatline/images/flake-sm3.gif width=24 height=25 border=0></div>
<div id=L3 style="position:absolute; left:186px; top:-41px; width:39px; height:52px; z-index:3">
<img src=/loginstatline/images/flake4.gif width=33 height=36 border=0></div>
<div id=L4 style="position:absolute; left:532px; top:-42px; width:31px; height:41px; z-index:4">
<img src=/loginstatline/images/flake1.gif width=39 height=44 border=0></div>
<script language=JavaScript>
d=document;
function TP(tmLnName, myID){
var i,j,tmLn,props,keyFrm,sprite,numKeyFr,firstKeyFr,propNum,theObj,firstTime=false;
if (d.Time == null) MM_initTimelines();
tmLn = d.Time[tmLnName];
if (myID == null) { myID = ++tmLn.ID; firstTime=true;}
if (myID == tmLn.ID) {
setTimeout('TP("'+tmLnName+'",'+myID+')',tmLn.delay);
fNew = ++tmLn.curFrame;
for (i=0; i<tmLn.length; i++) {
sprite = tmLn[i];
if (sprite.charAt(0) == 's') {
if (sprite.obj) {
numKeyFr = sprite.keyFrames.length; firstKeyFr = sprite.keyFrames[0];
if (fNew >= firstKeyFr && fNew <= sprite.keyFrames[numKeyFr-1]) { keyFrm=1;
for (j=0; j<sprite.values.length; j++) {
props = sprite.values[j];
if (numKeyFr != props.length) {
if (props.prop2 == null) sprite.obj[props.prop] = props[fNew-firstKeyFr];
else sprite.obj[props.prop2][props.prop] = props[fNew-firstKeyFr];
} else {
while (keyFrm<numKeyFr && fNew>=sprite.keyFrames[keyFrm]) keyFrm++;
if (firstTime || fNew==sprite.keyFrames[keyFrm-1]) {
if (props.prop2 == null) sprite.obj[props.prop] = props[keyFrm-1];
else sprite.obj[props.prop2][props.prop] = props[keyFrm-1];
} } } } }
} else if (sprite.charAt(0)=='b' && fNew == sprite.frame) eval(sprite.value);
if (fNew > tmLn.lastFrame) tmLn.ID = 0;
} }
}
function MM_findObj(n, d){
var p,i,x;
if(!d) d=document;
if((p=n.indexOf("?"))>0&&parent.frames.length){
d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
}
if(!(x=d[n])&&d.all) x=d.all[n];
for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
return x;
}
function MM_showHideLayers(){
var i,p,v,obj,args=MM_showHideLayers.arguments;
for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
obj.visibility=v; }
}
function MM_initTimelines() {
var ns = navigator.appName == "Netscape";
d.Time = new Array(4);
d.Time[0] = new Array(2);
d.Time["flk1"] = d.Time[0];
d.Time[0].MM_Name = "flk1";
d.Time[0].fps = 8;
d.Time[0][0] = new String("sprite");
d.Time[0][0].slot = 1;
if (ns)
d.Time[0][0].obj = d["L3"];
else
d.Time[0][0].obj = d.all ? d.all["L3"] : null;
d.Time[0][0].keyFrames = new Array(19, 20, 26, 33, 38, 43, 46, 54, 57, 69, 83, 96);
d.Time[0][0].values = new Array(2);
d.Time[0][0].values[0] = new Array(186,186,190,196,202,210,217,224,229,235,241,246,251,256,259,262,263,262,261,260,258,256,253,250,247,242,237,234,233,233,232,232,232,231,231,230,225,219,218,219,221,222,224,227,229,232,235,238,241,244,247,249,252,254,257,260,263,266,268,271,273,276,277,279,280,281,281,281,280,280,279,278,277,276,274,273,272,271);
d.Time[0][0].values[0].prop = "left";
d.Time[0][0].values[1] = new Array(-41,-34,-30,-26,-21,-15,-9,-2,3,9,14,20,26,33,40,51,62,74,84,95,105,115,124,132,139,146,151,160,167,175,184,193,203,212,220,228,238,244,259,267,275,284,294,304,315,327,338,350,361,373,384,392,400,408,416,424,432,439,447,455,463,471,480,488,497,507,517,527,537,548,558,569,579,590,600,611,621,632);
d.Time[0][0].values[1].prop = "top";
if (!ns) {
d.Time[0][0].values[0].prop2 = "style";
d.Time[0][0].values[1].prop2 = "style";
}
d.Time[0][1] = new String("behavior");
d.Time[0][1].frame = 96;
d.Time[0][1].value = "MM_showHideLayers('L1','','hide')";
d.Time[0].lastFrame = 96;
d.Time[1] = new Array(2);
d.Time["flk2"] = d.Time[1];
d.Time[1].MM_Name = "flk2";
d.Time[1].fps = 8;
d.Time[1][0] = new String("sprite");
d.Time[1][0].slot = 1;
if (ns)
d.Time[1][0].obj = d["L2"];
else
d.Time[1][0].obj = d.all ? d.all["L2"] : null;
d.Time[1][0].keyFrames = new Array(1, 13, 18, 35, 45, 51, 53, 54, 83, 95);
d.Time[1][0].values = new Array(2);
d.Time[1][0].values[0] = new Array(389,391,394,396,399,401,404,406,408,410,411,412,413,412,408,403,399,396,395,395,394,394,394,393,393,393,393,392,392,392,391,391,390,389,388,386,383,379,376,372,369,366,363,360,358,356,356,357,358,359,359,357,355,349,350,352,354,355,357,359,361,363,366,368,370,373,376,378,381,384,387,390,392,395,398,400,402,405,407,409,412,414,416,419,422,425,427,430,432,434,437,440,443,445,448);
d.Time[1][0].values[0].prop = "left";
d.Time[1][0].values[1] = new Array(-44,-38,-33,-27,-22,-16,-10,-5,1,6,11,16,21,29,35,40,47,57,62,68,73,79,86,92,99,106,114,121,129,136,142,149,156,162,168,176,184,191,197,203,209,214,219,224,229,236,243,249,254,258,263,273,283,315,321,327,334,340,347,354,362,370,378,386,394,403,413,422,432,442,452,461,470,479,487,495,503,511,518,526,533,539,546,556,564,570,576,581,586,590,595,599,603,608,612);
d.Time[1][0].values[1].prop = "top";
if (!ns) {
d.Time[1][0].values[0].prop2 = "style";
d.Time[1][0].values[1].prop2 = "style";
}
d.Time[1][1] = new String("behavior");
d.Time[1][1].frame = 95;
d.Time[1][1].value = "MM_showHideLayers('L2','','hide')";
d.Time[1].lastFrame = 95;
d.Time[2] = new Array(2);
d.Time["flk3"] = d.Time[2];
d.Time[2].MM_Name = "flk3";
d.Time[2].fps = 8;
d.Time[2][0] = new String("sprite");
d.Time[2][0].slot = 1;
if (ns)
d.Time[2][0].obj = d["L4"];
else
d.Time[2][0].obj = d.all ? d.all["L4"] : null;
d.Time[2][0].keyFrames = new Array(45, 52, 59, 64, 68, 72, 77, 81, 84, 94, 99);
d.Time[2][0].values = new Array(2);
d.Time[2][0].values[0] = new Array(532,535,539,543,546,549,551,552,551,548,545,541,538,535,534,536,540,544,548,551,551,549,546,545,546,548,549,549,546,542,537,532,529,528,528,529,529,527,524,525,527,529,532,536,539,543,547,550,552,554,555,554,552,549,547);
d.Time[2][0].values[0].prop = "left";
d.Time[2][0].values[1] = new Array(-42,-28,-14,1,15,29,43,56,69,81,92,103,114,124,134,147,158,168,178,188,200,212,224,236,250,265,279,294,305,315,325,335,345,359,372,385,397,409,419,436,445,455,466,478,490,504,516,529,540,552,570,586,601,616,631);
d.Time[2][0].values[1].prop = "top";
if (!ns) {
d.Time[2][0].values[0].prop2 = "style";
d.Time[2][0].values[1].prop2 = "style";
}
d.Time[2][1] = new String("behavior");
d.Time[2][1].frame = 99;
d.Time[2][1].value = "MM_showHideLayers('L1','','hide','L2','','hide','L3','','hide','L4','','hide')";
d.Time[2].lastFrame = 99;
d.Time[3] = new Array(2);
d.Time["flk4"] = d.Time[3];
d.Time[3].MM_Name = "flk4";
d.Time[3].fps = 8;
d.Time[3][0] = new String("sprite");
d.Time[3][0].slot = 1;
if (ns)
d.Time[3][0].obj = d["L1"];
else
d.Time[3][0].obj = d.all ? d.all["L1"] : null;
d.Time[3][0].keyFrames = new Array(49, 64, 67, 72, 78, 107, 117, 123, 142);
d.Time[3][0].values = new Array(2);
d.Time[3][0].values[0] = new Array(27,32,37,42,47,52,57,61,66,71,75,79,83,86,89,92,98,97,94,91,87,83,79,77,76,76,76,77,77,78,78,78,78,79,79,79,79,80,80,80,80,81,81,81,82,82,82,82,82,83,83,83,83,83,83,83,83,82,82,81,78,76,72,69,66,63,61,59,59,61,64,69,75,80,84,85,86,87,88,89,90,91,92,93,93,94,95,96,97,98,98,99,100,101);
d.Time[3][0].values[0].prop = "left";
d.Time[3][0].values[1] = new Array(-45,-38,-31,-24,-17,-10,-3,4,11,18,24,30,36,42,48,53,70,83,96,106,116,126,138,153,170,188,207,227,246,263,266,269,271,274,277,279,282,284,287,289,291,294,296,298,300,302,304,307,309,311,313,315,317,320,322,324,326,328,330,336,341,346,350,355,360,365,371,378,385,400,416,433,452,472,493,500,508,515,523,530,538,546,554,562,571,579,587,596,604,613,621,629,638,646);
d.Time[3][0].values[1].prop = "top";
if (!ns) {
d.Time[3][0].values[0].prop2 = "style";
d.Time[3][0].values[1].prop2 = "style";
}
d.Time[3][1] = new String("behavior");
d.Time[3][1].frame = 142;
d.Time[3][1].value = "MM_showHideLayers('L4','','hide')";
d.Time[3].lastFrame = 142;
for (i=0; i<d.Time.length; i++) {
d.Time[i].ID = null;
d.Time[i].curFrame = 0;
d.Time[i].delay = 1000/d.Time[i].fps;
}
}
TP('flk1');
TP('flk2');
TP('flk3');
TP('flk4');
</script>
-->
</body>
</html>

<% 

End If

%>