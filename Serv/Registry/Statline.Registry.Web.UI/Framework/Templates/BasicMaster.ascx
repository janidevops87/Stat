<%@ Register TagPrefix="cc" Namespace="Statline.StatTrac.Web.UI" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Control CodeBehind="BasicMaster.ascx.cs" Language="c#" AutoEventWireup="True" Inherits="Statline.Registry.Web.UI.Framework.Templates.BasicMaster" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD runat="server">
		<title>		
        <asp:Literal ID="pageTitleLiteral" Runat="server"></asp:Literal></title>
        <meta http-equiv="X-UA-Compatible" content="IE=9"/>
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
