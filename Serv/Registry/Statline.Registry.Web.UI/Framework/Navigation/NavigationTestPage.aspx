<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="uc1" TagName="OuterMenuControl" Src="OuterMenuControl.ascx" %>
<%@ Register TagPrefix="uc1" TagName="InnerMenuControl" Src="InnerMenuControl.ascx" %>
<%@ Page language="c#" Codebehind="NavigationTestPage.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Framework.Navigation.NavigationTestPage" %>
<mp:contentcontainer id="Content" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="outerNavRegion" runat="server">
		<uc1:OuterMenuControl id="outerMenuControl" runat="server" SelectedMenuItem="Policy">
		</uc1:OuterMenuControl>
	</mp:content>
	<mp:content id="innerNavRegion" runat="server">
		<uc1:InnerMenuControl id="innerMenuControl" runat="server" SelectedMenuItem="AirPolicy">
		</uc1:InnerMenuControl>
	</mp:content>
</mp:contentcontainer>
