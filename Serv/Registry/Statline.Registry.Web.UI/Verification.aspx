<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Verification.aspx.cs" Inherits="Statline.Registry.Web.UI.Verification" %>
<%@ Register Src="Controls/VerificationControl.ascx" TagName="VerificationControl" TagPrefix="uc1" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages" TagPrefix="mp" %>

<mp:ContentContainer ID="cC" MasterPageFile="~/Framework/Templates/BasicRegisterView.ascx" runat="server">
    <mp:Content ID="cR" runat="server">
        <uc1:VerificationControl ID="VerificationControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>
