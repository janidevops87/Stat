<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QAErrorDetail.aspx.cs" Inherits="Statline.StatTrac.Web.UI.QAErrorDetail" %>

<%@ Register Src="Controls/QAErrorDetailControl.ascx" TagName="QAErrorDetailControl"
    TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc2:QAErrorDetailControl ID="qAErrorDetailControl" runat="server" />
	</mp:content>
</mp:contentcontainer>

