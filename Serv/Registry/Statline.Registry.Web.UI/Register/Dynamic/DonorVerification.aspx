		<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DonorVerification.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Dynamic.DonorVerification" %>
<%@ Register Src="../../Controls/Dynamic/DonorVerificationControl.ascx" TagName="DonorVerificationControl" TagPrefix="uc1" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages" TagPrefix="mp" %>

<mp:ContentContainer ID="cC" MasterPageFile="~/Framework/Templates/BasicRegisterVerificationView.ascx" runat="server">
    <mp:Content ID="cRR" runat="server">
        <uc1:DonorVerificationControl ID="DonorVerificationControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>
