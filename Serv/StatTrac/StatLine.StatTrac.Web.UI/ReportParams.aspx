<%@ Page language="c#" Codebehind="ReportParams.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.ReportParams" enableViewState="True"%>
<%@ Register TagPrefix="uc1" TagName="ReportParamsControl" Src="Controls/ReportParamsControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<uc1:ReportParamsControl id="reportParamsControl" runat="server"></uc1:ReportParamsControl>
	</mp:content>
</mp:contentcontainer>
