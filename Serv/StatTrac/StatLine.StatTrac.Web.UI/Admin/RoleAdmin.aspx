<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Page language="c#" Codebehind="RoleAdmin.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Admin.RoleAdmin" %>
<%@ Register TagPrefix="uc1" TagName="RoleAdminControl" Src="~/Controls/Admin/RoleAdminControl.ascx" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<uc1:RoleAdminControl id=roleAdminControl runat="server"></uc1:RoleAdminControl>
	</mp:content>
</mp:contentcontainer>
