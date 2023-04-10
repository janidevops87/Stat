<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QAManageErrorList.aspx.cs" Inherits="Statline.StatTrac.Web.UI.QAManageErrorList" %>
<%@ Register Src="Controls/QAManageErrorListControl.ascx" TagName="QAManageErrorListControl"
    TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc2:QAManageErrorListControl ID="qAManageErrorListControl" runat="server" />
	</mp:content>
</mp:contentcontainer>
