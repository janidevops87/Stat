<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Page language="c#" Codebehind="RoleAdminEdit.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Admin.RoleAdminEdit" %>
<%@ Register TagPrefix="uc1" TagName="RoleAdminEditControl" Src="~/Controls/Admin/RoleAdminEditControl.ascx" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<uc1:RoleAdminEditControl id=roleAdminEditControl runat="server"></uc1:RoleAdminEditControl>
	</mp:content>
</mp:contentcontainer>
