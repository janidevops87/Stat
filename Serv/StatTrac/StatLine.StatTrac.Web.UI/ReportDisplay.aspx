<%@ Page language="c#" Codebehind="ReportDisplay.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.ReportDisplay" %>
<%@ Register TagPrefix="uc1" TagName="ReportDisplayControl" Src="Controls/ReportDisplayControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<uc1:ReportDisplayControl id="reportDisplayControl" runat="server"></uc1:ReportDisplayControl>
	</mp:content>
</mp:contentcontainer>