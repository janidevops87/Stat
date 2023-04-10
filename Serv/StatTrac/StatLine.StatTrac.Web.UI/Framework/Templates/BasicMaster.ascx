<%@ Register TagPrefix="cc" Namespace="Statline.StatTrac.Web.UI" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Control CodeBehind="BasicMaster.ascx.cs" Language="c#" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Framework.Templates.BasicMaster" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%-- Not putting the doctype puts it in quirks mode. Because the html uses tables for positioning, we need it in quirks mode to for it to position it correctly.
	It also does not require us to put the following tag: <meta http-equiv="X-UA-Compatible" content="IE=9"/>
--%>
<HTML>
	<HEAD>
	<LINK href="https://testportal.statline.org/Statline.StatTrac.Web.UI/controls/images/favicon.ico" rel="SHORTCUT ICON" type="image/x-icon" />
		<title>
			<asp:Literal ID="pageTitleLiteral" Runat="server"></asp:Literal></title>
        <asp:Literal id="styleSheetLiteral" Runat="server"></asp:Literal>
		<script language="javascript" src="FrameWork/Scripts/Framework.js"></script>		
	</HEAD>
	<body bgcolor="#a7a7a7" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<div align="center">
			<cc:baseform id="mF" runat="server">
				<mp:region id="bCR" runat="server"></mp:region>
			</cc:baseform>
		</div>
	</body>
</HTML>
