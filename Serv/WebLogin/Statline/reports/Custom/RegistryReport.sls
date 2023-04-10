
<% 
Option Explicit

Dim DataWarehouseConn
Dim pvStartDate
Dim pvEndDate

Dim pvSSN
Dim pvDLN
Dim pvLastName
Dim pvDOB
Dim pvUserOrg
Dim pvUserID
Dim pvDSN

Dim RS1

Dim vErrorMsg

Dim x
Dim i

Dim FontNameHead
Dim FontNameData

Dim vReportTitle
Dim vMainTitle
Dim vTitlePeriod
Dim vTitleTo
Dim vTitleTimes

FontNameHead = "Arial"
FontNameData = "Times New Roman"


%>



<!--#include virtual="/loginstatline/includes/Authorize.sls"--> 


<html>	
<head>
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<title>Louisiana Donor Registry</title>
<STYLE MEDIA=ALL >
	H1 {page-break-after: always}
</STYLE >
</head>
<BODY bgcolor="#F5EBDD" topmargin=24 leftmargin=24 rightmargin=24 bottommargin=24>



<P align=left>
	<STRONG>Louisiana Donor Registry</STRONG>
	<BR>P.O. Box 8468
	<BR>Metairie, LA 70011-8468
</P>
		
<%
Call Process
Set RS = Nothing
Set RS1 = Nothing
Set Conn = Nothing
Set DataWarehouseConn = Nothing

Function Process

'Execute the main page generating routine
If AuthorizeMain Then

	Set DataWarehouseConn = server.CreateObject("ADODB.Connection")
	DataWarehouseConn.Open WAREHOUSEDSN, DBUSER, DBPWD	'drh 1/6/04 - Un-hardcoded DSN
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD	'drh 1/6/04 - Un-hardcoded User/Pwd

	'Get the query variables
	pvUserOrg = FormatNumber(Request.QueryString("UserOrgID"),0,,0,0)
	pvUserID = FormatNumber(Request.QueryString("UserID"),0,,0,0)
	pvDSN = Request.QueryString("DSN")
	
	pvSSN = Request.QueryString("SSN")
	pvDLN = Request.QueryString("DLN")
	pvLastName = Request.QueryString("LastName")
	pvDOB = Request.QueryString("DOB")
	
	'Verify the requesting organization if it not Statline
	If pvUserOrg <> 194 then
		
		vQuery = "sps_OrganizationName " & pvUserOrg
		Set RS = Conn.Execute(vQuery)
		
		If RS.EOF = True Then
			vErrorMsg = "<FONT SIZE=4 FACE=Arial FONT COLOR = Red><B>"
			vErrorMsg = vErrorMsg & "The organization attempting to run this report does not exist. <BR> <BR>"
			vErrorMsg = vErrorMsg & "If you continue to have difficulty, <BR>"
			vErrorMsg = vErrorMsg & "Please contact Statline at (888) 881-7828 for assistance.</B> <BR> <BR> <BR>"
			vErrorMsg = vErrorMsg & "<FONT SIZE=1 FACE=Arial FONT COLOR = Black>"
			vErrorMsg = vErrorMsg & "Error:     (100, Org.IdentifyOrganization, Activity.sls) <BR> <BR>"
			vErrorMsg = vErrorMsg & "</FONT></FONT>"
			Response.Write(vErrorMsg)		
		End If
		
		Set RS = Nothing	

	End If
		
	
	'Get the registry report count
	If pvDOB = "" Then
		vQuery = "sps_RegistryLookupCount '" & pvSSN & "', '" & pvDLN & "', '" & pvLastName & "'"
	Else
		vQuery = "sps_RegistryLookupCount '" & pvSSN & "', '" & pvDLN & "', '" & pvLastName & "', '" & pvDOB & "' "
	End If
	
	Set RS = DataWarehouseConn.Execute(vQuery)
	
	If RS.EOF <> True Then
		If RS("RecordCount") > 1 Then
			'Get the registry report
			If pvDOB = "" Then
				vQuery = "sps_RegistryLookup '" & pvSSN & "', '" & pvDLN & "', '" & pvLastName & "'"
			Else
				vQuery = "sps_RegistryLookup '" & pvSSN & "', '" & pvDLN & "', '" & pvLastName & "', '" & pvDOB & "' "
			End If
	
			'Response.Write vQuery
			Set RS = DataWarehouseConn.Execute(vQuery)		
			Call FormatList
			Exit Function
		ElseIf RS("RecordCount") = 0 Then
			'Response.Write(vQuery)
			Response.Write("<font color=red>No records found for the criteria.</font>")
			Exit Function
		End If
	Else
		Response.Write("<font color=red>No records found for the criteria.</font>")
		Exit Function
	End If
		
	'Get the registry report
	If pvDOB = "" Then
		vQuery = "sps_RegistryLookup '" & pvSSN & "', '" & pvDLN & "', '" & pvLastName & "'"
	Else
		vQuery = "sps_RegistryLookup '" & pvSSN & "', '" & pvDLN & "', '" & pvLastName & "', '" & pvDOB & "' "
	End If
	
	'Response.Write vQuery
	Set RS = DataWarehouseConn.Execute(vQuery)
	
%>

<!-- begin report -->

<p>
<FONT face=FontNameData size=2>This individual has indicated a desire to donate by stating YES to organ donation with the DMV office.
</FONT>
</p>

<Table BORDER=0 cellpadding=3 cellSpacing="0">
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Name:
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS("First") & " " & RS("Middle") & " " & RS("Last") & " " & RS("Suffix")%>
			</FONT>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Address:
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS("Addr1") & " " & RS("Addr2")%>
			</FONT>
		</TD>
	</TR>
		
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>&nbsp
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS("City") & ", " & RS("State") & " " & RS("Zip1") & "-" & RS("Zip2")%>
			</FONT>
		</TD>
	</TR>
			

	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>SSN
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS("SSN")%>
			</FONT>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Driver's License #
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS("License")%>
			</FONT>
		</TD>
	</TR>

	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Date of Birth
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS("DOB")%>
			</FONT>
		</TD>
	</TR>
				
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>&nbsp
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2>&nbsp
			</FONT>
		</TD>
	</TR>		
	
<%	
	'Check to see if there is a donor registration form on file.
	vQuery = "sps_RegistryDonorLookup '" & RS("SSN") & "'"
	
	Set RS1 = DataWarehouseConn.Execute(vQuery)
	
	If RS1.EOF = True Then
		Response.Write("</TABLE><FONT face=FontNameData size=2 color=red>NO DONOR REGISTRATION FORM ON FILE.</font></BODY></HTML>")
		Exit Function
	End If
%>
					
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2 color=red>Consented To
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2 color=red><%=RS1("Consented")%>
			</FONT>
		</TD>
	</TR>	
		
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Purpose
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2>
			<%SELECT CASE RS1("Purpose") 
				CASE "T" 
					Response.Write("Transplant") 
				CASE "R" 
					Response.Write("Research") 
				CASE "B" 
					Response.Write("Transplant, Research") 
			END SELECT%>
			</FONT>
		</TD>
	</TR>
									
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Special Wishes
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS1("Wishes")%>
			</FONT>
		</TD>
	</TR>							
			
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Emergency Contact
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS1("EContact1") & " " & RS1("EContact2")%>
			</FONT>
		</TD>
	</TR>
				
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>Scanned
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS1("Scandate")%>
			</FONT>
		</TD>
	</TR>	

	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>DMV Tape Match
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS1("Matcdate")%>
			</FONT>
		</TD>
	</TR>	
					
	<TR>
		<TD WIDTH="120">
			<FONT face=FontNameData size=2>ID Mailed
			</FONT>
		</TD>
		<TD>
			<FONT face=FontNameData size=2><%=RS1("Iddate")%>
			</FONT>
		</TD>
	</TR>
										
</TABLE>	


	
<%
End If

End Function

Function FormatList
%>

	<p>
	<FONT face=FontNameData size=2 color=red>There is more than one record matching the selection criteria.
	</FONT>
	</p>

	<Table BORDER=0 cellpadding=0 cellSpacing="0">

		<TR>
			<TD WIDTH="200">
				<FONT face=FontNameData size=2><u><b>Name</b></u></FONT>
			</TD>
			<TD WIDTH="100">
				<FONT face=FontNameData size=2><u><b>SSN</b></u></FONT>
			</TD>		
			<TD WIDTH="100">
				<FONT face=FontNameData size=2><u><b>License</b></u></FONT>
			</TD>	
			<TD WIDTH="100">
				<FONT face=FontNameData size=2><u><b>DOB</b></u></FONT>
			</TD>								
		</TR>
				
		<%Do While RS.EOF <> True%>

			<TR>
				<TD WIDTH="200">
					<a href="/loginstatline/reports/custom/registryreport.sls?SSN=<%=RS("SSN")%>&DLN=<%=RS("License")%>&LastName=<%=RS("Last")%>&DOB=<%=RS("DOB")%>&userID=<%=pvUserID%>&userOrgID=<%=pvUserOrg%>&DSN=<%=pvDSN%>">
					<FONT face=FontNameData size=2><%=RS("First") & " " & RS("Middle") & " " & RS("Last") & " " & RS("Suffix")%></FONT>
					</a>
				</TD>
				<TD WIDTH="100">
					<FONT face=FontNameData size=2><%=RS("SSN")%></FONT>
				</TD>		
				<TD WIDTH="100">
					<FONT face=FontNameData size=2><%=RS("License")%></FONT>
				</TD>	
				<TD WIDTH="100">
					<FONT face=FontNameData size=2><%=RS("DOB")%></FONT>
				</TD>								
			</TR>
			
		<%RS.MoveNext%>
		<%Loop%>
		
	</Table>
<%
End Function
%>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
	

