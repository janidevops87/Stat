<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReferralFacilityCompliance.aspx.cs" Inherits="Statline.StatTrac.Web.UI.ReferralFacilityCompliance" %>
<%@ Register Src="Controls/ReferralFacilityComplianceControl.ascx" TagName="ReferralFacilityComplianceControl" TagPrefix="uc2" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicViewSecure.ascx" runat="server">
	<mp:content id="cR" runat="server">
	<uc2:ReferralFacilityComplianceControl ID="referralFacilityCompliance" runat="server" />
	</mp:content>
</mp:contentcontainer>

