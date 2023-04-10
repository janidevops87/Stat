<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReferralSearch.aspx.cs" Inherits="Statline.StatTrac.Web.UI.ReferralSearch" %>

<%@ Register Src="Controls/ReferralSearchControl.ascx" TagName="ReferralSearchControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	<uc2:ReferralSearchControl ID="referralSearchControl" runat="server" />
	</mp:content>
</mp:contentcontainer>

