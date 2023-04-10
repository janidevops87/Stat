<%@ Language=VBScript %><%Option Explicit%>

<%Dim AsgChoice			'Variable Containing the desired filter for the report in question.
  Dim Counter			'Counter for Each Record
  Dim pvStartDate		'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
  Dim pvEndDate			'Required for \includes\Authorize.sls to work.  Not used for anything else in this page.
  Dim ReportName		'The ReportDisplayName of the calling report.  Used in all calling reports.
  
  Dim ReportID
  Dim UserID
  Dim UserOrgID

  'Get values for the incoming variables
  AsgChoice  = Request.QueryString("AsgChoice")
  ReportID   = Request.QueryString("ReportID")
  ReportName = Request.QueryString("ReportName")
  UserID     = Request.QueryString("UserID")
  UserOrgID  = Request.QueryString("UserOrgID")
%>

<HTML>
<HEAD>
<TITLE><%=ReportName%></TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
</HEAD>


<FRAMESET COLS="200px,*">
<NOFRAME>You must use a browser that can display frames to see this page.</NOFRAME>
<FRAME SRC="CONTRACTS_CriteriaGroups_TOC.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AsgChoice=<%=AsgChoice%>&ReportID=<%=ReportID%>&ReportName=<%=ReportName%>" NAME=toc>
<FRAME SRC="CONTRACTS_CriteriaGroups_ByClient.sls?UserID=<%=UserID%>&UserOrgID=<%=UserOrgID%>&AsgChoice=<%=AsgChoice%>&ReportID=<%=ReportID%>&ReportName=<%=ReportName%>" NAME=page>
</FRAMESET>
</HTML>


