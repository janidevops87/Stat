<%@ Page language="c#" Codebehind="Reports.aspx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Reports"  enableViewState="True" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
		<uc1:ReportListControl id="reportListControl" runat="server"></uc1:ReportListControl>
	</mp:content>
</mp:contentcontainer>

