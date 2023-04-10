<%
Option Explicit


'**************************************************************************************
'LifeBreach.sls
'Summary: This page is for the Life Breach Program. This Administration page maintains
'					two tables (LifeBreachEmail and StagingLifeBreach) LifeBreachEmail contains all the participating
'					organizations and email addresses. StagingLifeBreach contains all the emails that will be sent to
' 				the participating organizations.
'Tables: StagingLifeBreach, LifeBreachEmail 
'Stored Procs: sps_LifeBreach, spi_lifeBreach
'**************************************************************************************

Dim UserName									'User login name
Dim pvStartDate								'Start Date
Dim pvEndDate									'End Date
Dim vErrorMsg									'Error message
Dim ErrorReturn								'Error Return
Dim PERMISSIONID							'Permissions
Dim cmdB											'Command prompt
Dim cmd2											'Command prompt
Dim TimeRepeat								'interval of time repeated
Dim TimeRepeatString					'interval of time repeated string	
Dim RSDel											'Recordset for deletion of records
Dim member										'object for deletion of records	
Dim Choices										'variable that holds deletion choices
Dim OrgName										'Organization name
Dim Personemail								'Email of person
Dim rsrec											'Recordset of clients
Dim RSperson									'individual record of client
Dim RSOrg											'Recordset of organizations	
Dim RSRep											'Recordset of Reps
Dim MasterReportGroupID				'Group ID of client organizations
Dim RSGroups 									'Recordset of Groups
Dim GroupName 								'MasterGroup Name
Dim RSEmails 									'Email Recordset
Dim Orgchoice 								'Organization choices
Dim RSIns											'Recordset for insertion of clients	
Dim PersonChoice							'Person added to recordset
Dim cmd												'Command object 
Dim RSREPORT									'Recordset Report 
Dim RSREPORTLOOP							'Recordset Loop 
Dim RSREPORTTYPE							'Recordset Reporttype 
Dim RSTimeRepeat							'Recordset Timeinterval
Dim vQ												'Query string

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%



If AuthorizeMain Then
   'Ready to update  
   'Verify Access
	 								
	 									
	 							
	 									'Recordset to get time intervals for programbreach
	 									Set RSTimeRepeat = Server.CreateObject("ADODB.Recordset")
																	Set cmd2 = Server.CreateObject("ADODB.Command")
																	cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																  vQ = "select Repeatmin, RepeatString from  LifeBreachEmail where ReportGroupMaster = "& userOrgID
																	cmd2.CommandText = vQ
																	Set RSTimeRepeat = cmd2.execute 												        	
													        TimeRepeat = RSTimeRepeat.Fields("Repeatmin")
	 																timeRepeatString = RSTimeRepeat.Fields("RepeatString")	 																	
	 									'Recordset to get life breach 								
	 									Set rsrec = Server.CreateObject("ADODB.Recordset")
	       													Set cmd2 = Server.CreateObject("ADODB.Command")
	       													cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
	       													vQ="sps_LifeBreach" 
	       													cmd2.CommandText = vQ  
	       													cmd2.CommandType = adCmdStoredProc
	       													cmd2.Parameters.Append cmd2.CreateParameter("@OrgID", adInteger, adParamInput)
	       													cmd2.Parameters("@OrgID").Value = UserOrgID
	       													Set rsrec = cmd2.execute								
									 'Recordset List of names
				       	   Set RSEmails = Server.CreateObject("ADODB.Recordset")
																		Set cmd2 = Server.CreateObject("ADODB.Command")
																		cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																		vQ = "SELECT Distinct Person.PersonFirst, WebPerson.WebpersonEmail, Person.PersonID, CASE WHEN Person.Inactive = 1 THEN Person.PersonFirst+' '+PersonLast + ' (Inactive)' ELSE Person.PersonFirst+' '+PersonLast END  AS Person, PersonType.PersonTypeName FROM Person JOIN Organization ON Organization.OrganizationID = Person.OrganizationID Join WebPerson ON person.personid = webperson.personid JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID WHERE Person.OrganizationID = " & userOrgID &" AND Person.Inactive = 0 ORDER BY PersonFirst"
																		cmd2.CommandText = vQ
																		Set RSEmails = cmd2.execute
				       	   'Recordset organizations
				       	   Set RSrep = Server.CreateObject("ADODB.Recordset")
																		Set cmd2 = Server.CreateObject("ADODB.Command")
																		cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																		vQ="sps_ReportGroupMaster " & UserOrgID
																		cmd2.CommandText  = vQ
																		Set RSrep = cmd2.execute
																
																						 			 
				       	  
		If Not RSrep.EOF Then
						MasterReportGroupID = RSrep("WebReportGroupID")
		Else
						MasterReportGroupID = 0
		End If
    Set RSrep = Nothing
		'response.write MasterReportGroupID		       	  																				
									'List of Hospitals ect..
									Set RSGroups = Server.CreateObject("ADODB.Recordset")
																		Set cmd2 = Server.CreateObject("ADODB.Command")
																		cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																		vQ = "sps_ReportGroupOrgs " & MasterReportGroupID
																		cmd2.CommandText  = vQ
																		Set RSGroups = cmd2.execute
																											
   IF Request.ServerVariables("REQUEST_METHOD") = "POST" then
          	'Recordset Get organization list
     	 			Set rsrec = Server.CreateObject("ADODB.Recordset")
								       							Set cmd2 = Server.CreateObject("ADODB.Command")
								       							cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
								       							vQ = "sps_LifeBreach" 
								       							cmd2.CommandText = vQ 
								       							cmd2.CommandType = adCmdStoredProc
								       							cmd2.Parameters.Append cmd2.CreateParameter("@OrgID", adInteger, adParamInput)
								       							cmd2.Parameters("@OrgID").Value = UserOrgID
								       							Set rsrec = cmd2.execute													       													
				 
				   set personChoice = (request("OrganizationEmail_"& UserOrgID))
				   set personEmail = (request("PersonID_" & personChoice))				   			      	
				   set orgchoice =  (request("OrganizationName_" & UserOrgID))				
				   set OrgName =  (request("OrganizationName_" & orgchoice))
				  				        
								  ' This is the code that keeps the state of the checkbox.
								  ' All it does is check to see if the value returned is
								  ' the same as the value parameter of the checkbox input
								  ' tag.  If so, the box was checked and we output the
								  ' input tag's "checked" attribute to keep it that way.
								 								  
					choices = Request.Form("state_keeper")								
					choices = Split(choices, ",")								
					For Each member in choices
									'Deletes each organization that has been checked							
									 Set RSDEL = Server.CreateObject("ADODB.Recordset")
																		Set cmd2 = Server.CreateObject("ADODB.Command")
																		cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																		vQ = "Delete From LifeBreachEmail where ID = " & Member
																		cmd2.CommandText = vQ																						 			 
																	  Set RSDEL = cmd2.execute
					Next
	       												 
     			If Orgchoice <> "" and PersonChoice<>"" then
					 Set RSIns = Server.CreateObject("ADODB.Recordset")
 																		Set cmd2 = Server.CreateObject("ADODB.Command")
 																		cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
 																		vQ = "SPI_LifeBreach"
 																		cmd2.CommandText = vQ
 																		cmd2.CommandType = adCmdStoredProc
 																		'cmd2.Parameters.Append cmd2.CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue)
 																		cmd2.Parameters.Append cmd2.CreateParameter("@ReportGroupMaster", adInteger, adParamInput)
 																		cmd2.Parameters.Append cmd2.CreateParameter("@OrganizationName", advarchar, adParamInput,100)
 																		cmd2.Parameters.Append cmd2.CreateParameter("@OrganizationID", adInteger, adParamInput)
 																		cmd2.Parameters.Append cmd2.CreateParameter("@PersonName", advarchar, adParamInput,100)
 																		cmd2.Parameters.Append cmd2.CreateParameter("@PersonID", adInteger, adParamInput)
 																		cmd2.Parameters.Append cmd2.CreateParameter("@EmailAddress", advarchar, adParamInput,100)
 																		'cmd2.Parameters.Append cmd2.CreateParameter("@Repeat", advarchar, adParamInput)
 																		cmd2.Parameters("@ReportGroupMaster").Value = userOrgID
 																		cmd2.Parameters("@OrganizationName").Value = OrgName
 																		cmd2.Parameters("@OrganizationID").Value = orgchoice'request("OrganizationName_" & orgchoice)
 																		cmd2.Parameters("@PersonName").Value = personChoice
 																		cmd2.Parameters("@PersonID").Value =0
 																		cmd2.Parameters("@emailAddress").Value = PersonEmail
 																		'cmd2.Parameters("@Repeatmin").Value ="Hithere"
								           					Set RSINS = cmd2.execute	
				end if
				'Update the time interval				           									
				Set RSTimeRepeat = Server.CreateObject("ADODB.Recordset")
																	Set cmd2 = Server.CreateObject("ADODB.Command")
																	cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																	vQ="update LifeBreachEmail set Repeatmin = " & "'" & (request("OrganizationRepeat"))& "'" &" where ReportGroupMaster = "& userOrgID
																	cmd2.CommandText = vQ
																	Set RSTimeRepeat = cmd2.execute
				'Get LifeBreach Organizations	        
				Set rsrec = Server.CreateObject("ADODB.Recordset")
								       							Set cmd2 = Server.CreateObject("ADODB.Command")
								       							cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
								       							vQ = "sps_LifeBreach"
								       							cmd2.CommandText = vQ  
								       							cmd2.CommandType = adCmdStoredProc
								       							cmd2.Parameters.Append cmd2.CreateParameter("@OrgID", adInteger, adParamInput)
								       							cmd2.Parameters("@OrgID").Value = UserOrgID
								       							Set rsrec = cmd2.execute										       							
		       													
				'List of names
				Set RSEmails = Server.CreateObject("ADODB.Recordset")
																Set cmd2 = Server.CreateObject("ADODB.Command")
																cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																vQ = "SELECT Distinct Person.PersonFirst, WebPerson.WebpersonEmail, Person.PersonID, CASE WHEN Person.Inactive = 1 THEN Person.PersonFirst+' '+PersonLast + ' (Inactive)' ELSE Person.PersonFirst+' '+PersonLast END  AS Person, PersonType.PersonTypeName FROM Person JOIN Organization ON Organization.OrganizationID = Person.OrganizationID Join WebPerson ON person.personid = webperson.personid JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID WHERE Person.OrganizationID = " & userOrgID &" AND Person.Inactive = 0 ORDER BY PersonFirst"
																cmd2.CommandText = vQ
																Set RSEmails = cmd2.execute  
															  
				choices = Request.Form("state_keeper")
				choices = Split(choices, ",")
				For Each member in choices			
					'Delete each organization that has been checked									
					Set RSDEL = Server.CreateObject("ADODB.Recordset")
																Set cmd2 = Server.CreateObject("ADODB.Command")
																cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
															  vQ="Delete From LifeBreachEmail where ID = " & Member
															  cmd2.CommandText = vQ
																Set RSDEL = cmd2.execute
				Next
					'Update the time interval											 
					Set RSTimeRepeat = Server.CreateObject("ADODB.Recordset")
																Set cmd2 = Server.CreateObject("ADODB.Command")
																cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																vQ="update LifeBreachEmail set Repeatmin = " & "'" & (request("OrganizationRepeat")) & "'" &  " where ReportGroupMaster = "& userOrgID
																cmd2.CommandText = vQ
																Set RSTimeRepeat = cmd2.execute 
					'Get list of organizations						    
	    		Set rsrec = Server.CreateObject("ADODB.Recordset")
											       							Set cmd2 = Server.CreateObject("ADODB.Command")
											       							cmd2.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
											       							vQ = "sps_LifeBreach"
											       							cmd2.CommandText = vQ  
											       							cmd2.CommandType = adCmdStoredProc
											       							cmd2.Parameters.Append cmd2.CreateParameter("@OrgID", adInteger, adParamInput)
											       							cmd2.Parameters("@OrgID").Value = UserOrgID
								       										Set rsrec = cmd2.execute	

     
   END IF
    
%>
<form action="LifeBreach.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="frmLifeBreach" method="post">
<%
'To refresh the page without caching
response.expires = -1
response.AddHeader "Pragma", "no-cache"
response.AddHeader "cache-control", "no-store"
%>

<html>
<head>
<title>LifeBreach Administration</title>
</head>
<body bgcolor="#F5EBDD" text="#000000">
  <table border="0" cellPadding="0" cellSpacing="0" width="300" bgColor="#112084">
    <tr>
        <td width="300"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;LifeBreach Administration&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp                </b></font></td>  
    </tr>   
  </table>
<TABLE border=0> 
<TR>
 				<TD valign="bottom"><font color="000099"><B>Repeat Intervals #Min </B></font></TD>
</TR>	
<TR>
				<td width="25"><select name="OrganizationRepeat" size="1">
				<option value="00:15"<% If TimeRepeat = "00:15" then response.write("selected") end if%>>00:15</option</TD>
				<option value="00:30"<% If TimeRepeat = "00:30" then response.write("selected") end if%>>00:30</option</TD>
				<option value="00:45"<% If TimeRepeat = "00:45" then response.write("selected") end if%>>00:45</option</TD>
				<option value="01:00"<% If TimeRepeat = "01:00" then response.write("selected") end if%>>01:00</option</TD> 
				<option value="01:15"<% If TimeRepeat = "01:15" then response.write("selected") end if%>>01:15</option</TD>  
				<option value="01:30"<% If TimeRepeat = "01:30" then response.write("selected") end if%>>01:30</option</TD>  
				<option value="01:45"<% If TimeRepeat = "01:45" then response.write("selected") end if%>>01:45</option</TD>  
				<option value="02:00"<% If TimeRepeat = "02:00" then response.write("selected") end if%>>02:00</option</TD>  
				<option value="02:15"<% If TimeRepeat = "02:15" then response.write("selected") end if%>>02:15</option</TD>
				<option value="02:30"<% If TimeRepeat = "02:30" then response.write("selected") end if%>>02:30</option</TD> 
				<option value="02:45"<% If TimeRepeat = "02:30" then response.write("selected") end if%>>02:45</option</TD>  
				<option value="03:00"<% If TimeRepeat = "03:00" then response.write("selected") end if%>>03:00</option</TD> 
				<option value="03:15"<% If TimeRepeat = "03:15" then response.write("selected") end if%>>03:15</option</TD>  
				<option value="03:30"<% If TimeRepeat = "03:30" then response.write("selected") end if%>>03:30</option</TD>  
				<option value="03:45"<% If TimeRepeat = "03:45" then response.write("selected") end if%>>03:45</option</TD>  
	 			<option value="04:00"<% If TimeRepeat = "04:00" then response.write("selected") end if%>>04:00</option</TD>  								
								
</TR>				    
<TR>
<TD valign="bottom"><font color="000099"><B>Delete&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp                    </B></font>  
   <font color="000099"><B>Organization Name</B></font></TD>  
<TD valign="bottom"><font color="000099"><B>Person Name</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Organization ID</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Email Address</B></font></TD>
</TR>

<%
rsrec.movefirst
do while not rsrec.eof
%>

<TR>
<TD><input type="checkbox" name="state_keeper" value= "<%=RSRec("ID")%>"

<input type="hidden" name="OrganizationName_<%=RSREc("OrganizationName")%>" value="<%=RSREc("OrganizationName")%>" size="4" maxlength="4" />
<input type="text" name="OrganizationNameDis_<%=RSREc("OrganizationName")%>" value="<%=RSREc("OrganizationName")%>" size="50" maxlength="50" width = "25" readonly/></TD>

<input type="hidden" name="PersonName_<%=RSREc("PersonName")%>" value="<%=RSREc("PersonName")%>" size="4" maxlength="4" />
<TD><input type="text" name="PersonNameDis_<%=RSREc("PersonName")%>" value="<%=RSREc("PersonName")%>" size="25" maxlength="20" readonly/></TD>

<input type="hidden" name="OrganizationID_<%=RSREc("OrganizationID")%>" value="<%=RSREc("OrganizationID")%>" size="4" maxlength="4" />
<TD><input type="text" name="OrganizationIDDis_<%=RSREc("OrganizationID")%>" value="<%=RSREc("OrganizationID")%>" size="10" maxlength="20" readonly/></TD>

<input type="hidden" name="EmailAddress_<%=RSREc("EmailAddress")%>" value="<%=RSREc("EmailAddress")%>" size="4" maxlength="4" />
<TD><input type="text" name="EmailAddressDis_<%=RSREc("EmailAddress")%>" value="<%=RSREc("EmailAddress")%>" size="50" maxlength="50" readonly/></TD>

<%
rsrec.movenext
loop
%>

<TR>
<TD valign="bottom"><font color="000099"><B>Organization<BR>Name</B></font></TD>
<TD valign="bottom"><font color="000099"><B>Person<BR>Name</B></font></TD>
<TD></TD>
</TR>
<TR> 
<TD width = "10">
<select name="OrganizationName_<%=UserOrgID%>" size="1">
<option value="">------</option>															 							
			 	<%Do While Not RSGroups.EOF%>              
            <option value="<%=RSGroups("OrganizationID")%>"><%=RSGroups("OrganizationName")%></option> 
           	<%RSGroups.MoveNext%>
        <%
        Loop
        
				RSGroups.MoveFirst 
				Do While Not RSGroups.EOF%>
				  		<input type="hidden" name="OrganizationName_<%=RSGroups("OrganizationID")%>" value="<%=RSGroups("OrganizationName")%>" />
							<%RSGroups.MoveNext%>
				<%
        Loop	 
%>
</TD>




 
<TD>
<select name="OrganizationEmail_<%=UserOrgID%>" size="1">
<option value="">------</option>
															 							
			 	<%Do While Not RSEmails.EOF%>             
            <option value="<%=RSEmails("Person")%>"><%=RSEmails("Person")%></option> 
            <%RSEmails.MoveNext%>
        <%
        Loop	 
        
        RSEmails.MoveFirst
        Do while Not RSEmails.EOF%>
        		<input type="hidden" name="PersonID_<%=RSEmails("Person")%>" value="<%=RSEmails("webpersonemail")%>" size="255" maxlength="255" />
						<%RSEmails.MoveNext%>
				<%
				Loop
%>
</TD>
<TR>
<TD></TD>
</TR>
<TR>
<TD></TD>
<td colspan=11>
<input type="submit" name="submitform" value="Submit" />
</TD>
</TR>
</form>
</body>
<SCRIPT LANGUAGE="JavaScript">
function ChangeRegion()
{
	 
	document.frmLifeBreach.submit();
}

</SCRIPT>

<% END IF %>





</HTML>
