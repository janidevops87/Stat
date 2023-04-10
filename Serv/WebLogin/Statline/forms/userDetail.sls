<%
Option Explicit

Dim UserName
Dim pvStartDate
Dim pvEndDate
Dim vErrorMsg
Dim ErrorReturn

%>

<!--#include virtual="/loginstatline/includes/Authorize.sls"-->

<%
'Verify Access
If AuthorizeMain Then

'drh 12/17/03 - Use the TransactionDSN
DataSourceName = TRANSACTIONDSN
	
If Request.ServerVariables("REQUEST_METHOD") <> "GET" Then
	Dim intNumberSelected ' Count of items selected
	Dim strSelectedAccess' String returned from QS (or Form)
	Dim arrSelectedAccess' Variable To hold team array
	Dim I ' Looping variable
	Dim nCount, updateTime
	'Retrieve the count of items selected
	intNumberSelected = Request.Form("Access").Count
	strSelectedAccess = Request.Form("Access")
	arrSelectedAccess = Split(strSelectedAccess, ", ", -1, 1)
	nCount=0
	For I = LBound(arrSelectedAccess) To UBound(arrSelectedAccess)
		
		nCount=nCount + arrSelectedAccess(I)
  	
    	Next 'I 
    	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	'Response.Write(DataSourceName)
	Conn.Open DataSourceName, DBUSER, DBPWD
	vQuery = "EXEC spu_Access "
	vQuery = vQuery & "'" & request("WebUserID")  & "', "
	vQuery = vQuery & nCount
	
	'response.write(vQuery)
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open vQuery, Conn, 3, 3
	
	updateTime= Date & "&nbsp;" & Time
End IF

IF request("webuserid") <> "" then
	Dim RSAccessType, RSWebUser
	Set Conn = server.CreateObject("ADODB.Connection")
	'Response.Write(DataSourceName)
	Conn.Open DataSourceName, DBUSER, DBPWD
	vQuery = "EXEC sps_Access_BW "
	vQuery = vQuery & "'" & request("WebUserID")  & "'"
		
	'response.write(vQuery)
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.Open vQuery, Conn, 2, 3
	
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	vQuery = "EXEC sps_AccessType "
			
	'response.write(vQuery)
	Set RSAccessType = Server.CreateObject("ADODB.Recordset")
	RSAccessType.Open vQuery, Conn, 1, 2
		
	'Open Connection
	Set Conn = server.CreateObject("ADODB.Connection")
	Conn.Open DataSourceName, DBUSER, DBPWD
	vQuery = "EXEC sps_WebUSerbyID "
	vQuery = vQuery & "'" & request("WebUserID")  & "'"
				
	'response.write(vQuery)
	Set RSWebUser = Server.CreateObject("ADODB.Recordset")
	RSWebUser.Open vQuery, Conn, 3, 3

END IF
%>

<html>
<head>
<title>Donor Registry - User Detail</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="../styles/common.css" type="text/css">

</head>

<body bgcolor="#F5EBDD" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="450" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top"> 
    <td width="100" height="270" bgcolor="#F5EBDD"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
    <td width="350" bgcolor="#FFFFFF"> 
      <table width="350" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td valign="top"> 
            <p><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Hold down the "ctrl" key to select multiple values.</font></p>
            <% 
            If Request.ServerVariables("REQUEST_METHOD") <> "GET" Then            
            	response.write("<font class='menu_sub' size=-1><B>Updated at: " & updateTime & "</B></font>")
            END IF %>
            <table width="340" border="0" cellspacing="0" cellpadding="0" bordercolor="#CCCCCC">
                
                <TR>
                <TD align="left" width="5%" class="menu_background"><font class="menu_sub"><B>Name:</B></font>
                </TD>
                <TD align="left"><%=RSWebUser("PersonFirst")%>&nbsp;<%=RSWebUser("PersonLast")%>
                </TD>
                </TR>
                <TR>
			<TD align="left" width="10%" class="menu_background" height="5"></TD>
		        <TD align="left" height="5"></TD>
                </TR>
                <TR>
			<TD align="left" width="5%" class="menu_background"><font class="menu_sub"><B>User Name:</B></font>
		        </TD>
		        <TD align="left"><%=RSWebUser("WebPersonUserName")%>
		        </TD>
                </TR>
                <TR>
			<TD align="left" width="10%" class="menu_background" height="5"></TD>
		        <TD align="left" height="5"></TD>
                </TR>
                <TR>
			<TD align="left" valign="top" width="10%" class="menu_background"><font class="menu_sub"><B>Access Types:</B></font>
                </TD>
                  <TD> 
                  <Form ACTION="userDetail.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>" METHOD="POST">
                  
                  <input type="hidden" name="webuserid" value="<%=request("webuserid")%>">
                  <Select name="Access" size="6" multiple>
	          <%
		  While (NOT RSAccessType.EOF)
		  	Dim strSelected
		  	strSelected=""
		  	If NOT RS.EOF AND NOT RS.BOF then
		  		RS.Requery
		  		While (NOT RS.EOF)
		  		response.write(RS("Access") & "-" & RSAccessType("Access"))
		  			IF (RS("Access") = RSAccessType("Access")) then
		  				strSelected="selected"
		  			end if
		  		RS.MoveNext()
		  		Wend 
		  		RS.Requery
		  	end if%>
		       <option value="<%=RSAccessType("Access")%>" <%=strSelected%>><%=RSAccessType("AccessName")%></option>
		    <%
		  RSAccessType.MoveNext()
		  Wend
		  
		  If (RSAccessType.CursorType > 0) Then
		    RSAccessType.MoveFirst
		  Else
		    RSAccessType.Requery
		  End If
		  %>
        	</select> 
                </td>
                </tr>
                 <TR>
		  	<TD align="left" width="5%" class="menu_background"><font class="menu_sub"><B></B></font>
		        </TD>
		        <TD align="left"><input type="Submit" value="Update"><input type="Reset" value="Reset"></TD>
                </TR>
                  </form>
                </TR>
              </table>
          </td>
        </tr>
      </table>
    </td>
    <td width="150" bgcolor="#F5EBDD"> 

    </td>
    <td width="150"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
  </tr>
</table>
<!--#include virtual="/loginstatline/includes/copyright.shm"-->
</body>
</html>
<%
End If
%>