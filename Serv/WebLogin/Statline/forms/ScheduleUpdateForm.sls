 <%Option Explicit
 
Response.CacheControl = "no-cache" 
Response.AddHeader "Cache-Control", "private" 
Response.AddHeader "Pragma", "no-cache" 
Response.Expires = -1 

 %>

<html>

<head>
<meta http-equiv="Expires" content="now">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Schedule Update</title>
</head>

<body bgcolor="#F5EBDD">
<!-- Include any files here Response.Write("All Times " & ZoneName(vTZ)) -->

<!--#include virtual="/loginstatline/includes/TimeZoneProcess.vbs"-->
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
 
<%	

Dim FontNameHead
Dim FontSizeHead
Dim FontNameData
Dim FontSizeData

Dim pvStartDate
Dim pvEndDate
Dim vUserID
Dim vUserName
Dim pvUserOrgID
Dim vUserOrgName
Dim vScheduleItemID
Dim vReportGroupID
Dim vUpdateApproachInfo
Dim ScheduleItemPersons
Dim SchedulePersonList


Dim ConsentToUpdate
Dim RecoveryToUpdate

Dim RS1
Dim vValue
Dim i
Dim vTZ
Dim WhileCounter
Dim ForLoopCounter
Dim ForLoopCounter1
Dim ForLoopCounter2
Dim WhileLoopCounter
Dim MaxPriority
Dim PersonExists
Dim OrganizationName 
Dim ScheduleGroupName                                   
Dim PersonID    
Dim ScheduleItemID 
Dim Priority 
Dim ScheduleGroupID 
Dim ScheduleItemName 
Dim pvScheduleGroupID

'Font Constants
FontNameHead = "Arial"
FontSizeHead = "2"
FontNameData = "Times New Roman"
FontSizeData = "3"

Call FixQueryString(Request.QueryString("StartDate"), pvStartDate)
Call FixQueryString(Request.QueryString("EndDate"), pvEndDate)
vUserID = Request.QueryString("UserID")
pvUserOrgID = Request.QueryString("UserOrgID")
vReportGroupID = Request.QueryString("ReportGroupID")
vScheduleItemID = Request.QueryString("ScheduleItemID")
pvScheduleGroupID = Request.QueryString("ScheduleGroupID")

'Execute the main page generating routine
If AuthorizeMain Then

'Open Connection
DataSourceName = TRANSACTIONDSN
Set Conn = server.CreateObject("ADODB.Connection")
Conn.Open DataSourceName, DBUSER, DBPWD


'Get the user's time zone
vQuery = "sps_OrganizationTimeZone " & pvUserOrgID
Set RS = Conn.Execute(vQuery)
vTZ = RS("OrganizationTimeZone")
Set RS = Nothing

'Get the user name
vQuery = "sps_WebPerson " & vUserID
Set RS = Conn.Execute(vQuery)
vUserName = RS("PersonFirst") & " " & RS("PersonLast")
Set RS = Nothing
%>


<!-- Pending Referrals Table -->
<form name="UpdateScheduleForm"
    action="<%=strHttpHeader & Request.ServerVariables("SERVER_NAME")%>/loginstatline/forms/ProcessSchedule.sls"
    method="POST">

<%'List the hidden fields%>   
<input type="hidden" name="DataSourceName" value=<%=DataSourceName%>>

<input type="hidden" name="ScheduleItemID" value=<%=vScheduleItemID%>>
<input type="hidden" name="UserName" value="<%=vUserName%>">
<input type="hidden" name="UserOrgID" value=<%=Request.QueryString("UserOrgID")%>>
<input type="hidden" name="UserID" value=<%=vUserID%>>
<input type="hidden" name="TZ" value=<%=vTZ%>>
    
<!-- Begin Header -->
<table  border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td ALIGN=LEFT width="85"><img src="/loginstatline/images/logo1.gif" width="60" height="60"></td>
		<td ALIGN=LEFT width="61%" valign="CENTER"><font size="5" face="Arial Black"><b>Schedule Update</b></font>			<br>
			<font size="2" face="<%=FontNameData%>">
			<%	Response.Write("All Times " & ZoneName(vTZ)) %>
			</font>
			</br>
		</td>
		<td width="85" align="LEFT">
			<%=GetLogoScheduleGroup(pvScheduleGroupID)%>
		</td>    	

		
	</tr>
</table>	
<table border="0" cellpadding="0" cellspacing="0">
	
	<tr>
		<td>&nbsp;</td>
	</tr>
	
	<tr>
	
		<td width="25">
			<A	HREF="javascript:document.UpdateScheduleForm.submit();" NAME="Save">
				<IMG src="/loginstatline/images/submit2.gif"
				NAME="Save"
				BORDER="0">
			</A>		
		</td>
		<td>&nbsp;&nbsp;</td>	
		<td width="25">
			<A	HREF="javascript:self.close();" NAME="Cancel">
				<IMG src="/loginstatline/images/cancel2.gif"
				NAME="Cancel"
				BORDER="0">
			</A>			
		</td>
	</tr>
</table>

<br>
<img src="/loginstatline/images/redline.gif" height="2" width="100%">
<!-- End Header -->

<!-- Get  Data -->

<%
'Get data rows
'sps_ScheduleItemPersons, @vScheduleItemID, @pvUserOrgID,@vTZ
vQuery = "sps_ScheduleItemPersons " & vScheduleItemID & ", " & Request.QueryString("UserOrgID")  & ", " & vTZ
'Response.Write vQuery
Set RS = Conn.Execute(vQuery)

If RS.EOF = True Then
%>
<%=vQuery%><br>
<p><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b><%Response.Write("No Schedule Available.")%></b><font></p>

<%
Else
	ScheduleItemPersons = RS.GetRows
	SET RS = Nothing

	'Get the PersonList
	
	vQuery = "sps_SchedulePersonList " & ScheduleItemPersons(5,0) 'RS("ScheduleGroupID")
	'Response.Write vQuery
	Set RS1 = Conn.Execute(vQuery)	
	SchedulePersonList = RS1.GetRows
	Set RS1 = Nothing

	'ScheduleItemPersons
	'0. OrganizationName 
	'1. ScheduleGroupName                                   
	'2. PersonID    
	'3. ScheduleItemID 
	'4. Priority 
	'5. ScheduleGroupID 
	'6. ScheduleItemName 
	'7. Start                       
	'8. End                         
	'9. PersonFirst                                        
	'10. PersonLast


%>
	

	<!-- Format Data -->
	<BR>
	<table border="0" cellpadding="0" cellspacing="2">	

		<tr>
			<td ALIGN=LEFT VALIGN=CENTER width="150"><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Schedule Organization:</b></font>
			</td>
			<td>&nbsp</td>
		    <td ALIGN=LEFT VALIGN=CENTER width="200"><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>">				
		    <%=ScheduleItemPersons(0,0)%></FONT>
			</td>
    	</tr>
		<tr>
			<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Schedule Group: &nbsp</b></font></td>
		    <td>&nbsp</td>
		    <td ALIGN=LEFT VALIGN=CENTER><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ScheduleItemPersons(1,0)%></FONT></td>
		
		</tr>		
		<tr>
			<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Schedule Name: &nbsp</b></font></td>
		    <td>&nbsp</td>
		    <td ALIGN=LEFT VALIGN=CENTER><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=UCase(Left(ScheduleItemPersons(6,0),1)) & LCase(Right(ScheduleItemPersons(6,0),Len(ScheduleItemPersons(6,0))-1))%></FONT></td>
		</tr>		
		<tr>
			<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>Start: &nbsp</b></font></td>
		    <td>&nbsp</td>
		    <td ALIGN=LEFT VALIGN=CENTER><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ScheduleItemPersons(7,0)%></FONT></td>
		    
		</tr>		
		<tr>
			<td ALIGN=LEFT VALIGN=CENTER><font size="<%=FontSizeHead%>" face="<%=FontNameHead%>"><b>End: &nbsp</b></font></td>
		    <td>&nbsp</td>
		    <td ALIGN=LEFT VALIGN=CENTER><FONT FACE="<%=FontNameData%>" SIZE="<%=FontSizeData%>"><%=ScheduleItemPersons(8,0)%></FONT></td>

		</tr>		

	</table>
	</BR>
				
	<BR>
	
	<%
	'Build the options table
		
		MaxPriority = 0
		For ForLoopCounter=0 to Ubound(ScheduleItemPersons,2)
			If ScheduleItemPersons(4,ForLoopCounter)> MaxPriority Then
				MaxPriority = ScheduleItemPersons(4,ForLoopCounter)
			End If
		Next
		
		OrganizationName	= ScheduleItemPersons(0,0)
		ScheduleGroupName	= ScheduleItemPersons(1,0)                                 
		ScheduleItemID		= ScheduleItemPersons(3,0)  
		ScheduleGroupID		= ScheduleItemPersons(5,0)
		ScheduleItemName	= ScheduleItemPersons(6,0)
		pvStartDate			= ScheduleItemPersons(7,0)
		pvEndDate			= ScheduleItemPersons(8,0) 
	
		ScheduleItemPersons = RebuildArray(ScheduleItemPersons, MaxPriority)		
					
	%>
	
	
	<table border="1" cellpadding="2" cellspacing="1" width="200">
	
		<input type="hidden" name="ScheduleGroupID" value=<%=ScheduleItemPersons(5,0)%>>
		<input type="hidden" name="StartShift" value="<%=ScheduleItemPersons(7,0)%>">
		<input type="hidden" name="EndShift" value="<%=ScheduleItemPersons(8,0)%>">
		
		
		<% For ForLoopCounter = 0 to MaxPriority - 1
		%>						
		
					<TR> 
					    <td width="80" ALIGN=LEFT VALIGN=TOP NOWRAP>
							<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>	
							On Call &nbsp <%=ScheduleItemPersons(4,ForLoopCounter) %>
							</b></Font>
					    </td>
					    
					    <td width="180" ALIGN=LEFT VALIGN=TOP NOWRAP>
							<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>	
							
							<SELECT NAME="NewOnCall<%=ScheduleItemPersons(4,ForLoopCounter) %>" >
											
										<option value=<%=ScheduleItemPersons(2,ForLoopCounter)%> selected ><%=ScheduleItemPersons(9,ForLoopCounter) & " " & ScheduleItemPersons(10,ForLoopCounter)%>  </option>
															
								<%For ForLoopCounter1 = 0 to Ubound(SchedulePersonList,2)%>
									<option value= <%=SchedulePersonList(0, ForLoopCounter1)%> ><%=SchedulePersonList(1, ForLoopCounter1)%>  </option>
								<%Next%>
									<option value=0 >&nbsp </option>
							</SELECT>
									<input type="hidden" name="CurrentOnCall<%=ScheduleItemPersons(4,ForLoopCounter)%>" value=<%=ScheduleItemPersons(2,ForLoopCounter)%>>
							</b></Font>
					    </td>
    					
					</tr>
			
		<%			

		Next 
			'Display Final Oncall Person selection box
		%>		
		
				
<%
	dim vNum
'response.write("MaxPriority = " & MaxPriority)
	select case MaxPriority
		case 10, 11, 12, 13, 14
			vNum = 14 - MaxPriority
		case 15, 16, 17, 18, 19
			vNum = 19 - MaxPriority
		case 20, 21, 22, 23, 24
			vNum = 24 - MaxPriority
		case else
			vNum = 9 - MaxPriority
	end select
'response.write("<br>vNum = " & vNum)	
		for i = 0 to vNum
			if i > 0 then
				MaxPriority = MaxPriority + 1
			end if
%>
		<TR> 
		            <td width="80" ALIGN=LEFT VALIGN=TOP NOWRAP>
						<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>	
						On Call &nbsp <%=MaxPriority + 1 %>
						</b></Font>
		            </td>
		            
		            <td width="180" ALIGN=LEFT VALIGN=TOP NOWRAP>
						<FONT FACE="<%=FontNameHead%>" SIZE="<%=FontSizeHead%>"><b>	
						<SELECT NAME="NewOnCall<%=MaxPriority + 1 %>" >
								<option value=0 selected ></option>
							<%For ForLoopCounter = 0 to Ubound(SchedulePersonList,2)%>
								<option value= <%=SchedulePersonList(0, ForLoopCounter)%> ><%=SchedulePersonList(1, ForLoopCounter)%>  </option>
							<%Next%>
						</SELECT>
							<input type="hidden" name="CurrentOnCall<%=MaxPriority + 1%>" value=0>
						</b></Font>
		            </td>
		    		
		
		
		</tr>
<%
		next
%>

		<% 'Response.Write ("MaxPriority" & MaxPriority) %>
		<input type="hidden" name="MaxPriority" value=<%=MaxPriority %>>
	</table>

</form>

</BODY>
</HTML>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
<%
End If

Set RS = Nothing
Set Conn = Nothing

End If

Function RebuildArray(GivenArray, MaxPriority)

	ReDim NewArray(10,MaxPriority)
			
	'loop through the given array assigning the given data to NewArray based on the Priority of the data given.
	'In some cases there is not a oncall person or a priorit 1 through x. The first value might not start until priority
	'5.  This loop places the given data in the appropriate on call slot.
	
	For ForLoopCounter = 0 to Ubound(GivenArray,2)
		For ForLoopCounter1 = 0 to Ubound(NewArray,1)
			IF GivenArray(4,ForLoopCounter) = 0 Then
				NewArray(ForLoopCounter1, GivenArray(4,ForLoopCounter)) = GivenArray(ForLoopCounter1, ForLoopCounter)
			Else
				NewArray(ForLoopCounter1, GivenArray(4,ForLoopCounter)-1) = GivenArray(ForLoopCounter1, ForLoopCounter)
			End If					
		Next
	Next
	
	'Reset the priority from 1 to the given MaxPriority.
	For ForLoopCounter = 0 to Ubound(NewArray,2)
		If IsEmpty(NewArray(4, ForLoopCounter)) Then
			NewArray(4, ForLoopCounter) = ForLoopcounter + 1
		End If
	
	Next
	
	'If an oncall person does not exists set the ids to 0 
	For ForLoopCounter = 0 to Ubound(NewArray,2)
		For ForLoopCounter1 = 2 to 5
			IF IsEmpty(NewArray(0, ForLoopCounter)) Then
				NewArray(0, ForLoopCounter) = OrganizationName
				NewArray(1, ForLoopCounter) = ScheduleGroupName
				NewArray(2, ForLoopCounter) = 0
				NewArray(3, ForLoopCounter) = ScheduleItemID
				NewArray(5, ForLoopCounter) = ScheduleGroupID
				NewArray(6, ForLoopCounter) = ScheduleItemName
				NewArray(7, ForLoopCounter) = pvStartDate
				NewArray(8, ForLoopCounter) = pvEndDate
			End IF
		Next
	Next


	RebuildArray = NewArray
	
End Function
Sub FixQueryString(pvIn, pvOut)
	
	Dim x
	
	pvOut = ""
	For x=1 TO Len(pvIn)
		If Mid(pvIn,x,1) = "_" Then
			pvOut = pvOut & " "
		Else
			pvOut = pvOut & Mid(pvIn,x,1)
		End If
	Next
End Sub
%>

<script language="JavaScript">
	
	function getCookie(Name) 
	{
	   var search = Name + "="
	
	   if (document.cookie.length > 0) 
	   { // if there are any cookies
	   
	      offset = document.cookie.indexOf(search) 
	      
	      if (offset != -1) 
	      { // if cookie exists 
	      
	         offset += search.length 
	         
	         // set index of beginning of value
	         end = document.cookie.indexOf(";", offset) 
	         
	         // set index of end of cookie value
	         if (end == -1) 
	            end = document.cookie.length
	            
	         return unescape(document.cookie.substring(offset, end))
	
	      } 
	   }
	}
	
	// Sets cookie values. Expiration date is optional
	//
	function setCookie(name, value, expire) 
	{
		if (value == null)
		{
			value = ""
		}
		
		document.cookie = name + "=" + escape(value) + ((expire == null) ? "" : ("; expires=" + expire.toGMTString()))
	}
	
	function doNothing() 
	{
	}
	
</script>