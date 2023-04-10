<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
</HEAD>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<BODY bgcolor="#F5EBDD">

<table align="left" border="0" cellPadding="0" cellSpacing="0" style="WIDTH: 550px"
	width="550" bgColor="#112084">
	<tr>
		<td width="540"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Downloads</b></font></td>
	</tr>
  </table>

<p>&nbsp;</p>
<p><A HREF="javascript:alert('To download a file, right-click on the file; then choose Save Target As.')"><font size=2 face=Arial>Download Instructions</Font></A></p>

<%
	dim vUserOrgId
	dim vDSN
	dim vPath
	dim fso
	dim folder
	dim f1
	dim ff1
	dim fc
	dim ffc
	dim srcCode
	dim vPercent
	dim vQuote

	'Set module-level variables
	vDSN = Request.QueryString("DSN")
	vUserOrgId = Request.QueryString("UserOrgID")
	Set Conn = server.CreateObject("ADODB.Connection")
	Set fso = CreateObject("Scripting.FileSystemObject")
	vPercent = chr(37)
	vQuote = chr(34)

%>

<%

	'Get Organization Name
	Conn.Open vDSN, DBUSER, DBPWD
	vQuery = "SELECT OrganizationName FROM Organization WHERE OrganizationID = " & vUserOrgId
	Set RS = Conn.Execute(vQuery)
	If Not RS.EOF then
		Response.Write("<font size=3 face=Arial><B>" & RS("OrganizationName") & "</B></FONT>")
	End If
	Set RS = Nothing

	'Get raw directory path
	vQuery = "SELECT ExportFileDirectoryPath FROM ExportFile "
	vQuery = vQuery & "WHERE OrganizationID = " & vUserOrgId

	'Response.Write(vQuery)	'Remove this statement
	Set RS = Conn.Execute(vQuery)

	If Not RS.EOF then
		vPath = RS("ExportFileDirectoryPath")
	End If
	'Response.Write(vPath)	'Remove this statement
	Set RS = Nothing

	'Get folder for this agency
	If vPath <> "" Then
		if InStrRev(vPath, "\") <> 0 then
			vAgencyFolder = Right(vPath, Len(vPath) - InStrRev(vPath, "\"))
		end if
	End If
	'Response.Write("><BR>" & vAgencyFolder & "<BR><")	'Remove this statement

	Set folder = fso.GetFolder("\\st-statweb\ftproot\" & vAgencyFolder)

	'Display files from folder
	if vUserOrgId = 194 then
		Response.Write("<TABLE border=1 cellPadding=1 cellSpacing=1 width=30" & vPercent & ">")
		Response.Write("<TR><TD width=100><font size=2 face=Arial><B>File Name</B></Font></TD>")
		Response.Write("<TD width=100><font size=2 face=Arial><B>File Date</B></Font></TD></TR>")

		Set ffc = folder.SubFolders
		if ffc.count > 0 then
			For Each ff1 in ffc
			vAgencyFolder = Right(ff1, Len(ff1) - InStrRev(ff1, "\"))
				Response.Write("<TR><TD width=200 colspan=2><font size=2 face=Arial><B><U>Organization: " & ff1.name & "</U></B></Font></TD>")

				Set fc = ff1.Files
				if fc.count > 0 then
					For Each f1 in fc
					If InStr(f1.name, "#") = 0 and InStr(f1.name, " ") = 0 Then
						Response.Write("<TR><TD width=100><font size=2 face=Arial><A href=" & vQuote & "../webftp/" & vAgencyFolder & "/" & f1.name & vQuote & ">" & f1.name & "</A></Font></TD>")
						Response.Write("<TD width=100><font size=2 face=Arial>" & datePart("m", f1.datelastmodified) & "/" & datePart("d", f1.datelastmodified) & "/" & datePart("yyyy", f1.datelastmodified) & "</Font></TD></TR>")
					End If
					Next
				end if
			Next
		end if

		Response.Write("</TABLE>")
	else
		Set fc = folder.Files
		if fc.count > 0 then
			Response.Write("<TABLE border=1 cellPadding=1 cellSpacing=1 width=30" & vPercent & ">")
			Response.Write("<TR><TD width=100><font size=2 face=Arial><B>File Name</B></Font></TD>")
			Response.Write("<TD width=100><font size=2 face=Arial><B>File Date</B></Font></TD></TR>")

			For Each f1 in fc
				If InStr(f1.name, "#") = 0 and InStr(f1.name, " ") = 0 Then
					Response.Write("<TR><TD width=100><font size=2 face=Arial><A href=" & vQuote & "../webftp/" & vAgencyFolder & "/" & f1.name & vQuote & ">" & f1.name & "</A></Font></TD>")
					Response.Write("<TD width=100><font size=2 face=Arial>" & datePart("m", f1.datelastmodified) & "/" & datePart("d", f1.datelastmodified) & "/" & datePart("yyyy", f1.datelastmodified) & "</Font></TD></TR>")
				End If
			Next

			Response.Write("</TABLE>")
		else
			Response.Write("<BR><BR><font size=2 face=Arial><B>Currently, there are no files to download.</B></Font>")
		end if
	end if
%>
  </P>
<%

%>
</BODY>
</HTML>

