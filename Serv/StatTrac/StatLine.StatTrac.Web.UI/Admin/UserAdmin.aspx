<%@ Register TagPrefix="uc1" TagName="UserAdminControl" Src="~/Controls/Admin/UserAdminControl.ascx" %>
<%@ Page language="c#" Codebehind="UserAdmin.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Admin.UserAdmin" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" runat="server" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx">
	<mp:content id="cR" runat="server">
		<uc1:UserAdminControl id="userAdminControl" runat="server"></uc1:UserAdminControl>
	</mp:content>
</mp:contentcontainer>
