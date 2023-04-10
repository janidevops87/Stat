<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn
Dim PERMISSIONID
Dim cmd
Dim rsC
Dim rsC2
dim a
Dim rsReportGroupSelect
Dim rsReportGroupHospital
Dim rsGroupOwnerSelect
Dim rsSourceOwneredit
Dim GroupOwnerValue
dim counter
Dim rsCheck
Dim rsMasterOrg
Dim rsMasterOrgedit
Dim rsSrch
Dim rsHosp
Dim rsRoles
Dim rsSource
Dim rsSourceUser
Dim rsSourceOwner
Dim sParentOrgName
Dim sHospName
Dim vWebPersonId 
Dim vPersonId
Dim vPersonIDSecond
Dim vWebUserName
Dim vPassword
Dim vWebAccess
Dim vPersonFirst
Dim vPersonLast
Dim vPersonTypeId
Dim vPersonOrgId
Dim vButtonCaption
Dim vDesigRequestor
Dim sConfirm
Dim sAsterisk
Dim vPersonOrgName
Dim SourceValue
Dim SourceName
Dim ReportGroupValue
Dim DebugMode
Dim GroupOwnerSwitch
Dim ButtonPress
Dim Role
Dim rsWebPerson
Dim rsWebPersonState
Dim EditBooln
Dim rsEditUser
dim WebpersonUserID
Dim WebPersonGroupOwner
Dim WebPersonReportGroup
Dim WebPersonHospital
Dim WebPersonDSC
Dim rsHospitalEdit
Dim rsSourceCodeEdit
Dim vsrch
Dim vPersonIDState2
Dim rsSourceCodeRem
Dim rsSourceOwnerRem
Dim rsSourceOwnerInsert
Dim rsDSC
Dim vSourceAssign
Dim vSourceTrans
Dim rsDeleteSource
Dim rsDeleteSourceCheck
 


DebugMode = true

' Display all Form and QueryString variables when DebugMode is on.
If DebugMode = True Then
			'Debuggin code
			'*******************************
							 
								vSourceAssign = 	Request.Form("vSourceAssign")
								 
								if (vSourceAssign <> "Assign") then%>
						
									call SetUSERID()<%
									Set cmd = Server.CreateObject("ADODB.Command")
									cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
									cmd.CommandText = "delete onlinehospitalsourcecodewebperson   where webpersonID = " & Request.QueryString("UserID") 					 
									SET rsDeleteSource = cmd.Execute	

								end if 
							  
					
					
					
					
					
					
					if Request.Form("vButtonCaption")= "Edit" then
							vButtonCaption = "Edit Account"
					end if
			
			
			
					
			
					'Response variables
					'*******************************
			    Response.Write "Request"
			    Dim strItem
			    Response.Write "<b>FORM VARS</b><br>"
			    For Each strItem In Request.Form
			        Response.Write "<br>" & strItem & " = " 
			        Response.Write Request.Form(strItem) & vbCrLf
			    Next
			    '*******************************
			    
			    'QueryString vars
			    '*******************************
			    Response.Write "Query "
			    Response.Write "<b>QUERYSTRING VARS</b><br>"
			    For Each strItem In Request.QueryString
			        Response.Write "<br>" & strItem & " = " 
			        Response.Write Request.QueryString(strItem) & vbCrLf
			    Next
    '*******************************
			
End If	


'Begin Page Code
			EditBooln = false
			GroupOwnerValue = 0
			ReportGroupValue = 0
			ButtonPress = "NA"
			
			
				 			'Determine if source code has been assigned 
								vSourceAssign = 	Request.Form("vSourceAssign")

								if (vSourceAssign <> "Assign") then


									Set cmd = Server.CreateObject("ADODB.Command")
									cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
									cmd.CommandText = "delete onlinehospitalsourcecodewebperson   where webpersonID = " & Request.QueryString("UserID") 					 
									SET rsDeleteSource = cmd.Execute	
			
								end if 
			 
			GroupOwnerSwitch = False
			if Request.Form("GroupOwner") <> Request.Form("GroupOwnerLast") then
					GroupOwnerSwitch = True	
			end if
				vPersonFirst= Request.Form("FirstName")
				vPersonLast= Request.Form("LastName")
				vWebUserName = Request.Form("USERID")
				vPassword = Request.Form("PWD1")
				vPersonTypeId = Request.Form("Role")
				vWebAccess = Request.Form("ACCOUNTTYPE")
				
			GroupOwnerValue =  Request.Form("GroupOwner")
			ReportGroupValue = Request.Form("Report Group")
    
    'Check to see if user is edited
    '*******************************
    if Request.QueryString("EditUser") > 1 then
    	EditBooln = true
    end if
    '*******************************
    
     'Check to see if user is edited
     '*******************************
    if Request.Form("vButtonCaption") = "Edit Account" then
    		EditBooln = true
    end if
    '*******************************
    
    
   
		'If Edit then get userID   
		'*******************************
    if EditBooln = true then
    		Set cmd = Server.CreateObject("ADODB.Command")
				cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
				cmd.CommandText = "Select * from onlinehospitalaccount where webpersonID = " & Request.QueryString("EditUser")
				
				Set rsEditUser = cmd.Execute
				
				if rsEditUser.EOF = False then
							'print "WebPersonfromEditUser"
							WebpersonUserID = rsEditUser("WebPersonID")		
							'Print webpersonUserID
							WebPersonGroupOwner = rsEditUser("GroupOwnerID")
							'Print "WebPersonGroupOwner"
							'Print WebPersonGroupOwner
							WebPersonReportGroup = rsEditUser("ReportGroupID")
							'Print WebPersonReportGroup
							WebPersonHospital = rsEditUser("HospitalID")
							'Print WebPersonHospital
							WebPersonDSC = rsEditUser("DefaultSourceCodeID")
							'Print WebPersonDSC
			 else
			 		'print "WebPersonfromEditUser"
					WebpersonUserID = 0	
					'Print webpersonUserID
					WebPersonGroupOwner = 0
					'Print "WebPersonGroupOwner"
					'Print WebPersonGroupOwner
					WebPersonReportGroup = 0
					'Print WebPersonReportGroup
					WebPersonHospital = 0
					'Print WebPersonHospital
					WebPersonDSC = 0
					'Print WebPersonDSC
			end if
			 		
		end if
		'*******************************
    
    
    'Add button was pressed
    '*******************************
    if Request.Form("AddButton") = "       Add      " then 
						'Print "Pressed Add"
						For a = 1 to Request.Form("AddSource").Count
						'Response.Write("The add " & Request.Form("AddSource")(a) & " was selected<BR>")

								Set cmd = Server.CreateObject("ADODB.Command")
								cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD

								cmd.CommandText = "Select * from onlinehospitalsourcecodewebperson where webpersonID = " & Request.QueryString("UserID") & " and sourceCodeID = " & Request.Form("AddSource")(a) 
								Set rsCheck = cmd.Execute

								if rsCheck.EOF = True then
									cmd.CommandText = "insert into onlinehospitalsourcecodewebperson (webpersonID,sourceCodeID,SourceCodeName) values ("& Request.QueryString("USERID")&"," & Request.Form("AddSource")(a) & ",'Blank')"
									'print cmd.CommandText

									Set rs = cmd.Execute
								end if
								vSourceAssign = "Assign"
							Set rsCheck = nothing
						Next
		end if
		'*******************************
		
		
		'RemoveButton was pressed
		'*******************************
		if Request.Form("RemoveButton") = " Remove " then
						'print "pressed Remove"
						For a = 1 to Request.Form("RemoveSource").Count
							'Response.Write("The Remove " & Request.Form("RemoveSource")(a) & " was selected<BR>")

									Set cmd = Server.CreateObject("ADODB.Command")
									cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
									cmd.CommandText = "delete from OnlineHospitalSourceCodeWebPerson where webpersonID = " & Request.QueryString("UserID") & " and sourcecodeID = " & Request.Form("RemoveSource")
								  Set rs = cmd.Execute
					Next
		end if
		'*******************************
		
		'Get records for sourceCode list
		'*******************************
		Set cmd = Server.CreateObject("ADODB.Command")
		cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
		cmd.CommandText = "select distinct SourceCodeID,SourceCodeName from sourcecode where sourceCodeType = 1 order by SourceCodeName asc"
		 
		SET rsSource = cmd.Execute
		Do While Not rsSource.EOF 
			If Not rsSource.EOF Then
		   	'Print rsSource("SourceCodeName")
			End If   
			rsSource.MoveNext
			  
	  Loop
	  '*******************************
	  
	  		'Get source code list for userID
	  		'*******************************
	  		Set cmd = Server.CreateObject("ADODB.Command")
				cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
				cmd.CommandText = "select ohswp.SourceCodeID,SourceCode.SourceCodeName from onlinehospitalsourcecodewebperson ohswp join SourceCode ON SourceCode.SourceCodeID = ohswp.SourceCodeID where webpersonID = " & Request.QueryString("UserID") & " order by SourceCode.SourceCodeName"
				 
				SET rsSourceUser = cmd.Execute
				
				Set cmd = Server.CreateObject("ADODB.Command")
								cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
								cmd.CommandText = "select ohswp.SourceCodeID,SourceCode.SourceCodeName from onlinehospitalsourcecodewebperson ohswp join SourceCode ON SourceCode.SourceCodeID = ohswp.SourceCodeID where webpersonID = " & Request.QueryString("UserID") & " order by SourceCode.SourceCodeName"						 
				SET rsSourceOwner = cmd.Execute		
				counter = 0
				Do While Not rsSourceOwner.EOF 
							If Not rsSourceOwner.EOF Then
						   	Set cmd = Server.CreateObject("ADODB.Command")
								cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
								cmd.CommandText = "select Distinct OrganizationName, OrganizationID from Organization inner join webreportgroup	on webreportgroup.orghierarchyparentid = organization.organizationid inner join webreportgroupsourcecode on webreportgroupsourcecode.webreportgroupid = webreportgroup.webreportgroupid where webreportgroupsourcecode.sourcecodeid = " & rsSourceOwner("SourceCodeID") & " and Organization.OrganizationID <> 194 "
								Set rsMasterOrg = cmd.Execute
											Do While Not rsMasterOrg.EOF 
														If Not rsMasterOrg.EOF Then
													   	'Print rsMasterOrg("OrganizationName")
													   	counter = counter + 1
														End If   
														rsMasterOrg.MoveNext													  
	  									Loop
							End If   
							rsSourceOwner.MoveNext						  
	  	Loop
	  	'print counter
 			'*******************************	
 

' Default this to "Create Account" - it changes for edited records
if Len(Request.Form("SRCHUER"))> 0 then
		vButtonCaption = "Edit Account"
		
else
		vButtonCaption = "Create Account"
end if


	if Request.Form("vButtonCaption")= "Edit" then
				vButtonCaption = "Edit Account"
				
							'Get webperson
							'*******************************
							Set cmd = Server.CreateObject("ADODB.Command")
							cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
						'
							cmd.CommandText = "select * from webperson where webpersonUserName = '" & vWebUserName & "'" 
							'print cmd.CommandText
							set rsWebPersonstate = cmd.Execute
							vPersonIDState2 = rsWebPersonstate("PersonID")
							
			'*******************************
		end if
%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
' If a search string was sent, perform the search finds user from search
''**************************************************************
If Len(Request.Form("SRCHUSER")) > 0 Then

	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
	cmd.CommandText = "sps_GetWebPersonByUserId"
	cmd.CommandType = adCmdStoredProc
	cmd.Parameters.Append cmd.CreateParameter("@userName", adVarChar, adParamInput, 16)
	cmd.Parameters.Append cmd.CreateParameter("@userOrgId", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@userId", adInteger, adParamInput)
	cmd.Parameters("@userName").Value = Request.Form("SRCHUSER")
	cmd.Parameters("@userOrgId").Value = Request.QueryString("UserOrgID")
	cmd.Parameters("@userId").Value = 4971
	SET rsSrch = cmd.Execute
End If
'**************************************************************

' If the user's org is not Statline, search for display and list of elegible hospitals,
' if the org is Statline, get a list of OPOs to populate in the hospital drop-down.  3/25/05 - SAP
'Set cmd = Server.CreateObject("ADODB.Command")
'cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
'cmd.CommandText = "sps_GetWebOrgsByParentId"
'cmd.CommandType = adCmdStoredProc
'cmd.Parameters.Append cmd.CreateParameter("@parentId", adInteger, adParamInput)
'cmd.Parameters("@parentId").Value = Request.QueryString("UserOrgID")
'SET rsHosp = cmd.Execute
'If Not rsHosp.EOF Then
'   sParentOrgName = rsHosp("ParentOrganizationName")
'End If


' Get the list of possible Roles for a Person from PersonType table
'*******************************
Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
cmd.CommandText = "sps_GetPersonTypes"
cmd.CommandType = adCmdStoredProc
SET rsRoles = cmd.Execute
'*******************************



' If this is a user to be edited, go fetch the user's information  
'*******************************'*******************************
If Len(Request.QueryString("EditUser")) > 0 Then
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
	cmd.CommandText = "sps_EditWebUserAcct"
	cmd.CommandType = adCmdStoredProc
	cmd.Parameters.Append cmd.CreateParameter("@webPersonId", adInteger, adParamInput)
	cmd.Parameters("@webPersonId").Value = Request.QueryString("EditUser")
	SET rsC = cmd.Execute
	If Not rsC.EOF Then  
	   vWebPersonId = rsC("WebPersonId")
	   vPersonId = rsC("PersonId")
	   vWebUserName = rsC("WebPersonUserName")
	   'To prevent user from seeing password, set this to "NO_CHANGE".
	   'the stored procedure which edits existing users recognizes this and leaves
	   'existing password intact.
	   vPassword = "NO_CHANGE"
	   vWebAccess = rsC("Access")
	   vPersonFirst = rsC("PersonFirst")
	   vPersonLast = Trim(rsC("PersonLast"))
	   If Right(Trim(vPersonLast),1) = "*" Then
	   	vDesigRequestor = True
	   	vPersonLast = Left(vPersonLast, Len(vPersonLast) - 1)
	   End If
	   vPersonTypeId = rsC("PersonTypeId")
	   vPersonOrgId = rsC("OrganizationId")	
	   vPersonOrgName = rsC("OrganizationName")
	   'Set button caption to Edit
	   vButtonCaption = "Edit Account"
	End If
	Set rsC = Nothing
End If
'*******************************'*******************************

' If the form was submitted create or update the user
'*******************************'*******************************'*******************************
If UCase(Request.Form("submitform")) = "CREATE ACCOUNT" Or UCase(Request.Form("submitform")) = "EDIT ACCOUNT" Then
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
	cmd.CommandText = "spui_CreateWebAcct"
	cmd.CommandType = adCmdStoredProc
	cmd.Parameters.Append cmd.CreateParameter("@personId", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@webPersonId", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@webPersonName", adVarChar, adParamInput, 15)
	cmd.Parameters.Append cmd.CreateParameter("@webPersonPwd", adVarChar, adParamInput, 20)
	cmd.Parameters.Append cmd.CreateParameter("@orgId", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@personTypeId", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@personFirst", adVarChar, adParamInput, 50)
	cmd.Parameters.Append cmd.CreateParameter("@personLast", adVarChar, adParamInput, 50)
	cmd.Parameters.Append cmd.CreateParameter("@webAccess", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@adminId", adInteger, adParamInput)
	If IsNumeric(Request.Form("PERSONID")) Then
		vPersonId = Request.Form("PERSONID")
	 
	Else
		vPersonId = 0
	End If
	
	if vPersonIDState2 > 0 then
			vPersonId = vPersonIDState2
	end if
	cmd.Parameters("@personId").Value = vPersonId
	If IsNumeric(Request.Form("WEBPERSONID")) Then
		vWebPersonId = Request.Form("WEBPERSONID")
	Else
		vWebPersonId = 0
	End If	
	
	
	cmd.Parameters("@webPersonId").Value = vWebPersonId
	
	cmd.Parameters("@webPersonName").Value = Request.Form("USERID")
	cmd.Parameters("@webPersonPwd").Value = Request.Form("PWD1")
	
	If IsNumeric(Request.Form("GroupOwnerHospital")) Then
		vPersonOrgId = Request.Form("GroupOwnerHospital")
	Else
		vPersonOrgId = 0
	End If	
	cmd.Parameters("@orgId").Value = vPersonOrgId
	   
	If IsNumeric(Request.Form("ROLE")) Then
		vPersonTypeId = Request.Form("ROLE")
	Else
		vPersonTypeId = 0
	End If	
	cmd.Parameters("@personTypeId").Value = vPersonTypeId
	cmd.Parameters("@personFirst").Value = Request.Form("FIRSTNAME")
	' If the Designated Requestor box is checked, append an asterisk to last name
	If UCase(Request.Form("DESREQUESTOR")) = "ON" Then
		sAsterisk = "*"
	Else
		sAsterisk = ""
	End If
	cmd.Parameters("@personLast").Value = Request.Form("LASTNAME") & sAsterisk
	cmd.Parameters("@webAccess").Value = CInt(Request.Form("ACCOUNTTYPE"))
	cmd.Parameters("@adminId").Value = CInt(Request.QueryString("UserID"))
	
	sConfirm = "<font color=""red"">Saved User <B>" & Request.Form("USERID") & "</font></b>"
	cmd.Execute	
	
			'Get webperson
			'*******************************
			Set cmd = Server.CreateObject("ADODB.Command")
			cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
		'
			cmd.CommandText = "select * from webperson where webpersonUserName = '" & vWebUserName & "'" 
			'print cmd.CommandText
			set rsWebPerson = cmd.Execute
			'*******************************
 
 	
 	
	'Adding variables for OnlineHospitalAccount T.T 12/01/2005
	'*******************************
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
	cmd.CommandText = "spui_CreateWebAcctOwners"
	cmd.CommandType = adCmdStoredProc
	cmd.Parameters.Append cmd.CreateParameter("@WebPersonID", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@GroupOwnerID", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@ReportGroupID", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@HospitalID", adInteger, adParamInput)
	cmd.Parameters.Append cmd.CreateParameter("@DefaultSourcecodeID", adInteger, adParamInput) 
	cmd.Parameters.Append cmd.CreateParameter("@vPersonId", adInteger, adParamInput)
	cmd.Parameters("@WebPersonID").Value = rsWebPerson("WebPersonID")
	cmd.Parameters("@GroupOwnerID").Value = GroupOwnerValue
	cmd.Parameters("@ReportGroupID").Value = ReportGroupValue
	cmd.Parameters("@HospitalID").Value = Request.Form("GroupOwnerHospital")
	cmd.Parameters("@DefaultSourcecodeID").Value = Request.Form("Defaultsource") 
	cmd.Parameters("@vPersonId").Value = rsWebPerson("PersonID")
	cmd.Execute	
	'*******************************
	
	'Adding Sourcecodes for user account
	'*******************************
	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
	
	cmd.CommandText = "delete from onlinehospitalsourcecodewebperson where webpersonID = " & rsWebPerson("WebPersonID")
	SET rsSourceCodeRem = cmd.Execute
	Set rsSourcecodeRem = Nothing
	
	cmd.CommandText = "select ohswp.SourceCodeID as SourceCodeID,SourceCode.SourceCodeName as SourceCodeName from onlinehospitalsourcecodewebperson ohswp join SourceCode ON SourceCode.SourceCodeID = ohswp.SourceCodeID where webpersonID = " & Request.QueryString("UserID") & " order by SourceCode.SourceCodeName"						 
	SET rsSourceOwnerRem = cmd.Execute
	
		Do While Not rsSourceOwnerRem.EOF 
					If Not rsSourceOwnerRem.EOF Then
					
						cmd.CommandText = "insert into onlinehospitalsourcecodewebperson (webpersonID,sourceCodeID,SourceCodeName) values (" & rsWebPerson("WebPersonID") & "," & rsSourceOwnerRem("SourcecodeID") & ",'" & rsSourceOwnerRem("SourceCodeName") & "')"
					  set rsSourceOwnerInsert = cmd.Execute
					end if
					rsSourceOwnerRem.MoveNext
	  Loop
	
	
		
		
		' Reset variables
	vWebPersonId = ""

	vWebUserName = ""
	vPassword = ""
	vWebAccess = 0
	vPersonFirst = ""
	vPersonLast = ""
	vDesigRequestor = False
	vPersonTypeId = ""
	vPersonOrgId = ""
	ButtonPress = ""
End If
'*******************************'*******************************'*******************************


'Verify Access
'*******************************'*******************************'*******************************
If AuthorizeMain Then %>
	<html>
	
	<head>
	<title>Create Account Admin.</title>
	<link rel="stylesheet" href="../styles/StatReports.css" type="text/css">
	</head>
	<body class="body_background">
	
	<% IF TRUE=TRUE then  ' ToDo: Add permissions here? %>
	<Table border="0">
	    <tr>
		<td colspan=2>
		    <table border="0" cellPadding="0" cellSpacing="0" width="450" bgColor="#112084">
			<tr>
			    <td width="450"><font color=#FFFFFF face="Arial" size="4"><b>&nbsp;Create Account</b></font></td>
			</tr>
		    </table>
		</td>
	    </tr>
      <form action="CreateAcctAdmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="srchacct" method="post">
<%    If Len(sConfirm) > 0 Then %>
            <tr>
               <td colspan=2 align=center><%=sConfirm%></td>
            </tr>
<%    End If %>
	    <tr>
	       <td>&nbsp;</td>
         <td align=center><div class="body_background">(*Required fields)</div></td>
	    </tr>
	    <tr>
	        <td valign=top rowspan=2>
	            <table class="sidebar" border="0">
	                <tr>
	    	            <td valign=top>
		               <table border="0" cellpadding=3>
		                  <tr>
			              <td align=center colspan=2><div class="body_head">Search User Id:</div></td>
		                  </tr>
		                  <tr>
		                      <td align=center colspan=2><input type="text" name="SRCHUSER" size=14 maxlength=15 value="<%=vsrch%>"></td>
		                  </tr>
		                  <tr>
		                      <td align=center colspan=2><input type="submit" value="Search"></td>
		                  </tr>		      
		                  <tr>
		                  <td valign=top>
											<%		 
											
														If Len(Request.Form("SRCHUSER")) > 0 Then
														If rsSrch.EOF Then %>
																							<div align=center class="body_background">No matches found for <br><b>"<%=Request.Form("SRCHUSER")%>"</b></div>
											<%		End If
														Do While Not rsSrch.EOF %>
																				<a href="CreateAcctAdmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&EditUser=<%=rsSrch("WebPersonId")%>"><%=rsSrch("WebPersonUserName")%></a><br>
														<%rsSrch.MoveNext  
														Loop  
												 End If   %>
		          
		                      &nbsp;</td>
		                      <td>
				          						<img src="../images/spacer.gif" height=270 width=1 border=0>
		                      </td>
		                  </tr>
		               </table></form>
		           </td>
		       </tr>
		    </table>
		    
		</td>
		
		<form action="CreateAcctAdmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="acctform" method="post" onsubmit="return validateCreation()">
	    </tr>

	    <tr>
		<td valign=top>
		    <table border="0">
		        <tr>
		            <td align=center>
                               <table border="0">
	    	                  <tr>
	    	                      <td><div class="body_background">* User ID:</div></td>
	    	                      <td><input type="text" name="USERID" maxlength="15" value="<%=vWebUserName%>"></td>
	    	                  </tr>
	    	                  <tr>
	    	                      <td><div class="body_background">* Password:</div></td>
	    	                      <td><input type="password" name="PWD1" maxlength="20" value="<%=vPassword%>"></td>
	    	                  </tr>
	    	                  <tr>
	    	                      <td><div class="body_background">* Verify Password:</div></td>
	    	                      <td><input type="password" name="PWD2" maxlength="20" value="<%=vPassword%>"></td>
	    	                  </tr>
	    	                  <tr>
	    	                      <td>&nbsp;</td>
	    	                      <td><div class="body_background">(Password must be 8 - 16 characters long)</div></td>
	    	                  </tr>	
	    	                  <tr><td>&nbsp;</td>
	    	                  </tr>
	    	                  
	    	</Table>
	    	
	    <%If Request.Querystring("UserOrgID") = 194 Then%>
	    	<Table table border="0">
	    	              <tr> 
	    	                  <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	    	                  <td><div class="body_background">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;Source&nbsp;Code:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
	    	                  		
														 <td><SELECT NAME="AddSource" MULTIPLE SIZE="3">
																		<%rsSource.MoveFirst
																		Do While Not rsSource.EOF 
																					If Not rsSource.EOF Then
																						'Print rsSource("SourceCodeName")
																					End If   %>
																					<OPTION VALUE=<%=rsSource("SourceCodeID")%>><%=rsSource("SourceCodeName")%></OPTION>

																					<%rsSource.MoveNext
																		Loop  %>
														 </td>
														 <td>												
																	</SELECT>

																	<SELECT NAME="RemoveSource" MULTIPLE SIZE="3">
																	<%
																	'rsSourceUser.MoveFirst
																	Do While Not rsSourceUser.EOF 
																				If Not rsSourceUser.EOF Then
																					Print rsSourceUser("SourceCodeName")
																				End If   %>
																				<OPTION VALUE=<%=rsSourceUser("SourceCodeID")%>><%=rsSourceUser("SourceCodeName")%></OPTION>

																				<%rsSourceUser.MoveNext
																  Loop  %>
														
																</SELECT>
														</td>
												</tr>
				</Table>
				
				
				<Table>								
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>
							<INPUT TYPE="submit" VALUE="       Add      " NAME="Addbutton" onClick="ReviewAdd()">

							<INPUT TYPE="submit" VALUE=" Remove " NAME= "Removebutton" onClick="ReviewRemove()">

						</td>
					</tr>

	 			</table>
	 			<%End if%>
		    	    </td>
		        </tr>
		        <tr>
	    	            <td><div class="body_background">Account Information</div><td>
	                </tr>
                        <tr>
	                    <td>
	                       <table border="0">
	                          <tr><input type="hidden" name="PERSONID" value="<%=vPersonId%>">
	                          		<input type="hidden" name="vPersonIdState" value="<%=vPersonIDState2%>">
	                              <input type="hidden" name="WEBPERSONID" value="<%=Request.Form("SRCHUSER")%>">
	                              <input type="hidden" name="ButtonPress" value="<%=ButtonPress%>">
	                              <input type="hidden" name="vButtonCaption" value="<%=vButtonCaption%>">
	                              <input type="hidden" name="vSourceAssign" value="<%=vSourceAssign%>">
	                             
	                               
	                             <td><div class="body_background">*&nbsp;First&nbsp;Name</div></td>
	                             <td><input type="text" name="FIRSTNAME" value="<%=vPersonFirst%>"></td>
	                              
	                             <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                             <td><div class="body_background">*&nbsp;Group&nbsp;Owner</div></td>
	                   
	                             <td>
	                             <SELECT NAME="GroupOwner" ONCHANGE="document.forms[1].submit();">
															 																														
															 			<option value=0></option>
															 		<%
															 			'Fill Group Owner DropDown
															 			'*******************************
																		Set cmd = Server.CreateObject("ADODB.Command")
																		cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																		cmd.CommandText = "select ohswp.SourceCodeID,SourceCode.SourceCodeName from onlinehospitalsourcecodewebperson ohswp join SourceCode ON SourceCode.SourceCodeID = ohswp.SourceCodeID where webpersonID = " & Request.QueryString("UserID") & " order by SourceCode.SourceCodeName"						 
																		SET rsSourceOwner = cmd.Execute
																		counter = 0
																						Do While Not rsSourceOwner.EOF 
																									If Not rsSourceOwner.EOF Then
																										Set cmd = Server.CreateObject("ADODB.Command")
																										cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																										cmd.CommandText = "select Distinct OrganizationName, OrganizationID from Organization inner join webreportgroup	on webreportgroup.orghierarchyparentid = organization.organizationid inner join webreportgroupsourcecode on webreportgroupsourcecode.webreportgroupid = webreportgroup.webreportgroupid where webreportgroupsourcecode.sourcecodeid = " & rsSourceOwner("SourceCodeID") & " and Organization.OrganizationID <> 194 "

																										Set rsMasterOrg = cmd.Execute
																													Do While Not rsMasterOrg.EOF 
																																If Not rsMasterOrg.EOF Then%>
																																	<%If Len(rsMasterOrg("OrganizationName")) > 45 Then 
																																			sHospName = Left(rsMasterOrg("OrganizationName"), 45) & "..."
																																	Else
																																			sHospName = rsMasterOrg("OrganizationName")
																																	End If %>
																																	<OPTION VALUE=<%=rsMasterOrg("OrganizationID")%>><%=sHospName%></OPTION> 

																																	<%counter = counter + 1
																																End If   
																																rsMasterOrg.MoveNext													  
																													Loop
																									End If   
																									rsSourceOwner.MoveNext						  
																					Loop%>
																					 
																					
																					<%'If User Edit 
																						'*******************************
																							if EditBooln = True then
																							
																							Set cmd = Server.CreateObject("ADODB.Command")
																							cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																							cmd.CommandText = "select OrganizationName,OrganizationID from Organization where OrganizationID = " & WebPersonGroupOwner
																							SET rsGroupOwnerSelect = cmd.Execute

																								
																										If Not rsGroupOwnerSelect.EOF Then%>
																														<option value=<%=WebPersonGroupOwner%><% Response.Write(" selected")%>><%=rsGroupOwnerSelect("OrganizationName")%></option>										 
																														<input type="hidden" name="GroupOwnerLast" value="<%=Request.Form("GroupOwner")%>">
																										<%End If
																								
																					end if%>
																				<%'*******************************
																				
																	
																	
																				'If GroupOwner Value, Page is refreshed
																				'*******************************
																				if GroupOwnerValue > 0 then
																							Set cmd = Server.CreateObject("ADODB.Command")
																							cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																							cmd.CommandText = "select OrganizationName,OrganizationID from Organization where OrganizationID = " & GroupOwnerValue
																							SET rsGroupOwnerSelect = cmd.Execute

																								if Request.Form("RemoveButton") = " Remove " then
																										'nothing
																								else 
																										If Not rsGroupOwnerSelect.EOF Then%>
																														<option value=<%=Request.Form("GroupOwner")%><% Response.Write(" selected")%>><%=rsGroupOwnerSelect("OrganizationName")%></option>										 
																														<input type="hidden" name="GroupOwnerLast" value="<%=Request.Form("GroupOwner")%>">
																										<%End If
																								end if
																				end if
																				'*******************************
																				%>
																				
																				
																				
											 																						
															</SELECT>					
	                            </td>
	                          </tr>
	                          <tr>  
	                             <td><div class="body_background">*&nbsp;Last&nbsp;Name<div></td>
	                             <td><input type="text" name="LASTNAME" value="<%=vPersonLast%>"></td>
	                             <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                             <td><div class="body_background">* <%If Request.Querystring("UserOrgID") = 194 Then Response.Write("ReportGroup") Else Response.Write("ReportGroup") End If %>:</div></td>
	                             <td>
	                             <select name="Report Group"  ONCHANGE="document.forms[1].submit()">
	                             		<%if GroupOwnerValue =0 then %>
	                             				<option value=0>Select Group Owner</option>
	                             			<%else%>
	                             				<option value=0></option>
	                             		
	                             					<% 
	                             					'Fill ReportGroup DropDown
	                             					'*******************************
	                             					Set cmd = Server.CreateObject("ADODB.Command")
																				cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																				cmd.CommandText = "SELECT DISTINCT WebReportGroupID, WebReportGroupName FROM WebReportGroup WHERE OrgHierarchyParentID = " & GroupOwnerValue & " ORDER BY WebReportGroupName" 
																				set rsReportGroupSelect = cmd.Execute
																				 
																				Do While Not rsReportGroupSelect.EOF 
																							If Not rsReportGroupSelect.EOF Then%>
																								<OPTION VALUE=<%=rsReportGroupSelect("WebReportGroupID")%>><%=rsReportGroupSelect("WebReportGroupName")%></OPTION> 
																							
																							<%End If   
																							rsReportGroupSelect.MoveNext													  
																				Loop
																	end if
																				'*******************************
																				%>
																	<%'If user is being edited
																	'*******************************
																	if EditBooln = True then

																			Set cmd = Server.CreateObject("ADODB.Command")
																			cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																			cmd.CommandText = "select WebReportGroupID,WebReportGroupName from webreportgroup where webreportgroupID =" & WebPersonReportGroup
																			set rsMasterOrgedit = cmd.Execute

																						If Not rsMasterOrgedit.EOF Then%>
																								<option value=<%=WebPersonReportGroup%><% Response.Write(" selected")%>><%=rsMasterOrgedit("WebReportGroupName")%></option>
																						<%End If

																	ReportGroupValue = 0

																	end if
															'*******************************
																					%>
															<%'If ReportGroup value has value in it, maintain state
															'*******************************
															if ReportGroupValue > 0 then		
																		Set cmd = Server.CreateObject("ADODB.Command")
																		cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																		cmd.CommandText = "select WebReportGroupID,WebReportGroupName from webreportgroup where webreportgroupID =" & Request.Form("Report Group") 
																		set rsReportGroupSelect = cmd.Execute

																		if Request.Form("RemoveButton") = " Remove " then
																				'nothing
																		else 
																				if GroupOwnerSwitch = False then
																					If Not rsReportGroupSelect.EOF Then%>
																							<option value=<%=Request.Form("Report Group")%><% Response.Write(" selected")%>><%=rsReportGroupSelect("WebReportGroupName")%></option>
																					<%End If
																				End If
																		end if

															end if
															'*******************************
																	%>
													</select>
																	
	                          </tr>
	                          <tr>
	                             <td><div class="body_background">*&nbsp;Role</div></td>
	                             <td>
	                            
	                             <select name="ROLE">
	                 	            		<option value=0></option>
																		<%		Do While Not rsRoles.EOF %>
																												<option value=<%=rsRoles("PersonTypeId")%><%If Cstr(rsRoles("PersonTypeId")) = Cstr(vPersonTypeId) Then Response.Write(" selected") End If%>><%=rsRoles("PersonTypeName")%></option>
																		<%		   rsRoles.MoveNext
																				Loop  %>
																
																				
																</select>
																</td> 
															  <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                              <td><div class="body_background">*&nbsp;Hospital&nbsp;</div></td>
															</SELECT>
																					</td>            
																	        <td>

																	        <select name="GroupOwnerHospital">
																									<%if ReportGroupValue =0 then %>
																											<option value=0>Select Hospital</option>
																									<%else%>
																											<option value=0></option>
																												<% 
																													if GroupOwnerSwitch = False then																
																														if ReportGroupValue > 0 then
																																Set cmd = Server.CreateObject("ADODB.Command")
																																cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																																cmd.CommandText = "SELECT WebReportGroupOrg.WebReportGroupOrgID, Organization.OrganizationName as orgName,Organization.OrganizationID as OrgID"& _
																																										" FROM WebReportGroup JOIN WebReportGroupOrg ON " & _
																																										 " WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID INNER "& _
																																										" JOIN ((Organization INNER JOIN OrganizationType "& _
																																										" ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID) "& _
																																										" INNER JOIN State ON Organization.StateID = State.StateID) "& _
																																										 " ON WebReportGroupOrg.OrganizationID = Organization.OrganizationID "& _
																																										" WHERE WebReportGroup.WebReportGroupID = "& ReportGroupValue  &  " ORDER BY Organization.OrganizationName ASC " 
																																set rsReportGroupHospital = cmd.Execute

																																Do While Not rsReportGroupHospital.eof
																																		If Not rsReportGroupHospital.EOF Then%>
																																				<option value=<%=rsReportGroupHospital("OrgID")%>><%=rsReportGroupHospital("OrgName")%></option>
																																		<%End If
																																		rsReportGroupHospital.MoveNext
																															Loop


																														end if
																													end if%>

																										<%end if
																										'*******************************
																										%>
																							
																									<%'Edit if user is being edited
																									'*******************************
																									if EditBooln = True then
																																																
																											Set cmd = Server.CreateObject("ADODB.Command")
																											cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																											cmd.CommandText = "select OrganizationName,OrganizationID from Organization where OrganizationID = " & WebPersonHospital
																											SET rsHospitalEdit = cmd.Execute


																														If Not rsHospitalEdit.EOF Then%>
																																		<option value=<%=WebPersonHospital%><% Response.Write(" selected")%>><%=rsHospitalEdit("OrganizationName")%></option>										
																														<%End If

																									end if
																									'*******************************
																								  %>
																	</select>
															 </tr>
	                            <tr>
	                           
	                             <td><div class="body_background">*&nbsp;Account&nbsp;Type:</div></td>
	                             <td>
	     
	                             <select name="ACCOUNTTYPE">
	                 	            <option value=0></option>
	                 	            <option value=511<%If vWebAccess = 511 Then Response.Write(" selected") End If%>>Administrator</option>
	                 	            <option value=13<%If vWebAccess = 13 Then Response.Write(" selected") End If%>>User</option>
	                             </select></td>
	                         			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                              <td><div class="body_background">*&nbsp;Default&nbsp;SourceCode:</div></td>
	                              
	                                      <td>
																			 <SELECT NAME="Defaultsource" >


																				<%'Fill in Deault source code dropdown
																				if ReportGroupValue > 0 then
																				Set cmd = Server.CreateObject("ADODB.Command")
																				cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																				cmd.CommandText = "SELECT DISTINCT SourceCode.SourceCodeID, SourceCode.SourceCodeName FROM SourceCode " _
																													& " JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = SourceCode.SourceCodeID " _
																													& " WHERE WebReportGroupSourceCode.WebReportGroupID = " & ReportGroupValue & "ORDER BY SourceCode.SourceCodeName ASC" 
																				SET rsDSC = cmd.Execute
																				
																					Do While Not rsDSC.EOF 
																								If Not rsDSC.EOF Then%>
																									<OPTION VALUE=<%=rsDSC("SourceCodeID")%>><%=rsDSC("SourceCodeName")%></OPTION> 
																								<%End If   %>
																								

																								<%rsDSC.MoveNext
																					Loop 
																							
																					else
																						  %>
																										<OPTION VALUE=0></OPTION>

																								   
																							'*******************************
																				<%end if
																			
																			%>
																					
																							
																							
																							<%'Edit default source code drop down
																								'*******************************
																								if EditBooln = True then

																										Set cmd = Server.CreateObject("ADODB.Command")
																										cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																										cmd.CommandText = "select distinct SourceCodeID,SourceCodeName from sourcecode where sourcecodeID = " & WebPersonDSC

																										SET rsSourceCodeEdit = cmd.Execute


																													If Not rsSourceCodeEdit.EOF Then%>
																																	<option value=<%=WebPersonDSC%><% Response.Write(" selected")%>><%=rsSourceCodeEdit("SourcecodeName")%></option>										
																													<%End If

																								end if
																								'*******************************
																			%>
															 
																</SELECT></td>
																 <tr>
																 <td>&nbsp;</td>
																 <td colspan=2><div class="body_background"><input type="checkbox" name="DESREQUESTOR" <%If vDesigRequestor = True Then Response.Write(" checked") End If%>>&nbsp;Designated Requestor</div></td>
																 <td>&nbsp;</td>
																 <td>&nbsp;</td>
	                          			</tr>	 
	                             
	                             <%If DebugMode = true Then%>
	                             <td>
	                             <SELECT NAME="DefaultsourceCode" >
	                             
	
																			<%'Fill in Deault source code dropdown
	                             				'*******************************
																			rsSourceUser.MoveFirst
																			Do While Not rsSourceUser.EOF 
																						If Not rsSourceUser.EOF Then
																							'Print rsSourceUser("SourceCodeName")
																						End If   %>
																						<OPTION VALUE=<%=rsSourceUser("SourceCodeID")%>><%=rsSourceUser("SourceCodeName")%></OPTION>

																						<%rsSourceUser.MoveNext
																			Loop  
															 				'*******************************
																			%>
																			<%'Edit default source code drop down
																			'*******************************
																			if EditBooln = True then
																																																																			
																					Set cmd = Server.CreateObject("ADODB.Command")
																					cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
																					cmd.CommandText = "select distinct SourceCodeID,SourceCodeName from sourcecode where sourcecodeID = " & WebPersonDSC
		 
																					SET rsSourceCodeEdit = cmd.Execute


																								If Not rsSourceCodeEdit.EOF Then%>
																												<option value=<%=WebPersonDSC%><% Response.Write(" selected")%>><%=rsSourceCodeEdit("SourcecodeName")%></option>										
																								<%End If
																			
																			end if
																			'*******************************
																			%>

																</SELECT></td>
																<%End if%>
															</tr>
									
	                             
	                                       
	                       </table>
	        
	                    </td>
	                </tr>
	                <tr>
	                
		            <td align=center valign=top><input type="submit" name="submitform" value="<%=vButtonCaption%>" onClick="ReviewCreateAccount()">
	    <% If vButtonCaption <> "Edit Account" Then %>	
		                <input type="reset" name="resetform" value="Clear"></td>
	    <% End If  %>
	                </tr>
	            </table>
	        </td>    
	    </tr>
	    
	</table>

	</form>

	<%ELSE  %>' If TRUE=TRUE 
	<font color="red">No elements exist for assignment of permissions for this permission type.</font>
	<%END IF%>
	</body>
	</HTML>
<% 
' Housekeeping
Set rsSrch = Nothing
Set rsHosp = Nothing
Set rsRoles = Nothing


Sub DebugPrint(sStr)
   If DebugMode = True Then
   	Response.Write("<b>Debug -></b><br>" & sStr & "<br>")
   End If
End Sub




End If   ' If AuthorizeMain %> 



<script type="text/javascript">
<!-- 
    

function validateCreation()
{

	var _userid = document.acctform.USERID.value;

	var _first = document.acctform.FIRSTNAME.value;

	var _last = document.acctform.LASTNAME.value;

	var _pwd1 = document.acctform.PWD1.value;

	var _pwd2 = document.acctform.PWD2.value;
	
	var _role = document.acctform.ROLE.options[document.acctform.ROLE.selectedIndex].value


	var _accttype = document.acctform.ACCOUNTTYPE.options[document.acctform.ACCOUNTTYPE.selectedIndex].value

	var _Addbutton = document.acctform.Addbutton.value;

	var _Removebutton = document.acctform.Removebutton.value;

  var _ButtonPress = document.acctform.ButtonPress.value;
		
		
		if(_ButtonPress.length >2)
		{
			return True;
		}
		
		  
		  	
		  
	
	// First, check thatpasswords match.		
	if(_pwd1 != _pwd2)
	{
		alert("Passwords do not match.  Please re-enter.");
		document.acctform.PWD1.value = "";
		document.acctform.PWD2.value = "";
		document.acctform.PWD1.focus();
		return false;
		 }
	else
	{  
		if(_pwd1.length < 8)
		{
		alert("Passwords must be at least 8 characters long.");
		document.acctform.PWD1.value = "";
		document.acctform.PWD2.value = "";
		document.acctform.PWD1.focus();
		return false;	
		}
		else
		{
			if(_userid.toString() == "")
			{
				alert("Please enter a User Id.");
				document.acctform.USERID.focus();
				return false;
			}
			else
			{
				if(_first.toString() == "")
				{
					alert("Please enter a First Name.")
					document.acctform.FIRSTNAME.focus();
					return false;
				}
				else
				{
					if(_last.toString() == "")
					{
						alert("Please enter a Last Name.")
						document.acctform.LASTNAME.focus();
						return false;
					}
					else
					{
						if(_role == 0)
						{
							alert("Please select the user's Role.")
							document.acctform.ROLE.focus();
							return false;
						}
						else
						{
							if(_role == 0)
								{
								alert("Please select the user's Role.")
								document.acctform.ROLE.focus();
								return false;
								}
							else
							{
								if(_accttype == 0)
								{
									alert("Please select the user's Account Type.")
									document.acctform.ACCOUNTTYPE.focus();
									return false;	
								}
								else
								{
									return true;
								}
							}
						}
					}
				}
			
			}
		
		}
		
	}

}



function ReviewAdd()
{
 document.acctform.ButtonPress.value =""
 document.acctform.ButtonPress.value = "Add";
  
}

function ReviewRemove()
{
	document.acctform.ButtonPress.value =""
 document.acctform.ButtonPress.value = "Remove";
  
}

function ReviewCreateAccount()
{
	document.acctform.ButtonPress.value =""
	document.acctform.ButtonPress.value = "NA";
  
}

function SetUSERID()
{
	document.acctform.USERID.focus();
}

//-->
</script> 