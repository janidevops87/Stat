<%@ Language=VBScript %>
<%
         Dim strQUERY_STRING
         dim strSecureURL
         dim strWork

         ' Get server variables
         strQUERY_STRING = Request.ServerVariables("QUERY_STRING")

         ' Fix the query string:
         strWork = Replace(strQUERY_STRING,"http","https")
         strWork = Replace(strWork,"403;","")
         strWork = Replace(strWork,":80","")
         ' Now, set the new, secure URL:
         strSecureURL = strWork

	Response.Redirect( strSecureURL )

%>