<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QAReview.aspx.cs" Inherits="Statline.StatTrac.Web.UI.QAReview" %>

<%@ Register Src="Controls/QAReviewControl.ascx" TagName="QAReviewControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="uc1" TagName="ReportListControl" Src="Controls/ReportListControl.ascx" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc2:QAReviewControl ID="qAReviewControl" runat="server" />
	</mp:content>
</mp:contentcontainer>

