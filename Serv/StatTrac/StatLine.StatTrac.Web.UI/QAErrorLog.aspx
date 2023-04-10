<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QAErrorLog.aspx.cs" Inherits="Statline.StatTrac.Web.UI.QAErrorLog" %>

<%@ Register Src="Controls/QAErrorLogControl.ascx" TagName="QAErrorLogControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc2:QAErrorLogControl ID="qAErrorLogControl" runat="server" />
	</mp:content>
</mp:contentcontainer>
