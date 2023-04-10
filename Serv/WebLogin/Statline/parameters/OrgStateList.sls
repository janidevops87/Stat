<%Option Explicit%>
<!--OrgStateList.sls - created 3/8 2000 by Daniel Reddy. Statline, LLC.-->
<%
'****************************************************************************************************
'File Name:		OrgStateList.sls						Created By:		Daniel Reddy  Statline, LLC.
'Date(s):		3/8 2000
'Description:	This is the parameters screen for Organizations Report.  On it the user selects the 
'				various filters they desire to produce a list of organizations.
'
'Changes:		4/6/2000 by Daniel Reddy.  Code Formatting changes.
'****************************************************************************************************
'Section I:  Variables and Includes
'****************************************************************************************************
'Pre-defined variables:
'Conn					'Variable used for Database Connection.  Used in \includes\Authorize.sls
'DataSourceName			'Variable defining Database to be used. Used and defined in \includes\Authorize.sls
'ReportID				'The ReportID of the desired Report. Passed from parameters\FrameCustomParams.sls
'RS						'Variable for RecordSets. Used in \includes\Authorize.sls
'UserID					'The current user's UserID. Used in \includes\Authorize.sls
'UserOrgID				'The Organization the current user belongs to. Used in \includes\Authorize.sls
'vQuery					'Variable that contains the Query sent to the Database. Used in \includes\Authorize.sls

'New variables:
Dim OrgTypeID			'Organization Type for Organization list.
Dim pvStartDate			'Required for \includes\Authorize.sls to work.
Dim pvEndDate			'Required for \includes\Authorize.sls to work.
Dim StateID				'State ID for Organization list.

'Get values for the incoming variables
OrgTypeID = Request.QueryString("OrgTypeID")
ReportID = Request.QueryString("ReportID")
StateID = Request.QueryString("StateID")
UserID = Request.QueryString("UserID")
UserOrgID = Request.QueryString("UserOrgID")

'Includes for this page:
%>
<!--#include virtual="/loginstatline/includes/Authorize.sls"-->
<%
'****************************************************************************************************
'Section II:  HTML and Page Header
'****************************************************************************************************
If AuthorizeMain Then 
'Open Connection to the Database
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD

%>
<html>

<head>
	<meta http-equiv="Expires" content="0">
	<title>OrgStateList frame</title>
</head>

<body bgcolor="#F5EBDD" text="BLACK">

<%
'****************************************************************************************************
'Section III: Main Body of Page
'****************************************************************************************************
'List the hidden fields
%>
<input type="hidden" name="ReportID" value="<%=ReportID%>">
<input type="hidden" name="UserID" value="<%=UserID%>">
<input type="hidden" name="UserOrgID" value="<%=UserOrgID%>">
<%
'Determine if State has been selected
	If StateID = 0 Then 'State has not been selected%>
		<select name="organization">
			<option value="0" selected></option>
		</select><%
	Else 'State has been selected
		'Generate Organization List
		vQuery = "EXECUTE sps_GetOrgStateList " & StateID & "," & OrgTypeID
		Set RS = Conn.Execute(vQuery)%>
		<select name="organization">  
		    <option value="0" selected></option>
				<%Do While Not RS.EOF%>        
					<option value="<%=RS("OrganizationID")%>"><%=RS("OrganizationName")%></option>
					<%RS.MoveNext
				Loop
				Set RS = Nothing
				Set Conn = Nothing%>      
		</select><%
	End If%>

<%
End If	'End of the AuthorizeMain If...Then statement (top of Section II).

'****************************************************************************************************
'Section IV:  End of Page 
'****************************************************************************************************
%>
</form>
</body>

</html>
<%'Clear Open Variables
Set Conn		   = Nothing
Set DataSourceName = Nothing
Set OrgTypeID	   = Nothing
Set pvStartDate	   = Nothing
Set pvEndDate	   = Nothing
Set ReportID	   = Nothing
Set RS			   = Nothing
Set StateID		   = Nothing
Set UserID		   = Nothing
Set UserOrgID	   = Nothing
Set vQuery		   = Nothing
%>
<%
'****************************************************************************************************
'Section V:  VBScript Functions and Subs 
'****************************************************************************************************
%>
<%
'****************************************************************************************************
'Section VI:  JavaScript Functions and Subs 
'****************************************************************************************************
%>

