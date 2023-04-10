<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QAConfig.aspx.cs" Inherits="Statline.StatTrac.Web.UI.QAConfig" %>
<%@ Register Src="Controls/QAConfigControl.ascx" TagName="QAConfigControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc2:QAConfigControl ID="qAConfigControl" runat="server" />
	</mp:content>
</mp:contentcontainer>
