<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="uc1" TagName="AdministrationControl" Src="~/Controls/Admin/AdministrationControl.ascx" %>
<%@ Page language="c#" Codebehind="Administration.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Admin.Administration" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<uc1:AdministrationControl id="administrationControl" runat="server"></uc1:AdministrationControl>
	</mp:content>
</mp:contentcontainer>
