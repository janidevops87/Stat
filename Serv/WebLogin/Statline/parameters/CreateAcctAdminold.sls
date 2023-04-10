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
Dim rsSrch
Dim rsHosp
Dim rsRoles
Dim sParentOrgName
Dim sHospName
Dim vWebPersonId 
Dim vPersonId
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

Dim DebugMode

DebugMode = False

' Display all Form and QueryString variables when DebugMode is on.
If DebugMode = True Then
    Response.Write "<br>"
    Dim strItem
    Response.Write "<b>FORM VARS</b><br>"
    For Each strItem In Request.Form
        Response.Write "<br>" & strItem & " = " 
        Response.Write Request.Form(strItem) & vbCrLf
    Next
    Response.Write "<br><br>"
    Response.Write "<b>QUERYSTRING VARS</b><br>"
    For Each strItem In Request.QueryString
        Response.Write "<br>" & strItem & " = " 
        Response.Write Request.QueryString(strItem) & vbCrLf
    Next
    Response.Write "<br>"    
End If	

' Default this to "Create Account" - it changes for edited records
vButtonCaption = "Create Account"

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
' If a search string was sent, perform the search
If Len(Request.Form("SRCHUSER")) > 0 Then

	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
	cmd.CommandText = "sps_GetWebPersonByUserId"
	cmd.CommandType = adCmdStoredProc
	cmd.Parameters.Append cmd.CreateParameter("@userName", adVarChar, adParamInput, 16)
	cmd.Parameters.Append cmd.CreateParameter("@userOrgId", adInteger, adParamInput)
	cmd.Parameters("@userName").Value = Request.Form("SRCHUSER")
	cmd.Parameters("@userOrgId").Value = Request.QueryString("UserOrgID")
	SET rsSrch = cmd.Execute
End If

' If the user's org is not Statline, search for display and list of elegible hospitals,
' if the org is Statline, get a list of OPOs to populate in the hospital drop-down.  3/25/05 - SAP
Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
cmd.CommandText = "sps_GetWebOrgsByParentId"
cmd.CommandType = adCmdStoredProc
cmd.Parameters.Append cmd.CreateParameter("@parentId", adInteger, adParamInput)
cmd.Parameters("@parentId").Value = Request.QueryString("UserOrgID")
SET rsHosp = cmd.Execute
If Not rsHosp.EOF Then
   sParentOrgName = rsHosp("ParentOrganizationName")
End If


' Get the list of possible Roles for a Person from PersonType table
Set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = "DSN=" & TRANSACTIONDSN & ";UID=" & DBUSER & ";Password=" & DBPWD
cmd.CommandText = "sps_GetPersonTypes"
cmd.CommandType = adCmdStoredProc
SET rsRoles = cmd.Execute

' If this is a user to be edited, go fetch the user's information
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

' If the form was submitted create or update the user
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
	cmd.Parameters("@personId").Value = vPersonId
	
	If IsNumeric(Request.Form("WEBPERSONID")) Then
		vWebPersonId = Request.Form("WEBPERSONID")
	Else
		vWebPersonId = 0
	End If	
	cmd.Parameters("@webPersonId").Value = vWebPersonId
	
	cmd.Parameters("@webPersonName").Value = Request.Form("USERID")
	cmd.Parameters("@webPersonPwd").Value = Request.Form("PWD1")
	
	If IsNumeric(Request.Form("HOSPITAL")) Then
		vPersonOrgId = Request.Form("HOSPITAL")
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
	
	' Reset variables
	vWebPersonId = ""
	vPersonId = ""
	vWebUserName = ""
	vPassword = ""
	vWebAccess = 0
	vPersonFirst = ""
	vPersonLast = ""
	vDesigRequestor = False
	vPersonTypeId = ""
	vPersonOrgId = ""

End If


'Verify Access
If AuthorizeMain Then %>
	<html>
	<head>
	<title>Create Account Admin.</title>
	<link rel="stylesheet" href="../styles/StatReports.css" type="text/css">
	</head>
	<body class="body_background">


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
	var _hospital = document.acctform.HOSPITAL.options[document.acctform.HOSPITAL.selectedIndex].value
	var _accttype = document.acctform.ACCOUNTTYPE.options[document.acctform.ACCOUNTTYPE.selectedIndex].value
	
	// First, check that passwords match.		
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
							if(_hospital == 0)
							{
								alert("Please select the user's Hospital.")
								document.acctform.HOSPITAL.focus();
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

//-->
</script> 


	
	
	
	
	
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
		                      <td align=center colspan=2><input type="text" name="SRCHUSER" size=14 maxlength=15 value="<%=Request.Form("SRCHUSER")%>"></td>
		                  </tr>
		                  <tr>
		                      <td align=center colspan=2><input type="submit" value="Search"></td>
		                  </tr>		      
		                  <tr>
		                      <td valign=top>
            <% If Len(Request.Form("SRCHUSER")) > 0 Then
                  If rsSrch.EOF Then %>
                                    <div align=center class="body_background">No matches found for <br><b>"<%=Request.Form("SRCHUSER")%>"</b></div>
            <%    End If
		  Do While Not rsSrch.EOF %>
			            <a href="CreateAcctAdmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&EditUser=<%=rsSrch("WebPersonId")%>"><%=rsSrch("WebPersonUserName")%></a><br>
		<%	rsSrch.MoveNext  
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
		</td><form action="CreateAcctAdmin.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" name="acctform" method="post" onsubmit="return validateCreation()">
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
	    	               </table>		    
		    	    </td>
		        </tr>
		        <tr>
	    	            <td><div class="body_background">Account Information</div><td>
	                </tr>
                        <tr>
	                    <td>
	                       <table border="0">
	                          <tr><input type="hidden" name="PERSONID" value="<%=vPersonId%>">
	                              <input type="hidden" name="WEBPERSONID" value="<%=Request.Form("SRCHUSER")%>">
	                             <td><div class="body_background">*&nbsp;First&nbsp;Name</div></td>
	                             <td><input type="text" name="FIRSTNAME" value="<%=vPersonFirst%>"></td>
	                             <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                             <td><div class="body_background">Organization:<div></td>
	                             <td><%=sParentOrgName%></td>
	                          </tr>
	                          <tr>
	                             <td><div class="body_background">*&nbsp;Last&nbsp;Name<div></td>
	                             <td><input type="text" name="LASTNAME" value="<%=vPersonLast%>"></td>
	                             <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                             <td><div class="body_background">* <%If Request.Querystring("UserOrgID") = 194 Then Response.Write("OPO") Else Response.Write("Hospital") End If %>:</div></td>
	                             <td><select name="HOSPITAL">
	                             	<option value=0></option>
<%		' If a Statline user, organization may not be automatically retrieved, since it grabs only OPOs,
		' so include the Edited user's Org.
		If Request.Querystring("UserOrgID") = 194 And Len(vPersonOrgName) > 0 Then %>
					<option value=<%=vPersonOrgId%> selected><%=vPersonOrgName%></option>
<%		End If
		
		Do While Not rsHosp.EOF  
		    If Len(rsHosp("OrganizationName")) > 45 Then 
		    	sHospName = Left(rsHosp("OrganizationName"), 45) & "..."
		    Else
		        sHospName = rsHosp("OrganizationName")
		    End If %>
				            <option value=<%=rsHosp("OrganizationId")%><%If Cstr(rsHosp("OrganizationId")) = Cstr(vPersonOrgId) Then Response.Write(" selected") End If%>><%=sHospName%></option>
<%		   rsHosp.MoveNext
		Loop  %>
	                             </select></td>
	                          </tr>
	                          <tr>
	                             <td><div class="body_background">*&nbsp;Role</div></td>
	                             <td><select name="ROLE">
	                 	            <option value=0></option>
<%		Do While Not rsRoles.EOF %>
				            <option value=<%=rsRoles("PersonTypeId")%><%If Cstr(rsRoles("PersonTypeId")) = Cstr(vPersonTypeId) Then Response.Write(" selected") End If%>><%=rsRoles("PersonTypeName")%></option>
<%		   rsRoles.MoveNext
		Loop  %>
	                             </select></td>
	                             <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                             <td><div class="body_background">*&nbsp;Account&nbsp;Type:</div></td>
	                             <td><select name="ACCOUNTTYPE">
	                 	            <option value=0></option>
	                 	            <option value=511<%If vWebAccess = 511 Then Response.Write(" selected") End If%>>Administrator</option>
	                 	            <option value=13<%If vWebAccess = 13 Then Response.Write(" selected") End If%>>User</option>
	                             </select></td>
	                          </tr>
	                          <tr>
	                             <td>&nbsp;</td>
	                             <td colspan=2><div class="body_background"><input type="checkbox" name="DESREQUESTOR" <%If vDesigRequestor = True Then Response.Write(" checked") End If%>>&nbsp;Designated Requestor</div></td>
	                             <td>&nbsp;</td>
	                             <td>&nbsp;</td>
	                          </tr>	              
	                       </table>
	        
	                    </td>
	                </tr>
	                <tr>
		            <td align=center valign=top><input type="submit" name="submitform" value="<%=vButtonCaption%>">
	    <% If vButtonCaption <> "Edit Account" Then %>	
		                <input type="reset" name="resetform" value="Clear"></td>
	    <% End If  %>
	                </tr>
	            </table>
	        </td>    
	    </tr>
	    
	    
	</table>

	</form>

	<%ELSE  ' If TRUE=TRUE %>
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




End If   ' If AuthorizeMain  %>