<%@ Page language="c#" Codebehind="Login.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Login" enableViewState="False" enableViewStateMac="True"%>
<%@ Register TagPrefix="uc1" TagName="LoginControl" Src="Controls/LoginControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicView.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<uc1:LoginControl id="LoginControl" runat="server"></uc1:LoginControl>
	</mp:content>
</mp:contentcontainer>
